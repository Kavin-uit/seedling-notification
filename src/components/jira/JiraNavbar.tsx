import React, { useState, useRef, useEffect, useMemo } from 'react'
import {
  Search,
  FileSpreadsheet,
  X,
  Layers,
  ChevronDown,
  Check,
  Share,
  Plus,
  Table2,
  BookOpen,
  Rocket,
  EyeOff,
} from 'lucide-react'
import type { SheetVerificationSummary } from '../../services/sheetVerificationService'
import { buildFilterShareUrl, copyShareUrlToClipboard } from '../../utils/filterShare'
import { parseSelectedEngines } from '../../utils/scenarioFilters'

export type EngineCategoryFilter = 'ALL' | string
export type ActiveDashboardView = 'scenarios' | 'rulebook' | 'production'

export interface EngineMenuItem {
  name: string
  count: number
}

interface JiraNavbarProps {
  searchQuery: string
  onSearchChange: (q: string) => void
  onAddRow?: () => void
  onImportClick?: () => void
  onExportClick: () => void
  exportCount?: number
  selectedEngine: string
  onSelectEngine: (engine: string) => void
  onResetAllFilters?: () => void
  engines?: EngineMenuItem[]
  engineCounts?: Record<string, number>
  totalEngines?: number
  govCount?: number
  contribCount?: number
  totalRows: number
  hiddenCount?: number
  ruleBookCount?: number
  productionCount?: number
  activeView?: ActiveDashboardView
  onChangeView?: (view: ActiveDashboardView) => void
  verificationSummary?: SheetVerificationSummary | null
  isVerifying?: boolean
  onOpenVerificationModal?: () => void
  statusFilter?: string
  onShowToast?: (message: string) => void
  onOpenShareModal?: () => void
}

export const JiraNavbar: React.FC<JiraNavbarProps> = ({
  searchQuery,
  onSearchChange,
  onAddRow,
  onExportClick,
  exportCount,
  selectedEngine,
  onSelectEngine,
  onResetAllFilters,
  engines,
  engineCounts,
  totalEngines,
  govCount,
  contribCount,
  totalRows,
  hiddenCount = 0,
  ruleBookCount = 440,
  productionCount = 0,
  activeView = 'scenarios',
  onChangeView,
  verificationSummary,
  isVerifying,
  onOpenVerificationModal,
  statusFilter = 'ALL',
  onShowToast,
  onOpenShareModal,
}) => {
  const [isEngineMenuOpen, setIsEngineMenuOpen] = useState(false)
  const engineMenuRef = useRef<HTMLDivElement>(null)
  const [copiedEngineKey, setCopiedEngineKey] = useState<string | null>(null)
  const [justCopiedNavbar, setJustCopiedNavbar] = useState(false)

  // Close dropdown on click outside or Escape
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (engineMenuRef.current && !engineMenuRef.current.contains(e.target as Node)) {
        setIsEngineMenuOpen(false)
      }
    }
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setIsEngineMenuOpen(false)
      }
    }
    if (isEngineMenuOpen) {
      document.addEventListener('mousedown', handleClickOutside)
      document.addEventListener('keydown', handleKeyDown)
    }
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isEngineMenuOpen])

  const hasActiveFilters =
    selectedEngine !== 'ALL' ||
    statusFilter !== 'ALL' ||
    Boolean(searchQuery && searchQuery.trim().length > 0)

  const selectedEngines = useMemo(
    () => parseSelectedEngines(selectedEngine),
    [selectedEngine]
  )

  const getEngineDisplayLabel = (name: string) => {
    if (name === 'ALL') return 'All Engines'
    return name.toLowerCase().endsWith('engine') ? name : `${name} Engine`
  }

  const getEngineButtonLabel = () => {
    if (selectedEngine === '__HIDDEN__' || selectedEngine.toLowerCase() === 'hidden') return 'Hidden Notifications'
    if (!selectedEngine || selectedEngine === 'ALL') return 'All Engines'
    if (selectedEngines.length === 0) return 'All Engines'
    if (selectedEngines.length === 1) {
      const match = engineList.find(
        (e) => e.name.toLowerCase().replace(/\s+engine$/i, '') === selectedEngines[0]
      )
      const name = match ? match.name : selectedEngines[0].charAt(0).toUpperCase() + selectedEngines[0].slice(1)
      return name.toLowerCase().endsWith('engine') ? name : `${name} Engine`
    }
    const names = selectedEngines.map((k) => {
      const match = engineList.find(
        (e) => e.name.toLowerCase().replace(/\s+engine$/i, '') === k
      )
      return match ? match.name.replace(/\s+engine$/i, '') : k.charAt(0).toUpperCase() + k.slice(1)
    })
    return names.join(' + ')
  }

  const handleToggleEngine = (engName: string) => {
    const cleanKey = engName.replace(/\s+engine$/i, '').trim().toLowerCase()
    const currentList = parseSelectedEngines(selectedEngine)
    const isAlreadySelected = currentList.includes(cleanKey)

    if (isAlreadySelected) {
      const remaining = currentList.filter((k) => k !== cleanKey)
      if (remaining.length === 0) {
        onSelectEngine('ALL')
      } else {
        const formatted = remaining
          .map((k) => {
            const found = engineList.find(
              (e) => e.name.toLowerCase().replace(/\s+engine$/i, '') === k
            )
            return found ? found.name.replace(/\s+engine$/i, '') : k.charAt(0).toUpperCase() + k.slice(1)
          })
          .join(', ')
        onSelectEngine(formatted)
      }
    } else {
      // Allow user to select up to two engines
      let nextKeys: string[] = []
      if (currentList.length >= 2) {
        // If 2 already selected, replace the 1st with 2nd and append new one (maintaining 2 engines)
        nextKeys = [currentList[1], cleanKey]
      } else {
        nextKeys = [...currentList, cleanKey]
      }

      const formatted = nextKeys
        .map((k) => {
          const found = engineList.find(
            (e) => e.name.toLowerCase().replace(/\s+engine$/i, '') === k
          )
          return found ? found.name.replace(/\s+engine$/i, '') : k.charAt(0).toUpperCase() + k.slice(1)
        })
        .join(', ')
      onSelectEngine(formatted)
    }
  }

  const handleShareEngine = async (engine: string, e: React.MouseEvent) => {
    e.stopPropagation()
    const url = buildFilterShareUrl({ engine: engine !== 'ALL' ? engine : undefined })
    const ok = await copyShareUrlToClipboard(url)
    if (ok) {
      setCopiedEngineKey(engine)
      setTimeout(() => setCopiedEngineKey(null), 2000)
      const label = getEngineDisplayLabel(engine)
      if (onShowToast) {
        onShowToast(`Copied link for ${label}! Anyone opening it will see these records.`)
      }
    }
  }

  const handleShareNavbarView = async () => {
    const url = buildFilterShareUrl({
      engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
      status: statusFilter !== 'ALL' ? statusFilter : undefined,
      q: searchQuery.trim() || undefined,
    })
    const ok = await copyShareUrlToClipboard(url)
    if (ok) {
      setJustCopiedNavbar(true)
      setTimeout(() => setJustCopiedNavbar(false), 2200)
      const desc: string[] = []
      if (selectedEngine !== 'ALL') desc.push(`Engine: ${selectedEngine}`)
      if (statusFilter !== 'ALL') desc.push(`Status: ${statusFilter}`)
      if (searchQuery.trim()) desc.push(`Search: "${searchQuery}"`)
      if (onShowToast) {
        onShowToast(
          desc.length > 0
            ? `Copied link for active filters (${desc.join(', ')})!`
            : 'Copied link to dashboard view!'
        )
      }
    }
    if (onOpenShareModal) {
      onOpenShareModal()
    }
  }

  const engineList: EngineMenuItem[] =
    engines && engines.length > 0
      ? engines
      : [
          { name: 'Governance', count: govCount ?? 0 },
          { name: 'Contribution', count: contribCount ?? 0 },
        ]

  const totalEnginesCount = totalEngines ?? engineList.length

  const activeCount = useMemo(() => {
    if (selectedEngine === '__HIDDEN__' || selectedEngine.toLowerCase() === 'hidden') return hiddenCount
    if (selectedEngine === 'ALL') return totalEnginesCount
    if (selectedEngines.length === 0) return totalEnginesCount

    let sum = 0
    selectedEngines.forEach((k) => {
      const match = engineList.find(
        (e) => e.name.toLowerCase().replace(/\s+engine$/i, '') === k
      )
      if (match) {
        sum += match.count
      } else if (engineCounts?.[k]) {
        sum += engineCounts[k]
      }
    })
    return sum
  }, [selectedEngine, selectedEngines, totalEnginesCount, engineList, engineCounts])

  return (
    <header className="h-13 bg-[#0747A6] text-white flex items-center justify-between px-3 sm:px-4 select-none shrink-0 border-b border-[#0052CC] shadow-xs gap-2 sm:gap-3 flex-nowrap min-w-0">
      {/* Left side: Seedling Brand & Engine Switcher */}
      <div className="flex items-center gap-1.5 sm:gap-2.5 min-w-0 shrink-0">

        {/* Brand - Click to reset all filters and display all records */}
        <button
          type="button"
          onClick={onResetAllFilters}
          title="Reset all filters & display all records"
          className="flex items-center gap-1.5 sm:gap-2 shrink-0 cursor-pointer hover:opacity-85 active:scale-95 transition group text-left"
        >
          <img
            src="/seedling-icon.svg"
            alt="Seedling"
            className="w-6 h-6 object-contain filter brightness-0 invert shrink-0"
          />
          <span className="font-extrabold text-sm tracking-tight text-white hidden xs:inline sm:inline">
            Seedling
          </span>
        </button>

        {/* View Switcher: Test Scenarios vs Master Rule Book */}
        <div className="flex items-center bg-black/20 p-0.5 rounded-[4px] border border-white/10 shrink-0">
          <button
            type="button"
            onClick={() => onChangeView?.('scenarios')}
            className={`cursor-pointer h-7.5 px-2 sm:px-2.5 rounded-[3px] text-xs font-semibold flex items-center gap-1.5 transition select-none ${
              activeView === 'scenarios'
                ? 'bg-white text-[#0747A6] shadow-xs'
                : 'text-white/80 hover:text-white hover:bg-white/10'
            }`}
            title="Notification QA test scenarios spreadsheet"
          >
            <Table2 className="w-3.5 h-3.5" />
            <span className="hidden md:inline">Scenarios</span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                activeView === 'scenarios'
                  ? 'bg-[#DEEBFF] text-[#0747A6]'
                  : 'bg-white/20 text-white'
              }`}
            >
              {totalRows}
            </span>
          </button>

          <button
            type="button"
            onClick={() => onChangeView?.('rulebook')}
            className={`cursor-pointer h-7.5 px-2 sm:px-2.5 rounded-[3px] text-xs font-semibold flex items-center gap-1.5 transition select-none ${
              activeView === 'rulebook'
                ? 'bg-white text-[#0747A6] shadow-xs'
                : 'text-white/80 hover:text-white hover:bg-white/10'
            }`}
            title="Master Notification Rule Book (409 rules across 8 engines)"
          >
            <BookOpen className="w-3.5 h-3.5" />
            <span className="hidden md:inline">Rule Book</span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                activeView === 'rulebook'
                  ? 'bg-[#DEEBFF] text-[#0747A6]'
                  : 'bg-white/20 text-white'
              }`}
            >
              {ruleBookCount}
            </span>
          </button>

          <button
            type="button"
            onClick={() => onChangeView?.('production')}
            className={`cursor-pointer h-7.5 px-2 sm:px-2.5 rounded-[3px] text-xs font-semibold flex items-center gap-1.5 transition select-none ${
              activeView === 'production'
                ? 'bg-white text-[#0747A6] shadow-xs'
                : 'text-white/80 hover:text-white hover:bg-white/10'
            }`}
            title="Production Ready Notifications"
          >
            <Rocket className="w-3.5 h-3.5" />
            <span className="hidden md:inline">Production Ready</span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                activeView === 'production'
                  ? 'bg-[#DEEBFF] text-[#0747A6]'
                  : 'bg-white/20 text-white'
              }`}
            >
              {productionCount}
            </span>
          </button>
        </div>

        {/* Engine Switcher - Clean Jira App Style */}
        <div className="relative shrink-0" ref={engineMenuRef}>
          <button
            type="button"
            onClick={() => setIsEngineMenuOpen((prev) => !prev)}
            title={`Select Notification Engine (Currently: ${
              selectedEngine === 'ALL'
                ? `All ${totalEnginesCount} Engines • ${totalRows} Scenarios`
                : `${getEngineButtonLabel()}`
            })`}
            aria-label="Filter Notification Engine"
            className={`cursor-pointer h-8 px-2.5 rounded text-xs font-medium flex items-center gap-1.5 transition select-none ${
              isEngineMenuOpen
                ? 'bg-white/20 text-white'
                : 'text-white/90 hover:text-white hover:bg-white/10'
            }`}
          >
            <Layers className="w-3.5 h-3.5 opacity-85 shrink-0" />
            <span className="font-semibold hidden sm:inline">
              {getEngineButtonLabel()}
            </span>
            <span className="text-xs px-2 py-0.5 rounded-full font-bold bg-white/20 text-white leading-none">
              {activeCount}
            </span>
            <ChevronDown
              className={`w-3 h-3 opacity-70 transition-transform duration-150 ${
                isEngineMenuOpen ? 'rotate-180' : ''
              }`}
            />
          </button>

          {/* Atlassian Jira Dropdown Menu */}
          {isEngineMenuOpen && (
            <div className="absolute left-0 mt-1 w-72 bg-white rounded-[3px] shadow-[0_4px_16px_-2px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] py-1 z-50 text-[#172B4D] animate-in fade-in zoom-in-95 duration-100 max-h-[min(480px,80vh)] overflow-y-auto">
              <div className="px-3 py-2 text-[11px] font-semibold text-[#6B778C] border-b border-[#EBECF0] mb-0.5 flex items-center justify-between sticky top-0 bg-white z-10 shadow-2xs">
                <div className="flex items-center gap-1.5">
                  <span className="font-bold text-[#172B4D]">Engines</span>
                  <span className="text-[10px] font-semibold px-1.5 py-0.2 rounded bg-[#DEEBFF] text-[#0747A6]">
                    {selectedEngines.length === 0
                      ? 'All'
                      : `${selectedEngines.length}/2 Selected`}
                  </span>
                </div>
                {selectedEngines.length > 0 ? (
                  <button
                    type="button"
                    onClick={() => {
                      onSelectEngine('ALL')
                    }}
                    className="text-[10px] text-[#0052CC] hover:underline cursor-pointer font-semibold"
                  >
                    Reset to All
                  </button>
                ) : (
                  <span className="text-[10px] font-normal text-[#6B778C]">
                    Select up to 2
                  </span>
                )}
              </div>

              {engineList.map((eng) => {
                const cleanKey = eng.name.toLowerCase().replace(/\s+engine$/i, '')
                const isSelected = selectedEngines.includes(cleanKey)
                const displayLabel = getEngineDisplayLabel(eng.name)
                return (
                  <div
                    key={eng.name}
                    onClick={() => handleToggleEngine(eng.name)}
                    className={`w-full px-3 py-1.5 flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer text-xs group ${
                      isSelected
                        ? 'bg-[#EBECF0] font-semibold text-[#0052CC]'
                        : 'text-[#172B4D]'
                    }`}
                  >
                    <div className="flex items-center gap-2 min-w-0 mr-2">
                      <div
                        className={`w-4 h-4 rounded-[3px] flex items-center justify-center shrink-0 transition-colors ${
                          isSelected
                            ? 'bg-[#0052CC] text-white shadow-2xs'
                            : 'border border-[#C1C7D0] bg-white group-hover:border-[#0052CC]'
                        }`}
                      >
                        {isSelected && <Check className="w-3 h-3 stroke-[3]" />}
                      </div>
                      <span className="truncate">{displayLabel}</span>
                    </div>

                    <div className="flex items-center gap-1.5 shrink-0">
                      <span className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]">
                        {eng.count}
                      </span>
                      <button
                        type="button"
                        onClick={(e) => handleShareEngine(eng.name, e)}
                        title={`Copy direct share link for ${displayLabel}`}
                        className="p-1 rounded hover:bg-[#DEEBFF] text-[#6B778C] hover:text-[#0052CC] transition opacity-70 group-hover:opacity-100 cursor-pointer"
                      >
                        {copiedEngineKey === eng.name ? (
                          <Check className="w-3.5 h-3.5 text-emerald-600 stroke-[2.5]" />
                        ) : (
                          <Share className="w-3.5 h-3.5" />
                        )}
                      </button>
                    </div>
                  </div>
                )
              })}

              {/* Hidden Notifications */}
              <div
                onClick={() => {
                  onSelectEngine('__HIDDEN__')
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-1.5 flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer text-xs border-t border-[#EBECF0] mt-0.5 group ${
                  selectedEngine === '__HIDDEN__'
                    ? 'bg-[#EBECF0] font-semibold text-[#0052CC]'
                    : 'text-[#172B4D]'
                }`}
              >
                <div className="flex items-center gap-2">
                  <div
                    className={`w-4 h-4 rounded-[3px] flex items-center justify-center shrink-0 transition-colors ${
                      selectedEngine === '__HIDDEN__'
                        ? 'bg-[#0052CC] text-white shadow-2xs'
                        : 'border border-[#C1C7D0] bg-white group-hover:border-[#0052CC]'
                    }`}
                  >
                    {selectedEngine === '__HIDDEN__' && <Check className="w-3 h-3 stroke-[3]" />}
                  </div>
                  <span className="flex items-center gap-1.5">
                    <EyeOff className="w-3.5 h-3.5 text-[#6B778C]" />
                    <span>Hidden Notifications</span>
                  </span>
                </div>
                <div className="flex items-center gap-1.5 shrink-0">
                  <span
                    className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]"
                    title={`${hiddenCount} Hidden Notifications`}
                  >
                    {hiddenCount}
                  </span>
                </div>
              </div>

              {/* All Engines - Reset all filters */}
              <div
                onClick={() => {
                  if (onResetAllFilters) {
                    onResetAllFilters()
                  } else {
                    onSelectEngine('ALL')
                  }
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-1.5 flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer text-xs border-t border-[#EBECF0] mt-0.5 group sticky bottom-0 bg-white z-10 ${
                  selectedEngine === 'ALL'
                    ? 'bg-[#EBECF0] font-semibold text-[#0052CC]'
                    : 'text-[#172B4D]'
                }`}
              >
                <div className="flex items-center gap-2">
                  <div
                    className={`w-4 h-4 rounded-[3px] flex items-center justify-center shrink-0 transition-colors ${
                      selectedEngine === 'ALL'
                        ? 'bg-[#0052CC] text-white shadow-2xs'
                        : 'border border-[#C1C7D0] bg-white group-hover:border-[#0052CC]'
                    }`}
                  >
                    {selectedEngine === 'ALL' && <Check className="w-3 h-3 stroke-[3]" />}
                  </div>
                  <span>All Engines</span>
                </div>
                <div className="flex items-center gap-1.5 shrink-0">
                  <span
                    className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]"
                    title={`${totalEnginesCount} Engines`}
                  >
                    {totalEnginesCount}
                  </span>
                  <button
                    type="button"
                    onClick={(e) => handleShareEngine('ALL', e)}
                    title="Copy direct share link for All Engines"
                    className="p-1 rounded hover:bg-[#DEEBFF] text-[#6B778C] hover:text-[#0052CC] transition opacity-70 group-hover:opacity-100 cursor-pointer"
                  >
                    {copiedEngineKey === 'ALL' ? (
                      <Check className="w-3.5 h-3.5 text-emerald-600 stroke-[2.5]" />
                    ) : (
                      <Share className="w-3.5 h-3.5" />
                    )}
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Google Sheet Live Verification Status Button - Jira Style */}
        {onOpenVerificationModal && (
          <button
            type="button"
            onClick={onOpenVerificationModal}
            title={
              verificationSummary?.totalMismatches
                ? `${verificationSummary.totalMismatches} content mismatch(es) detected with Google Sheet! Click to inspect`
                : 'Google Sheets Connected & Verified. Click to view or edit URLs'
            }
            className={`cursor-pointer h-8 px-2.5 rounded text-xs font-medium flex items-center gap-1.5 transition select-none ${
              verificationSummary && verificationSummary.totalMismatches > 0
                ? 'bg-[#DE350B] text-white hover:bg-[#BF2600]'
                : isVerifying
                ? 'bg-white/10 text-white/80'
                : 'text-white/90 hover:text-white hover:bg-white/10'
            }`}
          >
            <FileSpreadsheet className="w-3.5 h-3.5 opacity-80 shrink-0" />
            <span className="hidden sm:inline">
              {isVerifying
                ? 'Verifying...'
                : verificationSummary && verificationSummary.totalMismatches > 0
                ? `${verificationSummary.totalMismatches} Mismatches`
                : 'Sheets Verified'}
            </span>
            <span className="sm:hidden">
              {verificationSummary && verificationSummary.totalMismatches > 0
                ? `${verificationSummary.totalMismatches} !`
                : 'Sheets'}
            </span>
          </button>
        )}
      </div>

      {/* Center Section: Jira-Sized Search Bar & "+ Create" Button */}
      <div className="flex items-center gap-2 flex-1 max-w-xl md:max-w-2xl min-w-0 mx-1 sm:mx-3">
        {/* Search with Clear 'X' button */}
        <div className="relative flex items-center flex-1 min-w-0">
          <Search className="w-4 h-4 text-slate-400 absolute left-2.5 pointer-events-none shrink-0" />
          <input
            type="text"
            autoComplete="off"
            spellCheck="false"
            value={searchQuery}
            onChange={(e) => onSearchChange(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === 'Escape' && searchQuery) {
                e.preventDefault()
                onSearchChange('')
              }
            }}
            placeholder="Search globally across all engines..."
            title="Search globally across all engines, events, triggers, and notification text"
            className="w-full h-8.5 bg-white text-slate-900 placeholder:text-slate-400 text-xs sm:text-[13px] rounded-[4px] pl-8.5 pr-8 transition outline-none border border-transparent focus:border-[#4C9AFF] focus:ring-2 focus:ring-white/80 shadow-xs"
          />

          {/* Clear 'X' Button */}
          {searchQuery && (
            <button
              type="button"
              onClick={() => onSearchChange('')}
              className="absolute right-1.5 p-1 rounded-full text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition cursor-pointer flex items-center justify-center"
              title="Clear search (Esc)"
            >
              <X className="w-3.5 h-3.5 stroke-[2.5]" />
            </button>
          )}
        </div>

        {/* Jira "+ Create" Button */}
        {onAddRow && (
          <button
            type="button"
            onClick={onAddRow}
            className="cursor-pointer h-8.5 px-3 rounded-[3px] bg-[#0052CC] hover:bg-[#0065FF] active:bg-[#0747A6] text-white text-xs font-semibold flex items-center gap-1.5 transition shadow-2xs shrink-0 select-none border border-white/20 hover:border-white/40"
            title="Create new scenario (Add row)"
          >
            <Plus className="w-3.5 h-3.5 stroke-[2.5]" />
            <span className="hidden xs:inline sm:inline">Create</span>
          </button>
        )}
      </div>

      {/* Right side: Share, Excel Actions & Jira Utility Icons */}
      <div className="flex items-center gap-1.5 sm:gap-2 min-w-0 shrink-0">
        {/* Share View / Filter Button */}
        <button
          type="button"
          onClick={handleShareNavbarView}
          className={`cursor-pointer px-2.5 sm:px-3 h-8.5 rounded text-xs font-semibold flex items-center gap-1.5 transition shadow-2xs shrink-0 select-none ${
            hasActiveFilters
              ? 'bg-[#0052CC] hover:bg-[#0747A6] text-white ring-1 ring-white/40'
              : 'bg-white/10 hover:bg-white/20 text-white'
          }`}
          title={hasActiveFilters ? 'Copy link with active filtered view' : 'Copy link to dashboard'}
        >
          {justCopiedNavbar ? (
            <>
              <Check className="w-3.5 h-3.5 text-emerald-300 stroke-[2.5]" />
              <span className="hidden sm:inline">Copied!</span>
            </>
          ) : (
            <>
              <Share className="w-3.5 h-3.5" />
              <span className="hidden sm:inline">
                {hasActiveFilters ? 'Share Filter' : 'Share'}
              </span>
              <span className="sm:hidden">Share</span>
            </>
          )}
        </button>

        {/* Export Excel Button */}
        <button
          type="button"
          onClick={onExportClick}
          className="cursor-pointer bg-emerald-700 hover:bg-emerald-600 text-white px-2.5 sm:px-3 h-8.5 rounded text-xs font-semibold flex items-center gap-1.5 transition shadow-2xs shrink-0"
          title={
            exportCount !== undefined
              ? `Export ${exportCount} filtered record${exportCount === 1 ? '' : 's'} to Excel .xlsx`
              : 'Export current table to Excel .xlsx'
          }
        >
          <FileSpreadsheet className="w-3.5 h-3.5 shrink-0" />
          <span className="hidden sm:inline">Export .xlsx</span>
          <span className="sm:hidden">Export</span>
        </button>
      </div>
    </header>
  )
}
