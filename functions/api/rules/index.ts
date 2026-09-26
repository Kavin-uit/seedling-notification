import { Env, NotificationRuleDbRow, jsonResponse, mapDbRowToRule } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/rules - List notification rules with optional filtering
export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse(
      { error: 'Cloudflare D1 database binding (env.DB) not found.' },
      503
    )
  }

  const url = new URL(request.url)
  const engine = url.searchParams.get('engine')?.trim()
  const scenarioId = url.searchParams.get('scenarioId')?.trim()
  const ruleId = url.searchParams.get('ruleId')?.trim()
  const q = url.searchParams.get('q')?.trim()

  try {
    let query = 'SELECT * FROM notification_rules WHERE 1=1'
    const binds: any[] = []

    if (ruleId) {
      query += ' AND (rule_id = ? OR rule_id LIKE ?)'
      binds.push(ruleId, `%${ruleId}%`)
    }

    if (scenarioId) {
      query += ' AND scenario_id = ?'
      binds.push(scenarioId)
    }

    if (engine && engine !== 'ALL') {
      query += ' AND LOWER(engine) = LOWER(?)'
      binds.push(engine)
    }

    if (q) {
      query += ` AND (
        rule_id LIKE ? OR
        rule_name LIKE ? OR
        trigger LIKE ? OR
        audience LIKE ? OR
        communication_objective LIKE ? OR
        channel_tier LIKE ? OR
        delivery LIKE ?
      )`
      const pattern = `%${q}%`
      binds.push(pattern, pattern, pattern, pattern, pattern, pattern, pattern)
    }

    query += ' ORDER BY engine ASC, rule_id ASC'

    const stmt = env.DB.prepare(query)
    const { results } = binds.length > 0 ? await stmt.bind(...binds).all<NotificationRuleDbRow>() : await stmt.all<NotificationRuleDbRow>()

    const rules = (results || []).map(mapDbRowToRule)

    return jsonResponse({
      rules,
      count: rules.length,
      source: 'cloudflare-d1',
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to query notification rules' }, 500)
  }
}
