import { Env, jsonResponse } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/engines - Fetch all distinct engine categories from Cloudflare D1
export const onRequestGet: PagesFunction<Env> = async ({ env }) => {
  if (!env.DB) {
    return jsonResponse(
      { error: 'Cloudflare D1 database binding (env.DB) not found.' },
      503
    )
  }

  try {
    // Collect distinct engine categories from both scenarios and engine_sheets
    const { results } = await env.DB.prepare(`
      SELECT DISTINCT engine_category as engineCategory FROM (
        SELECT engine_category FROM scenarios WHERE engine_category IS NOT NULL AND TRIM(engine_category) != ''
        UNION
        SELECT engine_category FROM engine_sheets WHERE engine_category IS NOT NULL AND TRIM(engine_category) != ''
      ) ORDER BY engineCategory ASC
    `).all<{ engineCategory: string }>()

    const engines = (results || [])
      .map((r) => (r.engineCategory || '').trim())
      .filter(Boolean)

    return jsonResponse({
      engines,
      count: engines.length,
      source: 'cloudflare-d1',
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to query engines from D1' }, 500)
  }
}
