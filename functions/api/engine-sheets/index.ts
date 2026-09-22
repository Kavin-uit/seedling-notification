import { Env, EngineSheetDbRow, jsonResponse } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return jsonResponse({}, 200)
}

// GET /api/engine-sheets - Fetch all registered engine sheets
export const onRequestGet: PagesFunction<Env> = async ({ env }) => {
  if (!env.DB) {
    return jsonResponse(
      { error: 'Cloudflare D1 database binding (env.DB) not found.' },
      503
    )
  }

  try {
    const { results } = await env.DB.prepare(
      'SELECT * FROM engine_sheets ORDER BY engine_category ASC'
    ).all<EngineSheetDbRow>()

    const sheets = (results || []).map((row) => ({
      engineCategory: row.engine_category,
      sheetName: row.sheet_name,
      sheetUrl: row.sheet_url,
      csvExportUrl: row.csv_export_url,
      enabled: Boolean(row.enabled),
      createdAt: row.created_at,
      updatedAt: row.updated_at,
    }))

    return jsonResponse({
      sheets,
      count: sheets.length,
      source: 'cloudflare-d1',
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to query engine_sheets from D1' }, 500)
  }
}

// PUT /api/engine-sheets - Upsert an engine sheet configuration
export const onRequestPut: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    const data: any = await request.json()
    const engineCategory = (data.engineCategory || '').trim()
    const sheetName = (data.sheetName || `${engineCategory} Content Sheet`).trim()
    const sheetUrl = (data.sheetUrl || '').trim()
    const csvExportUrl = (data.csvExportUrl || '').trim()
    const enabled = data.enabled === false ? 0 : 1

    if (!engineCategory) {
      return jsonResponse({ error: 'engineCategory is required' }, 400)
    }

    await env.DB.prepare(`
      INSERT INTO engine_sheets (
        engine_category, sheet_name, sheet_url, csv_export_url, enabled, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, datetime('now'), datetime('now'))
      ON CONFLICT(engine_category) DO UPDATE SET
        sheet_name = excluded.sheet_name,
        sheet_url = excluded.sheet_url,
        csv_export_url = excluded.csv_export_url,
        enabled = excluded.enabled,
        updated_at = datetime('now')
    `)
      .bind(engineCategory, sheetName, sheetUrl, csvExportUrl, enabled)
      .run()

    return jsonResponse({
      success: true,
      sheet: {
        engineCategory,
        sheetName,
        sheetUrl,
        csvExportUrl,
        enabled: Boolean(enabled),
      },
    })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to save engine sheet' }, 500)
  }
}

// POST /api/engine-sheets - Insert or update (alias for PUT)
export const onRequestPost: PagesFunction<Env> = onRequestPut

// DELETE /api/engine-sheets - Delete an engine sheet (cannot delete Governance)
export const onRequestDelete: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.DB) {
    return jsonResponse({ error: 'Cloudflare D1 database binding not found' }, 503)
  }

  try {
    const url = new URL(request.url)
    let engine = url.searchParams.get('engine')

    if (!engine) {
      try {
        const body: any = await request.json()
        engine = body.engineCategory || body.engine
      } catch {
        // No body
      }
    }

    if (!engine) {
      return jsonResponse({ error: 'engine parameter is required' }, 400)
    }

    if (engine.toLowerCase() === 'governance') {
      return jsonResponse({ error: 'Governance engine sheet cannot be deleted' }, 400)
    }

    await env.DB.prepare('DELETE FROM engine_sheets WHERE engine_category = ?')
      .bind(engine)
      .run()

    return jsonResponse({ success: true, deletedEngine: engine })
  } catch (error: any) {
    return jsonResponse({ error: error.message || 'Failed to delete engine sheet' }, 500)
  }
}
