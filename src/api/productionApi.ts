import type { ProductionNotification, NotificationScenario } from '../types/notification'
import { DEFAULT_PRODUCTION_NOTIFICATIONS } from '../data/defaultProductionNotifications'

const LOCAL_STORAGE_KEY = 'seedling_production_notifications_v1'

export type DbConnectionStatus = 'connecting' | 'connected' | 'offline'

class ProductionApi {
  private connectionStatus: DbConnectionStatus = 'connecting'
  private listeners: ((status: DbConnectionStatus) => void)[] = []
  private inFlightFetch: Promise<{ productionNotifications: ProductionNotification[]; source: 'cloudflare-d1' | 'local-cache' }> | null = null

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

  // Local Storage fallback cache
  public getLocalCache(): ProductionNotification[] {
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
    return DEFAULT_PRODUCTION_NOTIFICATIONS
  }

  public setLocalCache(items: ProductionNotification[]) {
    try {
      localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(items))
    } catch {
      // ignore
    }
  }

  // GET: Fetch all production notifications
  async fetchProductionNotifications(): Promise<{ productionNotifications: ProductionNotification[]; source: 'cloudflare-d1' | 'local-cache' }> {
    if (this.inFlightFetch) {
      return this.inFlightFetch
    }

    this.inFlightFetch = (async () => {
      try {
        const res = await fetch('/api/production', {
          headers: { Accept: 'application/json' },
        })
        const contentType = res.headers.get('content-type') || ''

        if (res.ok && contentType.includes('application/json')) {
          const data = await res.json()
          if (data && Array.isArray(data.productionNotifications)) {
            this.setStatus('connected')
            this.setLocalCache(data.productionNotifications)
            return {
              productionNotifications: data.productionNotifications,
              source: 'cloudflare-d1' as const,
            }
          }
        }
      } catch {
        // Network error or local dev
      }

      this.setStatus('offline')
      const fallback = this.getLocalCache()
      return { productionNotifications: fallback, source: 'local-cache' as const }
    })().finally(() => {
      this.inFlightFetch = null
    })

    return this.inFlightFetch
  }

  // POST: Clone and insert a scenario into production
  async cloneToProduction(
    scenario: NotificationScenario
  ): Promise<{ productionNotification: ProductionNotification; source: 'cloudflare-d1' | 'local-cache' }> {
    const now = new Date().toISOString()
    const id = `prod-${scenario.id}-${Date.now().toString().slice(-4)}`
    const cloned: ProductionNotification = {
      ...scenario,
      id,
      originalScenarioId: scenario.id,
      key: scenario.key.startsWith('PROD-') ? scenario.key : `PROD-${scenario.key}`,
      environment: 'PROD',
      status: 'READY FOR PROD',
      clonedAt: now,
      createdAt: now,
      updatedAt: now,
    }

    // Always update local cache first for instant optimistic update
    const currentList = this.getLocalCache()
    const updatedList = [cloned, ...currentList.filter((item) => item.id !== id)]
    this.setLocalCache(updatedList)

    try {
      const res = await fetch('/api/production', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(cloned),
      })

      if (res.ok) {
        const data = await res.json()
        if (data && data.productionNotification) {
          const serverCreated = data.productionNotification
          const finalMerged = [serverCreated, ...currentList.filter((item) => item.id !== id)]
          this.setLocalCache(finalMerged)
          return { productionNotification: serverCreated, source: 'cloudflare-d1' }
        }
      }
    } catch {
      // Offline fallback
    }

    return { productionNotification: cloned, source: 'local-cache' }
  }

  // PUT: Update an existing production notification
  async updateProductionNotification(
    item: ProductionNotification
  ): Promise<{ productionNotification: ProductionNotification; source: 'cloudflare-d1' | 'local-cache' }> {
    const currentList = this.getLocalCache()
    const updated = { ...item, updatedAt: new Date().toISOString() }
    const updatedList = currentList.map((i) => (i.id === item.id ? updated : i))
    this.setLocalCache(updatedList)

    try {
      const res = await fetch(`/api/production/${encodeURIComponent(item.id)}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(item),
      })

      if (res.ok) {
        const data = await res.json()
        if (data && data.productionNotification) {
          return { productionNotification: data.productionNotification, source: 'cloudflare-d1' }
        }
      }
    } catch {
      // Fallback to local cache
    }

    return { productionNotification: updated, source: 'local-cache' }
  }

  // DELETE: Remove a notification from production
  async deleteProductionNotification(id: string): Promise<boolean> {
    const currentList = this.getLocalCache()
    const updatedList = currentList.filter((i) => i.id !== id)
    this.setLocalCache(updatedList)

    try {
      const res = await fetch(`/api/production/${encodeURIComponent(id)}`, {
        method: 'DELETE',
      })
      return res.ok
    } catch {
      return true
    }
  }
}

export const productionApi = new ProductionApi()
