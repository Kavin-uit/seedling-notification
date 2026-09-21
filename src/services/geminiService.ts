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

Scenario Schema Fields:
- key: string (e.g. GOV-${maxGov + 1} or CONTRIB-${maxContrib + 1})
- engineCategory: "Governance" | "Contribution"
- governanceEvent: string (The event name or headline)
- trigger: string (What triggered this notification)
- audience: string (e.g. "User", "Donor", "Charity", "Community Member")
- communicationObjective: string (Purpose of communication)
- desiredOutcome: string (What user should do)
- pushSubject: string (Short mobile push title)
- pushBody: string (Push notification message copy)
- emailSubject: string (Email subject line)
- emailBody: string (Full email message copy)
- inAppExperience: string (Target screen or action)
- cta: string (Button copy e.g. "Add Funds", "View GreenHouse")
- comments: string (QA notes, defect descriptions, or empty)
- status: ScenarioStatus (defaults to "TO DO")

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

        return JSON.parse(textContent) as GeminiParsedResponse
      } catch (err: any) {
        lastError = err
      }
    }

    if (lastError) throw lastError
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
        return JSON.parse(textContent) as GeminiParsedResponse
      }
    }
  } catch {
    // ignore
  }

  throw new Error(
    'Gemini API key is not configured. Please add VITE_GEMINI_API_KEY=your_key_here in your .env file.'
  )
}
