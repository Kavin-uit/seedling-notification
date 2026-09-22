import { useState, useEffect, useCallback } from 'react'
import type { NotificationScenario, ScenarioStatus } from './types/notification'
import { JiraNavbar } from './components/jira/JiraNavbar'
import type { EngineCategoryFilter } from './components/jira/JiraNavbar'
import { JiraTable } from './components/jira/JiraTable'
import { ExcelImportModal } from './components/jira/ExcelImportModal'
import { exportScenariosToExcel } from './utils/excel'
import { scenariosApi } from './api/scenariosApi'
import { engineSheetsApi } from './api/engineSheetsApi'
import { recordScenarioUpdate } from './utils/versionHistory'
import {
  verifyAllEngines,
  type SheetVerificationSummary,
} from './services/sheetVerificationService'
import { SheetVerificationModal } from './components/jira/SheetVerificationModal'
import { Loader2 } from 'lucide-react'

export default function App() {
  const [scenarios, setScenarios] = useState<NotificationScenario[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [selectedEngine, setSelectedEngine] = useState<EngineCategoryFilter>('ALL')
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState<string>('ALL')
  const [isImportOpen, setIsImportOpen] = useState(false)

  // Reset all filters (engine, status, search) to show all records
  const handleResetAllFilters = () => {
    setSelectedEngine('ALL')
    setSearchQuery('')
    setStatusFilter('ALL')
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

  // Load scenarios & registered engine sheet links dynamically from Cloudflare D1 & verify on refresh
  useEffect(() => {
    Promise.all([scenariosApi.fetchScenarios(), engineSheetsApi.fetchEngineSheets()])
      .then(([{ scenarios: data }]) => {
        if (data && data.length > 0) {
          setScenarios(data)
          runVerification(data)
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

  // Count per engine category
  const govCount = scenarios.filter((s) => s.engineCategory === 'Governance').length
  const contribCount = scenarios.filter((s) => s.engineCategory === 'Contribution').length

  // Add new row directly into active engine category (persisted to D1)
  const handleAddRow = (): NotificationScenario => {
    const targetEngine = selectedEngine === 'Contribution' ? 'Contribution' : 'Governance'
    const prefix = targetEngine === 'Contribution' ? 'CONTRIB' : 'GOV'

    const existingNums = scenarios
      .filter((s) => s.engineCategory === targetEngine)
      .map((s) => {
        const match = s.key.match(new RegExp(`${prefix}-(\\d+)`))
        return match ? parseInt(match[1], 10) : 0
      })
    const maxNum = existingNums.length > 0 ? Math.max(...existingNums) : 0
    const newNum = maxNum + 1

    const newRow: NotificationScenario = {
      id: `${prefix.toLowerCase()}-${Date.now()}-${Math.floor(Math.random() * 1000)}`,
      key: `${prefix}-${newNum}`,
      engineCategory: targetEngine,
      governanceEvent: targetEngine === 'Contribution' ? 'New Contribution Event' : 'New Governance Event',
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
        govCount={govCount}
        contribCount={contribCount}
        totalRows={scenarios.length}
        verificationSummary={verificationSummary}
        isVerifying={isVerifying}
        onOpenVerificationModal={() => setIsVerificationModalOpen(true)}
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
            statusFilter={statusFilter}
            onStatusFilterChange={setStatusFilter}
            onResetAllFilters={handleResetAllFilters}
            verificationSummary={verificationSummary}
            onApplySheetValue={handleApplySheetValue}
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
    </div>
  )
}
