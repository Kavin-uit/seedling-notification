import type { NotificationScenario } from '../types/notification'

const LOCAL_STORAGE_KEY = 'seedling_scenarios_v1'

export type DbConnectionStatus = 'connecting' | 'connected' | 'offline'

class ScenariosApi {
  private connectionStatus: DbConnectionStatus = 'connecting'
  private listeners: ((status: DbConnectionStatus) => void)[] = []

  public onStatusChange(listener: (status: DbConnectionStatus) => void) {
    this.listeners.push(listener)
    listener(this.connectionStatus)
    return () => {
      this.listeners = this.listeners.filter((l) => l !== listener)
    }
  }

  private setStatus(status: DbConnectionStatus) {
    if (this.connectionStatus !== status) {
      this.connectionStatus = status
      this.listeners.forEach((l) => l(status))
    }
  }

  public getStatus(): DbConnectionStatus {
    return this.connectionStatus
  }

  // Helper: Read local fallback cache
  private getLocalCache(): NotificationScenario[] {
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
    return []
  }

  // Helper: Write local fallback cache
  private setLocalCache(scenarios: NotificationScenario[]) {
    try {
      localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(scenarios))
    } catch {
      // ignore
    }
  }

  // GET: Fetch all scenarios
  async fetchScenarios(): Promise<{ scenarios: NotificationScenario[]; source: 'cloudflare-d1' | 'local-cache' }> {
    try {
      const res = await fetch('/api/scenarios', {
        headers: { Accept: 'application/json' },
      })
      const contentType = res.headers.get('content-type') || ''

      if (res.ok && contentType.includes('application/json')) {
        const data = await res.json()
        if (data && Array.isArray(data.scenarios) && data.scenarios.length > 0) {
          this.setStatus('connected')
          // Preserve local version history and field history across D1 refreshes
          const local = this.getLocalCache()
          const localMap = new Map(local.map((s) => [s.id, s]))
          const merged: NotificationScenario[] = data.scenarios.map((s: NotificationScenario) => {
            const cached = localMap.get(s.id)
            if (cached) {
              return {
                ...s,
                versionHistory: cached.versionHistory || s.versionHistory || [],
                fieldHistory: cached.fieldHistory || s.fieldHistory || {},
              }
            }
            return s
          })
          this.setLocalCache(merged)
          return { scenarios: merged, source: 'cloudflare-d1' }
        }
      }
    } catch {
      // Network error or standalone vite dev without backend
    }

    this.setStatus('offline')
    const fallback = this.getLocalCache()
    return { scenarios: fallback, source: 'local-cache' }
  }

  // POST: Create scenario
  async createScenario(scenario: NotificationScenario): Promise<NotificationScenario> {
    const current = this.getLocalCache()
    this.setLocalCache([scenario, ...current])

    try {
      const res = await fetch('/api/scenarios', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(scenario),
      })
      const contentType = res.headers.get('content-type') || ''
      if (res.ok && contentType.includes('application/json')) {
        const data = await res.json()
        if (data.scenario) {
          this.setStatus('connected')
          return {
            ...data.scenario,
            versionHistory: scenario.versionHistory || data.scenario.versionHistory || [],
            fieldHistory: scenario.fieldHistory || data.scenario.fieldHistory || {},
          }
        }
      }
    } catch {
      // offline fallback
    }

    this.setStatus('offline')
    return scenario
  }

  // PUT: Update scenario (inline edit, status change, engine switch)
  async updateScenario(scenario: NotificationScenario): Promise<NotificationScenario> {
    // Immediately persist to local cache so updates never get lost
    const current = this.getLocalCache()
    const exists = current.some((s) => s.id === scenario.id)
    const updatedList = exists
      ? current.map((s) => (s.id === scenario.id ? scenario : s))
      : [...current, scenario]
    this.setLocalCache(updatedList)

    try {
      const res = await fetch(`/api/scenarios/${encodeURIComponent(scenario.id)}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(scenario),
      })
      const contentType = res.headers.get('content-type') || ''
      if (res.ok && contentType.includes('application/json')) {
        const data = await res.json()
        if (data.scenario) {
          this.setStatus('connected')
          return {
            ...data.scenario,
            versionHistory: scenario.versionHistory || data.scenario.versionHistory || [],
            fieldHistory: scenario.fieldHistory || data.scenario.fieldHistory || {},
          }
        }
      }
    } catch {
      // offline fallback
    }

    this.setStatus('offline')
    return scenario
  }

  // DELETE: Delete scenario
  async deleteScenario(id: string): Promise<boolean> {
    try {
      const res = await fetch(`/api/scenarios/${encodeURIComponent(id)}`, {
        method: 'DELETE',
      })
      if (res.ok) {
        this.setStatus('connected')
        const current = this.getLocalCache()
        this.setLocalCache(current.filter((s) => s.id !== id))
        return true
      }
    } catch {
      // offline fallback
    }

    this.setStatus('offline')
    const current = this.getLocalCache()
    this.setLocalCache(current.filter((s) => s.id !== id))
    return true
  }

  // POST: Bulk import scenarios
  async bulkImportScenarios(scenarios: NotificationScenario[]): Promise<NotificationScenario[]> {
    try {
      const res = await fetch('/api/scenarios/bulk', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ scenarios }),
      })
      if (res.ok) {
        const data = await res.json()
        if (data.scenarios && Array.isArray(data.scenarios)) {
          this.setStatus('connected')
          this.setLocalCache(data.scenarios)
          return data.scenarios
        }
      }
    } catch {
      // offline fallback
    }

    this.setStatus('offline')
    this.setLocalCache(scenarios)
    return scenarios
  }
}

export const scenariosApi = new ScenariosApi()
