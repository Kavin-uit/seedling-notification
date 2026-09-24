const LOCAL_STORAGE_KEY = 'seedling_engines_v1'

export const FALLBACK_ENGINES = [
  'Governance',
  'Contribution',
  'Participation',
  'Identity',
  'Opportunity',
  'Discovery',
]

class EnginesApi {
  getLocalCache(): string[] {
    try {
      const stored = localStorage.getItem(LOCAL_STORAGE_KEY)
      if (stored) {
        const parsed = JSON.parse(stored)
        if (Array.isArray(parsed) && parsed.length > 0) {
          return parsed
        }
      }
    } catch {
      // ignore
    }
    return [...FALLBACK_ENGINES]
  }

  setLocalCache(engines: string[]) {
    try {
      localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(engines))
    } catch {
      // ignore
    }
  }

  async fetchEngines(): Promise<string[]> {
    try {
      const res = await fetch('/api/engines', {
        headers: { Accept: 'application/json' },
      })
      if (res.ok) {
        const data = await res.json()
        if (Array.isArray(data.engines) && data.engines.length > 0) {
          const list = data.engines.map((e: string) => (e || '').trim()).filter(Boolean)
          this.setLocalCache(list)
          return list
        }
      }
    } catch (e) {
      console.warn('Failed to fetch engines from D1, using local fallback:', e)
    }
    return this.getLocalCache()
  }
}

export const enginesApi = new EnginesApi()
