import type { NotificationScenario } from '../types/notification'

export interface GeminiParsedResponse {
  action: 'INSERT' | 'UPDATE' | 'DELETE' | 'ANSWER'
  summary: string
  insertedRows?: Partial<NotificationScenario>[]
  updatedRows?: { id: string; key?: string; changes: Partial<NotificationScenario> }[]
  deletedKeys?: string[]
  answer?: string
}

export function isGeminiEnvConfigured(): boolean {
  return Boolean(
    (import.meta as any).env?.VITE_GEMINI_API_KEY &&
      (import.meta as any).env?.VITE_GEMINI_API_KEY.trim().length > 0
  )
}

/**
 * Parses tab-separated spreadsheet lines directly to guarantee 100% field preservation
 */
export function parseSpreadsheetTsv(
  rawText: string,
  maxGov: number,
  maxContrib: number
): Partial<NotificationScenario>[] {
  const lines = rawText.split(/\r?\n/).filter((l) => l.includes('\t'))
  const results: Partial<NotificationScenario>[] = []

  let govOffset = 0
  let contribOffset = 0

  for (const line of lines) {
    const parts = line.split('\t').map((p) => p.trim())
    const nonEmpty = parts.filter((p) => p.length > 0)
    if (nonEmpty.length < 2) continue

    const eventName = parts[0] || 'New Notification Scenario'
    const trigger = parts[1] || ''
    const audience = parts[2] || 'Donor'
    const commObj = parts[3] || ''
    const outcome = parts[4] || ''
    const pushSub = parts[5] || ''
    const pushMsg = parts[6] || ''
    const emailSub = parts[7] || ''
    const emailMsg = parts[8] || ''
    const inApp = parts[9] || ''
    const cta = parts[10] || 'View Details'
    const comments = parts[11] || ''

    const isGov =
      audience.toLowerCase().includes('community') ||
      audience.toLowerCase().includes('member') ||
      eventName.toLowerCase().includes('voting') ||
      eventName.toLowerCase().includes('proposal') ||
      eventName.toLowerCase().includes('review') ||
      eventName.toLowerCase().includes('seedling')

    const engineCategory = isGov ? 'Governance' : 'Contribution'
    const prefix = isGov ? 'GOV' : 'CONTRIB'
    const num = isGov ? maxGov + 1 + govOffset++ : maxContrib + 1 + contribOffset++

    results.push({
      key: `${prefix}-${num}`,
      engineCategory,
      governanceEvent: eventName,
      trigger,
      audience,
      communicationObjective: commObj,
      desiredOutcome: outcome,
      pushSubject: pushSub,
      pushBody: pushMsg,
      emailSubject: emailSub,
      emailBody: emailMsg,
      inAppExperience: inApp,
      cta,
      comments,
      status: 'TO DO',
    })
  }

  return results
}

export async function callGeminiApi(
  userPrompt: string,
  currentScenarios: NotificationScenario[]
): Promise<GeminiParsedResponse> {
  const clientApiKey = ((import.meta as any).env?.VITE_GEMINI_API_KEY || '').trim()

  // Calculate current maximum sequence numbers for GOV and CONTRIB
  const govNums = currentScenarios
    .filter((s) => s.engineCategory === 'Governance')
    .map((s) => {
      const m = s.key.match(/GOV-(\d+)/)
      return m ? parseInt(m[1], 10) : 0
    })
  const maxGov = govNums.length > 0 ? Math.max(...govNums) : 0

  const contribNums = currentScenarios
    .filter((s) => s.engineCategory === 'Contribution')
    .map((s) => {
      const m = s.key.match(/CONTRIB-(\d+)/)
      return m ? parseInt(m[1], 10) : 0
    })
  const maxContrib = contribNums.length > 0 ? Math.max(...contribNums) : 0

  // Pre-parse TSV lines if user copied from Excel or Google Sheets
  const preParsedTsv = userPrompt.includes('\t')
    ? parseSpreadsheetTsv(userPrompt, maxGov, maxContrib)
    : []

  // Existing summary of keys to help AI identify references
  const existingSummary = currentScenarios.slice(0, 30).map((s) => ({
    id: s.id,
    key: s.key,
    engine: s.engineCategory,
    event: s.governanceEvent,
    status: s.status,
  }))

  const systemInstruction = `You are an elite QA and Notification Scenario Data Manager for Seedling.
The project manages user notifications across Governance Engine and Contribution Engine.

Current Database State:
- Latest Governance Key: GOV-${maxGov}
- Latest Contribution Key: CONTRIB-${maxContrib}
- Valid Engine Categories: "Governance" or "Contribution"
- Valid Statuses:
  - "TO DO"
  - "TESTED"
  - "NOT WORKING"
  - "NAVIGATION NOT WORKING"
  - "PUSH NOTIFICATION NOT WORKING"
  - "EMAIL NOTIFICATION NOT WORKING"
  - "SMS NOTIFICATION NOT WORKING"

SPREADSHEET / TAB-SEPARATED VALUES (TSV) PARSING RULES:
When the user input contains tab-separated text (copied from Google Sheets or Excel), map the columns STRICTLY in this order:
Column 1: governanceEvent (Event / Scenario name)
Column 2: trigger (Notification Trigger)
Column 3: audience (Target Audience, e.g. "Donor", "Community Member")
Column 4: communicationObjective (Why we are sending this notification)
Column 5: desiredOutcome (What we want the user to do)
Column 6: pushSubject (Mobile Push Subject / Title)
Column 7: pushBody (Mobile Push Message Body)
Column 8: emailSubject (Email Subject Line)
Column 9: emailBody (Email Message Body)
Column 10: inAppExperience (In-App Experience / Deep Link)
Column 11: cta (Button Action Copy)
Column 12 (if present): comments (Notes / Comments)

Engine Category inference:
- If audience is "Donor" or mentions tax/giving/donation/contribution, set engineCategory = "Contribution" (Key: CONTRIB-X).
- If audience is "Community Member", "Sponsor", or mentions voting/proposal/governance, set engineCategory = "Governance" (Key: GOV-X).

CRITICAL: NEVER drop, truncate, or omit any of these 11 columns. Copy every column value verbatim into its matching field!

Your job:
1. When user gives raw text, tabular data, Excel dump, or requests new scenarios:
   - Extract/synthesize all 14+ fields cleanly.
   - Assign sequential keys starting after latest key (GOV-${maxGov + 1}, CONTRIB-${maxContrib + 1}, etc.).
   - Return action = "INSERT" with "insertedRows".
2. When user asks to update an existing scenario (e.g. "Change CONTRIB-7 status to TESTED"):
   - Find matching scenario in existing list.
   - Return action = "UPDATE" with "updatedRows" containing the id, key, and the changed fields.
3. If user asks a general question:
   - Return action = "ANSWER" with your explanation in "answer".

CRITICAL: Return ONLY valid JSON adhering strictly to this structure:
{
  "action": "INSERT" | "UPDATE" | "DELETE" | "ANSWER",
  "summary": "Clear, concise 1-2 sentence description of what you did",
  "insertedRows": [
    {
      "key": "CONTRIB-...",
      "engineCategory": "Contribution",
      "governanceEvent": "...",
      "trigger": "...",
      "audience": "...",
      "communicationObjective": "...",
      "desiredOutcome": "...",
      "pushSubject": "...",
      "pushBody": "...",
      "emailSubject": "...",
      "emailBody": "...",
      "inAppExperience": "...",
      "cta": "...",
      "comments": "...",
      "status": "TO DO"
    }
  ],
  "updatedRows": [
    {
      "id": "scenario-id",
      "key": "CONTRIB-...",
      "changes": {
        "status": "TESTED",
        "comments": "..."
      }
    }
  ],
  "answer": "Optional explanation text"
}`

  const requestBody = {
    contents: [
      {
        role: 'user',
        parts: [
          {
            text: `Current Existing DB sample: ${JSON.stringify(existingSummary)}\n\nUser Request / Raw Data:\n${userPrompt}`,
          },
        ],
      },
    ],
    systemInstruction: {
      parts: [{ text: systemInstruction }],
    },
    generationConfig: {
      temperature: 0.1,
      responseMimeType: 'application/json',
    },
  }

  // Helper to enrich Gemini response with verbatim TSV fields if available
  const enrichWithTsv = (parsed: GeminiParsedResponse): GeminiParsedResponse => {
    if (preParsedTsv.length > 0) {
      if (!parsed.insertedRows || parsed.insertedRows.length === 0) {
        parsed.action = 'INSERT'
        parsed.insertedRows = preParsedTsv
      } else {
        parsed.insertedRows = parsed.insertedRows.map((r, i) => {
          const tsv = preParsedTsv[i] || preParsedTsv[0]
          return {
            ...r,
            governanceEvent: r.governanceEvent || tsv.governanceEvent,
            trigger: r.trigger || tsv.trigger,
            audience: r.audience || tsv.audience,
            communicationObjective: r.communicationObjective || tsv.communicationObjective,
            desiredOutcome: r.desiredOutcome || tsv.desiredOutcome,
            pushSubject: r.pushSubject || tsv.pushSubject,
            pushBody: r.pushBody || tsv.pushBody,
            emailSubject: r.emailSubject || tsv.emailSubject,
            emailBody: r.emailBody || tsv.emailBody,
            inAppExperience: r.inAppExperience || tsv.inAppExperience,
            cta: r.cta || tsv.cta,
            comments: r.comments || tsv.comments,
          }
        })
      }
    }
    return parsed
  }

  // 1. Direct Google API call if clientApiKey is present in .env
  if (clientApiKey) {
    const models = ['gemini-3.6-flash', 'gemini-3.5-flash', 'gemini-flash-latest', 'gemini-2.5-pro']
    let lastError: Error | null = null

    for (const model of models) {
      try {
        const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${clientApiKey}`
        const response = await fetch(endpoint, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(requestBody),
        })

        if (!response.ok) {
          const errData = await response.json().catch(() => ({}))
          const errorMsg = errData?.error?.message || `HTTP ${response.status}: ${response.statusText}`
          lastError = new Error(errorMsg)
          continue
        }

        const data = await response.json()
        const textContent = data?.candidates?.[0]?.content?.parts?.[0]?.text || ''
        if (!textContent) {
          throw new Error('Gemini API returned an empty response.')
        }

        const parsed = JSON.parse(textContent) as GeminiParsedResponse
        return enrichWithTsv(parsed)
      } catch (err: any) {
        lastError = err
      }
    }

    if (lastError && preParsedTsv.length === 0) throw lastError
  }

  // 2. Fallback to server-side Pages Function endpoint (uses GEMINI_API_KEY from server env)
  try {
    const proxyRes = await fetch('/api/ai/gemini', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...requestBody, apiKey: clientApiKey }),
    })

    if (proxyRes.ok) {
      const data = await proxyRes.json()
      const textContent = data?.candidates?.[0]?.content?.parts?.[0]?.text || ''
      if (textContent) {
        const parsed = JSON.parse(textContent) as GeminiParsedResponse
        return enrichWithTsv(parsed)
      }
    }
  } catch {
    // ignore
  }

  // 3. Fallback to deterministic TSV parser if user pasted spreadsheet data
  if (preParsedTsv.length > 0) {
    return {
      action: 'INSERT',
      summary: `Parsed and validated ${preParsedTsv.length} scenario(s) directly from spreadsheet copy-paste with all 11 columns preserved.`,
      insertedRows: preParsedTsv,
    }
  }

  throw new Error(
    'Gemini API key is not configured. Please add VITE_GEMINI_API_KEY=your_key_here in your .env file.'
  )
}
