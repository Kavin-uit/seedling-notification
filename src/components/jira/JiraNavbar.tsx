import React, { useState, useRef, useEffect } from 'react'
import { Search, FileSpreadsheet, X, Layers, ChevronDown, Check } from 'lucide-react'
import type { SheetVerificationSummary } from '../../services/sheetVerificationService'

export type EngineCategoryFilter = 'ALL' | 'Governance' | 'Contribution'

interface JiraNavbarProps {
  searchQuery: string
  onSearchChange: (q: string) => void
  onAddRow?: () => void
  onImportClick?: () => void
  onExportClick: () => void
  selectedEngine: EngineCategoryFilter
  onSelectEngine: (engine: EngineCategoryFilter) => void
  onResetAllFilters?: () => void
  govCount: number
  contribCount: number
  totalRows: number
  verificationSummary?: SheetVerificationSummary | null
  isVerifying?: boolean
  onOpenVerificationModal?: () => void
}

export const JiraNavbar: React.FC<JiraNavbarProps> = ({
  searchQuery,
  onSearchChange,
  onExportClick,
  selectedEngine,
  onSelectEngine,
  onResetAllFilters,
  govCount,
  contribCount,
  totalRows,
  verificationSummary,
  isVerifying,
  onOpenVerificationModal,
}) => {
  const [isEngineMenuOpen, setIsEngineMenuOpen] = useState(false)
  const engineMenuRef = useRef<HTMLDivElement>(null)

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

  const activeCount =
    selectedEngine === 'Governance'
      ? govCount
      : selectedEngine === 'Contribution'
      ? contribCount
      : totalRows

  return (
    <header className="h-13 bg-[#0747A6] text-white flex items-center justify-between px-3 sm:px-4 select-none shrink-0 border-b border-[#0052CC] shadow-xs gap-2 sm:gap-3 flex-nowrap min-w-0">
      {/* Left side: Seedling Brand & Engine Category Switcher */}
      <div className="flex items-center gap-2 sm:gap-3 min-w-0 shrink-0">
        {/* Brand - Click to reset all filters and display all records */}
        <button
          type="button"
          onClick={onResetAllFilters}
          title="Reset all filters & display all records"
          className="flex items-center gap-1.5 sm:gap-2 shrink-0 cursor-pointer hover:opacity-90 active:scale-95 transition group text-left"
        >
          <div className="w-7 h-7 rounded-lg bg-[#00B060] flex items-center justify-center shadow-xs p-1 text-white shrink-0 group-hover:ring-2 ring-white/40 transition">
            <img
              src="/seedling-icon.svg"
              alt="Seedling"
              className="w-full h-full object-contain filter brightness-0 invert"
            />
          </div>
          <span className="font-extrabold text-sm tracking-tight text-white hidden xs:inline sm:inline">
            Seedling
          </span>
        </button>

        {/* Engine Switcher - Clean Jira App Style */}
        <div className="relative shrink-0" ref={engineMenuRef}>
          <button
            type="button"
            onClick={() => setIsEngineMenuOpen((prev) => !prev)}
            title={`Select Notification Engine (Currently: ${
              selectedEngine === 'ALL' ? 'All Engines' : `${selectedEngine} Engine`
            })`}
            aria-label="Filter Notification Engine"
            className={`cursor-pointer h-8 px-2.5 rounded text-xs font-medium flex items-center gap-1.5 transition select-none ${
              isEngineMenuOpen
                ? 'bg-white/20 text-white'
                : 'text-white/90 hover:text-white hover:bg-white/10'
            }`}
          >
            <Layers className="w-3.5 h-3.5 opacity-85 shrink-0" />
            <span className="hidden sm:inline">
              {selectedEngine === 'ALL' ? 'All Engines' : selectedEngine}
            </span>
            <span className="text-[10px] px-1.5 py-0.2 rounded-full font-bold bg-white/20 text-white">
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
            <div className="absolute left-0 mt-1 w-56 bg-white rounded-[3px] shadow-[0_4px_12px_-2px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] py-1 z-50 text-[#172B4D] animate-in fade-in zoom-in-95 duration-100">
              <div className="px-3 py-1.5 text-[11px] font-semibold text-[#6B778C] border-b border-[#EBECF0] mb-0.5">
                Engines
              </div>

              {/* Governance Engine */}
              <button
                type="button"
                onClick={() => {
                  onSelectEngine('Governance')
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-1.5 text-left flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer text-xs ${
                  selectedEngine === 'Governance'
                    ? 'bg-[#EBECF0] font-semibold text-[#0052CC]'
                    : 'text-[#172B4D]'
                }`}
              >
                <span>Governance Engine</span>
                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]">
                    {govCount}
                  </span>
                  {selectedEngine === 'Governance' && (
                    <Check className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
                  )}
                </div>
              </button>

              {/* Contribution Engine */}
              <button
                type="button"
                onClick={() => {
                  onSelectEngine('Contribution')
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-1.5 text-left flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer text-xs ${
                  selectedEngine === 'Contribution'
                    ? 'bg-[#EBECF0] font-semibold text-[#0052CC]'
                    : 'text-[#172B4D]'
                }`}
              >
                <span>Contribution Engine</span>
                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]">
                    {contribCount}
                  </span>
                  {selectedEngine === 'Contribution' && (
                    <Check className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
                  )}
                </div>
              </button>

              {/* All Engines - Reset all filters */}
              <button
                type="button"
                onClick={() => {
                  if (onResetAllFilters) {
                    onResetAllFilters()
                  } else {
                    onSelectEngine('ALL')
                  }
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-1.5 text-left flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer text-xs border-t border-[#EBECF0] mt-0.5 ${
                  selectedEngine === 'ALL'
                    ? 'bg-[#EBECF0] font-semibold text-[#0052CC]'
                    : 'text-[#172B4D]'
                }`}
              >
                <span>All Engines</span>
                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]">
                    {totalRows}
                  </span>
                  {selectedEngine === 'ALL' && (
                    <Check className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
                  )}
                </div>
              </button>
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

      {/* Right side: Search & Excel Actions */}
      <div className="flex items-center gap-1.5 sm:gap-2 min-w-0 shrink-0">
        {/* Search with Clear 'X' button & AI toggle */}
        <div className="relative flex items-center w-36 sm:w-56 md:w-72 lg:w-80 transition-all">
          <Search className="w-3.5 h-3.5 text-slate-400 absolute left-2.5 pointer-events-none shrink-0" />
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
            placeholder="Search events, triggers, copy..."
            className="w-full bg-white text-slate-900 placeholder:text-slate-400 text-xs rounded pl-7 sm:pl-8 pr-7 sm:pr-8 py-1.5 transition outline-none border border-transparent focus:ring-2 focus:ring-white/80 shadow-xs"
          />

          {/* Clear 'X' Button */}
          {searchQuery && (
            <button
              type="button"
              onClick={() => onSearchChange('')}
              className="absolute right-1.5 p-1 rounded text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition cursor-pointer flex items-center justify-center"
              title="Clear search (Esc)"
            >
              <X className="w-3.5 h-3.5 stroke-[2.5]" />
            </button>
          )}
        </div>

        {/* Export Excel Button */}
        <button
          onClick={onExportClick}
          className="cursor-pointer bg-emerald-700 hover:bg-emerald-600 text-white px-2.5 sm:px-3 py-1.5 rounded text-xs font-semibold flex items-center gap-1.5 transition shadow-2xs shrink-0"
          title="Export current table to Excel .xlsx"
        >
          <FileSpreadsheet className="w-3.5 h-3.5 shrink-0" />
          <span className="hidden sm:inline">Export .xlsx</span>
          <span className="sm:hidden">Export</span>
        </button>
      </div>
    </header>
  )
}
