import { AwsClient } from 'aws4fetch'
import {
  Env,
  getR2Config,
  jsonResponse,
  ScenarioAttachmentDbRow,
} from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// DELETE /api/attachments/:id - Delete attachment from Cloudflare R2 and D1
export const onRequestDelete: PagesFunction<Env, 'id'> = async ({ params, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  const id = params.id as string
  if (!id) {
    return jsonResponse({ error: 'Attachment ID parameter is required' }, 400)
  }

  try {
    // 1. Get attachment record from D1
    const attachment = await env.DB.prepare(
      'SELECT * FROM scenario_attachments WHERE id = ?'
    )
      .bind(id)
      .first<ScenarioAttachmentDbRow>()

    if (!attachment) {
      return jsonResponse({ error: 'Attachment not found' }, 404)
    }

    // 2. Delete from Cloudflare R2
    const r2Config = getR2Config(env)
    const aws = new AwsClient({
      accessKeyId: r2Config.accessKeyId,
      secretAccessKey: r2Config.secretAccessKey,
      service: 's3',
      region: 'auto',
    })

    const r2DeleteUrl = `https://${r2Config.accountId}.r2.cloudflarestorage.com/${r2Config.bucketName}/${attachment.r2_key}`
    try {
      await aws.fetch(r2DeleteUrl, { method: 'DELETE' })
    } catch (r2Err) {
      console.warn('Warning deleting from R2:', r2Err)
      // Continue to delete from D1 even if R2 already cleaned up
    }

    // 3. Delete from Cloudflare D1
    await env.DB.prepare('DELETE FROM scenario_attachments WHERE id = ?').bind(id).run()

    return jsonResponse({ success: true, id })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to delete attachment' }, 500)
  }
}
