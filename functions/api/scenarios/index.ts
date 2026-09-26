import { Env, ScenarioDbRow, jsonResponse, mapDbRowToScenario, mapDbRowToRule } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/scenarios - Fetch all scenarios from Cloudflare D1 with joined rules
export const onRequestGet: PagesFunction<Env> = async ({ env }) => {
  if (!env.DB) {
    return jsonResponse(
      { error: 'Cloudflare D1 database binding (env.DB) not found. Check wrangler.json configuration.' },
      503
    )
  }

  try {
    const { results } = await env.DB.prepare(`
      SELECT 
        s.*,
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
      FROM scenarios s
      LEFT JOIN notification_rules r ON s.rule_id = r.rule_id
      ORDER BY s.created_at ASC
    `).all<any>()

    const scenarios = (results || []).map((row: any) => {
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
      return mapDbRowToScenario(row, rule)
    })

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
        priority, environment, rule_id, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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
        data.ruleId || '',
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
