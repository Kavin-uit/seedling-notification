import {
  Env,
  ProductionNotificationDbRow,
  jsonResponse,
  mapDbRowToProductionNotification,
} from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/production/:id - Get a single production notification
export const onRequestGet: PagesFunction<Env> = async ({ params, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Production notification ID is required' }, 400)
  }

  try {
    const row = await env.DB.prepare('SELECT * FROM production_notifications WHERE id = ?')
      .bind(id)
      .first<ProductionNotificationDbRow>()

    if (!row) {
      return jsonResponse({ error: `Production notification with id ${id} not found` }, 404)
    }

    return jsonResponse({ productionNotification: mapDbRowToProductionNotification(row) }, 200)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to fetch production notification' }, 500)
  }
}

// PUT /api/production/:id - Update an existing production notification
export const onRequestPut: PagesFunction<Env> = async ({ params, request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Production notification ID is required' }, 400)
  }

  try {
    const data: any = await request.json()
    const now = new Date().toISOString()

    const existing = await env.DB.prepare('SELECT * FROM production_notifications WHERE id = ?')
      .bind(id)
      .first<ProductionNotificationDbRow>()

    if (!existing) {
      return jsonResponse({ error: `Production notification with id ${id} not found` }, 404)
    }

    await env.DB.prepare(`
      UPDATE production_notifications
      SET
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
        data.governanceEvent !== undefined ? data.governanceEvent : existing.governance_event,
        data.trigger !== undefined ? data.trigger : existing.trigger,
        data.audience !== undefined ? data.audience : existing.audience,
        data.communicationObjective !== undefined ? data.communicationObjective : existing.communication_objective,
        data.desiredOutcome !== undefined ? data.desiredOutcome : existing.desired_outcome,
        data.pushSubject !== undefined ? data.pushSubject : existing.push_subject,
        data.pushBody !== undefined ? data.pushBody : existing.push_body,
        data.emailSubject !== undefined ? data.emailSubject : existing.email_subject,
        data.emailBody !== undefined ? data.emailBody : existing.email_body,
        data.inAppExperience !== undefined ? data.inAppExperience : existing.in_app_experience,
        data.cta !== undefined ? data.cta : existing.cta,
        data.comments !== undefined ? data.comments : existing.comments,
        data.notes !== undefined ? data.notes : existing.notes,
        data.status !== undefined ? data.status : existing.status,
        data.priority !== undefined ? data.priority : existing.priority,
        data.environment !== undefined ? data.environment : existing.environment,
        now,
        id
      )
      .run()

    const updated = await env.DB.prepare('SELECT * FROM production_notifications WHERE id = ?')
      .bind(id)
      .first<ProductionNotificationDbRow>()

    return jsonResponse({
      productionNotification: updated ? mapDbRowToProductionNotification(updated) : null,
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to update production notification' }, 500)
  }
}

// DELETE /api/production/:id - Remove a notification from production
export const onRequestDelete: PagesFunction<Env> = async ({ params, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Production notification ID is required' }, 400)
  }

  try {
    await env.DB.prepare('DELETE FROM production_notifications WHERE id = ?').bind(id).run()
    return jsonResponse({ success: true, message: `Production notification ${id} removed successfully` })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to delete production notification' }, 500)
  }
}
