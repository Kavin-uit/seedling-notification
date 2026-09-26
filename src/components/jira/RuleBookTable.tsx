import React, { useState, useMemo, useRef, useEffect } from 'react'
import type { NotificationRule, NotificationScenario } from '../../types/notification'
import {
  ALL_NOTIFICATION_RULES,
  RULE_BOOK_SHEET_URL,
  SCENARIO_ID_TO_RULE_ID,
  getRuleForScenario,
} from '../../data/notificationRules'
import { NotificationRuleModal } from './NotificationRuleModal'
import {
  Search,
  X,
  FileSpreadsheet,
  ExternalLink,
  Copy,
  Check,
  ChevronUp,
  ChevronDown,
  ArrowRight,
  RotateCcw,
  AlignJustify,
} from 'lucide-react'

export type RuleBookColumnKey =
  | 'index'
  | 'ruleId'
  | 'engine'
  | 'ruleName'
  | 'mappedScenario'
  | 'trigger'
  | 'audience'
  | 'communicationObjective'
  | 'priority'
  | 'channelTier'
  | 'delivery'
  | 'attentionClass'
  | 'candidateScore'
  | 'actions'

export type RowDensity = 'compact' | 'standard' | 'wrap'

export const DEFAULT_RULEBOOK_COLUMN_WIDTHS: Record<RuleBookColumnKey, number> = {
  index: 46,
  ruleId: 135,
  engine: 115,
  ruleName: 240,
  mappedScenario: 125,
  trigger: 190,
  audience: 120,
  communicationObjective: 280,
  priority: 95,
  channelTier: 160,
  delivery: 170,
  attentionClass: 110,
  candidateScore: 70,
  actions: 80,
}

export const MIN_RULEBOOK_COLUMN_WIDTHS: Record<RuleBookColumnKey, number> = {
  index: 36,
  ruleId: 90,
  engine: 75,
  ruleName: 120,
  mappedScenario: 80,
  trigger: 90,
  audience: 75,
  communicationObjective: 120,
  priority: 65,
  channelTier: 90,
  delivery: 90,
  attentionClass: 70,
  candidateScore: 50,
  actions: 65,
}

const STORAGE_KEY_WIDTHS = 'seedling_rulebook_col_widths_v2'
const STORAGE_KEY_DENSITY = 'seedling_rulebook_row_density_v2'

interface RuleBookTableProps {
  scenarios: NotificationScenario[]
  initialEngineFilter?: string
  initialSearchQuery?: string
  onJumpToScenario?: (scenario: NotificationScenario) => void
  onShowToast?: (msg: string) => void
}

function renderExcelPriority(priority?: string) {
  const p = (priority || 'Medium').toLowerCase()
  if (p.includes('highest')) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-red-700 font-medium">
        <ChevronUp className="w-3.5 h-3.5 text-red-600 stroke-[2.5]" />
        <span>Highest</span>
      </span>
    )
  }
  if (p.includes('high')) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-orange-700 font-medium">
        <ChevronUp className="w-3.5 h-3.5 text-orange-600 stroke-[2.5]" />
        <span>High</span>
      </span>
    )
  }
  if (p.includes('low')) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-slate-600 font-medium">
        <ChevronDown className="w-3.5 h-3.5 text-emerald-600 stroke-[2.5]" />
        <span>Low</span>
      </span>
    )
  }
  return (
    <span className="inline-flex items-center gap-1 text-[11px] text-amber-700 font-medium">
      <span className="text-amber-500 font-bold text-xs leading-none">＝</span>
      <span>Medium</span>
    </span>
  )
}

export const RuleBookTable: React.FC<RuleBookTableProps> = ({
  scenarios,
  initialEngineFilter = 'ALL',
  initialSearchQuery = '',
  onJumpToScenario,
  onShowToast,
}) => {
  const [selectedEngine, setSelectedEngine] = useState<string>(initialEngineFilter)
  const [searchQuery, setSearchQuery] = useState<string>(initialSearchQuery)
  const [tierFilter, setTierFilter] = useState<string>('ALL')
  const [pageSize, setPageSize] = useState<number>(100)
  const [currentPage, setCurrentPage] = useState<number>(1)
  const [selectedRowId, setSelectedRowId] = useState<string | null>(null)

  // Row Density State: Compact (28px) | Standard (36px) | Wrap Text (auto)
  const [rowDensity, setRowDensity] = useState<RowDensity>(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY_DENSITY)
      if (saved === 'compact' || saved === 'standard' || saved === 'wrap') {
        return saved
      }
    } catch {}
    return 'standard'
  })

  const handleChangeRowDensity = (density: RowDensity) => {
    setRowDensity(density)
    try {
      localStorage.setItem(STORAGE_KEY_DENSITY, density)
    } catch {}
    if (onShowToast) {
      onShowToast(`Row density set to ${density === 'wrap' ? 'Wrap Text' : density}`)
    }
  }

  // Column Widths with LocalStorage persistence & Resizing
  const [columnWidths, setColumnWidths] = useState<Record<RuleBookColumnKey, number>>(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY_WIDTHS)
      if (saved) {
        const parsed = JSON.parse(saved)
        return { ...DEFAULT_RULEBOOK_COLUMN_WIDTHS, ...parsed }
      }
    } catch {}
    return DEFAULT_RULEBOOK_COLUMN_WIDTHS
  })

  const [activeResizingCol, setActiveResizingCol] = useState<RuleBookColumnKey | null>(null)
  const resizingStateRef = useRef<{
    colKey: RuleBookColumnKey
    startX: number
    startWidth: number
    startScrollLeft: number
  } | null>(null)

  const tableContainerRef = useRef<HTMLDivElement>(null)

  // Start Column Drag Resize
  const handleResizeStart = (colKey: RuleBookColumnKey, e: React.PointerEvent) => {
    e.preventDefault()
    e.stopPropagation()
    const targetEl = e.currentTarget
    try {
      targetEl.setPointerCapture(e.pointerId)
    } catch {}

    const startScrollLeft = tableContainerRef.current ? tableContainerRef.current.scrollLeft : 0
    resizingStateRef.current = {
      colKey,
      startX: e.clientX,
      startWidth: columnWidths[colKey] || DEFAULT_RULEBOOK_COLUMN_WIDTHS[colKey],
      startScrollLeft,
    }
    setActiveResizingCol(colKey)

    const onPointerMove = (ev: PointerEvent) => {
      if (!resizingStateRef.current) return
      const { colKey: key, startX, startScrollLeft, startWidth } = resizingStateRef.current
      const currentScrollLeft = tableContainerRef.current ? tableContainerRef.current.scrollLeft : 0
      const scrollDiff = currentScrollLeft - startScrollLeft
      const delta = ev.clientX - startX + scrollDiff
      const minW = MIN_RULEBOOK_COLUMN_WIDTHS[key] || 40
      const newWidth = Math.min(2000, Math.max(minW, Math.round(startWidth + delta)))
      setColumnWidths((prev) => ({
        ...prev,
        [key]: newWidth,
      }))
    }

    const onPointerUp = (ev: PointerEvent) => {
      try {
        targetEl.releasePointerCapture(ev.pointerId)
      } catch {}
      if (resizingStateRef.current) {
        setColumnWidths((latest) => {
          try {
            localStorage.setItem(STORAGE_KEY_WIDTHS, JSON.stringify(latest))
          } catch {}
          return latest
        })
      }
      resizingStateRef.current = null
      setActiveResizingCol(null)
      window.removeEventListener('pointermove', onPointerMove)
      window.removeEventListener('pointerup', onPointerUp)
      window.removeEventListener('pointercancel', onPointerUp)
    }

    window.addEventListener('pointermove', onPointerMove)
    window.addEventListener('pointerup', onPointerUp)
    window.addEventListener('pointercancel', onPointerUp)
  }

  // Double click column handle to auto-reset width
  const handleResizeDoubleClick = (colKey: RuleBookColumnKey, e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    const defaultW = DEFAULT_RULEBOOK_COLUMN_WIDTHS[colKey]
    setColumnWidths((prev) => {
      const next = { ...prev, [colKey]: defaultW }
      try {
        localStorage.setItem(STORAGE_KEY_WIDTHS, JSON.stringify(next))
      } catch {}
      return next
    })
    if (onShowToast) onShowToast(`Reset ${colKey} to ${defaultW}px`)
  }

  // Reset all column widths
  const handleResetAllColumnWidths = () => {
    setColumnWidths(DEFAULT_RULEBOOK_COLUMN_WIDTHS)
    try {
      localStorage.removeItem(STORAGE_KEY_WIDTHS)
    } catch {}
    if (onShowToast) onShowToast('All column widths reset to default')
  }

  const isAnyColumnCustomized = useMemo(() => {
    return (Object.keys(DEFAULT_RULEBOOK_COLUMN_WIDTHS) as RuleBookColumnKey[]).some(
      (k) => columnWidths[k] !== DEFAULT_RULEBOOK_COLUMN_WIDTHS[k]
    )
  }, [columnWidths])

  const totalTableWidth = useMemo(() => {
    return (Object.keys(DEFAULT_RULEBOOK_COLUMN_WIDTHS) as RuleBookColumnKey[]).reduce(
      (sum, key) => sum + (columnWidths[key] ?? DEFAULT_RULEBOOK_COLUMN_WIDTHS[key]),
      0
    )
  }, [columnWidths])

  // Mouse cursor styling during column resize
  useEffect(() => {
    if (activeResizingCol) {
      document.body.style.cursor = 'col-resize'
      document.body.style.userSelect = 'none'
      return () => {
        document.body.style.cursor = ''
        document.body.style.userSelect = ''
      }
    }
  }, [activeResizingCol])

  // Resize handle component
  const renderResizeHandle = (colKey: RuleBookColumnKey, colTitle: string) => {
    const isResizing = activeResizingCol === colKey
    return (
      <div
        onPointerDown={(e) => handleResizeStart(colKey, e)}
        onDoubleClick={(e) => handleResizeDoubleClick(colKey, e)}
        className="absolute top-0 bottom-0 -right-2.5 w-5 z-40 cursor-col-resize select-none flex items-center justify-center group/resizer touch-none"
        title={`Drag to adjust ${colTitle} width • Double-click to auto-reset (${DEFAULT_RULEBOOK_COLUMN_WIDTHS[colKey]}px)`}
      >
        <div
          className={`w-[2px] h-full transition-colors ${
            isResizing
              ? 'bg-amber-300 w-[3px]'
              : 'bg-white/30 group-hover/resizer:bg-white group-hover/resizer:w-[3px]'
          }`}
        />
        {/* Visual Grip Handle Dots on hover */}
        <div className="absolute top-1/2 -translate-y-1/2 w-3.5 h-5 rounded bg-[#0D6535] border border-white/60 flex items-center justify-center opacity-0 group-hover/resizer:opacity-100 transition shadow-xs pointer-events-none">
          <div className="flex flex-col gap-0.5">
            <div className="w-1.5 h-0.5 bg-white rounded-full" />
            <div className="w-1.5 h-0.5 bg-white rounded-full" />
            <div className="w-1.5 h-0.5 bg-white rounded-full" />
          </div>
        </div>
        {isResizing && (
          <div className="absolute -top-7 left-1/2 -translate-x-1/2 px-1.5 py-0.5 bg-[#172B4D] text-[#57D9A3] text-[10px] font-mono font-bold rounded shadow-lg whitespace-nowrap pointer-events-none z-50 border border-emerald-400">
            {columnWidths[colKey]}px
          </div>
        )}
      </div>
    )
  }

  // Active inspected rule modal
  const [inspectedRule, setInspectedRule] = useState<{
    rule: NotificationRule
    rowNumber: number
  } | null>(null)

  const [copiedId, setCopiedId] = useState<string | null>(null)
  const copyTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  const handleCopyId = (id: string, e: React.MouseEvent) => {
    e.stopPropagation()
    navigator.clipboard.writeText(id).then(() => {
      if (copyTimerRef.current) clearTimeout(copyTimerRef.current)
      setCopiedId(id)
      copyTimerRef.current = setTimeout(() => setCopiedId(null), 2000)
      if (onShowToast) onShowToast(`Copied Rule ID "${id}"`)
    })
  }

  // Precompute reverse scenario mapping: ruleId -> NotificationScenario
  const ruleToScenarioMap = useMemo(() => {
    const map = new Map<string, NotificationScenario>()
    scenarios.forEach((s) => {
      if (s.ruleId) {
        map.set(s.ruleId.trim().toUpperCase(), s)
      }
      if (s.id && SCENARIO_ID_TO_RULE_ID[s.id]) {
        map.set(SCENARIO_ID_TO_RULE_ID[s.id].trim().toUpperCase(), s)
      }
      const resolved = getRuleForScenario(s)
      if (resolved && resolved.ruleId) {
        const key = resolved.ruleId.trim().toUpperCase()
        if (!map.has(key)) {
          map.set(key, s)
        }
      }
    })
    return map
  }, [scenarios])

  // Count rules per real engine
  const engineCounts = useMemo(() => {
    const counts: Record<string, number> = {}
    ALL_NOTIFICATION_RULES.forEach((r) => {
      const eng = r.engine || 'Other'
      counts[eng] = (counts[eng] || 0) + 1
    })
    return counts
  }, [])

  const engineList = useMemo(() => {
    return [
      'Opportunity',
      'Identity',
      'Participation',
      'Discovery',
      'Contribution',
      'Campaign',
      'Narrative',
      'Governance',
    ]
  }, [])

  // Filtered rules
  const filteredRules = useMemo(() => {
    let list = ALL_NOTIFICATION_RULES

    // Engine Filter
    if (selectedEngine !== 'ALL') {
      const eLower = selectedEngine.toLowerCase()
      list = list.filter((r) => r.engine.toLowerCase() === eLower)
    }

    // Tier Filter
    if (tierFilter !== 'ALL') {
      const tLower = tierFilter.toLowerCase()
      list = list.filter((r) => r.channelTier.toLowerCase().includes(tLower))
    }

    // Search Query
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
  }, [selectedEngine, tierFilter, searchQuery])

  // Reset pagination when filters change
  useEffect(() => {
    setCurrentPage(1)
  }, [selectedEngine, tierFilter, searchQuery, pageSize])

  // Paginated slice
  const paginatedRules = useMemo(() => {
    if (pageSize === 0) return filteredRules
    const start = (currentPage - 1) * pageSize
    return filteredRules.slice(start, start + pageSize)
  }, [filteredRules, currentPage, pageSize])

  const totalPages = pageSize === 0 ? 1 : Math.ceil(filteredRules.length / pageSize)

  // Row height / wrapping class names based on density
  const rowHeightClass =
    rowDensity === 'compact'
      ? 'h-7 py-1 text-[11px]'
      : rowDensity === 'wrap'
      ? 'min-h-12 py-2 text-[12px]'
      : 'h-9 py-1.5 text-[12px]'

  const cellTextClass =
    rowDensity === 'wrap'
      ? 'break-words whitespace-normal leading-snug'
      : 'truncate whitespace-nowrap overflow-hidden'

  return (
    <div className="flex-1 flex flex-col min-w-0 h-full overflow-hidden bg-white text-[#172B4D] font-sans">
      {/* 1. Authentic Excel / Google Sheets Workbook Sheet Tabs at the top */}
      <div className="bg-[#EAECEF] border-b border-[#D1D5DB] px-2 pt-1.5 shrink-0 flex items-center gap-0.5 overflow-x-auto select-none no-scrollbar">
        {/* All Rules Tab */}
        <button
          type="button"
          onClick={() => setSelectedEngine('ALL')}
          className={`cursor-pointer px-3 py-1.5 text-xs rounded-t-[3px] border-t border-l border-r transition font-medium flex items-center gap-1.5 shrink-0 ${
            selectedEngine === 'ALL'
              ? 'bg-white text-[#107C41] font-bold border-[#D1D5DB] border-b-white -mb-[1px] z-10 shadow-xs'
              : 'bg-[#DFE1E6] hover:bg-[#EBECF0] text-slate-700 border-transparent'
          }`}
        >
          <FileSpreadsheet className="w-3.5 h-3.5 text-[#107C41]" />
          <span>All Rules</span>
          <span className="text-[10px] text-slate-500 font-mono">409</span>
        </button>

        {/* Engine Tabs */}
        {engineList.map((eng) => {
          const isSelected = selectedEngine === eng
          const count = engineCounts[eng] || 0

          return (
            <button
              key={eng}
              type="button"
              onClick={() => setSelectedEngine(eng)}
              className={`cursor-pointer px-3 py-1.5 text-xs rounded-t-[3px] border-t border-l border-r transition font-medium flex items-center gap-1.5 shrink-0 ${
                isSelected
                  ? 'bg-white text-[#107C41] font-bold border-[#D1D5DB] border-b-white -mb-[1px] z-10 shadow-xs'
                  : 'bg-[#DFE1E6] hover:bg-[#EBECF0] text-slate-700 border-transparent'
              }`}
            >
              <span>{eng}</span>
              <span className="text-[10px] text-slate-500 font-mono">({count})</span>
            </button>
          )
        })}
      </div>

      {/* 2. Excel Ribbon / Toolbar: AutoFilter Controls, Row Density & Actions */}
      <div className="bg-[#F8F9FA] border-b border-[#D1D5DB] px-3 py-1.5 shrink-0 flex flex-wrap items-center justify-between gap-2 text-xs">
        {/* Left Side: Excel Formula / Search & Filters */}
        <div className="flex items-center gap-2 flex-1 max-w-3xl min-w-0">
          {/* Search box styled like Excel Find */}
          <div className="relative flex items-center flex-1 min-w-[180px]">
            <Search className="w-3.5 h-3.5 text-slate-400 absolute left-2 pointer-events-none shrink-0" />
            <input
              type="text"
              autoComplete="off"
              spellCheck="false"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search ID, trigger, audience, objective..."
              className="w-full h-7 bg-white text-slate-800 placeholder:text-slate-400 text-xs rounded-[2px] pl-7 pr-6 transition outline-none border border-[#CBD5E1] focus:border-[#107C41] focus:ring-1 focus:ring-[#107C41]"
            />
            {searchQuery && (
              <button
                type="button"
                onClick={() => setSearchQuery('')}
                className="absolute right-1.5 p-0.5 rounded text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition cursor-pointer"
                title="Clear search"
              >
                <X className="w-3 h-3 stroke-[2.5]" />
              </button>
            )}
          </div>

          {/* Tier AutoFilter */}
          <div className="flex items-center gap-1 shrink-0">
            <span className="text-[11px] text-slate-500 font-medium">Tier:</span>
            <select
              value={tierFilter}
              onChange={(e) => setTierFilter(e.target.value)}
              className="h-7 bg-white border border-[#CBD5E1] rounded-[2px] px-2 text-xs text-slate-800 outline-none focus:border-[#107C41] cursor-pointer"
              title="Filter Channel Tier"
            >
              <option value="ALL">All Tiers</option>
              <option value="Tier 1">Tier 1 - Urgent / Guaranteed</option>
              <option value="Tier 2">Tier 2 - Timely</option>
              <option value="Tier 3">Tier 3 - Ambient / Digest</option>
            </select>
          </div>

          {/* Row Height / Density Adjuster */}
          <div className="flex items-center gap-1 shrink-0 bg-white border border-[#CBD5E1] rounded-[2px] p-0.5 shadow-2xs">
            <span className="text-[11px] text-slate-500 pl-1 font-medium flex items-center gap-1">
              <AlignJustify className="w-3 h-3 text-slate-400" />
              <span>Row:</span>
            </span>
            <button
              type="button"
              onClick={() => handleChangeRowDensity('compact')}
              className={`cursor-pointer px-1.5 py-0.5 rounded-[2px] text-[11px] font-medium transition ${
                rowDensity === 'compact'
                  ? 'bg-[#107C41] text-white font-semibold'
                  : 'text-slate-600 hover:bg-slate-100'
              }`}
              title="Compact row height (28px) - Maximum data density"
            >
              Compact
            </button>
            <button
              type="button"
              onClick={() => handleChangeRowDensity('standard')}
              className={`cursor-pointer px-1.5 py-0.5 rounded-[2px] text-[11px] font-medium transition ${
                rowDensity === 'standard'
                  ? 'bg-[#107C41] text-white font-semibold'
                  : 'text-slate-600 hover:bg-slate-100'
              }`}
              title="Standard row height (36px)"
            >
              Normal
            </button>
            <button
              type="button"
              onClick={() => handleChangeRowDensity('wrap')}
              className={`cursor-pointer px-1.5 py-0.5 rounded-[2px] text-[11px] font-medium transition ${
                rowDensity === 'wrap'
                  ? 'bg-[#107C41] text-white font-semibold'
                  : 'text-slate-600 hover:bg-slate-100'
              }`}
              title="Wrap text automatically - Expands row height to display full text without truncation"
            >
              Wrap Text
            </button>
          </div>

          {/* Reset Column Widths Button */}
          {isAnyColumnCustomized && (
            <button
              type="button"
              onClick={handleResetAllColumnWidths}
              className="cursor-pointer text-[11px] text-[#107C41] hover:underline flex items-center gap-1 shrink-0 font-medium px-1.5 py-0.5 rounded hover:bg-emerald-50 border border-emerald-200"
              title="Reset all column widths to default"
            >
              <RotateCcw className="w-3 h-3" />
              <span>Reset columns</span>
            </button>
          )}

          {(searchQuery || tierFilter !== 'ALL') && (
            <button
              type="button"
              onClick={() => {
                setSearchQuery('')
                setTierFilter('ALL')
              }}
              className="cursor-pointer text-[11px] text-slate-500 hover:text-slate-800 flex items-center gap-0.5 shrink-0"
              title="Clear active search & tier filters"
            >
              <X className="w-3 h-3" />
              <span>Clear filters</span>
            </button>
          )}
        </div>

        {/* Right Side: Summary and Google Sheet Link */}
        <div className="flex items-center gap-2 text-xs text-slate-600 shrink-0">
          <span className="text-[11px]">
            Showing <strong>{filteredRules.length}</strong> of <strong>409</strong> rows
          </span>

          <span className="text-slate-300">|</span>

          {/* Page size picker */}
          <select
            value={pageSize}
            onChange={(e) => setPageSize(parseInt(e.target.value, 10))}
            className="h-7 bg-white border border-[#CBD5E1] rounded-[2px] px-1.5 text-xs text-slate-800 outline-none cursor-pointer"
            title="Rows per page"
          >
            <option value={50}>50 rows</option>
            <option value={100}>100 rows</option>
            <option value={200}>200 rows</option>
            <option value={0}>All 409 rows</option>
          </select>

          {/* Link to Google Sheet */}
          <a
            href={RULE_BOOK_SHEET_URL}
            target="_blank"
            rel="noopener noreferrer"
            className="cursor-pointer h-7 px-2 rounded-[2px] bg-emerald-700 hover:bg-emerald-600 text-white text-xs font-semibold flex items-center gap-1 transition shadow-2xs"
            title="Open official Google Sheet in new tab"
          >
            <FileSpreadsheet className="w-3.5 h-3.5" />
            <span className="hidden sm:inline">Google Sheet</span>
            <ExternalLink className="w-3 h-3 opacity-80" />
          </a>
        </div>
      </div>

      {/* 3. Main Spreadsheet Table Grid with Resizable Columns and Adjustable Row Density */}
      <div
        className="flex-1 overflow-auto bg-white relative"
        ref={tableContainerRef}
      >
        <table
          className="border-collapse text-left text-xs font-sans w-max min-w-full"
          style={{
            tableLayout: 'fixed',
            width: `${totalTableWidth}px`,
          }}
        >
          {/* Colgroup with exact pixel widths */}
          <colgroup>
            <col style={{ width: `${columnWidths.index}px` }} />
            <col style={{ width: `${columnWidths.ruleId}px` }} />
            <col style={{ width: `${columnWidths.engine}px` }} />
            <col style={{ width: `${columnWidths.ruleName}px` }} />
            <col style={{ width: `${columnWidths.mappedScenario}px` }} />
            <col style={{ width: `${columnWidths.trigger}px` }} />
            <col style={{ width: `${columnWidths.audience}px` }} />
            <col style={{ width: `${columnWidths.communicationObjective}px` }} />
            <col style={{ width: `${columnWidths.priority}px` }} />
            <col style={{ width: `${columnWidths.channelTier}px` }} />
            <col style={{ width: `${columnWidths.delivery}px` }} />
            <col style={{ width: `${columnWidths.attentionClass}px` }} />
            <col style={{ width: `${columnWidths.candidateScore}px` }} />
            <col style={{ width: `${columnWidths.actions}px` }} />
          </colgroup>

          {/* Classic Excel Dark Forest Green Table Header with Drag Resizers */}
          <thead className="sticky top-0 bg-[#107C41] text-white z-20 border-b border-[#0D6535] shadow-xs select-none">
            <tr className="border-b border-[#0D6535] text-[11px] font-semibold h-8.5">
              {/* Row Index # */}
              <th
                style={{
                  width: `${columnWidths.index}px`,
                  minWidth: `${columnWidths.index}px`,
                  maxWidth: `${columnWidths.index}px`,
                }}
                className="relative px-2 py-2 text-center border-r border-[#0D6535] bg-[#0E6C38]"
              >
                <span>#</span>
                {renderResizeHandle('index', 'Row Number')}
              </th>

              {/* Rule ID */}
              <th
                style={{
                  width: `${columnWidths.ruleId}px`,
                  minWidth: `${columnWidths.ruleId}px`,
                  maxWidth: `${columnWidths.ruleId}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Rule ID</span>
                {renderResizeHandle('ruleId', 'Rule ID')}
              </th>

              {/* Engine */}
              <th
                style={{
                  width: `${columnWidths.engine}px`,
                  minWidth: `${columnWidths.engine}px`,
                  maxWidth: `${columnWidths.engine}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Engine</span>
                {renderResizeHandle('engine', 'Engine')}
              </th>

              {/* Rule / Message Name */}
              <th
                style={{
                  width: `${columnWidths.ruleName}px`,
                  minWidth: `${columnWidths.ruleName}px`,
                  maxWidth: `${columnWidths.ruleName}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Event / Message</span>
                {renderResizeHandle('ruleName', 'Rule / Message Name')}
              </th>

              {/* Mapped QA Scenario */}
              <th
                style={{
                  width: `${columnWidths.mappedScenario}px`,
                  minWidth: `${columnWidths.mappedScenario}px`,
                  maxWidth: `${columnWidths.mappedScenario}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Mapped</span>
                {renderResizeHandle('mappedScenario', 'Mapped Scenario')}
              </th>

              {/* Trigger */}
              <th
                style={{
                  width: `${columnWidths.trigger}px`,
                  minWidth: `${columnWidths.trigger}px`,
                  maxWidth: `${columnWidths.trigger}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Trigger</span>
                {renderResizeHandle('trigger', 'Trigger')}
              </th>

              {/* Audience */}
              <th
                style={{
                  width: `${columnWidths.audience}px`,
                  minWidth: `${columnWidths.audience}px`,
                  maxWidth: `${columnWidths.audience}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Audience</span>
                {renderResizeHandle('audience', 'Audience')}
              </th>

              {/* Communication Objective */}
              <th
                style={{
                  width: `${columnWidths.communicationObjective}px`,
                  minWidth: `${columnWidths.communicationObjective}px`,
                  maxWidth: `${columnWidths.communicationObjective}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Communication Objective</span>
                {renderResizeHandle('communicationObjective', 'Communication Objective')}
              </th>

              {/* Priority */}
              <th
                style={{
                  width: `${columnWidths.priority}px`,
                  minWidth: `${columnWidths.priority}px`,
                  maxWidth: `${columnWidths.priority}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Priority</span>
                {renderResizeHandle('priority', 'Priority')}
              </th>

              {/* Channel Tier */}
              <th
                style={{
                  width: `${columnWidths.channelTier}px`,
                  minWidth: `${columnWidths.channelTier}px`,
                  maxWidth: `${columnWidths.channelTier}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Channel Tier</span>
                {renderResizeHandle('channelTier', 'Channel Tier')}
              </th>

              {/* Delivery Mode */}
              <th
                style={{
                  width: `${columnWidths.delivery}px`,
                  minWidth: `${columnWidths.delivery}px`,
                  maxWidth: `${columnWidths.delivery}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Delivery Mode</span>
                {renderResizeHandle('delivery', 'Delivery Mode')}
              </th>

              {/* Attention Class */}
              <th
                style={{
                  width: `${columnWidths.attentionClass}px`,
                  minWidth: `${columnWidths.attentionClass}px`,
                  maxWidth: `${columnWidths.attentionClass}px`,
                }}
                className="relative px-2.5 py-2 border-r border-[#0D6535]"
              >
                <span>Attention</span>
                {renderResizeHandle('attentionClass', 'Attention Class')}
              </th>

              {/* Score */}
              <th
                style={{
                  width: `${columnWidths.candidateScore}px`,
                  minWidth: `${columnWidths.candidateScore}px`,
                  maxWidth: `${columnWidths.candidateScore}px`,
                }}
                className="relative px-2.5 py-2 text-center border-r border-[#0D6535]"
              >
                <span>Score</span>
                {renderResizeHandle('candidateScore', 'Candidate Score')}
              </th>

              {/* Action */}
              <th
                style={{
                  width: `${columnWidths.actions}px`,
                  minWidth: `${columnWidths.actions}px`,
                  maxWidth: `${columnWidths.actions}px`,
                }}
                className="relative px-2 py-2 text-center"
              >
                <span>Action</span>
                {renderResizeHandle('actions', 'Action')}
              </th>
            </tr>
          </thead>

          {/* Spreadsheet Data Rows with Crisp Excel Gridlines */}
          <tbody className="divide-y divide-[#E5E7EB]">
            {paginatedRules.length === 0 ? (
              <tr>
                <td colSpan={14} className="text-center py-16 text-slate-500 bg-white">
                  <div className="flex flex-col items-center gap-1.5">
                    <FileSpreadsheet className="w-8 h-8 text-slate-300" />
                    <p className="font-semibold text-slate-800 text-sm">No spreadsheet rows match the filter.</p>
                    <p className="text-xs text-slate-500">Try selecting &ldquo;All Rules&rdquo; or clearing the search text.</p>
                  </div>
                </td>
              </tr>
            ) : (
              paginatedRules.map((rule, idx) => {
                const globalIndex = (currentPage - 1) * pageSize + idx + 1
                const mappedScenario = ruleToScenarioMap.get(rule.ruleId.trim().toUpperCase())
                const isSelected = selectedRowId === rule.ruleId

                return (
                  <tr
                    key={rule.ruleId}
                    onClick={() => setSelectedRowId(rule.ruleId)}
                    onDoubleClick={() => setInspectedRule({ rule, rowNumber: globalIndex })}
                    className={`transition-colors cursor-pointer select-none ${rowHeightClass} ${
                      isSelected
                        ? 'bg-[#E8F5E9]'
                        : idx % 2 === 0
                        ? 'bg-white hover:bg-[#F0FDF4]'
                        : 'bg-[#F9FAFB] hover:bg-[#F0FDF4]'
                    }`}
                  >
                    {/* Row Header (#) - Excel gray gutter */}
                    <td
                      style={{
                        width: `${columnWidths.index}px`,
                        minWidth: `${columnWidths.index}px`,
                        maxWidth: `${columnWidths.index}px`,
                      }}
                      className="px-2 py-1.5 text-center text-slate-500 font-mono text-[11px] font-medium border-r border-b border-[#E5E7EB] bg-[#F9FAFB] select-none"
                    >
                      {globalIndex}
                    </td>

                    {/* Rule ID (Always single-line nowrap!) */}
                    <td
                      style={{
                        width: `${columnWidths.ruleId}px`,
                        minWidth: `${columnWidths.ruleId}px`,
                        maxWidth: `${columnWidths.ruleId}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] font-mono text-[11px] font-semibold text-slate-900 whitespace-nowrap overflow-hidden"
                    >
                      <div className="flex items-center justify-between gap-1 group">
                        <span className="hover:text-[#107C41] truncate">{rule.ruleId}</span>
                        <button
                          type="button"
                          onClick={(e) => handleCopyId(rule.ruleId, e)}
                          title={`Copy ${rule.ruleId}`}
                          className="opacity-0 group-hover:opacity-100 p-0.5 rounded hover:bg-slate-200 text-slate-400 hover:text-slate-700 transition shrink-0"
                        >
                          {copiedId === rule.ruleId ? (
                            <Check className="w-3 h-3 text-emerald-600 stroke-[2.5]" />
                          ) : (
                            <Copy className="w-3 h-3" />
                          )}
                        </button>
                      </div>
                    </td>

                    {/* Engine */}
                    <td
                      style={{
                        width: `${columnWidths.engine}px`,
                        minWidth: `${columnWidths.engine}px`,
                        maxWidth: `${columnWidths.engine}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] font-medium text-slate-800 whitespace-nowrap overflow-hidden text-ellipsis"
                    >
                      {rule.engine}
                    </td>

                    {/* Rule / Message Name */}
                    <td
                      style={{
                        width: `${columnWidths.ruleName}px`,
                        minWidth: `${columnWidths.ruleName}px`,
                        maxWidth: `${columnWidths.ruleName}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] font-medium text-slate-900"
                    >
                      <span className={`block ${cellTextClass}`} title={rule.ruleName}>
                        {rule.ruleName}
                      </span>
                    </td>

                    {/* Mapped QA Scenario (Always single-line nowrap!) */}
                    <td
                      style={{
                        width: `${columnWidths.mappedScenario}px`,
                        minWidth: `${columnWidths.mappedScenario}px`,
                        maxWidth: `${columnWidths.mappedScenario}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] whitespace-nowrap overflow-hidden"
                    >
                      {mappedScenario ? (
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation()
                            if (onJumpToScenario) onJumpToScenario(mappedScenario)
                          }}
                          className="cursor-pointer font-mono font-bold text-[11px] text-[#0052CC] hover:text-[#0747A6] hover:underline inline-flex items-center gap-1 transition shrink-0 whitespace-nowrap"
                          title={`Mapped to QA test scenario ${mappedScenario.key} (${mappedScenario.engineCategory}). Click to open.`}
                        >
                          <span>{mappedScenario.key}</span>
                          <ArrowRight className="w-3 h-3 shrink-0" />
                        </button>
                      ) : (
                        <span className="text-slate-400 font-mono text-[11px]">—</span>
                      )}
                    </td>

                    {/* Trigger */}
                    <td
                      style={{
                        width: `${columnWidths.trigger}px`,
                        minWidth: `${columnWidths.trigger}px`,
                        maxWidth: `${columnWidths.trigger}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700"
                    >
                      <span className={`block ${cellTextClass}`} title={rule.trigger}>
                        {rule.trigger || '—'}
                      </span>
                    </td>

                    {/* Audience */}
                    <td
                      style={{
                        width: `${columnWidths.audience}px`,
                        minWidth: `${columnWidths.audience}px`,
                        maxWidth: `${columnWidths.audience}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700"
                    >
                      <span className={`block ${cellTextClass}`} title={rule.audience}>
                        {rule.audience || 'All users'}
                      </span>
                    </td>

                    {/* Communication Objective */}
                    <td
                      style={{
                        width: `${columnWidths.communicationObjective}px`,
                        minWidth: `${columnWidths.communicationObjective}px`,
                        maxWidth: `${columnWidths.communicationObjective}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700"
                    >
                      <span className={`block ${cellTextClass}`} title={rule.communicationObjective}>
                        {rule.communicationObjective || '—'}
                      </span>
                    </td>

                    {/* Priority */}
                    <td
                      style={{
                        width: `${columnWidths.priority}px`,
                        minWidth: `${columnWidths.priority}px`,
                        maxWidth: `${columnWidths.priority}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] whitespace-nowrap"
                    >
                      {renderExcelPriority(rule.priority)}
                    </td>

                    {/* Channel Tier */}
                    <td
                      style={{
                        width: `${columnWidths.channelTier}px`,
                        minWidth: `${columnWidths.channelTier}px`,
                        maxWidth: `${columnWidths.channelTier}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700 text-[11px]"
                    >
                      <span className={`block ${cellTextClass}`} title={rule.channelTier}>
                        {rule.channelTier || 'Tier 1'}
                      </span>
                    </td>

                    {/* Delivery Mode */}
                    <td
                      style={{
                        width: `${columnWidths.delivery}px`,
                        minWidth: `${columnWidths.delivery}px`,
                        maxWidth: `${columnWidths.delivery}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700 text-[11px]"
                    >
                      <span className={`block ${cellTextClass}`} title={rule.delivery}>
                        {rule.delivery || 'In-App + Push'}
                      </span>
                    </td>

                    {/* Attention Class */}
                    <td
                      style={{
                        width: `${columnWidths.attentionClass}px`,
                        minWidth: `${columnWidths.attentionClass}px`,
                        maxWidth: `${columnWidths.attentionClass}px`,
                      }}
                      className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-600 text-[11px] whitespace-nowrap overflow-hidden text-ellipsis"
                    >
                      <span className="truncate block font-mono" title={rule.attentionClass}>
                        {rule.attentionClass || 'Reflective'}
                      </span>
                    </td>

                    {/* Candidate Score */}
                    <td
                      style={{
                        width: `${columnWidths.candidateScore}px`,
                        minWidth: `${columnWidths.candidateScore}px`,
                        maxWidth: `${columnWidths.candidateScore}px`,
                      }}
                      className="px-2.5 py-1.5 text-center border-r border-b border-[#E5E7EB] font-mono text-[11px] text-slate-800 font-medium"
                    >
                      {rule.candidateScore || '50'}
                    </td>

                    {/* Action: Inspect */}
                    <td
                      style={{
                        width: `${columnWidths.actions}px`,
                        minWidth: `${columnWidths.actions}px`,
                        maxWidth: `${columnWidths.actions}px`,
                      }}
                      className="px-2 py-1 text-center border-b border-[#E5E7EB]"
                    >
                      <button
                        type="button"
                        onClick={(e) => {
                          e.stopPropagation()
                          setInspectedRule({ rule, rowNumber: globalIndex })
                        }}
                        className="cursor-pointer px-2 py-0.5 rounded-[2px] bg-white hover:bg-slate-100 border border-slate-300 text-slate-700 hover:text-slate-900 text-[11px] font-medium transition"
                        title="View complete specifications for this rule"
                      >
                        Inspect
                      </button>
                    </td>
                  </tr>
                )
              })
            )}
          </tbody>
        </table>
      </div>

      {/* 4. Classic Excel Status Bar at the bottom */}
      <div className="bg-[#F3F4F6] border-t border-[#D1D5DB] px-3 py-1 shrink-0 flex items-center justify-between text-[11px] text-slate-600 select-none">
        <div className="flex items-center gap-3">
          <span className="flex items-center gap-1.5 font-medium text-slate-700">
            <span className="w-2 h-2 rounded-full bg-emerald-600" />
            <span>Ready</span>
          </span>
          <span className="text-slate-300">|</span>
          <span>{filteredRules.length} rows</span>
          <span className="text-slate-300">|</span>
          <span className="text-slate-500">Drag column edges to resize • Double-click row to inspect</span>
        </div>

        {pageSize > 0 && totalPages > 1 && (
          <div className="flex items-center gap-1.5">
            <span>
              Page {currentPage} of {totalPages}
            </span>
            <button
              type="button"
              disabled={currentPage <= 1}
              onClick={() => setCurrentPage(1)}
              className="px-1.5 py-0.5 rounded-[2px] bg-white border border-[#CBD5E1] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-slate-100 font-mono"
              title="First Page"
            >
              «
            </button>
            <button
              type="button"
              disabled={currentPage <= 1}
              onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
              className="px-1.5 py-0.5 rounded-[2px] bg-white border border-[#CBD5E1] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-slate-100"
              title="Previous Page"
            >
              ‹
            </button>
            <button
              type="button"
              disabled={currentPage >= totalPages}
              onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
              className="px-1.5 py-0.5 rounded-[2px] bg-white border border-[#CBD5E1] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-slate-100"
              title="Next Page"
            >
              ›
            </button>
            <button
              type="button"
              disabled={currentPage >= totalPages}
              onClick={() => setCurrentPage(totalPages)}
              className="px-1.5 py-0.5 rounded-[2px] bg-white border border-[#CBD5E1] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-slate-100 font-mono"
              title="Last Page"
            >
              »
            </button>
          </div>
        )}
      </div>

      {/* Specification Modal */}
      {inspectedRule && (
        <NotificationRuleModal
          isOpen={true}
          rule={inspectedRule.rule}
          mappedScenario={ruleToScenarioMap.get(inspectedRule.rule.ruleId.trim().toUpperCase())}
          rowNumber={inspectedRule.rowNumber}
          onClose={() => setInspectedRule(null)}
          onJumpToScenario={(scen) => {
            setInspectedRule(null)
            if (onJumpToScenario) onJumpToScenario(scen)
          }}
          hasPrev={
            filteredRules.findIndex((r) => r.ruleId === inspectedRule.rule.ruleId) > 0
          }
          hasNext={
            filteredRules.findIndex((r) => r.ruleId === inspectedRule.rule.ruleId) <
            filteredRules.length - 1
          }
          onNavigatePrev={() => {
            const idx = filteredRules.findIndex((r) => r.ruleId === inspectedRule.rule.ruleId)
            if (idx > 0) {
              setInspectedRule({
                rule: filteredRules[idx - 1],
                rowNumber: idx,
              })
            }
          }}
          onNavigateNext={() => {
            const idx = filteredRules.findIndex((r) => r.ruleId === inspectedRule.rule.ruleId)
            if (idx >= 0 && idx < filteredRules.length - 1) {
              setInspectedRule({
                rule: filteredRules[idx + 1],
                rowNumber: idx + 2,
              })
            }
          }}
        />
      )}
    </div>
  )
}
