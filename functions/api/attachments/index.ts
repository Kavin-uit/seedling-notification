import { AwsClient } from 'aws4fetch'
import {
  Env,
  getR2Config,
  jsonResponse,
  mapDbRowToAttachment,
  ScenarioAttachmentDbRow,
} from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/attachments - List attachments (optional query param: scenarioId)
export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const url = new URL(request.url)
  const scenarioId = url.searchParams.get('scenarioId')

  try {
    if (scenarioId) {
      const { results } = await env.DB.prepare(
        'SELECT * FROM scenario_attachments WHERE scenario_id = ? ORDER BY created_at DESC'
      )
        .bind(scenarioId)
        .all<ScenarioAttachmentDbRow>()

      const attachments = (results || []).map(mapDbRowToAttachment)
      return jsonResponse({ attachments })
    }

    // If no scenarioId, return all attachments and counts per scenarioId
    const { results } = await env.DB.prepare(
      'SELECT * FROM scenario_attachments ORDER BY created_at DESC'
    ).all<ScenarioAttachmentDbRow>()

    const attachments = (results || []).map(mapDbRowToAttachment)
    const counts: Record<string, number> = {}
    for (const a of attachments) {
      counts[a.scenarioId] = (counts[a.scenarioId] || 0) + 1
    }

    return jsonResponse({ attachments, counts })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to query attachments' }, 500)
  }
}

// POST /api/attachments - Upload image to R2 and save in D1
export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    const formData = await request.formData()
    const file = formData.get('file') as File | null
    const scenarioId = formData.get('scenarioId') as string | null
    const tag = (formData.get('tag') as string) || 'screenshot'

    if (!file || !scenarioId) {
      return jsonResponse(
        { error: 'Missing required fields: file and scenarioId are required' },
        400
      )
    }

    const r2Config = getR2Config(env)
    const aws = new AwsClient({
      accessKeyId: r2Config.accessKeyId,
      secretAccessKey: r2Config.secretAccessKey,
      service: 's3',
      region: 'auto',
    })

    const attachmentId = `att-${Date.now()}-${Math.random().toString(36).substring(2, 8)}`
    const cleanFileName = file.name.replace(/[^a-zA-Z0-9._-]/g, '_')
    const r2Key = `scenarios/${scenarioId}/${attachmentId}-${cleanFileName}`

    // Upload to Cloudflare R2
    const r2UploadUrl = `https://${r2Config.accountId}.r2.cloudflarestorage.com/${r2Config.bucketName}/${r2Key}`
    const fileBuffer = await file.arrayBuffer()

    const r2Response = await aws.fetch(r2UploadUrl, {
      method: 'PUT',
      headers: {
        'Content-Type': file.type || 'application/octet-stream',
        'Cache-Control': 'public, max-age=31536000',
      },
      body: fileBuffer,
    })

    if (!r2Response.ok) {
      const errText = await r2Response.text()
      return jsonResponse(
        { error: `Failed to upload to R2 (${r2Response.status}): ${errText}` },
        502
      )
    }

    // Public URL through the enabled R2.dev domain
    const publicUrl = `${r2Config.publicDomain}/${r2Key}`
    const now = new Date().toISOString()

    // Save record in Cloudflare D1
    await env.DB.prepare(`
      INSERT INTO scenario_attachments (
        id, scenario_id, file_name, file_type, file_size, r2_key, public_url, tag, created_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    `)
      .bind(
        attachmentId,
        scenarioId,
        file.name,
        file.type || 'image/png',
        file.size,
        r2Key,
        publicUrl,
        tag,
        now
      )
      .run()

    const attachment: ScenarioAttachmentDbRow = {
      id: attachmentId,
      scenario_id: scenarioId,
      file_name: file.name,
      file_type: file.type || 'image/png',
      file_size: file.size,
      r2_key: r2Key,
      public_url: publicUrl,
      tag,
      created_at: now,
    }

    return jsonResponse({ attachment: mapDbRowToAttachment(attachment) }, 201)
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to upload attachment' }, 500)
  }
}
