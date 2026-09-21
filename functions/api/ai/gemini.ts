import { jsonResponse } from '../_types'

interface Env {
  GEMINI_API_KEY?: string
}

export async function onRequestPost(context: { request: Request; env: Env }) {
  const { request, env } = context

  try {
    const body: any = await request.json()
    const apiKey = env.GEMINI_API_KEY || body.apiKey

    if (!apiKey) {
      return jsonResponse(
        { error: 'Gemini API key is not configured in server environment (GEMINI_API_KEY) or request payload.' },
        400
      )
    }

    const { contents, systemInstruction, generationConfig } = body
    const models = ['gemini-3.7-flash', 'gemini-3.5-flash-lite', 'gemini-3.5-flash', 'gemini-3.6-flash']

    let lastError = 'Gemini API call failed'
    for (const model of models) {
      try {
        const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`
        const response = await fetch(endpoint, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            contents,
            systemInstruction,
            generationConfig,
          }),
        })

        const data = await response.json()
        if (response.ok) {
          return jsonResponse(data)
        }
        lastError = (data as any)?.error?.message || `HTTP ${response.status}`
      } catch (e: any) {
        lastError = e.message
      }
    }

    return jsonResponse({ error: lastError }, 503)
  } catch (err: any) {
    return jsonResponse({ error: err.message || 'Server error' }, 500)
  }
}
