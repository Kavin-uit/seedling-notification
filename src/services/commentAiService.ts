/**
 * Google Gemini AI Comment Polisher & Grammar/Spelling Frame Assistant
 */

export async function polishCommentWithGemini(rawDraft: string): Promise<string> {
  const text = rawDraft.trim()
  if (!text) return ''

  const clientApiKey = ((import.meta as any).env?.VITE_GEMINI_API_KEY || '').trim()

  if (!clientApiKey) {
    return localCleanComment(text)
  }

  const prompt = `You are an elite QA and software engineering assistant. 
Rewrite and polish this draft QA comment for a Jira test scenario record.
Requirements:
1. Fix all spelling errors, grammar mistakes, and typos.
2. Frame it into clear, professional, concise, and natural English.
3. Keep the original meaning and technical details (e.g. device names, error codes, HTTP statuses, links).
4. Return ONLY the final polished comment text with NO quotation marks, NO introductory text, and NO markdown code blocks.

Draft comment:
${text}`

  // High-availability model list in order of speed and stability
  const models = ['gemini-3.5-flash-lite', 'gemini-3.7-flash', 'gemini-3.5-flash', 'gemini-3.6-flash']

  for (const model of models) {
    try {
      const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${clientApiKey}`
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          contents: [
            {
              role: 'user',
              parts: [{ text: prompt }],
            },
          ],
          generationConfig: {
            temperature: 0.1,
          },
        }),
      })

      if (response.ok) {
        const data = await response.json()
        const candidate = data?.candidates?.[0]?.content?.parts?.[0]?.text?.trim()
        if (candidate) {
          // Clean any surrounding quotation marks or boilerplate
          const cleaned = candidate
            .replace(/^["'“”`]+|["'“”`]+$/g, '')
            .replace(/^polished comment:\s*/i, '')
            .trim()
          return cleaned || localCleanComment(text)
        }
      }
    } catch {
      // Try next model
    }
  }

  return localCleanComment(text)
}

/**
 * Intelligent local fallback if offline or if all Google models encounter high demand
 */
export function localCleanComment(text: string): string {
  if (!text) return ''
  let cleaned = text.trim()

  // Common quick QA spelling fixes
  const replacements: [RegExp, string][] = [
    [/\bteh\b/gi, 'the'],
    [/\bnavigashun\b/gi, 'navigation'],
    [/\bwrking\b/gi, 'working'],
    [/\bclik\b/gi, 'click'],
    [/\bnotifcaton\b/gi, 'notification'],
    [/\bnotifcations\b/gi, 'notifications'],
    [/\biosphone\b/gi, 'iOS device'],
    [/\bdonr\b/gi, 'donor'],
    [/\bscren\b/gi, 'screen'],
    [/\bverfy\b/gi, 'verify'],
    [/\bverfied\b/gi, 'verified'],
    [/\bproblm\b/gi, 'problem'],
    [/\bbloker\b/gi, 'blocker'],
    [/\bcant\b/gi, "cannot"],
    [/\bwont\b/gi, "will not"],
  ]

  for (const [pattern, rep] of replacements) {
    cleaned = cleaned.replace(pattern, rep)
  }

  // Capitalize first letter
  cleaned = cleaned.charAt(0).toUpperCase() + cleaned.slice(1)

  // Ensure ends with punctuation
  if (!/[.!?]$/.test(cleaned)) {
    cleaned += '.'
  }

  return cleaned
}
