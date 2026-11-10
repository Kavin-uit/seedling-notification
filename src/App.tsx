import { useState, useEffect, useCallback, useRef, useMemo } from 'react'
import type { NotificationScenario, ScenarioStatus, ProductionNotification } from './types/notification'
import { JiraNavbar } from './components/jira/JiraNavbar'
import type { EngineCategoryFilter, EngineMenuItem, ActiveDashboardView } from './components/jira/JiraNavbar'
import { JiraTable } from './components/jira/JiraTable'
import { RuleBookTable } from './components/jira/RuleBookTable'
import { ProductionReadyTable } from './components/jira/ProductionReadyTable'
import { ExcelImportModal } from './components/jira/ExcelImportModal'
import { JiraCreateModal } from './components/jira/JiraCreateModal'
import { exportScenariosToExcel, exportRulesToExcel } from './utils/excel'
import { filterScenarios, parseSelectedEngines, isScenarioHidden } from './utils/scenarioFilters'
import { ALL_NOTIFICATION_RULES } from './data/notificationRules'
import { scenariosApi } from './api/scenariosApi'
import { productionApi } from './api/productionApi'
import { engineSheetsApi } from './api/engineSheetsApi'
import { enginesApi } from './api/enginesApi'
import { recordScenarioUpdate } from './utils/versionHistory'
import { addActivityEntry } from './utils/productionActivityLog'
import confetti from 'canvas-confetti'
import {
  verifyAllEngines,
  type SheetVerificationSummary,
} from './services/sheetVerificationService'
import { SheetVerificationModal } from './components/jira/SheetVerificationModal'
import { ShareFilterModal } from './components/jira/ShareFilterModal'
import { Loader2, Check } from 'lucide-react'
import { parseFilterUrlParams, syncFiltersToUrl, buildFilterShareUrl } from './utils/filterShare'
import { NotificationBugsPage } from './components/NotificationBugsPage'

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

function NotificationApp() {

  const [scenarios, setScenarios] = useState<NotificationScenario[]>([])
  const [productionNotifications, setProductionNotifications] = useState<ProductionNotification[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [dbEngines, setDbEngines] = useState<string[]>([])
  // Active view: 'scenarios' (QA test execution), 'rulebook' (Master Rule Book), or 'production' (Production Ready)
  const [activeView, setActiveView] = useState<ActiveDashboardView>(() => {
    try {
      const params = new URLSearchParams(window.location.search)
      const v = params.get('view')
      if (v === 'rulebook') return 'rulebook'
      if (v === 'production') return 'production'
      const saved = localStorage.getItem(FILTERS_STORAGE_KEY)
      if (saved) {
        const parsed = JSON.parse(saved)
        if (parsed.engine === 'RuleBook') return 'rulebook'
      }
    } catch {}
    return 'scenarios'
  })

  // Initialize filters from URL query parameters or localStorage (persists across page refresh)
  const [initialFilters] = useState(() => {
    const filters = loadInitialFilters()
    // Clean up any stale RuleBook engine filter
    if (filters.engine === 'RuleBook') {
      filters.engine = 'ALL'
    }
    return filters
  })
  const [selectedEngine, setSelectedEngine] = useState<EngineCategoryFilter>(initialFilters.engine)
  const [searchQuery, setSearchQuery] = useState<string>(initialFilters.q)
  const [statusFilter, setStatusFilter] = useState<string>(initialFilters.status)
  const [isImportOpen, setIsImportOpen] = useState(false)
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false)

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

  // Sync activeView to URL
  useEffect(() => {
    try {
      const url = new URL(window.location.href)
      if (activeView === 'rulebook') {
        url.searchParams.set('view', 'rulebook')
      } else if (activeView === 'production') {
        url.searchParams.set('view', 'production')
      } else {
        url.searchParams.delete('view')
      }
      window.history.replaceState({}, '', url.toString())
    } catch {}
  }, [activeView])

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
      setSelectedEngine(parsed.engine === 'RuleBook' ? 'ALL' : parsed.engine)
      setStatusFilter(parsed.status)
      setSearchQuery(parsed.q)
      try {
        const params = new URLSearchParams(window.location.search)
        const v = params.get('view')
        setActiveView(v === 'rulebook' ? 'rulebook' : v === 'production' ? 'production' : 'scenarios')
      } catch {}
    }
    window.addEventListener('popstate', handlePopState)
    return () => window.removeEventListener('popstate', handlePopState)
  }, [])


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

  const selectedEngineRef = useRef(selectedEngine)
  useEffect(() => {
    selectedEngineRef.current = selectedEngine
  }, [selectedEngine])

  // Run dynamic verification against connected engine Google Sheets
  const runVerification = useCallback(
    async (currentScenarios: NotificationScenario[], engineOverride?: string, forceRefresh = false) => {
      if (!currentScenarios || currentScenarios.length === 0) return
      const targetEngine = engineOverride || selectedEngineRef.current
      setIsVerifying(true)
      try {
        const summary = await verifyAllEngines(targetEngine, currentScenarios, forceRefresh)
        setVerificationSummary(summary)
      } catch (err) {
        console.error('Failed to verify scenarios against Google Sheet:', err)
      } finally {
        setIsVerifying(false)
      }
    },
    []
  )

  const initialLoadRanRef = useRef(false)
  const prevEngineRef = useRef(selectedEngine)

  // Load scenarios, registered engine sheets, & distinct engines dynamically from Cloudflare D1
  useEffect(() => {
    if (initialLoadRanRef.current) return
    initialLoadRanRef.current = true

    Promise.all([
      scenariosApi.fetchScenarios(),
      engineSheetsApi.fetchEngineSheets(),
      enginesApi.fetchEngines(),
      productionApi.fetchProductionNotifications(),
    ])
      .then(([{ scenarios: data }, _sheets, enginesList, { productionNotifications: prodData }]) => {
        if (data && data.length > 0) {
          setScenarios(data)
          runVerification(data, selectedEngineRef.current)
        }
        if (enginesList && enginesList.length > 0) {
          setDbEngines(enginesList)
        }
        if (prodData && prodData.length > 0) {
          setProductionNotifications(prodData)
        }
      })
      .finally(() => {
        setIsLoading(false)
      })
  }, [runVerification])

  // Re-verify strictly when switching engine tabs (not on mount or scenarios state change)
  useEffect(() => {
    if (prevEngineRef.current !== selectedEngine) {
      prevEngineRef.current = selectedEngine
      if (scenarios.length > 0) {
        runVerification(scenarios, selectedEngine)
      }
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
    // From production notifications
    productionNotifications.forEach((p) => {
      const trimmed = (p.engineCategory || '').trim()
      if (trimmed) set.add(trimmed)
    })
    // Core fallback defaults if empty
    if (set.size === 0) {
      set.add('Campaign')
      set.add('Governance')
      set.add('Contribution')
      set.add('Participation')
      set.add('Identity')
      set.add('Opportunity')
      set.add('Discovery')
      set.add('Manual')
    }

    const list = Array.from(set)
    return list.sort((a, b) => {
      if (a === 'Campaign') return -1
      if (b === 'Campaign') return 1
      if (a === 'Governance') return -1
      if (b === 'Governance') return 1
      if (a === 'Contribution') return -1
      if (b === 'Contribution') return 1
      return a.localeCompare(b)
    })
  }, [dbEngines, scenarios, productionNotifications])

  // Count hidden scenarios
  const hiddenCount = useMemo(() => {
    return scenarios.filter(isScenarioHidden).length
  }, [scenarios])

  // Count per engine category dynamically (excluding HIDE scenarios)
  const engineCounts = useMemo(() => {
    const counts: Record<string, number> = {}
    dynamicEngines.forEach((e) => {
      counts[e] = 0
    })
    scenarios.forEach((s) => {
      if (isScenarioHidden(s)) return
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

  // Create new scenario from Jira modal (persisted to D1 and local state)
  const handleCreateScenario = (newScenario: NotificationScenario) => {
    setScenarios((prev) => [newScenario, ...prev])
    scenariosApi.createScenario(newScenario)
    if (selectedEngine !== 'ALL' && selectedEngine !== newScenario.engineCategory) {
      setSelectedEngine(newScenario.engineCategory as EngineCategoryFilter)
    }
    showToast(`Created ${newScenario.key} in ${newScenario.engineCategory} Engine`)
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
    if (newStatus === 'HIDE') {
      showToast(`"${target.governanceEvent || target.key}" moved to Hidden Notifications`)
    } else if (target.status === 'HIDE') {
      showToast(`"${target.governanceEvent || target.key}" restored to ${target.engineCategory} Engine`)
    }
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

  // Clone scenario and add to Production Ready
  const handleCloneToProduction = useCallback(
    async (scenario: NotificationScenario) => {
      try {
        const { productionNotification } = await productionApi.cloneToProduction(scenario)
        setProductionNotifications((prev) => [
          productionNotification,
          ...prev.filter((p) => p.id !== productionNotification.id),
        ])

        // Record in activity log
        addActivityEntry({
          action: 'ADDED',
          prodKey: productionNotification.key,
          governanceEvent: productionNotification.governanceEvent || scenario.governanceEvent || '',
          engineCategory: productionNotification.engineCategory || scenario.engineCategory || '',
          ruleId: productionNotification.originalScenarioId,
        })

        confetti({
          particleCount: 50,
          spread: 60,
          origin: { y: 0.7 },
        })
        showToast(`"${scenario.governanceEvent || scenario.key}" cloned to Production Ready!`)
      } catch (err) {
        console.error('Failed to clone notification to production:', err)
        showToast('Failed to clone notification to production')
      }
    },
    [showToast]
  )

  // Remove scenario from Production Ready (Uncheck)
  const handleRemoveFromProduction = useCallback(
    async (scenario: NotificationScenario) => {
      try {
        const matching = productionNotifications.filter(
          (p) =>
            p.originalScenarioId === scenario.id ||
            p.id === scenario.id ||
            (p.key && scenario.key && (p.key === scenario.key || p.key === `PROD-${scenario.key}`))
        )

        const idsToRemove = matching.map((p) => p.id)

        if (idsToRemove.length === 0) {
          const fallbackMatches = productionNotifications.filter(
            (p) => p.governanceEvent && scenario.governanceEvent && p.governanceEvent === scenario.governanceEvent
          )
          idsToRemove.push(...fallbackMatches.map((p) => p.id))
        }

        if (idsToRemove.length > 0) {
          setProductionNotifications((prev) => prev.filter((p) => !idsToRemove.includes(p.id)))
          await Promise.all(idsToRemove.map((id) => productionApi.deleteProductionNotification(id)))
        }

        showToast(`"${scenario.governanceEvent || scenario.key}" removed from Production Ready`)
      } catch (err) {
        console.error('Failed to remove notification from production:', err)
        showToast('Failed to remove notification from production')
      }
    },
    [productionNotifications, showToast]
  )

  // Update production notification
  const handleUpdateProductionNotification = useCallback(
    async (item: ProductionNotification) => {
      setProductionNotifications((prev) => prev.map((p) => (p.id === item.id ? item : p)))
      await productionApi.updateProductionNotification(item)
    },
    []
  )

  // Delete production notification
  const handleDeleteProductionNotification = useCallback(
    async (id: string) => {
      setProductionNotifications((prev) => prev.filter((p) => p.id !== id))
      await productionApi.deleteProductionNotification(id)
    },
    []
  )

  const productionScenarioIds = useMemo(() => {
    return new Set(productionNotifications.map((p) => p.originalScenarioId || p.id))
  }, [productionNotifications])

  // Filter scenarios for export and metrics according to active engine filter, status filter, and global search
  const exportTargetScenarios = useMemo(() => {
    return filterScenarios(scenarios, {
      selectedEngine,
      statusFilter,
      searchQuery,
    })
  }, [scenarios, selectedEngine, statusFilter, searchQuery])

  // Filtered rules for Master Rule Book
  const exportTargetRules = useMemo(() => {
    let list = ALL_NOTIFICATION_RULES
    if (selectedEngine !== 'ALL') {
      const selectedEngines = parseSelectedEngines(selectedEngine)
      list = list.filter((r) => {
        const rEng = r.engine.toLowerCase().replace(/\s+engine$/i, '')
        return selectedEngines.includes(rEng)
      })
    }
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase().trim()
      list = list.filter((r) => {
        return (
          r.ruleId.toLowerCase().includes(q) ||
          r.engine.toLowerCase().includes(q) ||
          r.ruleName.toLowerCase().includes(q) ||
          r.trigger.toLowerCase().includes(q) ||
          r.audience.toLowerCase().includes(q) ||
          r.communicationObjective.toLowerCase().includes(q) ||
          r.delivery.toLowerCase().includes(q) ||
          r.attentionClass.toLowerCase().includes(q) ||
          r.channelTier.toLowerCase().includes(q) ||
          r.templateId.toLowerCase().includes(q)
        )
      })
    }
    return list
  }, [selectedEngine, searchQuery])

  const [isShareModalOpen, setIsShareModalOpen] = useState(false)

  const activeStatuses = useMemo(() => {
    return statusFilter && statusFilter !== 'ALL'
      ? statusFilter.split(',').map((s) => s.trim()).filter((s) => s && s !== 'ALL')
      : []
  }, [statusFilter])

  const matchingCount = exportTargetScenarios.length

  const handleExport = () => {
    if (activeView === 'rulebook') {
      if (exportTargetRules.length === 0) {
        showToast('No notification rules to export with current filters')
        return
      }
      exportRulesToExcel(exportTargetRules, 'xlsx', {
        engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
        searchQuery: searchQuery.trim() || undefined,
      })
      showToast(`Exported ${exportTargetRules.length} rule${exportTargetRules.length === 1 ? '' : 's'} to Excel (.xlsx)`)
    } else if (activeView === 'production') {
      if (productionNotifications.length === 0) {
        showToast('No production ready notifications to export')
        return
      }
      exportScenariosToExcel(productionNotifications, 'xlsx', {
        engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
        status: statusFilter !== 'ALL' ? statusFilter : undefined,
        searchQuery: searchQuery.trim() || undefined,
      })
      showToast(
        `Exported ${productionNotifications.length} production notification${
          productionNotifications.length === 1 ? '' : 's'
        } to Excel (.xlsx)`
      )
    } else {
      if (exportTargetScenarios.length === 0) {
        showToast('No scenarios to export with current filters')
        return
      }
      exportScenariosToExcel(exportTargetScenarios, 'xlsx', {
        engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
        status: statusFilter !== 'ALL' ? statusFilter : undefined,
        searchQuery: searchQuery.trim() || undefined,
      })
      showToast(
        `Exported ${exportTargetScenarios.length} filtered scenario${
          exportTargetScenarios.length === 1 ? '' : 's'
        } to Excel (.xlsx)`
      )
    }
  }

  const currentShareUrl = buildFilterShareUrl({
    engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
    status: statusFilter !== 'ALL' ? statusFilter : undefined,
    q: searchQuery.trim() || undefined,
  })

  return (
    <div className="flex flex-col h-screen h-[100dvh] w-full min-w-0 overflow-hidden bg-white text-[#172B4D] font-sans antialiased select-none">
      {/* 1. Jira Navigation Bar with Engine Category Switcher, View Switcher, Live Sheet Status, & Search */}
      <JiraNavbar
        searchQuery={searchQuery}
        onSearchChange={setSearchQuery}
        onAddRow={() => setIsCreateModalOpen(true)}
        onImportClick={() => setIsImportOpen(true)}
        onExportClick={handleExport}
        exportCount={
          activeView === 'rulebook'
            ? exportTargetRules.length
            : activeView === 'production'
            ? productionNotifications.length
            : exportTargetScenarios.length
        }
        selectedEngine={selectedEngine}
        onSelectEngine={setSelectedEngine}
        onResetAllFilters={handleResetAllFilters}
        engines={navbarEngines}
        engineCounts={engineCounts}
        govCount={engineCounts['Governance'] || 0}
        contribCount={engineCounts['Contribution'] || 0}
        totalRows={scenarios.length - hiddenCount}
        hiddenCount={hiddenCount}
        ruleBookCount={ALL_NOTIFICATION_RULES.length}
        productionCount={productionNotifications.length}
        activeView={activeView}
        onChangeView={setActiveView}
        totalEngines={dynamicEngines.length}
        verificationSummary={verificationSummary}
        isVerifying={isVerifying}
        onOpenVerificationModal={() => setIsVerificationModalOpen(true)}
        statusFilter={statusFilter}
        onShowToast={showToast}
        onOpenShareModal={() => setIsShareModalOpen(true)}
      />

      {/* 2. Main Excel-like Spreadsheet Grid OR Master Rule Book Table OR Production Ready Table */}
      <main className="flex-1 flex flex-col min-w-0 overflow-hidden relative">
        {isLoading && scenarios.length === 0 ? (
          <div className="flex-1 flex flex-col items-center justify-center bg-white text-[#42526E] gap-3">
            <Loader2 className="w-8 h-8 text-[#0052CC] animate-spin" />
            <p className="font-semibold text-sm text-[#172B4D]">Loading notification scenarios from production D1...</p>
            <p className="text-xs text-[#6B778C]">Connecting to Cloudflare edge database</p>
          </div>
        ) : activeView === 'rulebook' ? (
          <RuleBookTable
            scenarios={scenarios}
            initialEngineFilter={selectedEngine}
            initialSearchQuery={searchQuery}
            onJumpToScenario={(scen) => {
              setActiveView('scenarios')
              setSelectedEngine(scen.engineCategory)
              setSearchQuery('')
              showToast(`Jumped to scenario ${scen.key} (${scen.engineCategory})`)
            }}
            onShowToast={showToast}
          />
        ) : activeView === 'production' ? (
          <ProductionReadyTable
            productionNotifications={productionNotifications}
            onUpdateProductionNotification={handleUpdateProductionNotification}
            onDeleteProductionNotification={handleDeleteProductionNotification}
            onSwitchToScenarios={() => setActiveView('scenarios')}
            onShowToast={showToast}
            availableEngines={dynamicEngines}
          />
        ) : (
          <JiraTable
            scenarios={scenarios}
            onUpdateScenario={handleUpdateScenario}
            onRollbackScenario={handleRollbackScenario}
            onBatchUpdateScenarios={handleBatchUpdateScenarios}
            onUpdateStatus={handleUpdateStatus}
            onDeleteScenario={handleDeleteScenario}
            onCloneToProduction={handleCloneToProduction}
            onRemoveFromProduction={handleRemoveFromProduction}
            productionScenarioIds={productionScenarioIds}
            onAddRow={() => setIsCreateModalOpen(true)}
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

      {/* 3. Jira Create Issue / Scenario Modal */}
      <JiraCreateModal
        isOpen={isCreateModalOpen}
        onClose={() => setIsCreateModalOpen(false)}
        availableEngines={dynamicEngines}
        currentEngine={selectedEngine !== 'ALL' ? selectedEngine : 'Campaign'}
        scenarios={scenarios}
        onCreateScenario={handleCreateScenario}
      />

      {/* 4. Excel / Google Sheets Import Modal */}
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
          onReverify={() => runVerification(scenarios, undefined, true)}
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

export default function App() {
  const isNotificationBugsRoute =
    window.location.pathname === '/notification-bugs' ||
    window.location.pathname === '/notification-bugs/' ||
    window.location.pathname.startsWith('/notification-bugs') ||
    new URLSearchParams(window.location.search).get('page') === 'notification-bugs'

  if (isNotificationBugsRoute) {
    return <NotificationBugsPage />
  }

  return <NotificationApp />
}
