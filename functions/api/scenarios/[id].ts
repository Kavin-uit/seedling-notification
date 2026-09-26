import { Env, ScenarioDbRow, jsonResponse, mapDbRowToScenario } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// PUT /api/scenarios/:id - Update existing scenario in Cloudflare D1
export const onRequestPut: PagesFunction<Env> = async ({ params, request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Scenario ID is required' }, 400)
  }

  try {
    const data: any = await request.json()
    const now = new Date().toISOString()

    // Ensure notes column exists in D1 schema
    try {
      await env.DB.exec(`ALTER TABLE scenarios ADD COLUMN notes TEXT DEFAULT ''`)
    } catch {
      // Column already exists
    }

    // Fetch current row to merge partial updates
    const current = await env.DB.prepare('SELECT * FROM scenarios WHERE id = ?').bind(id).first<ScenarioDbRow>()
    if (!current) {
      return jsonResponse({ error: `Scenario with id ${id} not found` }, 404)
    }

    // Helper to safely merge field: reject null, undefined, or empty/whitespace string
    const safeStr = (newVal: any, currentVal: string | null | undefined): string => {
      if (newVal === undefined || newVal === null) return currentVal ?? ''
      const trimmed = String(newVal).trim()
      return trimmed.length > 0 ? trimmed : (currentVal ?? '')
    }

    // Status normalization helper for server (flexible for current and future statuses)
    const normalizeServerStatus = (raw?: string): string | null => {
      if (!raw) return null
      const trimmed = String(raw).trim()
      if (!trimmed) return null
      const clean = trimmed.toUpperCase()

      // Normalize common legacy aliases
      if (clean === 'NAVIGATION NOT WORKING') return 'IN-APP NAVIGATION NOT WORKING'
      if (clean === 'PASSED' || clean === 'PASS' || clean === 'VERIFIED') return 'TESTED'
      if (clean === 'TODO' || clean === 'TO-DO' || clean === 'OPEN') return 'TO DO'

      // Accept any standard or future status string cleanly
      return clean
    }

    const validStatus = normalizeServerStatus(data.status)

    const updated = {
      engine_category: safeStr(data.engineCategory, current.engine_category),
      governance_event: safeStr(data.governanceEvent, current.governance_event),
      trigger: safeStr(data.trigger, current.trigger),
      audience: safeStr(data.audience, current.audience),
      communication_objective: safeStr(data.communicationObjective, current.communication_objective),
      desired_outcome: safeStr(data.desiredOutcome, current.desired_outcome),
      push_subject: safeStr(data.pushSubject, current.push_subject),
      push_body: safeStr(data.pushBody, current.push_body),
      email_subject: safeStr(data.emailSubject, current.email_subject),
      email_body: safeStr(data.emailBody, current.email_body),
      in_app_experience: safeStr(data.inAppExperience, current.in_app_experience),
      cta: safeStr(data.cta, current.cta),
      comments: data.comments !== undefined && data.comments !== null
        ? String(data.comments).trim()
        : (current.comments ?? ''),
      notes: data.notes !== undefined && data.notes !== null
        ? String(data.notes).trim()
        : (current.notes ?? ''),
      status: validStatus ?? current.status,
      priority: safeStr(data.priority, current.priority),
      environment: safeStr(data.environment, current.environment),
      rule_id: data.ruleId !== undefined ? String(data.ruleId).trim() : (current.rule_id ?? ''),
      updated_at: now,
    }

    await env.DB.prepare(`
      UPDATE scenarios SET
        engine_category = ?,
        governance_event = ?,
        trigger = ?,
        audience = ?,
        communication_objective = ?,
        desired_outcome = ?,
        push_subject = ?,
        push_body = ?,
        email_subject = ?,
        email_body = ?,
        in_app_experience = ?,
        cta = ?,
        comments = ?,
        notes = ?,
        status = ?,
        priority = ?,
        environment = ?,
        rule_id = ?,
        updated_at = ?
      WHERE id = ?
    `)
      .bind(
        updated.engine_category,
        updated.governance_event,
        updated.trigger,
        updated.audience,
        updated.communication_objective,
        updated.desired_outcome,
        updated.push_subject,
        updated.push_body,
        updated.email_subject,
        updated.email_body,
        updated.in_app_experience,
        updated.cta,
        updated.comments,
        updated.notes,
        updated.status,
        updated.priority,
        updated.environment,
        updated.rule_id,
        updated.updated_at,
        id
      )
      .run()

    const result = await env.DB.prepare(`
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
      WHERE s.id = ?
    `).bind(id).first<any>()

    let mappedScenario = null
    if (result) {
      const rule = result.r_rule_id
        ? {
            ruleId: result.r_rule_id,
            engine: result.r_engine,
            ruleName: result.r_rule_name,
            trigger: result.r_trigger || '',
            audience: result.r_audience || '',
            communicationObjective: result.r_communication_objective || '',
            priority: result.r_priority || 'Medium',
            delivery: result.r_delivery || '',
            channelTier: result.r_channel_tier || '',
            emailDeliveryPolicy: result.r_email_delivery_policy || '',
            cooldown: result.r_cooldown || '',
            suppression: result.r_suppression || '',
            sourceWorkbook: result.r_source_workbook || '',
            attentionClass: result.r_attention_class || '',
            candidateScore: result.r_candidate_score || '',
            guaranteedExperience: result.r_guaranteed_experience || '',
            batchEligible: result.r_batch_eligible || '',
            runtimeMemoryDependency: result.r_runtime_memory_dependency || '',
            attentionQueueGroup: result.r_attention_queue_group || '',
            rotationGroup: result.r_rotation_group || '',
            timing: result.r_timing || '',
            mergePolicy: result.r_merge_policy || '',
            defaultDecisionReason: result.r_default_decision_reason || '',
            experienceType: result.r_experience_type || '',
            memoryKeys: result.r_memory_keys || '',
            decisionReasonTemplate: result.r_decision_reason_template || '',
            candidateAudiences: result.r_candidate_audiences || '',
            candidateExperiences: result.r_candidate_experiences || '',
            templateId: result.r_template_id || '',
            changeNotes: result.r_change_notes || '',
            scenarioId: result.scenario_id || '',
            createdAt: result.created_at,
            updatedAt: result.updated_at,
          }
        : null
      mappedScenario = mapDbRowToScenario(result, rule)
    }

    return jsonResponse({ scenario: mappedScenario }, 200)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to update scenario in D1' }, 500)
  }
}

// DELETE /api/scenarios/:id - Delete scenario from Cloudflare D1
export const onRequestDelete: PagesFunction<Env> = async ({ params, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Scenario ID is required' }, 400)
  }

  try {
    try {
      await env.DB.prepare('DELETE FROM scenario_attachments WHERE scenario_id = ?').bind(id).run()
    } catch {
      // safe ignore if table not yet initialized
    }
    const res = await env.DB.prepare('DELETE FROM scenarios WHERE id = ?').bind(id).run()
    return jsonResponse({ success: true, id, changes: res.meta.changes }, 200)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to delete scenario from D1' }, 500)
  }
}
