import type { NotificationScenario } from '../types/notification'
import { parseStatuses } from '../types/notification'
import { executeSearch } from './aiSearch'

export interface ScenarioFilterOptions {
  selectedEngine?: string
  statusFilter?: string
  searchQuery?: string
  isAiSearch?: boolean
}

export function parseSelectedEngines(selectedEngine?: string): string[] {
  if (!selectedEngine || selectedEngine === 'ALL' || selectedEngine === '__HIDDEN__' || selectedEngine.toLowerCase() === 'hidden') return []
  return selectedEngine
    .split(',')
    .map((e) => e.trim().replace(/\s+engine$/i, '').toLowerCase())
    .filter(Boolean)
}

export function matchesEngineCategory(
  category: string | undefined,
  selectedEngine?: string
): boolean {
  if (!selectedEngine || selectedEngine === 'ALL') return true
  if (selectedEngine === '__HIDDEN__' || selectedEngine.toLowerCase() === 'hidden') return false
  const list = parseSelectedEngines(selectedEngine)
  if (list.length === 0) return true
  const sEngine = (category || 'Governance').trim().replace(/\s+engine$/i, '').toLowerCase()
  return list.includes(sEngine)
}

export function isScenarioHidden(s: NotificationScenario): boolean {
  const statuses = parseStatuses(s.status)
  return statuses.some(
    (st) => st.trim().toUpperCase() === 'HIDE' || st.trim().toUpperCase() === 'HIDDEN'
  )
}

/**
 * Filter scenarios matching the active engine category, status filter, and global search query.
 * Matches the exact filtering logic displayed in JiraTable and used for Excel export.
 */
export function filterScenarios(
  scenarios: NotificationScenario[],
  options: ScenarioFilterOptions
): NotificationScenario[] {
  const {
    selectedEngine = 'ALL',
    statusFilter = 'ALL',
    searchQuery = '',
    isAiSearch = false,
  } = options

  const isHiddenView = selectedEngine === '__HIDDEN__' || selectedEngine.toLowerCase() === 'hidden'

  // 1. When global search query is entered, search across appropriate subset
  if (searchQuery && searchQuery.trim().length > 0) {
    const allMatches = executeSearch(scenarios, searchQuery, Boolean(isAiSearch)).results
    if (isHiddenView) {
      return allMatches.filter(isScenarioHidden)
    }
    return allMatches.filter((s) => !isScenarioHidden(s))
  }

  // 2. Hidden Notifications View: return ONLY scenarios marked as HIDE / HIDDEN
  if (isHiddenView) {
    return scenarios.filter(isScenarioHidden)
  }

  // 3. Normal View: Always exclude HIDE / HIDDEN scenarios
  const activeScenarios = scenarios.filter((s) => !isScenarioHidden(s))

  const activeStatuses =
    statusFilter && statusFilter !== 'ALL'
      ? statusFilter
          .split(',')
          .map((s) => s.trim())
          .filter((s) => s && s !== 'ALL')
      : []

  return activeScenarios.filter((s) => {
    const matchesEngine = matchesEngineCategory(s.engineCategory, selectedEngine)
    if (!matchesEngine) return false

    if (activeStatuses.length === 0) return true

    const activeList = parseStatuses(s.status)
    const upperActiveList = activeList.map((st) => st.trim().toUpperCase())

    return activeStatuses.some((sel) => {
      const cleanSel = sel.trim().toUpperCase()
      if (cleanSel === 'NOT_WORKING_ANY' || cleanSel === 'ALL NOT WORKING') {
        return upperActiveList.some((st) => st.includes('NOT WORKING'))
      }
      return upperActiveList.includes(cleanSel)
    })
  })
}
