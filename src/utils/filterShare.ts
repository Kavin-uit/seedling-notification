import type { EngineCategoryFilter } from '../components/jira/JiraNavbar'

export interface FilterShareParams {
  engine?: EngineCategoryFilter | string
  status?: string | string[]
  statuses?: string[]
  q?: string
}

const KNOWN_STATUSES: string[] = [
  'TO DO',
  'TESTED',
  'NOT WORKING',
  'IN-APP NAVIGATION NOT WORKING',
  'PUSH NOTIFICATION NOT WORKING',
  'PUSH NOTIFICATION NAVIGATION NOT WORKING',
  'EMAIL NOTIFICATION NOT WORKING',
  'EMAIL NOTIFICATION NAVIGATION NOT WORKING',
  'SMS NOTIFICATION NOT WORKING',
]

function normalizeStatusItem(item: string): string {
  const clean = item.trim()
  if (!clean) return ''
  const upper = clean.toUpperCase().replace(/[-_]/g, ' ')

  if (
    upper === 'NOT WORKING ANY' ||
    upper === 'ALL NOT WORKING' ||
    clean === 'NOT_WORKING_ANY'
  ) {
    return 'NOT_WORKING_ANY'
  }
  if (upper === 'TODO' || upper === 'TO DO') return 'TO DO'
  if (upper === 'TESTED' || upper === 'PASS' || upper === 'PASSED') return 'TESTED'

  const matched = KNOWN_STATUSES.find(
    (ks) => ks.toUpperCase().replace(/[-_]/g, ' ') === upper
  )
  if (matched) return matched

  return clean
}

/**
 * Parses query parameters from window.location.search or provided URL string with support for multiple statuses
 */
export function parseFilterUrlParams(urlOrSearch?: string): {
  engine: EngineCategoryFilter
  status: string
  statuses: string[]
  q: string
  hasFilterInUrl: boolean
} {
  let search = ''
  if (urlOrSearch !== undefined) {
    if (urlOrSearch.includes('?')) {
      search = urlOrSearch.slice(urlOrSearch.indexOf('?'))
    } else {
      search = urlOrSearch.startsWith('&')
        ? `?${urlOrSearch.slice(1)}`
        : urlOrSearch.startsWith('?')
        ? urlOrSearch
        : `?${urlOrSearch}`
    }
  } else if (typeof window !== 'undefined') {
    search = window.location.search
  } else {
    return { engine: 'ALL', status: 'ALL', statuses: [], q: '', hasFilterInUrl: false }
  }

  try {
    const params = new URLSearchParams(search)
    const engineParam = params.get('engine')
    const statusParams = params.getAll('status')
    const qParam = params.get('q') || params.get('search') || ''

    let engine: EngineCategoryFilter = 'ALL'
    if (engineParam && engineParam.trim().toUpperCase() !== 'ALL') {
      const trimmed = engineParam.trim()
      engine = trimmed.charAt(0).toUpperCase() + trimmed.slice(1)
    }

    // Split multiple status params and comma-separated status lists
    const rawItems = statusParams
      .flatMap((sp) => sp.split(','))
      .map((s) => s.trim())
      .filter(Boolean)

    const normalizedSet = new Set<string>()
    rawItems.forEach((item) => {
      const norm = normalizeStatusItem(item)
      if (norm && norm.toUpperCase() !== 'ALL') {
        normalizedSet.add(norm)
      }
    })

    const statuses = Array.from(normalizedSet)
    const status = statuses.length > 0 ? statuses.join(',') : 'ALL'

    const hasFilterInUrl =
      engine !== 'ALL' || statuses.length > 0 || Boolean(qParam && qParam.trim().length > 0)

    return {
      engine,
      status,
      statuses,
      q: qParam.trim(),
      hasFilterInUrl,
    }
  } catch {
    return { engine: 'ALL', status: 'ALL', statuses: [], q: '', hasFilterInUrl: false }
  }
}

/**
 * Builds an absolute shareable URL based on the provided filters.
 */
export function buildFilterShareUrl(filters: FilterShareParams, customBaseUrl?: string): string {
  let base = customBaseUrl || ''
  if (!base) {
    if (typeof window !== 'undefined') {
      base = `${window.location.origin}${window.location.pathname}`
    } else {
      base = 'http://localhost:5173/'
    }
  }

  const params = new URLSearchParams()

  if (filters.engine && filters.engine !== 'ALL') {
    params.set('engine', filters.engine)
  }

  // Handle statuses array or status string/array
  const statusList: string[] = []
  if (filters.statuses && filters.statuses.length > 0) {
    filters.statuses.forEach((s) => {
      if (s && s !== 'ALL' && !statusList.includes(s)) statusList.push(s)
    })
  } else if (filters.status) {
    if (Array.isArray(filters.status)) {
      filters.status.forEach((s) => {
        if (s && s !== 'ALL' && !statusList.includes(s)) statusList.push(s)
      })
    } else if (filters.status !== 'ALL') {
      filters.status
        .split(',')
        .map((s) => s.trim())
        .forEach((s) => {
          if (s && s !== 'ALL' && !statusList.includes(s)) statusList.push(s)
        })
    }
  }

  if (statusList.length > 0) {
    params.set('status', statusList.join(','))
  }

  if (filters.q && filters.q.trim()) {
    params.set('q', filters.q.trim())
  }

  const query = params.toString()
  return query ? `${base}?${query}` : base
}

/**
 * Copies the shareable URL to the user's clipboard with fallback support.
 */
export async function copyShareUrlToClipboard(url: string): Promise<boolean> {
  if (!url) return false

  if (navigator?.clipboard?.writeText) {
    try {
      await navigator.clipboard.writeText(url)
      return true
    } catch {
      // Fallback to legacy execCommand below
    }
  }

  try {
    const textArea = document.createElement('textarea')
    textArea.value = url
    textArea.style.position = 'fixed'
    textArea.style.left = '-9999px'
    textArea.style.top = '-9999px'
    document.body.appendChild(textArea)
    textArea.focus()
    textArea.select()
    const successful = document.execCommand('copy')
    document.body.removeChild(textArea)
    return successful
  } catch {
    return false
  }
}

/**
 * Synchronizes current filters to browser address bar without reload.
 */
export function syncFiltersToUrl(filters: FilterShareParams): void {
  if (typeof window === 'undefined') return

  try {
    const params = new URLSearchParams()

    if (filters.engine && filters.engine !== 'ALL') {
      params.set('engine', filters.engine)
    }

    const statusList: string[] = []
    if (filters.statuses && filters.statuses.length > 0) {
      filters.statuses.forEach((s) => {
        if (s && s !== 'ALL' && !statusList.includes(s)) statusList.push(s)
      })
    } else if (filters.status) {
      if (Array.isArray(filters.status)) {
        filters.status.forEach((s) => {
          if (s && s !== 'ALL' && !statusList.includes(s)) statusList.push(s)
        })
      } else if (filters.status !== 'ALL') {
        filters.status
          .split(',')
          .map((s) => s.trim())
          .forEach((s) => {
            if (s && s !== 'ALL' && !statusList.includes(s)) statusList.push(s)
          })
      }
    }

    if (statusList.length > 0) {
      params.set('status', statusList.join(','))
    }

    if (filters.q && filters.q.trim()) {
      params.set('q', filters.q.trim())
    }

    const query = params.toString()
    const targetSearch = query ? `?${query}` : ''

    if (window.location.search !== targetSearch) {
      const newUrl = query
        ? `${window.location.pathname}?${query}${window.location.hash || ''}`
        : `${window.location.pathname}${window.location.hash || ''}`
      window.history.replaceState(null, '', newUrl)
    }
  } catch {
    // Ignore push/replace state errors in sandboxed environments
  }
}
