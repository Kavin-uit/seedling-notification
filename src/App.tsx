import { useState, useEffect, useCallback, useRef, useMemo } from 'react'
import type { NotificationScenario, ScenarioStatus } from './types/notification'
import { JiraNavbar } from './components/jira/JiraNavbar'
import type { EngineCategoryFilter, EngineMenuItem } from './components/jira/JiraNavbar'
import { JiraTable } from './components/jira/JiraTable'
import { ExcelImportModal } from './components/jira/ExcelImportModal'
import { exportScenariosToExcel } from './utils/excel'
import { scenariosApi } from './api/scenariosApi'
import { engineSheetsApi } from './api/engineSheetsApi'
import { enginesApi } from './api/enginesApi'
import { recordScenarioUpdate } from './utils/versionHistory'
import {
  verifyAllEngines,
  type SheetVerificationSummary,
} from './services/sheetVerificationService'
import { SheetVerificationModal } from './components/jira/SheetVerificationModal'
import { ShareFilterModal } from './components/jira/ShareFilterModal'
import { Loader2, Check } from 'lucide-react'
import { parseFilterUrlParams, syncFiltersToUrl, buildFilterShareUrl } from './utils/filterShare'
import { parseStatuses } from './types/notification'

const FILTERS_STORAGE_KEY = 'seedling_active_filters_v1'

interface InitialFiltersState {
  engine: EngineCategoryFilter
  status: string
  q: string
  hasFilterInUrl: boolean
}

function loadInitialFilters(): InitialFiltersState {
  // 1. URL search params take highest priority (e.g. shared deep links)
  const urlFilters = parseFilterUrlParams()
  if (urlFilters.hasFilterInUrl) {
    try {
      localStorage.setItem(
        FILTERS_STORAGE_KEY,
        JSON.stringify({
          engine: urlFilters.engine,
          status: urlFilters.status,
          q: urlFilters.q,
        })
      )
    } catch {}
    return urlFilters
  }

  // 2. If no filter in URL, restore saved filters from localStorage
  try {
    const saved = localStorage.getItem(FILTERS_STORAGE_KEY)
    if (saved) {
      const parsed = JSON.parse(saved)
      return {
        engine: (parsed.engine as EngineCategoryFilter) || 'ALL',
        status: typeof parsed.status === 'string' ? parsed.status : 'ALL',
        q: typeof parsed.q === 'string' ? parsed.q : '',
        hasFilterInUrl: false,
      }
    }
  } catch (err) {
    console.warn('Failed to parse filters from localStorage', err)
  }

  return {
    engine: 'ALL',
    status: 'ALL',
    q: '',
    hasFilterInUrl: false,
  }
}

export default function App() {
  const [scenarios, setScenarios] = useState<NotificationScenario[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [dbEngines, setDbEngines] = useState<string[]>([])

  // Initialize filters from URL query parameters or localStorage (persists across page refresh)
  const [initialFilters] = useState(() => loadInitialFilters())
  const [selectedEngine, setSelectedEngine] = useState<EngineCategoryFilter>(initialFilters.engine)
  const [searchQuery, setSearchQuery] = useState<string>(initialFilters.q)
  const [statusFilter, setStatusFilter] = useState<string>(initialFilters.status)
  const [isImportOpen, setIsImportOpen] = useState(false)

  // Toast feedback state for sharing links & actions
  const [toastMessage, setToastMessage] = useState<string | null>(null)
  const toastTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  const showToast = useCallback((msg: string) => {
    if (toastTimerRef.current) clearTimeout(toastTimerRef.current)
    setToastMessage(msg)
    toastTimerRef.current = setTimeout(() => {
      setToastMessage(null)
    }, 2800)
  }, [])

  // Keep URL search query parameters & localStorage synced with currently active filters
  useEffect(() => {
    try {
      if (
        selectedEngine !== 'ALL' ||
        statusFilter !== 'ALL' ||
        Boolean(searchQuery && searchQuery.trim().length > 0)
      ) {
        localStorage.setItem(
          FILTERS_STORAGE_KEY,
          JSON.stringify({
            engine: selectedEngine,
            status: statusFilter,
            q: searchQuery,
          })
        )
      } else {
        localStorage.removeItem(FILTERS_STORAGE_KEY)
      }
    } catch (e) {
      console.warn('Failed to persist filters to localStorage', e)
    }

    syncFiltersToUrl({
      engine: selectedEngine,
      status: statusFilter,
      q: searchQuery,
    })
  }, [selectedEngine, statusFilter, searchQuery])

  // Handle browser back / forward navigation
  useEffect(() => {
    const handlePopState = () => {
      const parsed = parseFilterUrlParams()
      setSelectedEngine(parsed.engine)
      setStatusFilter(parsed.status)
      setSearchQuery(parsed.q)
    }
    window.addEventListener('popstate', handlePopState)
    return () => window.removeEventListener('popstate', handlePopState)
  }, [])

  // Show a welcome toast if the page was opened with shared filter URL parameters
  useEffect(() => {
    if (initialFilters.hasFilterInUrl) {
      const parts: string[] = []
      if (initialFilters.status !== 'ALL') parts.push(`Status: ${initialFilters.status}`)
      if (initialFilters.engine !== 'ALL') parts.push(`Engine: ${initialFilters.engine}`)
      if (initialFilters.q) parts.push(`Search: "${initialFilters.q}"`)
      if (parts.length > 0) {
        showToast(`Viewing shared filter view (${parts.join(' • ')})`)
      }
    }
  }, [initialFilters, showToast])

  // Reset all filters (engine, status, search) to show all records and clear storage
  const handleResetAllFilters = () => {
    setSelectedEngine('ALL')
    setSearchQuery('')
    setStatusFilter('ALL')
    try {
      localStorage.removeItem(FILTERS_STORAGE_KEY)
    } catch {}
  }

  // Sheet Verification State (verifies against Google Sheets on every refresh/load)
  const [verificationSummary, setVerificationSummary] = useState<SheetVerificationSummary | null>(null)
  const [isVerifying, setIsVerifying] = useState(false)
  const [isVerificationModalOpen, setIsVerificationModalOpen] = useState(false)

  // Run dynamic verification against connected engine Google Sheets
  const runVerification = useCallback(
    async (currentScenarios: NotificationScenario[], engineOverride?: string) => {
      if (!currentScenarios || currentScenarios.length === 0) return
      const targetEngine = engineOverride || selectedEngine
      setIsVerifying(true)
      try {
        const summary = await verifyAllEngines(targetEngine, currentScenarios)
        setVerificationSummary(summary)
      } catch (err) {
        console.error('Failed to verify scenarios against Google Sheet:', err)
      } finally {
        setIsVerifying(false)
      }
    },
    [selectedEngine]
  )

  // Load scenarios, registered engine sheets, & distinct engines dynamically from Cloudflare D1
  useEffect(() => {
    Promise.all([
      scenariosApi.fetchScenarios(),
      engineSheetsApi.fetchEngineSheets(),
      enginesApi.fetchEngines(),
    ])
      .then(([{ scenarios: data }, _sheets, enginesList]) => {
        if (data && data.length > 0) {
          setScenarios(data)
          runVerification(data)
        }
        if (enginesList && enginesList.length > 0) {
          setDbEngines(enginesList)
        }
      })
      .finally(() => {
        setIsLoading(false)
      })
  }, [runVerification])

  // Re-verify when switching engine tabs
  useEffect(() => {
    if (scenarios.length > 0) {
      runVerification(scenarios)
    }
  }, [selectedEngine, scenarios, runVerification])

  // Sync to local cache so version histories persist across sessions
  useEffect(() => {
    if (scenarios.length > 0) {
      try {
        localStorage.setItem('seedling_scenarios_v1', JSON.stringify(scenarios))
      } catch {
        // storage quota fallback
      }
    }
  }, [scenarios])

  // Derive all unique engines dynamically from:
  // 1. D1 engines API (scenarios & engine_sheets in D1)
  // 2. Currently loaded scenarios in state
  // 3. Fallback defaults
  const dynamicEngines = useMemo<string[]>(() => {
    const set = new Set<string>()
    // From D1 engines endpoint
    dbEngines.forEach((e) => {
      const trimmed = (e || '').trim()
      if (trimmed) set.add(trimmed)
    })
    // From loaded scenarios
    scenarios.forEach((s) => {
      const trimmed = (s.engineCategory || '').trim()
      if (trimmed) set.add(trimmed)
    })
    // Core fallback defaults if empty
    if (set.size === 0) {
      set.add('Governance')
      set.add('Contribution')
      set.add('Participation')
      set.add('Identity')
      set.add('Opportunity')
      set.add('Discovery')
    }

    const list = Array.from(set)
    return list.sort((a, b) => {
      if (a === 'Governance') return -1
      if (b === 'Governance') return 1
      if (a === 'Contribution') return -1
      if (b === 'Contribution') return 1
      return a.localeCompare(b)
    })
  }, [dbEngines, scenarios])

  // Count per engine category dynamically
  const engineCounts = useMemo(() => {
    const counts: Record<string, number> = {}
    dynamicEngines.forEach((e) => {
      counts[e] = 0
    })
    scenarios.forEach((s) => {
      const cat = (s.engineCategory || 'Governance').trim()
      counts[cat] = (counts[cat] || 0) + 1
    })
    return counts
  }, [dynamicEngines, scenarios])

  // Formatted list for JiraNavbar
  const navbarEngines = useMemo<EngineMenuItem[]>(() => {
    return dynamicEngines.map((name) => ({
      name,
      count: engineCounts[name] || 0,
    }))
  }, [dynamicEngines, engineCounts])

  // Add new row directly into active engine category (persisted to D1)
  const handleAddRow = (): NotificationScenario => {
    const targetEngine = selectedEngine !== 'ALL' ? selectedEngine : 'Governance'
    let prefix = 'GOV'
    if (targetEngine === 'Contribution') prefix = 'CONTRIB'
    else if (targetEngine === 'Participation') prefix = 'PART'
    else if (targetEngine === 'Identity') prefix = 'ID'
    else if (targetEngine === 'Opportunity') prefix = 'OPP'
    else if (targetEngine === 'Discovery') prefix = 'DISC'
    else {
      const clean = targetEngine.toUpperCase().replace(/[^A-Z0-9]/g, '')
      prefix = clean.length > 5 ? clean.slice(0, 5) : clean || 'SCEN'
    }

    const existingNums = scenarios
      .filter((s) => (s.engineCategory || '').toLowerCase() === targetEngine.toLowerCase())
      .map((s) => {
        const match = s.key.match(new RegExp(`${prefix}-(\\d+)`, 'i'))
        return match ? parseInt(match[1], 10) : 0
      })
    const maxNum = existingNums.length > 0 ? Math.max(...existingNums) : 0
    const newNum = maxNum + 1

    const newRow: NotificationScenario = {
      id: `${prefix.toLowerCase()}-${Date.now()}-${Math.floor(Math.random() * 1000)}`,
      key: `${prefix}-${newNum}`,
      engineCategory: targetEngine,
      governanceEvent: `New ${targetEngine} Event`,
      trigger: '',
      audience: targetEngine === 'Contribution' ? 'Donor' : 'Community Member',
      communicationObjective: '',
      desiredOutcome: '',
      pushSubject: '',
      pushBody: '',
      emailSubject: '',
      emailBody: '',
      inAppExperience: '',
      cta: '',
      comments: '',
      status: 'TO DO',
      priority: 'Medium',
      environment: 'STAGING',
      assignee: {
        name: 'QA Tester',
        email: 'tester@seedling.org',
        avatar: '',
      },
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      versionHistory: [],
      fieldHistory: {},
    }

    setScenarios((prev) => [...prev, newRow])
    scenariosApi.createScenario(newRow)
    return newRow
  }

  // Handle Excel / Sheets JSON batch import (persisted to D1)
  const handleImportScenarios = (imported: NotificationScenario[]) => {
    setScenarios((prev) => [...imported, ...prev])
    scenariosApi.bulkImportScenarios(imported)
  }

  // Batch update & append multiple rows (e.g., from spreadsheet multi-row paste)
  const handleBatchUpdateScenarios = (
    updatedRows: NotificationScenario[],
    newRows?: NotificationScenario[]
  ) => {
    setScenarios((prev) => {
      const prevMap = new Map(prev.map((s) => [s.id, s]))
      const recordedUpdates = updatedRows.map((r) => {
        const current = prevMap.get(r.id)
        if (current) {
          return recordScenarioUpdate(current, r, 'Multi-cell paste update')
        }
        return r
      })
      const updateMap = new Map(recordedUpdates.map((r) => [r.id, r]))
      const updatedList = prev.map((item) => updateMap.get(item.id) || item)
      recordedUpdates.forEach((r) => scenariosApi.updateScenario(r))
      if (newRows && newRows.length > 0) {
        scenariosApi.bulkImportScenarios(newRows)
        return [...updatedList, ...newRows]
      }
      return updatedList
    })
  }

  // Quick inline edit of scenario field (persisted with version history)
  const handleUpdateScenario = (updated: NotificationScenario) => {
    const target = scenarios.find((s) => s.id === updated.id) || updated
    const recorded = recordScenarioUpdate(target, updated)
    setScenarios((prev) => prev.map((s) => (s.id === updated.id ? recorded : s)))
    scenariosApi.updateScenario(recorded).catch((err) => {
      console.error('Failed to persist scenario update:', err)
    })
  }

  // Apply Sheet Expected Value to Scenario
  const handleApplySheetValue = (
    scenario: NotificationScenario,
    field: string,
    expectedValue: string
  ) => {
    const updated = {
      ...scenario,
      [field]: expectedValue,
      updatedAt: new Date().toISOString(),
    }
    handleUpdateScenario(updated)

    // Clear mismatch immediately from verification summary state
    setVerificationSummary((prev) => {
      if (!prev) return null
      const copy = { ...prev.mismatchesByScenarioId }
      if (copy[scenario.id]) {
        const fieldCopy = { ...copy[scenario.id] }
        delete (fieldCopy as any)[field]
        if (Object.keys(fieldCopy).length === 0) {
          delete copy[scenario.id]
        } else {
          copy[scenario.id] = fieldCopy
        }
      }
      const newCount = Object.values(copy).reduce((acc, curr) => acc + Object.keys(curr).length, 0)
      return {
        ...prev,
        totalMismatches: newCount,
        mismatchesByScenarioId: copy,
      }
    })
  }

  // Quick status update (persisted with version history)
  const handleUpdateStatus = (id: string, newStatus: ScenarioStatus) => {
    const target = scenarios.find((s) => s.id === id)
    if (!target) return
    const updated: NotificationScenario = {
      ...target,
      status: newStatus,
      updatedAt: new Date().toISOString(),
    }
    const recorded = recordScenarioUpdate(
      target,
      updated,
      `Status changed: ${target.status} → ${newStatus}`
    )
    setScenarios((prev) => prev.map((s) => (s.id === id ? recorded : s)))
    scenariosApi.updateScenario(recorded).catch((err) => {
      console.error('Failed to persist status change:', err)
    })
  }

  // Rollback scenario row (persisted to D1)
  const handleRollbackScenario = (rolledBack: NotificationScenario) => {
    setScenarios((prev) =>
      prev.map((s) => (s.id === rolledBack.id ? rolledBack : s))
    )
    scenariosApi.updateScenario(rolledBack)
  }

  // Delete scenario row (persisted to D1)
  const handleDeleteScenario = (id: string) => {
    setScenarios((prev) => prev.filter((s) => s.id !== id))
    scenariosApi.deleteScenario(id)
  }

  // Filter exported data according to active engine filter
  const exportTargetScenarios =
    selectedEngine === 'ALL'
      ? scenarios
      : scenarios.filter((s) => s.engineCategory === selectedEngine)

  const [isShareModalOpen, setIsShareModalOpen] = useState(false)

  const activeStatuses =
    statusFilter && statusFilter !== 'ALL'
      ? statusFilter.split(',').map((s) => s.trim()).filter((s) => s && s !== 'ALL')
      : []

  const matchingCount = scenarios.filter((s) => {
    const matchesEngine =
      selectedEngine === 'ALL' || (s.engineCategory || 'Governance') === selectedEngine
    if (!matchesEngine) return false
    if (activeStatuses.length === 0) return true
    const upperActive = parseStatuses(s.status).map((st) => st.trim().toUpperCase())
    return activeStatuses.some((sel) => {
      const clean = sel.trim().toUpperCase()
      if (clean === 'NOT_WORKING_ANY' || clean === 'ALL NOT WORKING') {
        return upperActive.some((st) => st.includes('NOT WORKING'))
      }
      return upperActive.includes(clean)
    })
  }).length

  const currentShareUrl = buildFilterShareUrl({
    engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
    status: statusFilter !== 'ALL' ? statusFilter : undefined,
    q: searchQuery.trim() || undefined,
  })

  return (
    <div className="flex flex-col h-screen h-[100dvh] w-full min-w-0 overflow-hidden bg-white text-[#172B4D] font-sans antialiased select-none">
      {/* 1. Jira Navigation Bar with Engine Category Switcher, Live Sheet Status, & Search */}
      <JiraNavbar
        searchQuery={searchQuery}
        onSearchChange={setSearchQuery}
        onAddRow={handleAddRow}
        onImportClick={() => setIsImportOpen(true)}
        onExportClick={() => exportScenariosToExcel(exportTargetScenarios, 'xlsx')}
        selectedEngine={selectedEngine}
        onSelectEngine={setSelectedEngine}
        onResetAllFilters={handleResetAllFilters}
        engines={navbarEngines}
        engineCounts={engineCounts}
        govCount={engineCounts['Governance'] || 0}
        contribCount={engineCounts['Contribution'] || 0}
        totalRows={scenarios.length}
        totalEngines={dynamicEngines.length}
        verificationSummary={verificationSummary}
        isVerifying={isVerifying}
        onOpenVerificationModal={() => setIsVerificationModalOpen(true)}
        statusFilter={statusFilter}
        onShowToast={showToast}
        onOpenShareModal={() => setIsShareModalOpen(true)}
      />

      {/* 2. Main Excel-like Spreadsheet Grid */}
      <main className="flex-1 flex flex-col min-w-0 overflow-hidden relative">
        {isLoading && scenarios.length === 0 ? (
          <div className="flex-1 flex flex-col items-center justify-center bg-white text-[#42526E] gap-3">
            <Loader2 className="w-8 h-8 text-[#0052CC] animate-spin" />
            <p className="font-semibold text-sm text-[#172B4D]">Loading notification scenarios from production D1...</p>
            <p className="text-xs text-[#6B778C]">Connecting to Cloudflare edge database</p>
          </div>
        ) : (
          <JiraTable
            scenarios={scenarios}
            onUpdateScenario={handleUpdateScenario}
            onRollbackScenario={handleRollbackScenario}
            onBatchUpdateScenarios={handleBatchUpdateScenarios}
            onUpdateStatus={handleUpdateStatus}
            onDeleteScenario={handleDeleteScenario}
            onAddRow={handleAddRow}
            searchQuery={searchQuery}
            onClearSearch={() => setSearchQuery('')}
            selectedEngine={selectedEngine}
            onSelectEngine={setSelectedEngine}
            availableEngines={dynamicEngines}
            statusFilter={statusFilter}
            onStatusFilterChange={setStatusFilter}
            onResetAllFilters={handleResetAllFilters}
            verificationSummary={verificationSummary}
            onApplySheetValue={handleApplySheetValue}
            onShowToast={showToast}
            onOpenShareModal={() => setIsShareModalOpen(true)}
          />
        )}
      </main>

      {/* 3. Excel / Google Sheets Import Modal */}
      {isImportOpen && (
        <ExcelImportModal
          onClose={() => setIsImportOpen(false)}
          onImport={handleImportScenarios}
          currentMaxKeyNum={scenarios.length}
        />
      )}

      {/* 4. Google Sheet Verification & Management Modal */}
      {isVerificationModalOpen && (
        <SheetVerificationModal
          onClose={() => setIsVerificationModalOpen(false)}
          activeSummary={verificationSummary}
          onReverify={() => runVerification(scenarios)}
          isReverifying={isVerifying}
        />
      )}

      {/* 5. Share Filter Modal */}
      <ShareFilterModal
        isOpen={isShareModalOpen}
        onClose={() => setIsShareModalOpen(false)}
        shareUrl={currentShareUrl}
        selectedEngine={selectedEngine}
        selectedStatuses={activeStatuses}
        searchQuery={searchQuery}
        matchingCount={matchingCount}
      />

      {/* 6. Global Floating Toast for Share & Action Feedback */}
      {toastMessage && (
        <div className="fixed bottom-6 right-6 z-9999 bg-slate-900 text-white text-xs px-4 py-2.5 rounded shadow-2xl flex items-center gap-2.5 animate-in fade-in slide-in-from-bottom-3 duration-150 border border-slate-700 select-none">
          <Check className="w-4 h-4 text-emerald-400 stroke-[2.5] shrink-0" />
          <span className="font-medium">{toastMessage}</span>
        </div>
      )}
    </div>
  )
}
