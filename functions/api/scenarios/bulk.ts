import { Env, ScenarioDbRow, jsonResponse, mapDbRowToScenario } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// POST /api/scenarios/bulk - Bulk insert scenarios (Excel import or batch upload)
export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    const body: any = await request.json()
    const scenariosToInsert: any[] = Array.isArray(body) ? body : body.scenarios || []

    if (scenariosToInsert.length === 0) {
      return jsonResponse({ error: 'No scenarios provided for bulk insert' }, 400)
    }

    const statements = []
    const now = new Date().toISOString()

    for (const data of scenariosToInsert) {
      const id = data.id || `scen-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`
      const key = data.key || `TC-${Math.floor(1000 + Math.random() * 9000)}`

      statements.push(
        env.DB.prepare(`
          INSERT OR REPLACE INTO scenarios (
            id, key, engine_category, governance_event, trigger, audience,
            communication_objective, desired_outcome, push_subject, push_body,
            email_subject, email_body, in_app_experience, cta, comments, status,
            priority, environment, created_at, updated_at
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `).bind(
          id,
          key,
          data.engineCategory || 'Governance',
          data.governanceEvent || 'Untitled Event',
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
      )
    }

    // Cloudflare D1 batch execution
    await env.DB.batch(statements)

    const { results } = await env.DB.prepare(
      'SELECT * FROM scenarios ORDER BY created_at ASC'
    ).all<ScenarioDbRow>()

    return jsonResponse(
      {
        success: true,
        insertedCount: statements.length,
        totalCount: results.length,
        scenarios: results.map(mapDbRowToScenario),
      },
      201
    )
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Bulk insert failed in D1' }, 500)
  }
}
