import { Env, NotificationRuleDbRow, jsonResponse, mapDbRowToRule } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/rules/:id - Get a single notification rule by Rule ID
export const onRequestGet: PagesFunction<Env> = async ({ params, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Rule ID is required' }, 400)
  }

  try {
    const row = await env.DB.prepare('SELECT * FROM notification_rules WHERE rule_id = ?')
      .bind(id)
      .first<NotificationRuleDbRow>()

    if (!row) {
      return jsonResponse({ error: `Rule with id ${id} not found` }, 404)
    }

    return jsonResponse({ rule: mapDbRowToRule(row) }, 200)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to fetch rule' }, 500)
  }
}
