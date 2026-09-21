import { Env, jsonResponse, mapDbRowToScenario, ScenarioDbRow } from './_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// POST /api/init - Ensure D1 schema exists and re-seed the 20 default Governance & Contribution scenarios
export const onRequestPost: PagesFunction<Env> = async ({ env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    // Create schema
    await env.DB.exec(`
      CREATE TABLE IF NOT EXISTS scenarios (
        id TEXT PRIMARY KEY,
        key TEXT NOT NULL,
        engine_category TEXT NOT NULL DEFAULT 'Governance',
        governance_event TEXT NOT NULL,
        trigger TEXT NOT NULL DEFAULT '',
        audience TEXT NOT NULL DEFAULT '',
        communication_objective TEXT NOT NULL DEFAULT '',
        desired_outcome TEXT NOT NULL DEFAULT '',
        push_subject TEXT NOT NULL DEFAULT '',
        push_body TEXT NOT NULL DEFAULT '',
        email_subject TEXT NOT NULL DEFAULT '',
        email_body TEXT NOT NULL DEFAULT '',
        in_app_experience TEXT NOT NULL DEFAULT '',
        cta TEXT NOT NULL DEFAULT '',
        comments TEXT DEFAULT '',
        status TEXT NOT NULL DEFAULT 'TO DO',
        priority TEXT NOT NULL DEFAULT 'Medium',
        environment TEXT NOT NULL DEFAULT 'STAGING',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      );
      CREATE INDEX IF NOT EXISTS idx_scenarios_engine ON scenarios(engine_category);
      CREATE INDEX IF NOT EXISTS idx_scenarios_status ON scenarios(status);
    `)

    try {
      await env.DB.exec(`ALTER TABLE scenarios ADD COLUMN comments TEXT DEFAULT ''`)
    } catch {
      // Column may already exist, safe to ignore
    }

    return jsonResponse({ success: true, message: 'D1 schema initialized successfully' })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to initialize D1 schema' }, 500)
  }
}
