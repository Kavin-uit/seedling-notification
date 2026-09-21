import { Env, ScenarioDbRow, jsonResponse, mapDbRowToScenario } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/scenarios - Fetch all scenarios from Cloudflare D1
export const onRequestGet: PagesFunction<Env> = async ({ env }) => {
  if (!env.DB) {
    return jsonResponse(
      { error: 'Cloudflare D1 database binding (env.DB) not found. Check wrangler.json configuration.' },
      503
    )
  }

  try {
    const { results } = await env.DB.prepare(
      'SELECT * FROM scenarios ORDER BY created_at ASC'
    ).all<ScenarioDbRow>()

    const scenarios = (results || []).map(mapDbRowToScenario)

    return jsonResponse({
      scenarios,
      count: scenarios.length,
      source: 'cloudflare-d1',
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to query D1 database' }, 500)
  }
}

// POST /api/scenarios - Insert a new scenario into Cloudflare D1
export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    const data: any = await request.json()
    const id = data.id || `scen-${Date.now()}`
    const key = data.key || `TC-${Date.now().toString().slice(-4)}`
    const now = new Date().toISOString()
    const governanceEvent = data.governanceEvent !== undefined ? data.governanceEvent : ''

    await env.DB.prepare(`
      INSERT INTO scenarios (
        id, key, engine_category, governance_event, trigger, audience,
        communication_objective, desired_outcome, push_subject, push_body,
        email_subject, email_body, in_app_experience, cta, comments, status,
        priority, environment, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `)
      .bind(
        id,
        key,
        data.engineCategory || 'Governance',
        governanceEvent,
        data.trigger || '',
        data.audience || '',
        data.communicationObjective || '',
        data.desiredOutcome || '',
        data.pushSubject || '',
        data.pushBody || '',
        data.emailSubject || '',
        data.emailBody || '',
        data.inAppExperience || '',
        data.cta || '',
        data.comments || '',
        data.status || 'TO DO',
        data.priority || 'Medium',
        data.environment || 'STAGING',
        data.createdAt || now,
        now
      )
      .run()

    const created = await env.DB.prepare('SELECT * FROM scenarios WHERE id = ?').bind(id).first<ScenarioDbRow>()

    return jsonResponse({ scenario: created ? mapDbRowToScenario(created) : null }, 201)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to create scenario in D1' }, 500)
  }
}
