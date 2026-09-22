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

    // Status normalization helper for server
    const normalizeServerStatus = (raw?: string): string | null => {
      if (!raw) return null
      const clean = raw.trim().toUpperCase()
      const valids = [
        'TO DO',
        'TESTED',
        'NOT WORKING',
        'IN-APP NAVIGATION NOT WORKING',
        'NAVIGATION NOT WORKING',
        'PUSH NOTIFICATION NOT WORKING',
        'PUSH NOTIFICATION NAVIGATION NOT WORKING',
        'EMAIL NOTIFICATION NOT WORKING',
        'EMAIL NOTIFICATION NAVIGATION NOT WORKING',
        'SMS NOTIFICATION NOT WORKING',
      ]
      if (valids.includes(clean)) {
        if (clean === 'NAVIGATION NOT WORKING') return 'IN-APP NAVIGATION NOT WORKING'
        return clean
      }
      if (clean === 'PASSED' || clean === 'PASS' || clean === 'VERIFIED') return 'TESTED'
      if (clean.includes('PUSH') && clean.includes('NAV')) return 'PUSH NOTIFICATION NAVIGATION NOT WORKING'
      if (clean.includes('EMAIL') && clean.includes('NAV')) return 'EMAIL NOTIFICATION NAVIGATION NOT WORKING'
      if (clean.includes('NAV')) return 'IN-APP NAVIGATION NOT WORKING'
      if (clean.includes('PUSH') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('BUG'))) return 'PUSH NOTIFICATION NOT WORKING'
      if (clean.includes('EMAIL') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('BUG'))) return 'EMAIL NOTIFICATION NOT WORKING'
      if (clean.includes('SMS') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('BUG'))) return 'SMS NOTIFICATION NOT WORKING'
      if (clean.includes('FAIL') || clean.includes('DEFECT') || clean.includes('BUG')) return 'NOT WORKING'
      if (clean === 'TODO' || clean === 'TO-DO' || clean === 'OPEN') return 'TO DO'
      return null
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
        updated.updated_at,
        id
      )
      .run()

    const result = await env.DB.prepare('SELECT * FROM scenarios WHERE id = ?').bind(id).first<ScenarioDbRow>()

    return jsonResponse({ scenario: result ? mapDbRowToScenario(result) : null }, 200)
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
    const res = await env.DB.prepare('DELETE FROM scenarios WHERE id = ?').bind(id).run()
    return jsonResponse({ success: true, id, changes: res.meta.changes }, 200)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to delete scenario from D1' }, 500)
  }
}
