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
        {/* Brand */}
        <div className="flex items-center gap-1.5 sm:gap-2 shrink-0">
          <div className="w-7 h-7 rounded-lg bg-[#00B060] flex items-center justify-center shadow-xs p-1 text-white shrink-0">
            <img
              src="/seedling-icon.svg"
              alt="Seedling"
              className="w-full h-full object-contain filter brightness-0 invert"
            />
          </div>
          <span className="font-extrabold text-sm tracking-tight text-white hidden xs:inline sm:inline">
            Seedling
          </span>
        </div>

        {/* Engine Switcher - Hidden inside one clean icon dropdown */}
        <div className="relative shrink-0" ref={engineMenuRef}>
          <button
            type="button"
            onClick={() => setIsEngineMenuOpen((prev) => !prev)}
            title={`Select Notification Engine (Currently: ${
              selectedEngine === 'ALL' ? 'All Engines' : `${selectedEngine} Engine`
            })`}
            aria-label="Filter Notification Engine"
            className={`cursor-pointer h-8 px-2.5 rounded-lg flex items-center gap-1.5 transition font-semibold text-xs border shadow-2xs ${
              isEngineMenuOpen
                ? 'bg-white text-[#0747A6] border-white'
                : 'bg-[#0052CC]/80 hover:bg-[#0052CC] text-white border-white/20'
            }`}
          >
            <Layers className="w-4 h-4 shrink-0" />
            <span className="text-[11px] font-semibold hidden sm:inline">
              {selectedEngine === 'ALL' ? 'All' : selectedEngine}
            </span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                isEngineMenuOpen
                  ? 'bg-[#0747A6]/10 text-[#0747A6]'
                  : 'bg-white/20 text-white'
              }`}
            >
              {activeCount}
            </span>
            <ChevronDown
              className={`w-3 h-3 opacity-70 transition-transform duration-150 ${
                isEngineMenuOpen ? 'rotate-180' : ''
              }`}
            />
          </button>

          {/* Dropdown Menu */}
          {isEngineMenuOpen && (
            <div className="absolute left-0 mt-1.5 w-60 bg-white rounded-xl shadow-2xl border border-slate-200 py-1.5 z-50 text-slate-800 animate-in fade-in zoom-in-95 duration-100">
              <div className="px-3 py-1.5 text-[10px] font-bold uppercase tracking-wider text-slate-400 border-b border-slate-100 mb-1">
                Notification Engines
              </div>

              {/* Governance Engine */}
              <button
                type="button"
                onClick={() => {
                  onSelectEngine('Governance')
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-2 text-left flex items-center justify-between hover:bg-slate-50 transition cursor-pointer text-xs ${
                  selectedEngine === 'Governance'
                    ? 'bg-emerald-50/70 font-semibold text-emerald-950'
                    : 'text-slate-700'
                }`}
              >
                <div className="flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-emerald-500 shrink-0" />
                  <span>Governance Engine</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-bold px-1.5 py-0.5 rounded-full bg-emerald-100 text-emerald-800">
                    {govCount}
                  </span>
                  {selectedEngine === 'Governance' && (
                    <Check className="w-3.5 h-3.5 text-emerald-600 shrink-0" />
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
                className={`w-full px-3 py-2 text-left flex items-center justify-between hover:bg-slate-50 transition cursor-pointer text-xs ${
                  selectedEngine === 'Contribution'
                    ? 'bg-blue-50/70 font-semibold text-blue-950'
                    : 'text-slate-700'
                }`}
              >
                <div className="flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-blue-500 shrink-0" />
                  <span>Contribution Engine</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-bold px-1.5 py-0.5 rounded-full bg-blue-100 text-blue-800">
                    {contribCount}
                  </span>
                  {selectedEngine === 'Contribution' && (
                    <Check className="w-3.5 h-3.5 text-blue-600 shrink-0" />
                  )}
                </div>
              </button>

              {/* All Engines */}
              <button
                type="button"
                onClick={() => {
                  onSelectEngine('ALL')
                  setIsEngineMenuOpen(false)
                }}
                className={`w-full px-3 py-2 text-left flex items-center justify-between hover:bg-slate-50 transition cursor-pointer text-xs border-t border-slate-100 mt-1 ${
                  selectedEngine === 'ALL'
                    ? 'bg-slate-100 font-semibold text-slate-950'
                    : 'text-slate-700'
                }`}
              >
                <div className="flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-slate-400 shrink-0" />
                  <span>All Engines</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-bold px-1.5 py-0.5 rounded-full bg-slate-200 text-slate-700">
                    {totalRows}
                  </span>
                  {selectedEngine === 'ALL' && (
                    <Check className="w-3.5 h-3.5 text-slate-700 shrink-0" />
                  )}
                </div>
              </button>
            </div>
          )}
        </div>

        {/* Google Sheet Live Verification Status Badge */}
        {onOpenVerificationModal && (
          <button
            type="button"
            onClick={onOpenVerificationModal}
            title={
              verificationSummary?.totalMismatches
                ? `${verificationSummary.totalMismatches} content mismatch(es) detected with Google Sheet! Click to inspect`
                : 'Google Sheet Verified • Click to inspect or configure engine sheets'
            }
            className={`cursor-pointer px-2 sm:px-2.5 py-1 rounded-md text-[11px] font-semibold flex items-center gap-1.5 transition shrink-0 border ${
              verificationSummary && verificationSummary.totalMismatches > 0
                ? 'bg-[#FF3B30] text-white border-[#FF3B30] shadow-sm animate-pulse hover:bg-[#E02D23]'
                : isVerifying
                ? 'bg-white/10 text-white/80 border-white/20'
                : 'bg-emerald-500/20 text-emerald-200 border-emerald-400/30 hover:bg-emerald-500/30 hover:text-white'
            }`}
          >
            {isVerifying ? (
              <>
                <span className="w-1.5 h-1.5 rounded-full bg-blue-300 animate-ping shrink-0" />
                <span className="hidden xl:inline">Verifying Sheet...</span>
              </>
            ) : verificationSummary && verificationSummary.totalMismatches > 0 ? (
              <>
                <span className="w-3.5 h-3.5 rounded-full bg-white text-[#FF3B30] flex items-center justify-center text-[9px] font-black shrink-0">
                  !
                </span>
                <span>
                  {verificationSummary.totalMismatches} Sheet Mismatch
                  {verificationSummary.totalMismatches > 1 ? 'es' : ''}
                </span>
              </>
            ) : (
              <>
                <span className="w-1.5 h-1.5 rounded-full bg-[#30D158] shrink-0" />
                <span className="hidden sm:inline">Sheet Verified</span>
                <span className="sm:hidden">Verified</span>
              </>
            )}
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
