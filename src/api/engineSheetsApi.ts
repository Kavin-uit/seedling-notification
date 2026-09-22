import type { EngineSheetConfig } from '../services/sheetVerificationService'
import { DEFAULT_ENGINE_SHEETS } from '../services/sheetVerificationService'

const LOCAL_STORAGE_KEY = 'seedling_engine_sheets_v1'

class EngineSheetsApi {
  getLocalCache(): Record<string, EngineSheetConfig> {
    try {
      const stored = localStorage.getItem(LOCAL_STORAGE_KEY)
      if (stored) {
        const parsed = JSON.parse(stored)
        const merged: Record<string, EngineSheetConfig> = { ...DEFAULT_ENGINE_SHEETS }
        for (const [k, v] of Object.entries(parsed)) {
          const item = v as EngineSheetConfig
          merged[k] = {
            ...DEFAULT_ENGINE_SHEETS[k],
            ...item,
            sheetUrl: item.sheetUrl || DEFAULT_ENGINE_SHEETS[k]?.sheetUrl || '',
            csvExportUrl: item.csvExportUrl || DEFAULT_ENGINE_SHEETS[k]?.csvExportUrl || '',
            enabled: item.sheetUrl ? item.enabled : (DEFAULT_ENGINE_SHEETS[k]?.enabled ?? true),
          }
        }
        return merged
      }
    } catch {
      // ignore
    }
    return { ...DEFAULT_ENGINE_SHEETS }
  }

  setLocalCache(configs: Record<string, EngineSheetConfig>) {
    try {
      localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(configs))
    } catch {
      // ignore
    }
  }

  async fetchEngineSheets(): Promise<Record<string, EngineSheetConfig>> {
    try {
      const res = await fetch('/api/engine-sheets', {
        headers: { Accept: 'application/json' },
      })
      if (res.ok) {
        const data = await res.json()
        if (Array.isArray(data.sheets) && data.sheets.length > 0) {
          const mapped: Record<string, EngineSheetConfig> = { ...DEFAULT_ENGINE_SHEETS }
          for (const s of data.sheets) {
            mapped[s.engineCategory] = {
              engineCategory: s.engineCategory,
              sheetName: s.sheetName || `${s.engineCategory} Content Sheet`,
              sheetUrl: s.sheetUrl,
              csvExportUrl: s.csvExportUrl,
              enabled: s.enabled ?? true,
            }
          }
          this.setLocalCache(mapped)
          return mapped
        }
      }
    } catch (e) {
      console.warn('Failed to fetch engine sheets from D1, using local cache:', e)
    }
    return this.getLocalCache()
  }

  async saveEngineSheet(config: EngineSheetConfig): Promise<boolean> {
    const current = this.getLocalCache()
    current[config.engineCategory] = config
    this.setLocalCache(current)

    try {
      const res = await fetch('/api/engine-sheets', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(config),
      })
      return res.ok
    } catch (e) {
      console.warn('Failed to save engine sheet to D1:', e)
      return false
    }
  }

  async deleteEngineSheet(engineCategory: string): Promise<boolean> {
    const current = this.getLocalCache()
    delete current[engineCategory]
    this.setLocalCache(current)

    try {
      const res = await fetch(`/api/engine-sheets?engine=${encodeURIComponent(engineCategory)}`, {
        method: 'DELETE',
      })
      return res.ok
    } catch (e) {
      console.warn('Failed to delete engine sheet from D1:', e)
      return false
    }
  }
}

export const engineSheetsApi = new EngineSheetsApi()
