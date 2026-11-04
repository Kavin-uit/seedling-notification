// Production Activity Log — persisted to localStorage
// Logs whenever a new notification is added to Production Ready.

export interface ProductionActivityEntry {
  id: string
  timestamp: string       // ISO 8601
  action: 'ADDED'
  prodKey: string         // e.g. "PROD-OPP-171"
  governanceEvent: string
  engineCategory: string
  ruleId?: string
}

const LOG_KEY = 'seedling_prod_activity_log_v1'
const MAX_ENTRIES = 500

export function getActivityLog(): ProductionActivityEntry[] {
  try {
    const raw = localStorage.getItem(LOG_KEY)
    if (!raw) return []
    return JSON.parse(raw) as ProductionActivityEntry[]
  } catch {
    return []
  }
}

export function addActivityEntry(
  entry: Omit<ProductionActivityEntry, 'id' | 'timestamp'>
): void {
  try {
    const log = getActivityLog()
    const newEntry: ProductionActivityEntry = {
      id: crypto.randomUUID(),
      timestamp: new Date().toISOString(),
      ...entry,
    }
    // Newest first, cap at MAX_ENTRIES
    const updated = [newEntry, ...log].slice(0, MAX_ENTRIES)
    localStorage.setItem(LOG_KEY, JSON.stringify(updated))
  } catch {
    // Silently fail — never break the main flow
  }
}

export function clearActivityLog(): void {
  try {
    localStorage.removeItem(LOG_KEY)
  } catch {}
}

