import React from 'react'
import { Search, FileSpreadsheet, X } from 'lucide-react'

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
}) => {
  return (
    <header className="h-13 bg-[#0747A6] text-white flex items-center justify-between px-3 sm:px-4 select-none shrink-0 border-b border-[#0052CC] shadow-xs gap-2 sm:gap-3 flex-nowrap min-w-0">
      {/* Left side: Seedling Brand & Engine Category Switcher */}
      <div className="flex items-center gap-2 sm:gap-4 min-w-0 shrink-0">
        {/* Brand */}
        <div className="flex items-center gap-1.5 sm:gap-2 shrink-0">
          <div className="w-7 h-7 rounded-lg bg-[#00B060] flex items-center justify-center shadow-xs p-1 text-white shrink-0">
            <img
              src="/seedling-icon.svg"
              alt="Seedling"
              className="w-full h-full object-contain filter brightness-0 invert"
            />
          </div>
          <span className="font-extrabold text-sm tracking-tight text-white hidden xs:inline sm:inline">Seedling</span>
        </div>

        {/* Engine Switcher Tabs (Like Excel / Jira project categories) */}
        <div className="flex items-center bg-[#0052CC]/60 p-0.5 rounded-md border border-white/10 text-xs shrink-0">
          {/* Governance Engine Tab */}
          <button
            type="button"
            onClick={() => onSelectEngine('Governance')}
            className={`cursor-pointer px-2 sm:px-3 py-1 rounded flex items-center gap-1.5 transition font-semibold text-[11px] sm:text-xs ${
              selectedEngine === 'Governance'
                ? 'bg-white text-[#0747A6] shadow-xs'
                : 'text-white/80 hover:text-white hover:bg-white/10'
            }`}
          >
            <span>
              <span className="hidden lg:inline">Governance Engine</span>
              <span className="lg:hidden">Governance</span>
            </span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                selectedEngine === 'Governance'
                  ? 'bg-emerald-100 text-emerald-800'
                  : 'bg-white/20 text-white'
              }`}
            >
              {govCount}
            </span>
          </button>

          {/* Contribution Engine Tab */}
          <button
            type="button"
            onClick={() => onSelectEngine('Contribution')}
            className={`cursor-pointer px-2 sm:px-3 py-1 rounded flex items-center gap-1.5 transition font-semibold text-[11px] sm:text-xs ${
              selectedEngine === 'Contribution'
                ? 'bg-white text-[#0747A6] shadow-xs'
                : 'text-white/80 hover:text-white hover:bg-white/10'
            }`}
          >
            <span>
              <span className="hidden lg:inline">Contribution Engine</span>
              <span className="lg:hidden">Contribution</span>
            </span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                selectedEngine === 'Contribution'
                  ? 'bg-blue-100 text-blue-800'
                  : 'bg-white/20 text-white'
              }`}
            >
              {contribCount}
            </span>
          </button>

          {/* All Engines Tab */}
          <button
            type="button"
            onClick={() => onSelectEngine('ALL')}
            className={`cursor-pointer px-2 sm:px-2.5 py-1 rounded flex items-center gap-1.5 transition font-semibold text-[11px] sm:text-xs ${
              selectedEngine === 'ALL'
                ? 'bg-white text-[#0747A6] shadow-xs'
                : 'text-white/80 hover:text-white hover:bg-white/10'
            }`}
          >
            <span>All</span>
            <span
              className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                selectedEngine === 'ALL'
                  ? 'bg-slate-200 text-slate-800'
                  : 'bg-white/20 text-white'
              }`}
            >
              {totalRows}
            </span>
          </button>
        </div>
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
