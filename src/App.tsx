import { useState, useEffect } from 'react'
import type { NotificationScenario, ScenarioStatus } from './types/notification'
import { JiraNavbar } from './components/jira/JiraNavbar'
import type { EngineCategoryFilter } from './components/jira/JiraNavbar'
import { JiraTable } from './components/jira/JiraTable'
import { ExcelImportModal } from './components/jira/ExcelImportModal'
import { GeminiAssistantModal } from './components/jira/GeminiAssistantModal'
import { exportScenariosToExcel } from './utils/excel'
import { scenariosApi } from './api/scenariosApi'
import { recordScenarioUpdate } from './utils/versionHistory'
import { Loader2 } from 'lucide-react'

export default function App() {
  const [scenarios, setScenarios] = useState<NotificationScenario[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [selectedEngine, setSelectedEngine] = useState<EngineCategoryFilter>('ALL')
  const [searchQuery, setSearchQuery] = useState('')
  const [isImportOpen, setIsImportOpen] = useState(false)
  const [isGeminiOpen, setIsGeminiOpen] = useState(false)

  // Load scenarios dynamically from Cloudflare D1 production database
  useEffect(() => {
    scenariosApi
      .fetchScenarios()
      .then(({ scenarios: data }) => {
        if (data && data.length > 0) {
          setScenarios(data)
        }
      })
      .finally(() => {
        setIsLoading(false)
      })
  }, [])

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
    let scenarioToSave: NotificationScenario | null = null
    setScenarios((prev) => {
      const target = prev.find((s) => s.id === updated.id)
      if (!target) return prev
      const recorded = recordScenarioUpdate(target, updated)
      scenarioToSave = recorded
      return prev.map((s) => (s.id === updated.id ? recorded : s))
    })
    if (scenarioToSave) {
      scenariosApi.updateScenario(scenarioToSave)
    }
  }

  // Quick status update (persisted with version history)
  const handleUpdateStatus = (id: string, newStatus: ScenarioStatus) => {
    let scenarioToSave: NotificationScenario | null = null
    setScenarios((prev) => {
      const target = prev.find((s) => s.id === id)
      if (!target) return prev
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
      scenarioToSave = recorded
      return prev.map((s) => (s.id === id ? recorded : s))
    })
    if (scenarioToSave) {
      scenariosApi.updateScenario(scenarioToSave)
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

  // Filter exported data according to active engine filter
  const exportTargetScenarios =
    selectedEngine === 'ALL'
      ? scenarios
      : scenarios.filter((s) => s.engineCategory === selectedEngine)

  // Handle Gemini AI Batch Add (persisted to D1)
  const handleGeminiAddScenarios = (newScenarios: NotificationScenario[]) => {
    setScenarios((prev) => [...prev, ...newScenarios])
    scenariosApi.bulkImportScenarios(newScenarios)
  }

  return (
    <div className="flex flex-col h-screen h-[100dvh] w-full min-w-0 overflow-hidden bg-white text-[#172B4D] font-sans antialiased select-none">
      {/* 1. Jira Navigation Bar with Engine Category Switcher & AI Search */}
      <JiraNavbar
        searchQuery={searchQuery}
        onSearchChange={setSearchQuery}
        onAddRow={handleAddRow}
        onImportClick={() => setIsImportOpen(true)}
        onExportClick={() => exportScenariosToExcel(exportTargetScenarios, 'xlsx')}
        onOpenGemini={() => setIsGeminiOpen(true)}
        selectedEngine={selectedEngine}
        onSelectEngine={setSelectedEngine}
        govCount={govCount}
        contribCount={contribCount}
        totalRows={scenarios.length}
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

      {/* 4. Google Gemini AI Assistant Modal */}
      <GeminiAssistantModal
        isOpen={isGeminiOpen}
        onClose={() => setIsGeminiOpen(false)}
        scenarios={scenarios}
        onAddScenarios={handleGeminiAddScenarios}
        onUpdateScenario={handleUpdateScenario}
      />
    </div>
  )
}
