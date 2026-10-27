import {
  Env,
  ProductionNotificationDbRow,
  jsonResponse,
  mapDbRowToProductionNotification,
  mapDbRowToRule,
} from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

const ENSURE_PROD_TABLE_SQL = `
  CREATE TABLE IF NOT EXISTS production_notifications (
    id TEXT PRIMARY KEY,
    original_scenario_id TEXT DEFAULT '',
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
    notes TEXT DEFAULT '',
    status TEXT NOT NULL DEFAULT 'READY FOR PROD',
    priority TEXT NOT NULL DEFAULT 'Medium',
    environment TEXT NOT NULL DEFAULT 'PROD',
    rule_id TEXT DEFAULT '',
    cloned_at TEXT NOT NULL DEFAULT (datetime('now')),
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
  );
  CREATE INDEX IF NOT EXISTS idx_production_engine ON production_notifications(engine_category);
  CREATE INDEX IF NOT EXISTS idx_production_status ON production_notifications(status);
  CREATE INDEX IF NOT EXISTS idx_production_orig_scen ON production_notifications(original_scenario_id);
`

// GET /api/production - Fetch all production ready notifications with joined rules
export const onRequestGet: PagesFunction<Env> = async ({ env }) => {
  if (!env.DB) {
    return jsonResponse(
      { error: 'Cloudflare D1 database binding (env.DB) not found.' },
      503
    )
  }

  try {
    // Ensure table exists
    await env.DB.exec(ENSURE_PROD_TABLE_SQL).catch(() => {})

    const { results } = await env.DB.prepare(`
      SELECT 
        p.*,
        r.rule_id as r_rule_id,
        r.engine as r_engine,
        r.rule_name as r_rule_name,
        r.trigger as r_trigger,
        r.audience as r_audience,
        r.communication_objective as r_communication_objective,
        r.priority as r_priority,
        r.delivery as r_delivery,
        r.channel_tier as r_channel_tier,
        r.email_delivery_policy as r_email_delivery_policy,
        r.cooldown as r_cooldown,
        r.suppression as r_suppression,
        r.source_workbook as r_source_workbook,
        r.attention_class as r_attention_class,
        r.candidate_score as r_candidate_score,
        r.guaranteed_experience as r_guaranteed_experience,
        r.batch_eligible as r_batch_eligible,
        r.runtime_memory_dependency as r_runtime_memory_dependency,
        r.attention_queue_group as r_attention_queue_group,
        r.rotation_group as r_rotation_group,
        r.timing as r_timing,
        r.merge_policy as r_merge_policy,
        r.default_decision_reason as r_default_decision_reason,
        r.experience_type as r_experience_type,
        r.memory_keys as r_memory_keys,
        r.decision_reason_template as r_decision_reason_template,
        r.candidate_audiences as r_candidate_audiences,
        r.candidate_experiences as r_candidate_experiences,
        r.template_id as r_template_id,
        r.change_notes as r_change_notes
      FROM production_notifications p
      LEFT JOIN notification_rules r ON p.rule_id = r.rule_id
      ORDER BY p.cloned_at DESC, p.created_at DESC
    `).all<any>()

    const productionNotifications = (results || []).map((row: any) => {
      const rule = row.r_rule_id
        ? mapDbRowToRule({
            rule_id: row.r_rule_id,
            engine: row.r_engine,
            rule_name: row.r_rule_name,
            trigger: row.r_trigger,
            audience: row.r_audience,
            communication_objective: row.r_communication_objective,
            priority: row.r_priority,
            delivery: row.r_delivery,
            channel_tier: row.r_channel_tier,
            email_delivery_policy: row.r_email_delivery_policy,
            cooldown: row.r_cooldown,
            suppression: row.r_suppression,
            source_workbook: row.r_source_workbook,
            attention_class: row.r_attention_class,
            candidate_score: row.r_candidate_score,
            guaranteed_experience: row.r_guaranteed_experience,
            batch_eligible: row.r_batch_eligible,
            runtime_memory_dependency: row.r_runtime_memory_dependency,
            attention_queue_group: row.r_attention_queue_group,
            rotation_group: row.r_rotation_group,
            timing: row.r_timing,
            merge_policy: row.r_merge_policy,
            default_decision_reason: row.r_default_decision_reason,
            experience_type: row.r_experience_type,
            memory_keys: row.r_memory_keys,
            decision_reason_template: row.r_decision_reason_template,
            candidate_audiences: row.r_candidate_audiences,
            candidate_experiences: row.r_candidate_experiences,
            template_id: row.r_template_id,
            change_notes: row.r_change_notes,
          })
        : null
      return mapDbRowToProductionNotification(row, rule)
    })

    return jsonResponse({
      productionNotifications,
      count: productionNotifications.length,
      source: 'cloudflare-d1',
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to query production notifications' }, 500)
  }
}

// POST /api/production - Insert or clone a notification into production_notifications
export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    await env.DB.exec(ENSURE_PROD_TABLE_SQL).catch(() => {})

    const data: any = await request.json()
    const id = data.id || `prod-${Date.now()}-${Math.random().toString(36).substr(2, 6)}`
    const originalScenarioId = data.originalScenarioId || data.id || ''
    const key = data.key || `PROD-${Date.now().toString().slice(-4)}`
    const now = new Date().toISOString()
    const governanceEvent = data.governanceEvent !== undefined ? data.governanceEvent : ''

    await env.DB.prepare(`
      INSERT INTO production_notifications (
        id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
        communication_objective, desired_outcome, push_subject, push_body,
        email_subject, email_body, in_app_experience, cta, comments, notes, status,
        priority, environment, rule_id, cloned_at, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `)
      .bind(
        id,
        originalScenarioId,
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
        data.notes || '',
        data.status || 'READY FOR PROD',
        data.priority || 'Medium',
        data.environment || 'PROD',
        data.ruleId || '',
        data.clonedAt || now,
        data.createdAt || now,
        now
      )
      .run()

    const created = await env.DB.prepare('SELECT * FROM production_notifications WHERE id = ?')
      .bind(id)
      .first<ProductionNotificationDbRow>()

    return jsonResponse(
      { productionNotification: created ? mapDbRowToProductionNotification(created) : null },
      201
    )
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to create production notification in D1' }, 500)
  }
}
