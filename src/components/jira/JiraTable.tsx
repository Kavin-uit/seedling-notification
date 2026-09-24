import React, { useState, useMemo, useEffect, useRef, useLayoutEffect } from 'react'
import { createPortal } from 'react-dom'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { parseStatuses } from '../../types/notification'
import { JiraStatusBadge } from './JiraStatusBadge'
import { EngineBadge } from './EngineBadge'
import { JiraDefectModal } from './JiraDefectModal'
import { VersionHistoryModal } from './VersionHistoryModal'
import { EventBriefModal } from './EventBriefModal'
import { IosMismatchTooltip } from './IosMismatchTooltip'
import { JiraDetailModal } from './JiraDetailModal'
import type { SheetVerificationSummary, FieldMismatch } from '../../services/sheetVerificationService'
import {
  Filter,
  ChevronRight,
  ChevronUp,
  ChevronDown,
  Check,
  Bug,
  Copy,
  History,
  Info,
  X,
  Trash2,
  Pencil,
  MessageSquare,
  Loader2,
  RotateCcw,
  Share,
  Eye,
} from 'lucide-react'
import { executeSearch } from '../../utils/aiSearch'
import { rollbackToVersion, rollbackFieldToVersion } from '../../utils/versionHistory'
import { polishCommentWithGemini } from '../../services/commentAiService'
import { buildFilterShareUrl, copyShareUrlToClipboard } from '../../utils/filterShare'

// Google Gemini Multi-Color Gradient Sparkle Logo
export const GeminiSparkleIcon: React.FC<{ className?: string }> = ({ className = 'w-3.5 h-3.5' }) => (
  <svg viewBox="0 0 28 28" fill="none" className={className} xmlns="http://www.w3.org/2000/svg">
    <path
      d="M14 0C14 7.732 7.732 14 0 14C7.732 14 14 20.268 14 28C14 20.268 20.268 14 28 14C20.268 14 14 7.732 14 0Z"
      fill="url(#gemini_sparkle_comment_grad)"
    />
    <defs>
      <linearGradient id="gemini_sparkle_comment_grad" x1="0" y1="0" x2="28" y2="28" gradientUnits="userSpaceOnUse">
        <stop offset="0%" stopColor="#1A73E8" />
        <stop offset="50%" stopColor="#8AB4F8" />
        <stop offset="100%" stopColor="#9333EA" />
      </linearGradient>
    </defs>
  </svg>
)

interface JiraTableProps {
  scenarios: NotificationScenario[]
  verificationSummary?: SheetVerificationSummary | null
  onApplySheetValue?: (scenario: NotificationScenario, field: string, value: string) => void
  onUpdateScenario: (updated: NotificationScenario) => void
  onRollbackScenario?: (rolledBack: NotificationScenario) => void
  onBatchUpdateScenarios?: (
    updated: NotificationScenario[],
    newRows?: NotificationScenario[]
  ) => void
  onUpdateStatus: (id: string, newStatus: ScenarioStatus) => void
  onDeleteScenario: (id: string) => void
  onAddRow: () => NotificationScenario | void
  searchQuery: string
  onClearSearch?: () => void
  selectedEngine: string
  onSelectEngine?: (engine: string) => void
  availableEngines?: string[]
  statusFilter?: string
  onStatusFilterChange?: (status: string) => void
  onResetAllFilters?: () => void
  isAiSearch?: boolean
  onShowToast?: (message: string) => void
  onOpenShareModal?: () => void
}

type EditableField =
  | 'governanceEvent'
  | 'trigger'
  | 'audience'
  | 'communicationObjective'
  | 'desiredOutcome'
  | 'pushSubject'
  | 'pushBody'
  | 'emailSubject'
  | 'emailBody'
  | 'inAppExperience'
  | 'cta'
  | 'comments'

export type TableColumnKey =
  | 'index'
  | 'engine'
  | 'event'
  | 'trigger'
  | 'audience'
  | 'communicationObjective'
  | 'desiredOutcome'
  | 'pushSubject'
  | 'pushBody'
  | 'emailSubject'
  | 'emailBody'
  | 'inAppExperience'
  | 'cta'
  | 'comments'
  | 'status'
  | 'action'

const COLUMN_STORAGE_KEY = 'seedling_sheet_column_widths_v7'

const DEFAULT_COLUMN_WIDTHS: Record<TableColumnKey, number> = {
  index: 48,
  engine: 140,
  event: 220,
  trigger: 150,
  audience: 130,
  communicationObjective: 180,
  desiredOutcome: 150,
  pushSubject: 200,
  pushBody: 240,
  emailSubject: 200,
  emailBody: 250,
  inAppExperience: 180,
  cta: 130,
  comments: 220,
  status: 180,
  action: 88,
}

const MIN_COLUMN_WIDTHS: Record<TableColumnKey, number> = {
  index: 36,
  engine: 85,
  event: 120,
  trigger: 90,
  audience: 85,
  communicationObjective: 100,
  desiredOutcome: 90,
  pushSubject: 110,
  pushBody: 120,
  emailSubject: 110,
  emailBody: 120,
  inAppExperience: 100,
  cta: 80,
  comments: 120,
  status: 100,
  action: 76,
}

const escapeRegex = (str: string) => str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')

const STOP_WORDS_SET = new Set([
  'a', 'about', 'above', 'after', 'again', 'against', 'all', 'am', 'an', 'and', 'any', 'are', 'as', 'at',
  'be', 'because', 'been', 'before', 'being', 'below', 'between', 'both', 'but', 'by',
  'can', 'did', 'do', 'does', 'doing', 'down', 'during',
  'each', 'few', 'for', 'from', 'further',
  'had', 'has', 'have', 'having', 'he', 'her', 'here', 'hers', 'herself', 'him', 'himself', 'his', 'how',
  'i', 'if', 'in', 'into', 'is', 'it', 'its', 'itself',
  'just', 'me', 'more', 'most', 'my', 'myself',
  'no', 'nor', 'not', 'now', 'of', 'off', 'on', 'once', 'only', 'or', 'other', 'our', 'ours', 'ourselves', 'out', 'over', 'own',
  'same', 'she', 'should', 'so', 'some', 'such',
  'than', 'that', 'the', 'their', 'theirs', 'them', 'themselves', 'then', 'there', 'these', 'they', 'this', 'those', 'through', 'to', 'too',
  'under', 'until', 'up', 'very', 'was', 'we', 'were', 'what', 'when', 'where', 'which', 'while', 'who', 'whom', 'why', 'with',
  'you', 'your', 'yours', 'yourself', 'yourselves'
])

const highlightMatches = (
  text: string,
  query: string,
  matchedTerms?: Set<string>,
  isMatchingRow: boolean = true
): React.ReactNode => {
  if (!text) return <span className="text-slate-300 italic">Empty</span>
  const trimmed = query ? query.trim() : ''
  if (!trimmed || !isMatchingRow) return text

  // 1. Exact full query phrase
  const phrases: string[] = []
  if (trimmed.length >= 2) {
    phrases.push(trimmed)
  }

  // 2. Meaningful individual words
  const allWords = trimmed.split(/\s+/).map((w) => w.replace(/[^\w-]/g, '').trim())
  const isMultiWord = allWords.length > 2

  const uniqueWords: string[] = []
  allWords.forEach((w) => {
    const lower = w.toLowerCase()
    // When query is a sentence/phrase, strictly only highlight words >= 3 chars that are not stop words
    if (lower.length >= 3 && !STOP_WORDS_SET.has(lower)) {
      if (!uniqueWords.some((u) => u.toLowerCase() === lower)) {
        uniqueWords.push(w)
      }
    } else if (!isMultiWord && lower.length >= 2 && !STOP_WORDS_SET.has(lower)) {
      if (!uniqueWords.some((u) => u.toLowerCase() === lower)) {
        uniqueWords.push(w)
      }
    }
  })

  // 3. AI matched terms if any
  if (matchedTerms) {
    matchedTerms.forEach((term) => {
      const clean = term.replace(/[^\w-]/g, '').trim()
      const lower = clean.toLowerCase()
      if (lower.length >= 3 && !STOP_WORDS_SET.has(lower)) {
        if (!uniqueWords.some((u) => u.toLowerCase() === lower)) {
          uniqueWords.push(clean)
        }
      }
    })
  }

  // Build regex patterns:
  // Phrases match as substring
  // Single words MUST have word boundaries (\b) so they NEVER chop words like "on" in "donation"
  const patterns: string[] = []
  phrases.forEach((p) => {
    patterns.push(escapeRegex(p))
  })
  uniqueWords.forEach((w) => {
    patterns.push(`\\b${escapeRegex(w)}\\b`)
  })

  if (patterns.length === 0) return text

  patterns.sort((a, b) => b.length - a.length)

  try {
    const regex = new RegExp(`(${patterns.join('|')})`, 'gi')
    const parts = text.split(regex)
    if (parts.length <= 1) return text

    return parts.map((part, i) => {
      const isMatch = patterns.some((p) => {
        try {
          return new RegExp(`^${p}$`, 'i').test(part)
        } catch {
          return false
        }
      })
      if (isMatch) {
        return (
          <mark
            key={i}
            className="bg-[#FFE380] text-[#172B4D] px-0.5 rounded-[2px] font-semibold ring-1 ring-[#FFAB00]/50 shadow-2xs"
          >
            {part}
          </mark>
        )
      }
      return part
    })
  } catch {
    return text
  }
}

export const JiraTable: React.FC<JiraTableProps> = ({
  scenarios,
  onUpdateScenario,
  onRollbackScenario,
  onBatchUpdateScenarios: _onBatchUpdateScenarios,
  onUpdateStatus,
  onDeleteScenario,
  onAddRow: _onAddRow,
  searchQuery,
  onClearSearch,
  selectedEngine,
  onSelectEngine,
  availableEngines = ['Governance', 'Contribution', 'Participation', 'Identity', 'Opportunity', 'Discovery'],
  statusFilter: propsStatusFilter,
  onStatusFilterChange,
  onResetAllFilters,
  isAiSearch = false,
  verificationSummary,
  onApplySheetValue,
  onShowToast,
  onOpenShareModal,
}) => {
  const [internalStatusFilter, setInternalStatusFilter] = useState<string>('ALL')
  const statusFilter = propsStatusFilter !== undefined ? propsStatusFilter : internalStatusFilter
  const setStatusFilter = (val: string) => {
    if (onStatusFilterChange) {
      onStatusFilterChange(val)
    } else {
      setInternalStatusFilter(val)
    }
  }

  // Parse comma-separated active statuses into a clean array for multi-select
  const selectedStatuses = useMemo<string[]>(() => {
    if (!statusFilter || statusFilter === 'ALL') {
      return []
    }
    return statusFilter
      .split(',')
      .map((s) => s.trim())
      .filter((s) => s && s !== 'ALL')
  }, [statusFilter])

  // Toggle a status in or out of multi-select list
  const handleToggleStatus = (val: string) => {
    if (val === 'ALL') {
      setStatusFilter('ALL')
      return
    }

    const isAlreadySelected = selectedStatuses.includes(val)
    const nextList = isAlreadySelected
      ? selectedStatuses.filter((s) => s !== val)
      : [...selectedStatuses, val]

    setStatusFilter(nextList.length > 0 ? nextList.join(',') : 'ALL')
  }

  // Clear all status filters
  const handleClearStatusFilters = () => {
    setStatusFilter('ALL')
  }

  // Human-readable status button label
  const statusButtonLabel = useMemo(() => {
    if (selectedStatuses.length === 0) {
      return 'Status'
    }
    if (selectedStatuses.length === 1) {
      const val = selectedStatuses[0]
      return val === 'NOT_WORKING_ANY' ? 'Status: All Not Working' : `Status: ${val}`
    }
    if (selectedStatuses.length === 2) {
      const s1 = selectedStatuses[0] === 'NOT_WORKING_ANY' ? 'Not Working' : selectedStatuses[0]
      const s2 = selectedStatuses[1] === 'NOT_WORKING_ANY' ? 'Not Working' : selectedStatuses[1]
      return `Status: ${s1}, ${s2}`
    }
    return `Status: ${selectedStatuses.length} selected`
  }, [selectedStatuses])

  const handleResetAllFilters = () => {
    if (onResetAllFilters) {
      onResetAllFilters()
    } else {
      setStatusFilter('ALL')
      if (onClearSearch) onClearSearch()
      if (onSelectEngine) onSelectEngine('ALL')
    }
  }

  const hasActiveFilters =
    selectedEngine !== 'ALL' ||
    selectedStatuses.length > 0 ||
    Boolean(searchQuery && searchQuery.trim().length > 0)

  const [copiedActiveFilter, setCopiedActiveFilter] = useState<boolean>(false)
  const [copiedEngineFilter, setCopiedEngineFilter] = useState<boolean>(false)

  const handleShareActiveFilter = async () => {
    const url = buildFilterShareUrl({
      engine: selectedEngine !== 'ALL' ? selectedEngine : undefined,
      status: selectedStatuses.length > 0 ? selectedStatuses.join(',') : undefined,
      q: searchQuery.trim() || undefined,
    })
    const ok = await copyShareUrlToClipboard(url)
    if (ok) {
      setCopiedActiveFilter(true)
      setTimeout(() => setCopiedActiveFilter(false), 2200)
      const details: string[] = []
      if (selectedEngine !== 'ALL') details.push(`Engine: ${selectedEngine}`)
      if (selectedStatuses.length > 0) details.push(`Status: ${selectedStatuses.join(', ')}`)
      if (searchQuery.trim()) details.push(`Search: "${searchQuery}"`)
      const toastText =
        details.length > 0
          ? `Copied link for active filter (${details.join(' • ')})!`
          : 'Copied link to all records!'
      setCopiedToast(toastText)
      setTimeout(() => setCopiedToast(null), 2500)
      if (onShowToast) onShowToast(toastText)
    }
    if (onOpenShareModal) {
      onOpenShareModal()
    }
  }

  const handleShareEngineFilter = async () => {
    if (selectedEngine === 'ALL') return
    const url = buildFilterShareUrl({
      engine: selectedEngine,
    })
    const ok = await copyShareUrlToClipboard(url)
    if (ok) {
      setCopiedEngineFilter(true)
      setTimeout(() => setCopiedEngineFilter(false), 2000)
      const toastText = `Copied link for ${selectedEngine} Engine records!`
      setCopiedToast(toastText)
      setTimeout(() => setCopiedToast(null), 2500)
      if (onShowToast) onShowToast(toastText)
    }
  }

  const [isStatusDropdownOpen, setIsStatusDropdownOpen] = useState(false)
  const statusButtonRef = useRef<HTMLButtonElement>(null)
  const statusMenuRef = useRef<HTMLDivElement>(null)
  const [dropdownCoords, setDropdownCoords] = useState<{ top: number; left: number }>({ top: 0, left: 0 })
  const [hoveredStatusItem, setHoveredStatusItem] = useState<{
    label: string
    value: string
    dotColor: string
    count: number
    rect: { top: number; bottom: number; left: number; width: number }
  } | null>(null)

  const updateDropdownCoords = () => {
    if (statusButtonRef.current) {
      const rect = statusButtonRef.current.getBoundingClientRect()
      const menuWidth = 410
      let left = rect.left
      if (left + menuWidth > window.innerWidth - 10) {
        left = window.innerWidth - menuWidth - 10
      }
      setDropdownCoords({
        top: rect.bottom + 4,
        left: Math.max(10, left),
      })
    }
  }

  const handleToggleStatusDropdown = (e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    if (!isStatusDropdownOpen) {
      updateDropdownCoords()
    }
    setIsStatusDropdownOpen((prev) => !prev)
  }

  // Close status dropdown on click outside or Escape
  useEffect(() => {
    if (!isStatusDropdownOpen) return

    updateDropdownCoords()

    const handleClickOutside = (e: MouseEvent) => {
      const target = e.target as Node
      const isInsideButton = statusButtonRef.current?.contains(target)
      const isInsideMenu = statusMenuRef.current?.contains(target)
      if (!isInsideButton && !isInsideMenu) {
        setIsStatusDropdownOpen(false)
        setHoveredStatusItem(null)
      }
    }

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setIsStatusDropdownOpen(false)
        setHoveredStatusItem(null)
      }
    }

    const handleScrollOrResize = () => {
      updateDropdownCoords()
    }

    document.addEventListener('mousedown', handleClickOutside)
    document.addEventListener('keydown', handleKeyDown)
    window.addEventListener('resize', handleScrollOrResize)
    window.addEventListener('scroll', handleScrollOrResize, true)

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleKeyDown)
      window.removeEventListener('resize', handleScrollOrResize)
      window.removeEventListener('scroll', handleScrollOrResize, true)
    }
  }, [isStatusDropdownOpen])
  const [selectedRowIds, setSelectedRowIds] = useState<Set<string>>(new Set())
  const [defectScenario, setDefectScenario] = useState<NotificationScenario | null>(null)
  const [historyScenario, setHistoryScenario] = useState<NotificationScenario | null>(null)
  const [selectedEventBrief, setSelectedEventBrief] = useState<{
    scenario: NotificationScenario
    rect: DOMRect
  } | null>(null)
  const [detailScenario, setDetailScenario] = useState<{
    scenario: NotificationScenario
    rowNumber: number
  } | null>(null)
  const [activeMismatchTooltip, setActiveMismatchTooltip] = useState<{
    scenario: NotificationScenario
    mismatch: FieldMismatch
    anchorRect: DOMRect
  } | null>(null)
  const [hoveredInfo, setHoveredInfo] = useState<{
    scenario: NotificationScenario
    rect: DOMRect
  } | null>(null)
  const [hoveredComment, setHoveredComment] = useState<{
    scenario: NotificationScenario
    rowNumber: number
    rect: DOMRect
  } | null>(null)
  const [deletingScenario, setDeletingScenario] = useState<NotificationScenario | null>(null)
  const [copiedToast, setCopiedToast] = useState<string | null>(null)
  const tableContainerRef = useRef<HTMLDivElement>(null)

  // Clear comment tooltip on Escape key or window resize
  useEffect(() => {
    if (!hoveredComment) return
    const handleClose = (e: KeyboardEvent | Event) => {
      if ('key' in e && (e as KeyboardEvent).key === 'Escape') {
        setHoveredComment(null)
      } else if (!('key' in e)) {
        setHoveredComment(null)
      }
    }
    window.addEventListener('keydown', handleClose)
    window.addEventListener('resize', handleClose)
    return () => {
      window.removeEventListener('keydown', handleClose)
      window.removeEventListener('resize', handleClose)
    }
  }, [hoveredComment])

  // Adjustable column widths (Excel spreadsheet style)
  const [columnWidths, setColumnWidths] = useState<Record<TableColumnKey, number>>(() => {
    try {
      // Clear older versions so all users get the fresh default layout
      ['seedling_sheet_column_widths_v1', 'seedling_sheet_column_widths_v2', 'seedling_sheet_column_widths_v3', 'seedling_sheet_column_widths_v4', 'seedling_sheet_column_widths_v5', 'seedling_sheet_column_widths_v6'].forEach((k) => {
        try { localStorage.removeItem(k) } catch {}
      })
      const raw = localStorage.getItem(COLUMN_STORAGE_KEY)
      if (raw) {
        const parsed = JSON.parse(raw)
        const merged: Record<TableColumnKey, number> = { ...DEFAULT_COLUMN_WIDTHS }
        for (const key of Object.keys(DEFAULT_COLUMN_WIDTHS) as TableColumnKey[]) {
          if (typeof parsed[key] === 'number' && parsed[key] > 0) {
            merged[key] = parsed[key]
          }
        }
        return merged
      }
    } catch (e) {
      console.warn('Failed to parse saved column widths', e)
    }
    return DEFAULT_COLUMN_WIDTHS
  })

  const [activeResizingCol, setActiveResizingCol] = useState<TableColumnKey | null>(null)
  const resizingStateRef = useRef<{
    colKey: TableColumnKey
    startX: number
    startScrollLeft: number
    startWidth: number
  } | null>(null)

  const isAnyColumnCustomized = useMemo(() => {
    return (Object.keys(DEFAULT_COLUMN_WIDTHS) as TableColumnKey[]).some(
      (k) => columnWidths[k] !== DEFAULT_COLUMN_WIDTHS[k]
    )
  }, [columnWidths])

  const handleResetAllColumnWidths = () => {
    setColumnWidths(DEFAULT_COLUMN_WIDTHS)
    try {
      localStorage.removeItem(COLUMN_STORAGE_KEY)
    } catch {}
    setCopiedToast('Reset all columns to default width')
    setTimeout(() => setCopiedToast(null), 2000)
  }

  const handleResizeStart = (colKey: TableColumnKey, e: React.PointerEvent) => {
    e.preventDefault()
    e.stopPropagation()

    const targetEl = e.currentTarget as HTMLElement
    try {
      targetEl.setPointerCapture(e.pointerId)
    } catch {}

    const container = tableContainerRef.current
    const initialScrollLeft = container ? container.scrollLeft : 0

    resizingStateRef.current = {
      colKey,
      startX: e.clientX,
      startScrollLeft: initialScrollLeft,
      startWidth: columnWidths[colKey] ?? DEFAULT_COLUMN_WIDTHS[colKey],
    }
    setActiveResizingCol(colKey)

    const onPointerMove = (ev: PointerEvent) => {
      if (!resizingStateRef.current) return
      const { colKey: key, startX, startScrollLeft, startWidth } = resizingStateRef.current
      const currentScrollLeft = tableContainerRef.current ? tableContainerRef.current.scrollLeft : 0
      const scrollDiff = currentScrollLeft - startScrollLeft
      const delta = (ev.clientX - startX) + scrollDiff
      const minW = MIN_COLUMN_WIDTHS[key] || 40
      const newWidth = Math.min(2400, Math.max(minW, Math.round(startWidth + delta)))
      setColumnWidths((prev) => ({
        ...prev,
        [key]: newWidth,
      }))

      // Auto-scroll container smoothly when dragging near boundaries
      if (tableContainerRef.current) {
        const cont = tableContainerRef.current
        const rect = cont.getBoundingClientRect()
        if (ev.clientX > rect.right - 50) {
          cont.scrollLeft += 15
        } else if (ev.clientX < rect.left + 50) {
          cont.scrollLeft -= 15
        }
      }
    }

    const onPointerUp = (ev: PointerEvent) => {
      try {
        targetEl.releasePointerCapture(ev.pointerId)
      } catch {}
      if (resizingStateRef.current) {
        setColumnWidths((latest) => {
          try {
            localStorage.setItem(COLUMN_STORAGE_KEY, JSON.stringify(latest))
          } catch (err) {
            console.error('Failed to save column widths to localStorage', err)
          }
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

  const handleResizeDoubleClick = (colKey: TableColumnKey, e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    const defaultW = DEFAULT_COLUMN_WIDTHS[colKey]
    setColumnWidths((prev) => {
      const next = { ...prev, [colKey]: defaultW }
      try {
        localStorage.setItem(COLUMN_STORAGE_KEY, JSON.stringify(next))
      } catch {}
      return next
    })
    setCopiedToast(`Reset ${colKey} column to default width (${defaultW}px)`)
    setTimeout(() => setCopiedToast(null), 1800)
  }

  // Manage cursor & text selection styling on document.body during resize
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

  const totalTableWidth = useMemo(() => {
    return (Object.keys(DEFAULT_COLUMN_WIDTHS) as TableColumnKey[]).reduce(
      (sum, key) => sum + (columnWidths[key] ?? DEFAULT_COLUMN_WIDTHS[key]),
      0
    )
  }, [columnWidths])

  const renderResizeHandle = (colKey: TableColumnKey, colTitle: string) => {
    const isResizing = activeResizingCol === colKey
    return (
      <div
        onPointerDown={(e) => handleResizeStart(colKey, e)}
        onDoubleClick={(e) => handleResizeDoubleClick(colKey, e)}
        className="absolute top-0 bottom-0 -right-2.5 w-5 z-40 cursor-col-resize select-none flex items-center justify-center group/resizer touch-none"
        title={`Drag to adjust ${colTitle} width • Double-click to auto-reset (${DEFAULT_COLUMN_WIDTHS[colKey]}px)`}
      >
        <div
          className={`w-[2px] h-full transition-colors ${
            isResizing
              ? 'bg-amber-300 w-[3px]'
              : 'bg-white/40 group-hover/resizer:bg-white group-hover/resizer:w-[3px]'
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
  const [contextMenu, setContextMenu] = useState<{
    x: number
    y: number
    scenario: NotificationScenario
  } | null>(null)
  const contextMenuRef = useRef<HTMLDivElement>(null)

  // Dynamically clamp context menu strictly within viewport bounds after DOM render
  useLayoutEffect(() => {
    if (!contextMenu || !contextMenuRef.current) return
    const el = contextMenuRef.current
    const rect = el.getBoundingClientRect()
    const PADDING = 16

    let adjustedTop = rect.top
    let adjustedLeft = rect.left
    let modified = false

    if (rect.bottom > window.innerHeight - PADDING) {
      adjustedTop = Math.max(PADDING, window.innerHeight - rect.height - PADDING)
      modified = true
    }
    if (rect.right > window.innerWidth - PADDING) {
      adjustedLeft = Math.max(PADDING, window.innerWidth - rect.width - PADDING)
      modified = true
    }
    if (adjustedTop < PADDING) {
      adjustedTop = PADDING
      modified = true
    }
    if (adjustedLeft < PADDING) {
      adjustedLeft = PADDING
      modified = true
    }

    if (modified) {
      el.style.top = `${adjustedTop}px`
      el.style.left = `${adjustedLeft}px`
    }
  }, [contextMenu])

  // Copy entire row values to clipboard in tab-separated format (spreadsheet ready)
  const handleCopyRow = (scenario: NotificationScenario) => {
    const rowValues = [
      scenario.key,
      scenario.engineCategory,
      scenario.governanceEvent,
      scenario.trigger,
      scenario.audience,
      scenario.communicationObjective,
      scenario.desiredOutcome,
      scenario.pushSubject,
      scenario.pushBody,
      scenario.emailSubject,
      scenario.emailBody,
      scenario.inAppExperience,
      scenario.cta,
      scenario.comments || '',
      scenario.status,
    ]

    const tsv = rowValues
      .map((v) => (v || '').replace(/\t/g, ' ').replace(/\r?\n/g, ' '))
      .join('\t')

    navigator.clipboard.writeText(tsv).then(() => {
      setCopiedToast(`Copied row values for ${scenario.key}!`)
      setTimeout(() => setCopiedToast(null), 2200)
    })
    setContextMenu(null)
  }

  const handleDeleteRow = (scenario: NotificationScenario) => {
    setDeletingScenario(scenario)
  }

  // Comment editing state & handlers
  const [editingCommentId, setEditingCommentId] = useState<string | null>(null)
  const [commentDraft, setCommentDraft] = useState<string>('')
  const [isPolishingComment, setIsPolishingComment] = useState<boolean>(false)
  const [aiPolishedSuccess, setAiPolishedSuccess] = useState<boolean>(false)

  const startEditingComment = (scenario: NotificationScenario) => {
    setEditingCommentId(scenario.id)
    setCommentDraft(scenario.comments || '')
    setAiPolishedSuccess(false)
  }

  const handlePolishComment = async () => {
    if (!commentDraft.trim() || isPolishingComment) return
    setIsPolishingComment(true)
    try {
      const polished = await polishCommentWithGemini(commentDraft)
      if (polished) {
        setCommentDraft(polished)
        setAiPolishedSuccess(true)
        setTimeout(() => setAiPolishedSuccess(false), 2500)
      }
    } catch (err) {
      console.error('Failed to polish comment with Gemini AI:', err)
    } finally {
      setIsPolishingComment(false)
    }
  }

  const saveComment = (scenario: NotificationScenario) => {
    if (editingCommentId !== scenario.id) return
    const trimmed = commentDraft.trim()
    if (trimmed !== (scenario.comments || '').trim()) {
      onUpdateScenario({
        ...scenario,
        comments: trimmed,
        updatedAt: new Date().toISOString(),
      })
      setCopiedToast(trimmed ? `Saved comment for ${scenario.key}` : `Cleared comment for ${scenario.key}`)
      setTimeout(() => setCopiedToast(null), 2000)
    }
    setEditingCommentId(null)
  }

  const cancelEditingComment = () => {
    setEditingCommentId(null)
  }

  // Toggle row selection on row number click (DBeaver style: click to select, click again to unselect)
  const handleRowNumberClick = (e: React.MouseEvent, rowId: string) => {
    e.stopPropagation()
    setSelectedRowIds((prev) => {
      const next = new Set(prev)
      if (next.has(rowId)) {
        next.delete(rowId) // Unselect -> removes highlighter
      } else {
        if (!e.ctrlKey && !e.metaKey && !e.shiftKey) {
          next.clear() // Single selection unless modifier held
        }
        next.add(rowId)
      }
      return next
    })
  }

  // Close context menu & clear selection on Escape or outside click
  useEffect(() => {
    const handleGlobalPointerDown = (e: MouseEvent | PointerEvent) => {
      if (contextMenuRef.current && !contextMenuRef.current.contains(e.target as Node)) {
        setContextMenu(null)
      }
    }
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setContextMenu(null)
        setDeletingScenario(null)
        setEditingCommentId(null)
        setSelectedRowIds(new Set())
      }
    }
    window.addEventListener('pointerdown', handleGlobalPointerDown, true)
    window.addEventListener('keydown', handleKeyDown)
    return () => {
      window.removeEventListener('pointerdown', handleGlobalPointerDown, true)
      window.removeEventListener('keydown', handleKeyDown)
    }
  }, [])

  // Count scenarios per status within currently selected engine
  const statusCounts = useMemo(() => {
    const engineScenarios =
      selectedEngine === 'ALL'
        ? scenarios
        : scenarios.filter((s) => (s.engineCategory || 'Governance') === selectedEngine)

    const counts: Record<string, number> = {
      ALL: engineScenarios.length,
      NOT_WORKING_ANY: 0,
    }

    engineScenarios.forEach((s) => {
      const activeList = parseStatuses(s.status)
      let hasNotWorking = false
      activeList.forEach((st) => {
        counts[st] = (counts[st] || 0) + 1
        if (st.includes('NOT WORKING')) {
          hasNotWorking = true
        }
      })
      if (hasNotWorking) {
        counts.NOT_WORKING_ANY++
      }
    })

    return counts
  }, [scenarios, selectedEngine])

  // 1. Filter scenarios by engine category & multiple statuses (OR condition)
  const baseFiltered = useMemo(() => {
    return scenarios.filter((s) => {
      const matchesEngine =
        selectedEngine === 'ALL' || (s.engineCategory || 'Governance') === selectedEngine
      if (!matchesEngine) return false

      if (selectedStatuses.length === 0) return true

      const activeList = parseStatuses(s.status)
      const upperActiveList = activeList.map((st) => st.trim().toUpperCase())

      return selectedStatuses.some((sel) => {
        const cleanSel = sel.trim().toUpperCase()
        if (cleanSel === 'NOT_WORKING_ANY' || cleanSel === 'ALL NOT WORKING') {
          return upperActiveList.some((st) => st.includes('NOT WORKING'))
        }
        return upperActiveList.includes(cleanSel)
      })
    })
  }, [scenarios, selectedEngine, selectedStatuses])

  // 2. Global Search: When search query is entered, search GLOBALLY across ALL scenarios,
  // completely bypassing active engine and status filters as explicitly requested.
  const isSearchActive = Boolean(searchQuery && searchQuery.trim().length > 0)

  // 3. Find matching rows & terms globally across all scenarios
  const { results: matchingScenarios, matchedTerms } = useMemo(() => {
    if (!isSearchActive) {
      return { results: [], matchedTerms: new Set<string>() }
    }
    // Search GLOBALLY across all scenarios (ignoring selectedEngine and selectedStatuses)
    return executeSearch(scenarios, searchQuery, Boolean(isAiSearch))
  }, [scenarios, searchQuery, isAiSearch, isSearchActive])

  // When search query is entered, display matching scenarios globally across all engines.
  // When search is empty, display baseFiltered (respecting current engine and status filters).
  const filteredScenarios = isSearchActive ? matchingScenarios : baseFiltered

  const matchingRowIds = useMemo(() => {
    return new Set(matchingScenarios.map((s) => s.id))
  }, [matchingScenarios])

  const [currentMatchIndex, setCurrentMatchIndex] = useState<number>(0)

  // Auto-scroll to first matching row when query changes
  useEffect(() => {
    if (searchQuery.trim() && matchingScenarios.length > 0) {
      setCurrentMatchIndex(0)
      const firstId = matchingScenarios[0].id
      const el = document.getElementById(`row-${firstId}`)
      if (el) {
        el.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
      }
    }
  }, [searchQuery, isAiSearch])

  const handleNextMatch = () => {
    if (matchingScenarios.length === 0) return
    const nextIdx = (currentMatchIndex + 1) % matchingScenarios.length
    setCurrentMatchIndex(nextIdx)
    const targetId = matchingScenarios[nextIdx].id
    const el = document.getElementById(`row-${targetId}`)
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    }
  }

  const handlePrevMatch = () => {
    if (matchingScenarios.length === 0) return
    const prevIdx =
      (currentMatchIndex - 1 + matchingScenarios.length) % matchingScenarios.length
    setCurrentMatchIndex(prevIdx)
    const targetId = matchingScenarios[prevIdx].id
    const el = document.getElementById(`row-${targetId}`)
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    }
  }

  // Data is protected and read-only for production: cell editing and pasting disabled.
  // Status transitions remain fully active and persist to Cloudflare D1.

  // Handle right-click context menu (smart positioning to fit within viewport)
  const handleContextMenu = (e: React.MouseEvent, scenario: NotificationScenario) => {
    e.preventDefault()
    const MENU_WIDTH = 250
    const ESTIMATED_HEIGHT = 480
    const PADDING = 16

    let x = e.clientX
    if (x + MENU_WIDTH > window.innerWidth - PADDING) {
      x = Math.max(PADDING, window.innerWidth - MENU_WIDTH - PADDING)
    }

    let y = e.clientY
    const spaceBelow = window.innerHeight - e.clientY
    if (spaceBelow < 380 && e.clientY > 380) {
      // Flip upward when near the bottom of the screen
      y = Math.max(PADDING, e.clientY - ESTIMATED_HEIGHT)
    } else if (y + ESTIMATED_HEIGHT > window.innerHeight - PADDING) {
      y = Math.max(PADDING, window.innerHeight - ESTIMATED_HEIGHT - PADDING)
    }

    setContextMenu({
      x,
      y,
      scenario,
    })
  }

  // Header label based on engine category
  const eventColumnHeader =
    selectedEngine !== 'ALL'
      ? `${selectedEngine} Event`
      : 'Event'

  const allStatuses = useMemo<ScenarioStatus[]>(() => {
    const base: ScenarioStatus[] = [
      'TO DO',
      'TESTED',
      'NOT WORKING',
      'IN-APP NAVIGATION NOT WORKING',
      'PUSH NOTIFICATION NOT WORKING',
      'PUSH NOTIFICATION NAVIGATION NOT WORKING',
      'EMAIL NOTIFICATION NOT WORKING',
      'EMAIL NOTIFICATION NAVIGATION NOT WORKING',
      'SMS NOTIFICATION NOT WORKING',
    ]
    const seen = new Set<string>(base)
    scenarios.forEach((s) => {
      const list = parseStatuses(s.status)
      list.forEach((st) => {
        if (st && !seen.has(st)) {
          seen.add(st)
          base.push(st)
        }
      })
    })
    return base
  }, [scenarios])

  const statusFilterItems = useMemo(() => {
    const items: { label: string; value: string; dotColor: string }[] = [
      { label: 'All Statuses', value: 'ALL', dotColor: 'bg-[#6B778C]' },
    ]

    allStatuses.forEach((st) => {
      let dotColor = 'bg-[#BF2600]'
      const clean = st.toUpperCase()
      if (clean === 'TO DO' || clean.includes('TODO')) dotColor = 'bg-[#42526E]'
      else if (clean === 'TESTED' || clean.includes('PASS')) dotColor = 'bg-[#00875A]'
      else if (clean.includes('NAV')) dotColor = 'bg-[#FF8B00]'
      else if (clean.includes('PUSH')) dotColor = 'bg-[#FF5630]'
      else if (clean.includes('EMAIL')) dotColor = 'bg-[#6554C0]'
      else if (clean.includes('SMS')) dotColor = 'bg-[#00B8D9]'

      items.push({
        label: st,
        value: st,
        dotColor,
      })
    })

    items.push({ label: 'ALL NOT WORKING', value: 'NOT_WORKING_ANY', dotColor: 'bg-[#BF2600]' })
    return items
  }, [allStatuses])

  return (
    <div className="flex-1 flex flex-col min-w-0 bg-white overflow-hidden select-text relative">
      {/* Sub-toolbar: Active Engine tag, Status filter & sheet summary in a single scrollable line */}
      <div className="px-2.5 sm:px-3 py-1.5 bg-[#F4F5F7] border-b border-[#DFE1E6] flex items-center justify-between text-xs text-[#42526E] gap-2 sm:gap-3 min-w-0 flex-nowrap">
        {/* Horizontally scrollable single-line filter container */}
        <div
          onWheel={(e) => {
            if (e.deltaY && !e.deltaX) {
              e.currentTarget.scrollLeft += e.deltaY
            }
          }}
          className="flex items-center gap-2 sm:gap-2.5 overflow-x-auto whitespace-nowrap py-0.5 min-w-0 flex-1 no-scrollbar select-none"
        >
          {/* Active Engine Badge / Click to reset all filters */}
          <div className="flex items-center gap-1 font-bold text-[11px] sm:text-xs shrink-0">
            <button
              type="button"
              onClick={handleResetAllFilters}
              title="Click to reset all filters and display all records"
              className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-[3px] text-xs transition cursor-pointer select-none border font-semibold ${
                selectedEngine === 'Governance'
                  ? 'bg-emerald-100 hover:bg-emerald-200 text-emerald-800 border-emerald-300 shadow-2xs'
                  : selectedEngine === 'Contribution'
                  ? 'bg-blue-100 hover:bg-blue-200 text-blue-800 border-blue-300 shadow-2xs'
                  : selectedEngine === 'Participation'
                  ? 'bg-purple-100 hover:bg-purple-200 text-purple-800 border-purple-300 shadow-2xs'
                  : selectedEngine === 'Identity'
                  ? 'bg-amber-100 hover:bg-amber-200 text-amber-800 border-amber-300 shadow-2xs'
                  : selectedEngine !== 'ALL'
                  ? 'bg-teal-100 hover:bg-teal-200 text-teal-800 border-teal-300 shadow-2xs'
                  : hasActiveFilters
                  ? 'bg-[#DEEBFF] hover:bg-[#B3D4FF] text-[#0052CC] border-[#B3D4FF] shadow-2xs'
                  : 'bg-[#EBECF0] hover:bg-[#DFE1E6] text-[#172B4D] border-[#C1C7D0]'
              }`}
            >
              <span>
                {selectedEngine !== 'ALL'
                  ? `${selectedEngine.toLowerCase().endsWith('engine') ? selectedEngine : `${selectedEngine} Engine`} Sheet`
                  : 'All Engine Categories'}
              </span>
              {selectedEngine !== 'ALL' ? (
                <span className="text-[10px] opacity-70 hover:opacity-100 font-bold ml-0.5" title="Clear engine filter">✕</span>
              ) : hasActiveFilters ? (
                <span className="text-[9px] bg-[#0052CC] text-white px-1.5 py-0.2 rounded-full font-bold">Filtered</span>
              ) : null}
            </button>
            {selectedEngine !== 'ALL' && (
              <button
                type="button"
                onClick={handleShareEngineFilter}
                title={`Copy share link for ${selectedEngine} Engine records`}
                className="p-1 rounded hover:bg-[#DEEBFF] text-[#0052CC] transition cursor-pointer shrink-0"
              >
                {copiedEngineFilter ? (
                  <Check className="w-3.5 h-3.5 text-emerald-600 stroke-[2.5]" />
                ) : (
                  <Share className="w-3.5 h-3.5" />
                )}
              </button>
            )}
          </div>

          <span className="text-slate-300 shrink-0 select-none">|</span>

          {/* Status Filter - Jira-style Multi-Select Dropdown Button */}
          <div className="relative shrink-0">
            <button
              ref={statusButtonRef}
              type="button"
              onClick={handleToggleStatusDropdown}
              className={`cursor-pointer px-2.5 py-1 rounded-[3px] text-xs inline-flex items-center gap-1.5 transition border select-none ${
                selectedStatuses.length > 0
                  ? 'bg-[#DEEBFF] text-[#0052CC] border-[#B3D4FF] font-semibold shadow-2xs'
                  : isStatusDropdownOpen
                  ? 'bg-[#EBECF0] text-[#172B4D] border-[#C1C7D0]'
                  : 'bg-[#FAFBFC] hover:bg-[#EBECF0] text-[#42526E] hover:text-[#172B4D] border-[#DFE1E6]'
              }`}
              title={
                selectedStatuses.length > 0
                  ? `Filtered by: ${selectedStatuses.join(', ')}`
                  : 'Filter by Status'
              }
            >
              <Filter className={`w-3.5 h-3.5 ${selectedStatuses.length > 0 ? 'text-[#0052CC]' : 'text-[#6B778C]'}`} />
              <span>{statusButtonLabel}</span>
              <span
                className={`px-1.5 py-0.2 rounded-full text-[10px] font-bold ${
                  selectedStatuses.length > 0
                    ? 'bg-[#0052CC] text-white'
                    : 'bg-[#DFE1E6] text-[#42526E]'
                }`}
              >
                {selectedStatuses.length > 0 ? baseFiltered.length : statusCounts.ALL ?? scenarios.length}
              </span>
              {selectedStatuses.length > 0 ? (
                <span
                  role="button"
                  tabIndex={0}
                  onClick={(e) => {
                    e.stopPropagation()
                    handleClearStatusFilters()
                  }}
                  title="Clear all status filters"
                  className="hover:bg-[#B3D4FF] rounded p-0.5 text-[#0052CC] cursor-pointer"
                >
                  <X className="w-3 h-3 stroke-[2.5]" />
                </span>
              ) : (
                <ChevronDown
                  className={`w-3 h-3 text-[#6B778C] transition-transform duration-150 ${
                    isStatusDropdownOpen ? 'rotate-180' : ''
                  }`}
                />
              )}
            </button>

            {/* Jira Multi-Select Filter Dropdown Popover - Rendered via Portal */}
            {isStatusDropdownOpen &&
              createPortal(
                <>
                  <div
                    ref={statusMenuRef}
                    style={{
                      position: 'fixed',
                      top: `${dropdownCoords.top}px`,
                      left: `${dropdownCoords.left}px`,
                      zIndex: 9999,
                    }}
                    className="w-[360px] sm:w-[420px] max-w-[95vw] bg-white rounded-xl shadow-[0_16px_40px_rgba(9,30,66,0.22),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] pt-1.5 text-[#172B4D] animate-in fade-in zoom-in-95 duration-100 select-none flex flex-col max-h-[460px]"
                  >
                    <div className="px-3.5 py-2 flex items-center justify-between text-[11px] font-bold text-[#6B778C] border-b border-[#EBECF0] mb-1 bg-[#FAFBFC] rounded-t-xl">
                      <span className="text-xs font-semibold text-[#172B4D]">Filter by Status</span>
                      {selectedStatuses.length > 0 && (
                        <button
                          type="button"
                          onClick={handleClearStatusFilters}
                          className="text-[11px] text-[#0052CC] hover:underline cursor-pointer font-normal"
                        >
                          Clear ({selectedStatuses.length})
                        </button>
                      )}
                    </div>

                    <div className="overflow-y-auto py-1 flex-1 min-h-0 divide-y divide-slate-100/60">
                      {statusFilterItems.map(({ label, value, dotColor }) => {
                        const count = statusCounts[value] ?? 0
                        const isChecked =
                          value === 'ALL'
                            ? selectedStatuses.length === 0
                            : selectedStatuses.includes(value)

                        return (
                          <div
                            key={value}
                            onClick={() => handleToggleStatus(value)}
                            onMouseEnter={(e) => {
                              const rect = e.currentTarget.getBoundingClientRect()
                              setHoveredStatusItem({
                                label,
                                value,
                                dotColor,
                                count,
                                rect: {
                                  top: rect.top,
                                  bottom: rect.bottom,
                                  left: rect.left,
                                  width: rect.width,
                                },
                              })
                            }}
                            onMouseLeave={() => setHoveredStatusItem(null)}
                            title={label}
                            className={`w-full px-3.5 py-2 text-left text-xs flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer group ${
                              isChecked ? 'bg-[#EBECF0]/60' : ''
                            }`}
                          >
                            <div className="flex items-center gap-2.5 min-w-0 pr-3">
                              {/* Jira-style Checkbox */}
                              <div
                                className={`w-3.5 h-3.5 rounded-[3px] flex items-center justify-center transition shrink-0 ${
                                  isChecked
                                    ? 'bg-[#0052CC] border border-[#0052CC] text-white shadow-2xs'
                                    : 'border border-[#C1C7D0] bg-white group-hover:border-[#42526E]'
                                }`}
                              >
                                {isChecked && <Check className="w-2.5 h-2.5 stroke-[3]" />}
                              </div>

                              <span className={`w-2 h-2 rounded-full shrink-0 ${dotColor}`} />
                              <span
                                className={`text-xs leading-snug break-words ${
                                  isChecked ? 'font-semibold text-[#0052CC]' : 'text-[#172B4D]'
                                }`}
                              >
                                {label}
                              </span>
                            </div>

                            <span className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E] shrink-0">
                              {count}
                            </span>
                          </div>
                        )
                      })}
                    </div>

                    {/* Dropdown Footer with Done button & count summary */}
                    <div className="px-3.5 py-2.5 border-t border-[#EBECF0] mt-1 flex items-center justify-between bg-[#FAFBFC] rounded-b-xl">
                      <span className="text-[11px] text-[#6B778C]">
                        {selectedStatuses.length > 0 ? (
                          <>
                            <strong>{selectedStatuses.length}</strong> selected ({baseFiltered.length} records)
                          </>
                        ) : (
                          'All statuses active'
                        )}
                      </span>
                      <button
                        type="button"
                        onClick={() => {
                          setIsStatusDropdownOpen(false)
                          setHoveredStatusItem(null)
                        }}
                        className="px-3.5 py-1 rounded bg-[#0052CC] hover:bg-[#0747A6] text-white text-xs font-semibold cursor-pointer shadow-2xs transition"
                      >
                        Done
                      </button>
                    </div>
                  </div>

                  {/* iOS Style Stand-Up Callout / Tooltip on Mouse Hover */}
                  {hoveredStatusItem && (
                    <div
                      style={{
                        position: 'fixed',
                        top:
                          hoveredStatusItem.rect.top < 65
                            ? `${hoveredStatusItem.rect.bottom + 8}px`
                            : `${hoveredStatusItem.rect.top - 46}px`,
                        left: `${Math.max(
                          12,
                          Math.min(
                            window.innerWidth - 380,
                            hoveredStatusItem.rect.left + 8
                          )
                        )}px`,
                        zIndex: 10002,
                      }}
                      className="pointer-events-none transition-all duration-150 animate-in fade-in zoom-in-95"
                    >
                      <div className="relative bg-[#1C1C1E]/95 text-white backdrop-blur-xl px-3.5 py-2 rounded-xl shadow-[0_14px_34px_rgba(0,0,0,0.55),0_0_1px_rgba(255,255,255,0.35)] border border-white/20 text-xs font-semibold flex items-center gap-2.5 max-w-lg select-none">
                        <span
                          className={`w-2.5 h-2.5 rounded-full shrink-0 ${hoveredStatusItem.dotColor} ring-2 ring-white/30`}
                        />
                        <span className="text-white drop-shadow-xs font-medium tracking-tight">
                          {hoveredStatusItem.label}
                        </span>
                        <span className="text-[10px] font-bold px-1.5 py-0.5 rounded-full bg-white/20 text-white/90 shrink-0 ml-0.5">
                          {hoveredStatusItem.count}
                        </span>

                        {/* Little iOS Stand-up pointer arrow */}
                        <div
                          className={`absolute left-8 w-2 h-2 bg-[#1C1C1E] border-white/20 rotate-45 ${
                            hoveredStatusItem.rect.top < 65
                              ? '-top-1 border-t border-l'
                              : '-bottom-1 border-b border-r'
                          }`}
                        />
                      </div>
                    </div>
                  )}
                </>,
                document.body
              )}
          </div>

          {/* Share Filter Button - Quick one-click share for current filter view */}
          <button
            type="button"
            onClick={handleShareActiveFilter}
            title={
              selectedStatuses.length > 0
                ? `Share direct link for "${selectedStatuses.join(', ')}" filtered records`
                : hasActiveFilters
                ? 'Share direct link for active filtered records'
                : 'Share direct link for these records'
            }
            className={`cursor-pointer px-2.5 py-1 rounded-[3px] text-xs inline-flex items-center gap-1.5 transition border font-semibold select-none shadow-2xs shrink-0 ${
              selectedStatuses.length > 0
                ? 'bg-[#E3FCEF] hover:bg-[#D3F5E4] text-[#006644] border-[#ABF5D1]'
                : hasActiveFilters
                ? 'bg-[#DEEBFF] hover:bg-[#B3D4FF] text-[#0052CC] border-[#B3D4FF]'
                : 'bg-[#FAFBFC] hover:bg-[#EBECF0] text-[#42526E] hover:text-[#172B4D] border-[#DFE1E6]'
            }`}
          >
            {copiedActiveFilter ? (
              <>
                <Check className="w-3.5 h-3.5 text-emerald-600 stroke-[2.5]" />
                <span className="text-emerald-700">Link Copied!</span>
              </>
            ) : (
              <>
                <Share className="w-3.5 h-3.5" />
                <span>Share Filter</span>
              </>
            )}
          </button>

          {/* Reset all filters button when any filter is active */}
          {hasActiveFilters && (
            <button
              type="button"
              onClick={handleResetAllFilters}
              title="Reset all filters and display all records"
              className="cursor-pointer text-xs font-semibold text-[#0052CC] hover:text-[#0747A6] hover:underline flex items-center gap-1 px-2 py-1 rounded hover:bg-[#DEEBFF] transition select-none shrink-0"
            >
              <RotateCcw className="w-3 h-3" />
              <span>Clear all filters</span>
            </button>
          )}
        </div>

        {/* Right side pinned summary: matches indicator & total count (never wraps) */}
        <div className="flex items-center gap-1.5 sm:gap-2 shrink-0 pl-2 border-l border-[#DFE1E6] whitespace-nowrap text-[11px]">
          {isAiSearch && searchQuery.trim() && (
            <span className="px-1.5 py-0.5 rounded text-[10px] font-bold bg-purple-100 text-purple-800 border border-purple-200 shadow-2xs flex items-center gap-1">
              ✨ AI
            </span>
          )}

          {searchQuery.trim() && (
            matchingScenarios.length > 0 ? (
              <div className="flex items-center gap-1.5 px-2 py-0.5 rounded bg-amber-50 border border-amber-200 text-amber-900 text-[11px] font-medium shadow-2xs">
                <span>
                  Match <strong>{currentMatchIndex + 1}</strong> of <strong>{matchingScenarios.length}</strong>
                </span>
                <div className="flex items-center border-l border-amber-300 ml-1 pl-1 gap-0.5">
                  <button
                    type="button"
                    onClick={handlePrevMatch}
                    title="Previous match (↑)"
                    className="p-0.5 rounded hover:bg-amber-200 text-amber-900 cursor-pointer transition flex items-center justify-center"
                  >
                    <ChevronUp className="w-3.5 h-3.5" />
                  </button>
                  <button
                    type="button"
                    onClick={handleNextMatch}
                    title="Next match (↓)"
                    className="p-0.5 rounded hover:bg-amber-200 text-amber-900 cursor-pointer transition flex items-center justify-center"
                  >
                    <ChevronDown className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ) : (
              <span className="px-2 py-0.5 rounded bg-slate-100 border border-slate-200 text-slate-500 text-[11px]">
                0 matches
              </span>
            )
          )}

          <span className="text-[11px] text-[#6B778C]">
            {isSearchActive ? (
              <>
                Showing <strong>{filteredScenarios.length}</strong> global {filteredScenarios.length === 1 ? 'match' : 'matches'}
              </>
            ) : (
              <>
                Showing <strong>{filteredScenarios.length}</strong> rows
              </>
            )}
          </span>

          {isAnyColumnCustomized && (
            <button
              type="button"
              onClick={handleResetAllColumnWidths}
              title="Reset all table column widths back to standard Excel layout"
              className="inline-flex items-center gap-1 px-2 py-0.5 rounded text-[10px] font-semibold text-slate-600 hover:text-[#0052CC] bg-white hover:bg-[#DEEBFF] border border-slate-300 hover:border-[#B3D4FF] shadow-2xs transition cursor-pointer select-none"
            >
              <RotateCcw className="w-2.5 h-2.5" />
              <span>Reset column widths</span>
            </button>
          )}
        </div>
      </div>

      {/* Spreadsheet Table Container */}
      <div
        className="flex-1 overflow-auto bg-white pb-36"
        ref={tableContainerRef}
        onScroll={() => {
          setHoveredInfo(null)
          setHoveredComment(null)
        }}
      >
        <table
          className="border-collapse text-left text-xs font-sans w-max min-w-full"
          style={{
            tableLayout: 'fixed',
            width: `${totalTableWidth}px`,
          }}
        >
          <colgroup>
            <col style={{ width: `${columnWidths.index}px` }} />
            <col style={{ width: `${columnWidths.engine}px` }} />
            <col style={{ width: `${columnWidths.event}px` }} />
            <col style={{ width: `${columnWidths.trigger}px` }} />
            <col style={{ width: `${columnWidths.audience}px` }} />
            <col style={{ width: `${columnWidths.communicationObjective}px` }} />
            <col style={{ width: `${columnWidths.desiredOutcome}px` }} />
            <col style={{ width: `${columnWidths.pushSubject}px` }} />
            <col style={{ width: `${columnWidths.pushBody}px` }} />
            <col style={{ width: `${columnWidths.emailSubject}px` }} />
            <col style={{ width: `${columnWidths.emailBody}px` }} />
            <col style={{ width: `${columnWidths.inAppExperience}px` }} />
            <col style={{ width: `${columnWidths.cta}px` }} />
            <col style={{ width: `${columnWidths.comments}px` }} />
            <col style={{ width: `${columnWidths.status}px` }} />
            <col style={{ width: `${columnWidths.action}px` }} />
          </colgroup>

          {/* Header styled like Microsoft Excel / Google Sheets green header */}
          <thead className="bg-[#107C41] text-white sticky top-0 z-20 shadow-xs select-none border-b border-[#0D6535]">
            <tr className="border-b border-[#0D6535]">
              <th
                onClick={() => {
                  if (selectedRowIds.size > 0) {
                    setSelectedRowIds(new Set())
                  } else {
                    setSelectedRowIds(new Set(filteredScenarios.map((s) => s.id)))
                  }
                }}
                style={{
                  width: `${columnWidths.index}px`,
                  minWidth: `${columnWidths.index}px`,
                  maxWidth: `${columnWidths.index}px`,
                }}
                className="relative px-2 py-2.5 font-bold text-center border-r border-[#0D6535] bg-[#0E6C38] text-white cursor-pointer hover:bg-[#0A542B] transition select-none sticky left-0 z-30 shadow-[1px_0_0_0_#0D6535]"
                title={selectedRowIds.size > 0 ? 'Click to deselect all rows' : 'Click to select all rows'}
              >
                <span>#</span>
                {renderResizeHandle('index', 'Row Number')}
              </th>

              {/* Engine Column with Quick Status Dropdown */}
              <th
                style={{
                  width: `${columnWidths.engine}px`,
                  minWidth: `${columnWidths.engine}px`,
                  maxWidth: `${columnWidths.engine}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap bg-[#107C41] text-white"
              >
                <span className="truncate block" title="Engine">Engine</span>
                {renderResizeHandle('engine', 'Engine')}
              </th>

              <th
                style={{
                  width: `${columnWidths.event}px`,
                  minWidth: `${columnWidths.event}px`,
                  maxWidth: `${columnWidths.event}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title={eventColumnHeader}>{eventColumnHeader}</span>
                {renderResizeHandle('event', eventColumnHeader)}
              </th>

              <th
                style={{
                  width: `${columnWidths.trigger}px`,
                  minWidth: `${columnWidths.trigger}px`,
                  maxWidth: `${columnWidths.trigger}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Trigger">Trigger</span>
                {renderResizeHandle('trigger', 'Trigger')}
              </th>

              <th
                style={{
                  width: `${columnWidths.audience}px`,
                  minWidth: `${columnWidths.audience}px`,
                  maxWidth: `${columnWidths.audience}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Audience">Audience</span>
                {renderResizeHandle('audience', 'Audience')}
              </th>

              <th
                style={{
                  width: `${columnWidths.communicationObjective}px`,
                  minWidth: `${columnWidths.communicationObjective}px`,
                  maxWidth: `${columnWidths.communicationObjective}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Communication Objective">Communication Objective</span>
                {renderResizeHandle('communicationObjective', 'Communication Objective')}
              </th>

              <th
                style={{
                  width: `${columnWidths.desiredOutcome}px`,
                  minWidth: `${columnWidths.desiredOutcome}px`,
                  maxWidth: `${columnWidths.desiredOutcome}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Desired Outcome">Desired Outcome</span>
                {renderResizeHandle('desiredOutcome', 'Desired Outcome')}
              </th>

              <th
                style={{
                  width: `${columnWidths.pushSubject}px`,
                  minWidth: `${columnWidths.pushSubject}px`,
                  maxWidth: `${columnWidths.pushSubject}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Push Notification Subject Line">Push Notification Subject Line</span>
                {renderResizeHandle('pushSubject', 'Push Notification Subject Line')}
              </th>

              <th
                style={{
                  width: `${columnWidths.pushBody}px`,
                  minWidth: `${columnWidths.pushBody}px`,
                  maxWidth: `${columnWidths.pushBody}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Push Notification">Push Notification</span>
                {renderResizeHandle('pushBody', 'Push Notification')}
              </th>

              <th
                style={{
                  width: `${columnWidths.emailSubject}px`,
                  minWidth: `${columnWidths.emailSubject}px`,
                  maxWidth: `${columnWidths.emailSubject}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Email Subject Line">Email Subject Line</span>
                {renderResizeHandle('emailSubject', 'Email Subject Line')}
              </th>

              <th
                style={{
                  width: `${columnWidths.emailBody}px`,
                  minWidth: `${columnWidths.emailBody}px`,
                  maxWidth: `${columnWidths.emailBody}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Email Message">Email Message</span>
                {renderResizeHandle('emailBody', 'Email Message')}
              </th>

              <th
                style={{
                  width: `${columnWidths.inAppExperience}px`,
                  minWidth: `${columnWidths.inAppExperience}px`,
                  maxWidth: `${columnWidths.inAppExperience}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="In-App Experience">In-App Experience</span>
                {renderResizeHandle('inAppExperience', 'In-App Experience')}
              </th>

              <th
                style={{
                  width: `${columnWidths.cta}px`,
                  minWidth: `${columnWidths.cta}px`,
                  maxWidth: `${columnWidths.cta}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Call to Action">Call to Action</span>
                {renderResizeHandle('cta', 'Call to Action')}
              </th>

              <th
                style={{
                  width: `${columnWidths.comments}px`,
                  minWidth: `${columnWidths.comments}px`,
                  maxWidth: `${columnWidths.comments}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap"
              >
                <span className="truncate block" title="Comments">Comments</span>
                {renderResizeHandle('comments', 'Comments')}
              </th>

              <th
                style={{
                  width: `${columnWidths.status}px`,
                  minWidth: `${columnWidths.status}px`,
                  maxWidth: `${columnWidths.status}px`,
                }}
                className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#0D6535] whitespace-nowrap bg-[#107C41] text-white"
              >
                <span className="truncate block" title="Status">Status</span>
                {renderResizeHandle('status', 'Status')}
              </th>

              <th
                style={{
                  width: `${columnWidths.action}px`,
                  minWidth: `${columnWidths.action}px`,
                  maxWidth: `${columnWidths.action}px`,
                }}
                className="relative px-2 py-2.5 font-semibold text-xs tracking-normal text-center whitespace-nowrap bg-[#107C41] text-white"
              >
                <span className="block" title="Action">Action</span>
                {renderResizeHandle('action', 'Action')}
              </th>
            </tr>
          </thead>

          {/* Table Body: Excel Sheet Row Cells */}
          <tbody className="divide-y divide-[#E1E4E8] bg-white">
            {filteredScenarios.length === 0 ? (
              <tr>
                <td colSpan={16} className="py-12 text-center text-[#6B778C]">
                  <p className="font-semibold text-sm">No matching notification rows</p>
                  <p className="text-xs text-slate-400 mt-1">
                    {isSearchActive
                      ? `No scenarios found globally matching "${searchQuery}".`
                      : 'Adjust engine category or status filter to view scenarios'}
                  </p>
                  {isSearchActive && (
                    <button
                      type="button"
                      onClick={onClearSearch}
                      className="mt-3 px-3 py-1.5 bg-[#DEEBFF] hover:bg-[#B3D4FF] text-[#0052CC] font-semibold text-xs rounded transition cursor-pointer"
                    >
                      Clear search
                    </button>
                  )}
                </td>
              </tr>
            ) : (
              filteredScenarios.map((row, index) => {
                // Show original spreadsheet row number within its engine (Excel-style)
                const engineList = scenarios.filter(
                  (s) => (s.engineCategory || 'Governance') === (row.engineCategory || 'Governance')
                )
                const originalIndex = engineList.findIndex((s) => s.id === row.id)
                const rowNumber = originalIndex >= 0 ? originalIndex + 1 : index + 1

                const isSelected = selectedRowIds.has(row.id)
                const isTested = row.status === 'TESTED'
                const isNotWorking = Boolean(row.status && row.status.includes('NOT WORKING'))
                const isCurrentMatch =
                  Boolean(searchQuery.trim()) &&
                  matchingScenarios[currentMatchIndex]?.id === row.id
                const hasSearchMatch =
                  Boolean(searchQuery.trim()) && matchingRowIds.has(row.id)

                const renderCell = (field: EditableField, value: string) => {
                  const scenarioMismatches = verificationSummary?.mismatchesByScenarioId?.[row.id]
                  const mismatch = scenarioMismatches?.[field]

                  if (mismatch) {
                    return (
                      <div
                        onClick={(e) => {
                          e.stopPropagation()
                          const rect = e.currentTarget.getBoundingClientRect()
                          setActiveMismatchTooltip({
                            scenario: row,
                            mismatch,
                            anchorRect: rect,
                          })
                        }}
                        onMouseEnter={(e) => {
                          const rect = e.currentTarget.getBoundingClientRect()
                          setActiveMismatchTooltip({
                            scenario: row,
                            mismatch,
                            anchorRect: rect,
                          })
                        }}
                        className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md bg-[#FFF0ED] text-[#D70015] border border-[#FF3B30]/40 font-medium min-h-[20px] max-w-full select-text cursor-pointer hover:bg-[#FFE5E0] transition-all shadow-2xs group/mismatch"
                        title="Sheet Data Mismatch • Click or hover to view expected value"
                      >
                        <span className="w-3.5 h-3.5 rounded-full bg-[#FF3B30] text-white flex items-center justify-center text-[9px] font-black shrink-0 shadow-xs">
                          !
                        </span>
                        <span className="truncate underline decoration-[#FF3B30]/70 decoration-wavy underline-offset-2">
                          {highlightMatches(value, searchQuery, matchedTerms, hasSearchMatch)}
                        </span>
                      </div>
                    )
                  }

                  return (
                    <div
                      className={`px-1 py-0.5 rounded min-h-[20px] truncate select-text cursor-default transition-all ${
                        isSelected
                          ? "text-[#0747A6] font-semibold"
                          : isTested
                          ? "text-[#00552B] font-medium"
                          : isNotWorking
                          ? "text-[#A82200] font-medium"
                          : "text-[#172B4D]"
                      }`}
                      title={value || ''}
                    >
                      {highlightMatches(value, searchQuery, matchedTerms, hasSearchMatch)}
                    </div>
                  )
                }

                return (
                  <tr
                    key={row.id}
                    id={`row-${row.id}`}
                    onContextMenu={(e) => handleContextMenu(e, row)}
                    className={`transition group ${
                      isSelected
                        ? 'bg-[#CCE4FF] hover:bg-[#BBDCFE] text-[#0747A6] shadow-2xs ring-1 ring-inset ring-[#0052CC]/40'
                        : isCurrentMatch
                        ? 'bg-[#FFF9E6] hover:bg-[#FFF3CD] ring-2 ring-inset ring-[#FFAB00] shadow-2xs'
                        : hasSearchMatch
                        ? 'bg-[#FFFCF2] hover:bg-[#FFF8E6]'
                        : isTested
                        ? 'bg-[#F3FAF5] hover:bg-[#E7F7EC]'
                        : isNotWorking
                        ? 'bg-[#FFF5F3] hover:bg-[#FFEBE7]'
                        : index % 2 === 1
                        ? 'bg-[#FAFBFC] hover:bg-[#F4F5F7]'
                        : 'bg-white hover:bg-[#F4F5F7]'
                    }`}
                  >
                    {/* Excel Row Number with Visual Indicator & DBeaver Click Selection */}
                    <td
                      onClick={(e) => handleRowNumberClick(e, row.id)}
                      title={`Row #${rowNumber} • Click to ${isSelected ? 'unselect row' : 'highlight full row'} • Click eye to view all details`}
                      style={{
                        width: `${columnWidths.index}px`,
                        minWidth: `${columnWidths.index}px`,
                        maxWidth: `${columnWidths.index}px`,
                      }}
                      className={`px-1 py-2 font-mono text-[11px] text-center font-bold border-r border-[#E1E4E8] select-none transition-colors cursor-pointer sticky left-0 z-10 shadow-[1px_0_0_0_#E1E4E8] group/numcell ${
                        isSelected
                          ? 'border-l-[4px] border-l-[#0052CC] bg-[#0052CC] text-white shadow-xs'
                          : isCurrentMatch
                          ? 'border-l-[4px] border-l-[#FFAB00] bg-[#FFF0B3] text-[#172B4D] font-extrabold'
                          : hasSearchMatch
                          ? 'border-l-[4px] border-l-[#FFC400] bg-[#FFF8DB] text-[#7A5B00]'
                          : isTested
                          ? 'border-l-[4px] border-l-[#00875A] bg-[#E3FCEF] text-[#006644] hover:bg-[#D3F9E5]'
                          : isNotWorking
                          ? 'border-l-[4px] border-l-[#DE350B] bg-[#FFEBE6] text-[#BF2600] hover:bg-[#FED7D0]'
                          : 'border-l-[4px] border-l-transparent bg-[#F4F5F7] text-[#6B778C] hover:bg-[#EBECF0] hover:text-[#172B4D]'
                      }`}
                    >
                      <div className="flex items-center justify-center gap-1">
                        <span>{rowNumber}</span>
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation()
                            setDetailScenario({ scenario: row, rowNumber })
                          }}
                          className="opacity-0 group-hover/numcell:opacity-100 p-0.5 rounded text-slate-400 hover:text-[#0052CC] hover:bg-white/80 transition cursor-pointer"
                          title={`View full details for row #${rowNumber}`}
                          aria-label="View row details"
                        >
                          <Eye className="w-3 h-3 stroke-[2]" />
                        </button>
                      </div>
                    </td>

                    {/* Engine Column with Quick Status Dropdown */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] whitespace-nowrap overflow-hidden">
                      <EngineBadge
                        category={row.engineCategory || 'Governance'}
                        currentStatus={row.status}
                        onUpdateStatus={(st) => onUpdateStatus(row.id, st)}
                        onCreateDefect={() => setDefectScenario(row)}
                        onOpenLog={() => setHistoryScenario(row)}
                      />
                    </td>

                    {/* Event Name with iOS View Details Button and (i) Info Brief Button */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] font-medium group/event overflow-hidden">
                      <div className="flex items-center justify-between gap-1.5">
                        <div className="flex-1 min-w-0 overflow-hidden">
                          {renderCell('governanceEvent', row.governanceEvent)}
                        </div>
                        <div className="flex items-center gap-1 shrink-0">
                          {/* iOS-like View Details Button */}
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation()
                              setDetailScenario({ scenario: row, rowNumber })
                            }}
                            className="w-5 h-5 rounded-full flex items-center justify-center text-slate-400 hover:text-[#0052CC] hover:bg-blue-50 opacity-70 hover:opacity-100 group-hover/event:opacity-100 transition cursor-pointer shrink-0 active:scale-90"
                            title={`View all column details for #${rowNumber} (${row.key})`}
                            aria-label="View row details"
                          >
                            <Eye className="w-3.5 h-3.5 stroke-[1.8]" />
                          </button>
                          {/* Info Brief Button */}
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation()
                              setHoveredInfo(null)
                              const rect = e.currentTarget.getBoundingClientRect()
                              setSelectedEventBrief({ scenario: row, rect })
                            }}
                            onMouseEnter={(e) => {
                              if (selectedEventBrief || !row.notes?.trim()) return
                              const rect = e.currentTarget.getBoundingClientRect()
                              setHoveredInfo({ scenario: row, rect })
                            }}
                            onMouseLeave={() => setHoveredInfo(null)}
                            className={`w-5 h-5 rounded-full flex items-center justify-center transition cursor-pointer shrink-0 ${
                              row.notes?.trim()
                                ? 'text-[#0052CC] bg-blue-50/90 hover:bg-blue-100 ring-1 ring-blue-200/60 opacity-100'
                                : 'text-slate-400 hover:text-[#0052CC] hover:bg-blue-50 opacity-70 hover:opacity-100 group-hover/event:opacity-100'
                            }`}
                            aria-label="Event info"
                          >
                            <Info className="w-3.5 h-3.5" />
                          </button>
                        </div>
                      </div>
                    </td>

                    {/* Trigger */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('trigger', row.trigger)}
                    </td>

                    {/* Audience */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('audience', row.audience)}
                    </td>

                    {/* Communication Objective */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('communicationObjective', row.communicationObjective)}
                    </td>

                    {/* Desired Outcome */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('desiredOutcome', row.desiredOutcome)}
                    </td>

                    {/* Push Notification Subject Line */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('pushSubject', row.pushSubject)}
                    </td>

                    {/* Push Notification */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('pushBody', row.pushBody)}
                    </td>

                    {/* Email Subject Line */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('emailSubject', row.emailSubject)}
                    </td>

                    {/* Email Message */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('emailBody', row.emailBody)}
                    </td>

                    {/* In-App Experience */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('inAppExperience', row.inAppExperience)}
                    </td>

                    {/* Call to Action */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] overflow-hidden">
                      {renderCell('cta', row.cta)}
                    </td>

                    {/* Manual Comments */}
                    <td
                      className="px-2 py-1.5 border-r border-[#E1E4E8] overflow-hidden relative"
                      onMouseEnter={(e) => {
                        if (editingCommentId !== row.id && row.comments && row.comments.trim().length > 0) {
                          const rect = e.currentTarget.getBoundingClientRect()
                          setHoveredComment({
                            scenario: row,
                            rowNumber,
                            rect,
                          })
                        }
                      }}
                      onMouseLeave={() => setHoveredComment(null)}
                    >
                      {editingCommentId === row.id ? (
                        <div
                          className="flex items-center gap-1 w-full"
                          onClick={(e) => e.stopPropagation()}
                        >
                          <div className="relative flex-1 flex items-center min-w-0">
                            <input
                              type="text"
                              autoFocus
                              value={commentDraft}
                              onChange={(e) => setCommentDraft(e.target.value)}
                              onKeyDown={(e) => {
                                if (e.key === 'Enter') {
                                  e.preventDefault()
                                  saveComment(row)
                                } else if (e.key === 'Escape') {
                                  e.preventDefault()
                                  cancelEditingComment()
                                }
                              }}
                              onBlur={() => {
                                if (!isPolishingComment) {
                                  saveComment(row)
                                }
                              }}
                              placeholder="Add comment & press Enter..."
                              className={`w-full text-xs pl-2 ${
                                commentDraft.trim().length > 0 ? 'pr-7' : 'pr-2'
                              } py-1 rounded bg-white text-[#172B4D] border ${
                                aiPolishedSuccess
                                    ? 'border-emerald-500 ring-2 ring-emerald-200'
                                  : 'border-[#0052CC] ring-2 ring-blue-100'
                              } outline-none shadow-xs font-medium placeholder:text-slate-400 transition-all`}
                            />

                            {/* Gemini AI Auto-Frame & Spelling Correction Logo Button */}
                            {commentDraft.trim().length > 0 && (
                              <button
                                type="button"
                                disabled={isPolishingComment}
                                onMouseDown={(e) => {
                                  e.preventDefault()
                                  handlePolishComment()
                                }}
                                className="absolute right-1 p-1 rounded-full hover:bg-purple-100 text-purple-600 transition cursor-pointer flex items-center justify-center shrink-0 disabled:opacity-60"
                                title="Gemini AI: Click to auto-correct spelling & frame into proper English"
                              >
                                {isPolishingComment ? (
                                  <Loader2 className="w-3.5 h-3.5 animate-spin text-purple-600" />
                                ) : (
                                  <GeminiSparkleIcon className="w-3.5 h-3.5 hover:scale-125 transition-transform" />
                                )}
                              </button>
                            )}
                          </div>

                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation()
                              saveComment(row)
                            }}
                            onMouseDown={(e) => {
                              e.preventDefault()
                            }}
                            className="p-1 text-emerald-600 hover:bg-emerald-50 rounded transition cursor-pointer shrink-0"
                            title="Save comment (Enter)"
                          >
                            <Check className="w-3.5 h-3.5" />
                          </button>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation()
                              cancelEditingComment()
                            }}
                            onMouseDown={(e) => {
                              e.preventDefault()
                            }}
                            className="p-1 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded transition cursor-pointer shrink-0"
                            title="Cancel (Esc)"
                          >
                            <X className="w-3.5 h-3.5" />
                          </button>
                        </div>
                      ) : (
                        <div
                          onClick={() => {
                            setHoveredComment(null)
                            startEditingComment(row)
                          }}
                          className="flex items-center justify-between gap-1 group-hover/comment:bg-blue-50/60 px-1 py-0.5 rounded transition cursor-pointer group/comment"
                        >
                          <div
                            className={`truncate text-xs ${
                              row.comments
                                ? 'text-[#172B4D] font-medium'
                                : 'text-slate-400 italic group-hover/comment:text-[#0052CC]'
                            }`}
                            title={row.comments ? undefined : 'Click to add comment'}
                          >
                            {row.comments ? (
                              highlightMatches(row.comments, searchQuery, matchedTerms, hasSearchMatch)
                            ) : (
                              <span className="flex items-center gap-1 text-[11px] font-normal text-slate-400 group-hover/comment:text-[#0052CC]">
                                <Pencil className="w-3 h-3 opacity-60 group-hover/comment:opacity-100" />
                                <span>Add comment...</span>
                              </span>
                            )}
                          </div>
                          <Pencil className="w-3 h-3 text-[#0052CC] opacity-0 group-hover/comment:opacity-100 shrink-0 transition" />
                        </div>
                      )}
                    </td>

                    {/* Status (Jira dropdown with down arrow) */}
                    <td className="px-2.5 py-2 border-r border-[#E1E4E8] whitespace-nowrap overflow-hidden max-w-full">
                      <div className="w-full max-w-full overflow-hidden flex items-center">
                        <JiraStatusBadge
                          status={row.status}
                          onChange={(st) => onUpdateStatus(row.id, st)}
                          onCreateDefect={() => setDefectScenario(row)}
                          onOpenLog={() => setHistoryScenario(row)}
                          availableStatuses={allStatuses}
                          size="sm"
                        />
                      </div>
                    </td>

                    {/* Actions: View Details, History, Copy & Delete */}
                    <td className="px-2 py-2 text-center whitespace-nowrap overflow-hidden">
                      <div className="flex items-center justify-center gap-1">
                        <button
                          type="button"
                          onClick={() => setDetailScenario({ scenario: row, rowNumber })}
                          className="p-1 text-slate-400 hover:text-[#0052CC] hover:bg-blue-50 rounded transition cursor-pointer"
                          title={`View all column details #${rowNumber} (${row.key})`}
                          aria-label="View details"
                        >
                          <Eye className="w-3.5 h-3.5 stroke-[1.8]" />
                        </button>
                        <button
                          type="button"
                          onClick={() => setHistoryScenario(row)}
                          className="p-1 text-slate-400 hover:text-[#0052CC] hover:bg-blue-50 rounded transition cursor-pointer relative"
                          title={`Version history & rollback (${row.versionHistory?.length || 0} updates stored)`}
                        >
                          <History className="w-3.5 h-3.5" />
                          {row.versionHistory && row.versionHistory.length > 0 && (
                            <span className="absolute -top-0.5 -right-0.5 w-1.5 h-1.5 rounded-full bg-[#0052CC]" />
                          )}
                        </button>
                        <button
                          type="button"
                          onClick={() => handleCopyRow(row)}
                          className="p-1 text-slate-400 hover:text-[#0052CC] rounded transition cursor-pointer"
                          title={`Copy entire row #${rowNumber} (${row.key})`}
                        >
                          <Copy className="w-3.5 h-3.5" />
                        </button>
                        <button
                          type="button"
                          onClick={() => handleDeleteRow(row)}
                          className="p-1 text-slate-400 hover:text-rose-600 hover:bg-rose-50 rounded transition cursor-pointer"
                          title={`Delete row #${rowNumber} (${row.key})`}
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    </td>
                  </tr>
                )
              })
            )}
          </tbody>
        </table>
      </div>

      {/* Right-Click Context Menu */}
      {contextMenu && createPortal(
        <>
          {/* Full-screen backdrop to dismiss context menu on any click or tap */}
          <div
            className="fixed inset-0 z-40 bg-black/10 transition-opacity"
            onClick={() => setContextMenu(null)}
            onContextMenu={(e) => {
              e.preventDefault()
              setContextMenu(null)
            }}
          />
          <div
            ref={contextMenuRef}
            style={{
              top: `${contextMenu.y}px`,
              left: `${contextMenu.x}px`,
              maxHeight: 'calc(100vh - 32px)',
            }}
            className="fixed z-50 w-60 bg-white rounded-xl shadow-2xl border border-[#DFE1E6] text-xs text-[#172B4D] animate-in fade-in zoom-in-95 duration-100 flex flex-col overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Header with (i) Info Log button, View Details button and Close X button */}
            <div className="shrink-0 px-3 py-2 bg-[#FAFBFC] text-xs font-semibold text-[#6B778C] flex items-center justify-between border-b border-slate-100 rounded-t-xl select-none">
              <span className="font-semibold text-slate-800 truncate pr-1">
                {contextMenu.scenario.key} &bull; Quick Actions
              </span>
              <div className="flex items-center gap-1.5 shrink-0">
                <button
                  type="button"
                  onClick={() => {
                    const foundRowIdx = filteredScenarios.findIndex((s) => s.id === contextMenu.scenario.id)
                    const engineList =
                      selectedEngine === 'ALL'
                        ? scenarios
                        : scenarios.filter((s) => s.engineCategory === contextMenu.scenario.engineCategory)
                    const rowNum = engineList.findIndex((s) => s.id === contextMenu.scenario.id) + 1
                    setDetailScenario({
                      scenario: contextMenu.scenario,
                      rowNumber: rowNum > 0 ? rowNum : foundRowIdx + 1,
                    })
                    setContextMenu(null)
                  }}
                  className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded bg-blue-50 text-[#0052CC] hover:bg-blue-100 border border-blue-200 text-[10px] font-bold transition cursor-pointer shadow-2xs"
                  title="View Jira Details"
                >
                  <Eye className="w-3 h-3" />
                  <span>View</span>
                </button>
                <button
                  type="button"
                  onClick={() => {
                    setHistoryScenario(contextMenu.scenario)
                    setContextMenu(null)
                  }}
                  className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded bg-slate-100 text-slate-700 hover:bg-slate-200 text-[10px] font-bold transition cursor-pointer"
                  title="View Change History"
                >
                  <Info className="w-3 h-3" />
                  <span>Log</span>
                </button>
                <button
                  type="button"
                  onClick={() => setContextMenu(null)}
                  className="p-1 rounded text-slate-400 hover:text-slate-700 hover:bg-slate-200/70 transition cursor-pointer"
                  title="Close Menu (Esc)"
                  aria-label="Close"
                >
                  <X className="w-3.5 h-3.5" />
                </button>
              </div>
            </div>

            {/* Scrollable Actions Container */}
            <div className="flex-1 overflow-y-auto divide-y divide-slate-100 overscroll-contain">
              {/* Transition Status Options */}
              <div className="py-1">
                <div className="px-3 py-1 text-[10px] font-bold text-[#6B778C] uppercase flex items-center justify-between">
                  <span>Transition Status</span>
                  <ChevronRight className="w-3 h-3 text-slate-400" />
                </div>
                {allStatuses.map((st) => {
                  const isSelected = contextMenu.scenario.status === st
                  return (
                    <button
                      key={st}
                      type="button"
                      onClick={() => {
                        onUpdateStatus(contextMenu.scenario.id, st)
                        setContextMenu(null)
                      }}
                      className={`w-full flex items-center justify-between px-3 py-1.5 hover:bg-slate-50 cursor-pointer transition text-left text-xs ${
                        isSelected ? 'font-bold bg-slate-50 text-[#0052CC]' : 'text-[#42526E]'
                      }`}
                    >
                      <span>{st}</span>
                      {isSelected && <Check className="w-3.5 h-3.5 text-[#0052CC]" />}
                    </button>
                  )
                })}
              </div>

              {/* Change Engine Category */}
              <div className="py-1">
                <div className="px-3 py-1 text-[10px] font-bold text-[#6B778C] uppercase">
                  Switch Engine
                </div>
                {availableEngines.map((cat) => {
                  const isSelected = contextMenu.scenario.engineCategory === cat
                  return (
                    <button
                      key={cat}
                      type="button"
                      onClick={() => {
                        onUpdateScenario({
                          ...contextMenu.scenario,
                          engineCategory: cat,
                          updatedAt: new Date().toISOString(),
                        })
                        setContextMenu(null)
                      }}
                      className={`w-full flex items-center justify-between px-3 py-1.5 hover:bg-slate-50 cursor-pointer transition text-left text-xs ${
                        isSelected ? 'font-bold bg-slate-50 text-emerald-700' : 'text-[#42526E]'
                      }`}
                    >
                      <span>{cat} Engine</span>
                      {isSelected && <Check className="w-3.5 h-3.5 text-emerald-600" />}
                    </button>
                  )
                })}
              </div>

              {/* Edit Comments */}
              <div className="py-1">
                <button
                  type="button"
                  onClick={() => {
                    const target = contextMenu.scenario
                    setContextMenu(null)
                    startEditingComment(target)
                  }}
                  className="w-full flex items-center gap-2 px-3 py-1.5 hover:bg-blue-50 text-[#0052CC] cursor-pointer transition text-left text-xs font-semibold"
                >
                  <MessageSquare className="w-3.5 h-3.5 text-[#0052CC]" />
                  <span>Edit Comments</span>
                </button>
              </div>

              {/* Copy Entire Row */}
              <div className="py-1">
                <button
                  type="button"
                  onClick={() => handleCopyRow(contextMenu.scenario)}
                  className="w-full flex items-center gap-2 px-3 py-1.5 hover:bg-slate-50 text-[#172B4D] cursor-pointer transition text-left text-xs font-semibold"
                >
                  <Copy className="w-3.5 h-3.5 text-slate-500" />
                  <span>Copy Entire Row</span>
                </button>
              </div>

              {/* Version History & Rollback */}
              <div className="py-1">
                <button
                  type="button"
                  onClick={() => {
                    setHistoryScenario(contextMenu.scenario)
                    setContextMenu(null)
                  }}
                  className="w-full flex items-center gap-2 px-3 py-1.5 hover:bg-blue-50 text-[#0052CC] cursor-pointer transition text-left text-xs font-semibold"
                >
                  <History className="w-3.5 h-3.5 text-[#0052CC]" />
                  <span>Change History & Log ({contextMenu.scenario.versionHistory?.length || 0}/10)</span>
                </button>
              </div>

              {/* Create Defect Ticket */}
              <div className="py-1">
                <button
                  type="button"
                  onClick={() => {
                    setDefectScenario(contextMenu.scenario)
                    setContextMenu(null)
                  }}
                  className="w-full flex items-center gap-2 px-3 py-1.5 hover:bg-rose-50 text-[#BF2600] cursor-pointer transition text-left text-xs font-bold"
                >
                  <Bug className="w-3.5 h-3.5 text-[#BF2600]" />
                  <span>Create Defect Ticket</span>
                </button>
              </div>

              {/* Delete Row */}
              <div className="py-1">
                <button
                  type="button"
                  onClick={() => {
                    setContextMenu(null)
                    handleDeleteRow(contextMenu.scenario)
                  }}
                  className="w-full flex items-center gap-2 px-3 py-1.5 hover:bg-rose-50 text-[#BF2600] cursor-pointer transition text-left text-xs font-semibold"
                >
                  <Trash2 className="w-3.5 h-3.5 text-[#BF2600]" />
                  <span>Delete Row</span>
                </button>
              </div>
            </div>

            {/* Sticky Close Button Footer */}
            <div className="shrink-0 py-1.5 px-2 bg-slate-50 border-t border-slate-100 rounded-b-xl">
              <button
                type="button"
                onClick={() => setContextMenu(null)}
                className="w-full flex items-center justify-center gap-1.5 py-1 hover:bg-slate-200/70 text-slate-600 hover:text-slate-900 rounded cursor-pointer transition text-xs font-semibold"
              >
                <X className="w-3.5 h-3.5 text-slate-400" />
                <span>Close Menu</span>
              </button>
            </div>
          </div>
        </>,
        document.body
      )}

      {/* Jira Defect Generator Modal */}
      <JiraDefectModal
        scenario={defectScenario}
        isOpen={Boolean(defectScenario)}
        onClose={() => setDefectScenario(null)}
        onMarkNotWorking={(id) => {
          onUpdateStatus(id, 'NOT WORKING')
          if (defectScenario && defectScenario.id === id) {
            setDefectScenario({ ...defectScenario, status: 'NOT WORKING' })
          }
        }}
      />

      {/* Version History & Rollback Modal */}
      {historyScenario && (
        <VersionHistoryModal
          scenario={scenarios.find((s) => s.id === historyScenario.id) || historyScenario}
          onClose={() => setHistoryScenario(null)}
          onRollbackRow={(ver) => {
            const current =
              scenarios.find((s) => s.id === historyScenario.id) || historyScenario
            const rolledBack = rollbackToVersion(current, ver)
            if (onRollbackScenario) {
              onRollbackScenario(rolledBack)
            } else {
              onUpdateScenario(rolledBack)
            }
            setHistoryScenario(rolledBack)
            setCopiedToast(
              `Rolled back ${current.key} to version from ${new Date(ver.timestamp).toLocaleTimeString()}`
            )
            setTimeout(() => setCopiedToast(null), 3000)
          }}
          onRollbackField={(fieldKey, targetValue, timestamp) => {
            const current =
              scenarios.find((s) => s.id === historyScenario.id) || historyScenario
            const rolledBack = rollbackFieldToVersion(current, fieldKey, targetValue, timestamp)
            if (onRollbackScenario) {
              onRollbackScenario(rolledBack)
            } else {
              onUpdateScenario(rolledBack)
            }
            setHistoryScenario(rolledBack)
            setCopiedToast(
              `Restored ${fieldKey} to previous value from ${new Date(timestamp).toLocaleTimeString()}`
            )
            setTimeout(() => setCopiedToast(null), 3000)
          }}
        />
      )}

      {/* Floating Info Tooltip on Hover (only if data exists) */}
      {hoveredInfo && hoveredInfo.scenario.notes?.trim() && (() => {
        const isNearTop = hoveredInfo.rect.top < 140
        const tooltipWidth = 280
        const left = Math.max(
          16,
          Math.min(
            window.innerWidth - tooltipWidth - 16,
            hoveredInfo.rect.left + hoveredInfo.rect.width / 2 - tooltipWidth / 2
          )
        )
        const arrowOffset = Math.max(
          16,
          Math.min(
            tooltipWidth - 24,
            hoveredInfo.rect.left + hoveredInfo.rect.width / 2 - left - 5
          )
        )

        return (
          <div
            className="fixed z-50 pointer-events-none transition-all duration-150 animate-in fade-in zoom-in-95"
            style={{
              top: isNearTop ? `${hoveredInfo.rect.bottom + 8}px` : undefined,
              bottom: !isNearTop ? `${window.innerHeight - hoveredInfo.rect.top + 8}px` : undefined,
              left: `${left}px`,
              width: `${tooltipWidth}px`,
            }}
          >
            {isNearTop && (
              <div
                className="w-2.5 h-2.5 bg-white rotate-45 border-l border-t border-slate-200 -mb-1.5 z-10 shrink-0"
                style={{ marginLeft: `${arrowOffset}px` }}
              />
            )}
            <div className="bg-white text-slate-800 text-xs rounded-xl p-3 shadow-xl border border-slate-200 space-y-1.5">
              <div className="flex items-center justify-between gap-1 text-[11px] font-semibold text-slate-800 border-b border-slate-100 pb-1.5">
                <span className="truncate">{hoveredInfo.scenario.governanceEvent}</span>
                <span className="text-[10px] text-[#007AFF] font-medium shrink-0">Click to view/edit</span>
              </div>
              <div className="text-xs text-slate-600 leading-relaxed break-words whitespace-pre-wrap max-h-48 overflow-y-auto">
                {hoveredInfo.scenario.notes?.trim() ? (
                  hoveredInfo.scenario.notes.trim()
                ) : (
                  <span className="text-slate-400 italic">No extra info added yet. Click to add.</span>
                )}
              </div>
            </div>
            {!isNearTop && (
              <div
                className="w-2.5 h-2.5 bg-white rotate-45 border-r border-b border-slate-200 -mt-1.5 z-10 shrink-0"
                style={{ marginLeft: `${arrowOffset}px` }}
              />
            )}
          </div>
        )
      })()}

      {/* Floating Comment Tooltip on Hover */}
      {hoveredComment && hoveredComment.scenario.comments?.trim() && createPortal(
        (() => {
          const commentText = hoveredComment.scenario.comments.trim()
          const isNearBottom = hoveredComment.rect.bottom + 120 > window.innerHeight
          const isNearTop = hoveredComment.rect.top < 80
          const placeAbove = isNearBottom && !isNearTop

          const tooltipWidth = Math.min(
            380,
            Math.max(180, commentText.length > 80 ? 320 : 220)
          )

          const left = Math.max(
            12,
            Math.min(
              window.innerWidth - tooltipWidth - 12,
              hoveredComment.rect.left + hoveredComment.rect.width / 2 - tooltipWidth / 2
            )
          )

          const arrowOffset = Math.max(
            12,
            Math.min(
              tooltipWidth - 20,
              hoveredComment.rect.left + hoveredComment.rect.width / 2 - left - 4
            )
          )

          return (
            <div
              className="fixed z-[99999] pointer-events-none transition-all duration-100 animate-in fade-in zoom-in-95 ease-out select-none flex flex-col items-start"
              style={{
                top: !placeAbove ? `${hoveredComment.rect.bottom + 6}px` : undefined,
                bottom: placeAbove ? `${window.innerHeight - hoveredComment.rect.top + 6}px` : undefined,
                left: `${left}px`,
                width: `${tooltipWidth}px`,
              }}
            >
              {/* Arrow if placed below */}
              {!placeAbove && (
                <div
                  className="w-2 h-2 bg-[#172B4D] rotate-45 -mb-1 z-10 shrink-0"
                  style={{ marginLeft: `${arrowOffset}px` }}
                />
              )}

              {/* Simple Clean Tooltip - Text Only */}
              <div className="bg-[#172B4D] text-white text-xs leading-relaxed rounded-md shadow-lg px-2.5 py-1.5 pointer-events-none select-none break-words whitespace-pre-wrap w-full font-normal">
                {highlightMatches(commentText, searchQuery, matchedTerms, Boolean(searchQuery && searchQuery.trim()))}
              </div>

              {/* Arrow if placed above */}
              {placeAbove && (
                <div
                  className="w-2 h-2 bg-[#172B4D] rotate-45 -mt-1 z-10 shrink-0"
                  style={{ marginLeft: `${arrowOffset}px` }}
                />
              )}
            </div>
          )
        })(),
        document.body
      )}

      {/* Event Brief & Details Popover anchored to Info button */}
      {selectedEventBrief && (
        <EventBriefModal
          scenario={
            scenarios.find((s) => s.id === selectedEventBrief.scenario.id) ||
            selectedEventBrief.scenario
          }
          anchorRect={selectedEventBrief.rect}
          onClose={() => setSelectedEventBrief(null)}
          onUpdateScenario={(updated) => {
            onUpdateScenario(updated)
            setSelectedEventBrief((prev) =>
              prev ? { ...prev, scenario: updated } : null
            )
          }}
        />
      )}

      {/* Jira Issue Detail View Modal */}
      {detailScenario && (
        <JiraDetailModal
          scenario={
            scenarios.find((s) => s.id === detailScenario.scenario.id) ||
            detailScenario.scenario
          }
          rowNumber={detailScenario.rowNumber}
          allStatuses={allStatuses}
          isOpen={!!detailScenario}
          onClose={() => setDetailScenario(null)}
          onUpdateStatus={(st: ScenarioStatus) => {
            onUpdateStatus(detailScenario.scenario.id, st)
            setDetailScenario((prev) =>
              prev
                ? {
                    ...prev,
                    scenario: { ...prev.scenario, status: st },
                  }
                : null
            )
          }}
          onNavigatePrev={() => {
            const currentIndex = filteredScenarios.findIndex(
              (s) => s.id === detailScenario.scenario.id
            )
            if (currentIndex > 0) {
              const prev = filteredScenarios[currentIndex - 1]
              const engineList =
                selectedEngine === 'ALL'
                  ? scenarios
                  : scenarios.filter((s) => s.engineCategory === prev.engineCategory)
              const prevRowNumber = engineList.findIndex((s) => s.id === prev.id) + 1
              setDetailScenario({
                scenario: prev,
                rowNumber: prevRowNumber > 0 ? prevRowNumber : currentIndex,
              })
            }
          }}
          onNavigateNext={() => {
            const currentIndex = filteredScenarios.findIndex(
              (s) => s.id === detailScenario.scenario.id
            )
            if (currentIndex >= 0 && currentIndex < filteredScenarios.length - 1) {
              const next = filteredScenarios[currentIndex + 1]
              const engineList =
                selectedEngine === 'ALL'
                  ? scenarios
                  : scenarios.filter((s) => s.engineCategory === next.engineCategory)
              const nextRowNumber = engineList.findIndex((s) => s.id === next.id) + 1
              setDetailScenario({
                scenario: next,
                rowNumber: nextRowNumber > 0 ? nextRowNumber : currentIndex + 2,
              })
            }
          }}
          hasPrev={
            filteredScenarios.findIndex(
              (s) => s.id === detailScenario.scenario.id
            ) > 0
          }
          hasNext={
            (() => {
              const idx = filteredScenarios.findIndex(
                (s) => s.id === detailScenario.scenario.id
              )
              return idx >= 0 && idx < filteredScenarios.length - 1
            })()
          }
        />
      )}

      {/* iOS-Themed Confirmation Alert Modal */}
      {deletingScenario && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-[2px] animate-in fade-in duration-150"
          onClick={() => setDeletingScenario(null)}
        >
          <div
            className="w-[275px] sm:w-[295px] bg-[#F2F2F7]/95 backdrop-blur-2xl rounded-[16px] shadow-2xl border border-white/60 overflow-hidden text-center animate-in zoom-in-95 duration-150 select-none ring-1 ring-black/5"
            onClick={(e) => e.stopPropagation()}
            style={{
              fontFamily:
                "-apple-system, BlinkMacSystemFont, 'SF Pro Text', 'SF Pro Display', 'Helvetica Neue', Helvetica, Arial, sans-serif",
            }}
          >
            <div className="px-5 pt-5 pb-4">
              <h3 className="text-[17px] font-semibold text-[#000000] tracking-tight">
                Delete "{deletingScenario.key}"?
              </h3>
              <p className="mt-1.5 text-[13px] text-[#3C3C43]/80 leading-snug">
                {deletingScenario.governanceEvent
                  ? `${deletingScenario.governanceEvent}. `
                  : ''}
                This record will be permanently removed from the database.
              </p>
            </div>

            {/* iOS Action Buttons */}
            <div className="grid grid-cols-2 border-t border-[#3C3C43]/20 divide-x divide-[#3C3C43]/20 text-[17px]">
              <button
                type="button"
                onClick={() => setDeletingScenario(null)}
                className="py-2.5 font-normal text-[#007AFF] hover:bg-[#E5E5EA]/50 active:bg-[#D1D1D6] transition cursor-pointer"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={() => {
                  onDeleteScenario(deletingScenario.id)
                  setDeletingScenario(null)
                  setCopiedToast(`Deleted ${deletingScenario.key}`)
                  setTimeout(() => setCopiedToast(null), 2500)
                }}
                className="py-2.5 font-semibold text-[#FF3B30] hover:bg-[#E5E5EA]/50 active:bg-[#D1D1D6] transition cursor-pointer"
              >
                Delete
              </button>
            </div>
          </div>
        </div>
      )}

      {/* iOS Red Mismatch Warning Tooltip */}
      {activeMismatchTooltip && (
        <IosMismatchTooltip
          mismatch={activeMismatchTooltip.mismatch}
          anchorRect={activeMismatchTooltip.anchorRect}
          sheetUrl={verificationSummary?.sheetUrl}
          onClose={() => setActiveMismatchTooltip(null)}
          onApplyValue={(field, expectedValue) => {
            if (onApplySheetValue) {
              onApplySheetValue(activeMismatchTooltip.scenario, field, expectedValue)
            } else {
              onUpdateScenario({
                ...activeMismatchTooltip.scenario,
                [field]: expectedValue,
              })
            }
            setActiveMismatchTooltip(null)
          }}
        />
      )}

      {/* Floating Toast Feedback for Copied / Rolled back Row */}
      {copiedToast && (
        <div className="fixed bottom-6 right-6 z-50 bg-slate-900 text-white text-xs px-4 py-2.5 rounded shadow-xl flex items-center gap-2 animate-in fade-in slide-in-from-bottom-2 duration-150">
          <Check className="w-3.5 h-3.5 text-emerald-400 stroke-[2.5]" />
          <span className="font-medium">{copiedToast}</span>
        </div>
      )}
    </div>
  )
}
