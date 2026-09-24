import { Env } from '../_types'

export const onRequestOptions: PagesFunction<Env> = async () => {
  return new Response(null, {
    status: 204,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    },
  })
}

// GET /api/engine-sheets/proxy?url=<encoded_url>
// Edge proxy for Google Sheets CSV exports to bypass client-side CORS restrictions
export const onRequestGet: PagesFunction<Env> = async ({ request }) => {
  try {
    const requestUrl = new URL(request.url)
    const targetUrl = requestUrl.searchParams.get('url')

    if (!targetUrl) {
      return new Response(JSON.stringify({ error: 'Missing target url parameter' }), {
        status: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      })
    }

    // Security check: Only allow docs.google.com and googleusercontent.com URLs
    const parsedTarget = new URL(targetUrl)
    const allowedHosts = ['docs.google.com', 'sheets.google.com', 'drive.google.com']
    if (!allowedHosts.some((h) => parsedTarget.hostname.endsWith(h))) {
      return new Response(JSON.stringify({ error: 'URL hostname not allowed' }), {
        status: 403,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      })
    }

    const response = await fetch(targetUrl, {
      method: 'GET',
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        Accept: 'text/csv,text/plain,*/*',
      },
      redirect: 'follow',
    })

    if (!response.ok) {
      return new Response(JSON.stringify({ error: `Google returned HTTP ${response.status}` }), {
        status: response.status,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      })
    }

    const csvContent = await response.text()

    return new Response(csvContent, {
      status: 200,
      headers: {
        'Content-Type': 'text/csv; charset=utf-8',
        'Cache-Control': 'public, max-age=60', // cache for 60 seconds
        'Access-Control-Allow-Origin': '*',
      },
    })
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message || 'Failed to proxy sheet' }), {
      status: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    })
  }
}
