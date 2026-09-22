import React, { useState, useMemo, useEffect, useRef } from 'react'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { JiraStatusBadge } from './JiraStatusBadge'
import { EngineBadge } from './EngineBadge'
import { JiraDefectModal } from './JiraDefectModal'
import { VersionHistoryModal } from './VersionHistoryModal'
import { EventBriefModal } from './EventBriefModal'
import { IosMismatchTooltip } from './IosMismatchTooltip'
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
} from 'lucide-react'
import { executeSearch } from '../../utils/aiSearch'
import { rollbackToVersion, rollbackFieldToVersion } from '../../utils/versionHistory'
import { polishCommentWithGemini } from '../../services/commentAiService'

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
  selectedEngine: 'ALL' | 'Governance' | 'Contribution'
  onSelectEngine?: (engine: 'ALL' | 'Governance' | 'Contribution') => void
  statusFilter?: string
  onStatusFilterChange?: (status: string) => void
  onResetAllFilters?: () => void
  isAiSearch?: boolean
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
  statusFilter: propsStatusFilter,
  onStatusFilterChange,
  onResetAllFilters,
  isAiSearch = false,
  verificationSummary,
  onApplySheetValue,
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
    statusFilter !== 'ALL' ||
    Boolean(searchQuery && searchQuery.trim().length > 0)

  const [isStatusDropdownOpen, setIsStatusDropdownOpen] = useState(false)
  const statusDropdownRef = useRef<HTMLDivElement>(null)

  // Close status dropdown on click outside or Escape
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (statusDropdownRef.current && !statusDropdownRef.current.contains(e.target as Node)) {
        setIsStatusDropdownOpen(false)
      }
    }
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setIsStatusDropdownOpen(false)
      }
    }
    if (isStatusDropdownOpen) {
      document.addEventListener('mousedown', handleClickOutside)
      document.addEventListener('keydown', handleKeyDown)
    }
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isStatusDropdownOpen])
  const [selectedRowIds, setSelectedRowIds] = useState<Set<string>>(new Set())
  const [defectScenario, setDefectScenario] = useState<NotificationScenario | null>(null)
  const [historyScenario, setHistoryScenario] = useState<NotificationScenario | null>(null)
  const [selectedEventBrief, setSelectedEventBrief] = useState<{
    scenario: NotificationScenario
    rect: DOMRect
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
  const [deletingScenario, setDeletingScenario] = useState<NotificationScenario | null>(null)
  const [copiedToast, setCopiedToast] = useState<string | null>(null)
  const tableContainerRef = useRef<HTMLDivElement>(null)

  // Right-click context menu state
  const [contextMenu, setContextMenu] = useState<{
    x: number
    y: number
    scenario: NotificationScenario
  } | null>(null)
  const contextMenuRef = useRef<HTMLDivElement>(null)

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
      'TO DO': 0,
      TESTED: 0,
      'NOT WORKING': 0,
      'NAVIGATION NOT WORKING': 0,
      'PUSH NOTIFICATION NOT WORKING': 0,
      'EMAIL NOTIFICATION NOT WORKING': 0,
      'SMS NOTIFICATION NOT WORKING': 0,
      NOT_WORKING_ANY: 0,
    }

    engineScenarios.forEach((s) => {
      const st = s.status || 'TO DO'
      if (counts[st] !== undefined) {
        counts[st]++
      } else {
        counts[st] = 1
      }
      if (st && st.includes('NOT WORKING')) {
        counts.NOT_WORKING_ANY++
      }
    })

    return counts
  }, [scenarios, selectedEngine])

  // 1. Filter scenarios by engine category & status first
  const baseFiltered = useMemo(() => {
    return scenarios.filter((s) => {
      const matchesEngine =
        selectedEngine === 'ALL' || (s.engineCategory || 'Governance') === selectedEngine
      const matchesStatus =
        statusFilter === 'ALL'
          ? true
          : statusFilter === 'NOT_WORKING_ANY'
          ? s.status.includes('NOT WORKING')
          : s.status === statusFilter
      return matchesEngine && matchesStatus
    })
  }, [scenarios, selectedEngine, statusFilter])

  // 2. Spreadsheet behavior: Search does NOT filter out rows - all rows stay visible!
  // It only highlights the matched values where they appear in the cells.
  const filteredScenarios = baseFiltered

  // 3. Find matching rows & terms for highlighting and match navigation
  const { results: matchingScenarios, matchedTerms } = useMemo(() => {
    if (!searchQuery.trim()) {
      return { results: [], matchedTerms: new Set<string>() }
    }
    return executeSearch(baseFiltered, searchQuery, Boolean(isAiSearch))
  }, [baseFiltered, searchQuery, isAiSearch])

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

  // Handle right-click context menu
  const handleContextMenu = (e: React.MouseEvent, scenario: NotificationScenario) => {
    e.preventDefault()
    setContextMenu({
      x: Math.min(e.clientX, window.innerWidth - 220),
      y: Math.min(e.clientY, window.innerHeight - 300),
      scenario,
    })
  }

  // Header label based on engine category
  const eventColumnHeader =
    selectedEngine === 'Governance'
      ? 'Governance Event'
      : selectedEngine === 'Contribution'
      ? 'Contribution Event'
      : 'Event'

  const allStatuses: ScenarioStatus[] = [
    'TO DO',
    'TESTED',
    'NOT WORKING',
    'NAVIGATION NOT WORKING',
    'PUSH NOTIFICATION NOT WORKING',
    'EMAIL NOTIFICATION NOT WORKING',
    'SMS NOTIFICATION NOT WORKING',
  ]

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
          <div className="flex items-center gap-1.5 font-bold text-[11px] sm:text-xs shrink-0">
            <button
              type="button"
              onClick={handleResetAllFilters}
              title="Click to reset all filters and display all records"
              className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-[3px] text-xs transition cursor-pointer select-none border font-semibold ${
                selectedEngine === 'Governance'
                  ? 'bg-emerald-100 hover:bg-emerald-200 text-emerald-800 border-emerald-300 shadow-2xs'
                  : selectedEngine === 'Contribution'
                  ? 'bg-blue-100 hover:bg-blue-200 text-blue-800 border-blue-300 shadow-2xs'
                  : hasActiveFilters
                  ? 'bg-[#DEEBFF] hover:bg-[#B3D4FF] text-[#0052CC] border-[#B3D4FF] shadow-2xs'
                  : 'bg-[#EBECF0] hover:bg-[#DFE1E6] text-[#172B4D] border-[#C1C7D0]'
              }`}
            >
              <span>
                {selectedEngine === 'Governance'
                  ? 'Governance Engine Sheet'
                  : selectedEngine === 'Contribution'
                  ? 'Contribution Engine Sheet'
                  : 'All Engine Categories'}
              </span>
              {selectedEngine !== 'ALL' ? (
                <span className="text-[10px] opacity-70 hover:opacity-100 font-bold ml-0.5" title="Clear engine filter">✕</span>
              ) : hasActiveFilters ? (
                <span className="text-[9px] bg-[#0052CC] text-white px-1.5 py-0.2 rounded-full font-bold">Filtered</span>
              ) : null}
            </button>
          </div>

          <span className="text-slate-300 shrink-0 select-none">|</span>

          {/* Status Filter - Jira-style Dropdown Button */}
          <div className="relative shrink-0" ref={statusDropdownRef}>
            <button
              type="button"
              onClick={() => setIsStatusDropdownOpen((prev) => !prev)}
              className={`cursor-pointer px-2.5 py-1 rounded-[3px] text-xs inline-flex items-center gap-1.5 transition border select-none ${
                statusFilter !== 'ALL'
                  ? 'bg-[#DEEBFF] text-[#0052CC] border-[#B3D4FF] font-semibold shadow-2xs'
                  : isStatusDropdownOpen
                  ? 'bg-[#EBECF0] text-[#172B4D] border-[#C1C7D0]'
                  : 'bg-[#FAFBFC] hover:bg-[#EBECF0] text-[#42526E] hover:text-[#172B4D] border-[#DFE1E6]'
              }`}
            >
              <Filter className={`w-3.5 h-3.5 ${statusFilter !== 'ALL' ? 'text-[#0052CC]' : 'text-[#6B778C]'}`} />
              <span>
                {statusFilter === 'ALL'
                  ? 'Status'
                  : statusFilter === 'NOT_WORKING_ANY'
                  ? 'Status: All Not Working'
                  : `Status: ${statusFilter}`}
              </span>
              <span
                className={`px-1.5 py-0.2 rounded-full text-[10px] font-bold ${
                  statusFilter !== 'ALL'
                    ? 'bg-[#0052CC] text-white'
                    : 'bg-[#DFE1E6] text-[#42526E]'
                }`}
              >
                {statusCounts[statusFilter] ?? 0}
              </span>
              {statusFilter !== 'ALL' ? (
                <span
                  role="button"
                  tabIndex={0}
                  onClick={(e) => {
                    e.stopPropagation()
                    setStatusFilter('ALL')
                  }}
                  title="Clear status filter"
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

            {/* Jira Filter Dropdown Popover */}
            {isStatusDropdownOpen && (
              <div className="absolute left-0 mt-1 w-64 bg-white rounded-[4px] shadow-[0_4px_12px_-2px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] py-1.5 z-40 text-[#172B4D] animate-in fade-in zoom-in-95 duration-100">
                <div className="px-3 py-1 flex items-center justify-between text-[10px] font-bold text-[#6B778C] uppercase tracking-wider border-b border-[#EBECF0] pb-1.5 mb-1">
                  <span>Filter by Status</span>
                  {statusFilter !== 'ALL' && (
                    <button
                      type="button"
                      onClick={() => {
                        setStatusFilter('ALL')
                        setIsStatusDropdownOpen(false)
                      }}
                      className="text-[11px] text-[#0052CC] hover:underline cursor-pointer lowercase first-letter:uppercase font-normal"
                    >
                      Clear filter
                    </button>
                  )}
                </div>

                <div className="max-h-72 overflow-y-auto py-0.5">
                  {[
                    { label: 'All Statuses', value: 'ALL', dotColor: 'bg-[#6B778C]' },
                    { label: 'TO DO', value: 'TO DO', dotColor: 'bg-[#42526E]' },
                    { label: 'TESTED', value: 'TESTED', dotColor: 'bg-[#00875A]' },
                    { label: 'NOT WORKING', value: 'NOT WORKING', dotColor: 'bg-[#DE350B]' },
                    { label: 'NAVIGATION NOT WORKING', value: 'NAVIGATION NOT WORKING', dotColor: 'bg-[#FF8B00]' },
                    { label: 'PUSH NOTIFICATION NOT WORKING', value: 'PUSH NOTIFICATION NOT WORKING', dotColor: 'bg-[#FF5630]' },
                    { label: 'EMAIL NOTIFICATION NOT WORKING', value: 'EMAIL NOTIFICATION NOT WORKING', dotColor: 'bg-[#6554C0]' },
                    { label: 'SMS NOTIFICATION NOT WORKING', value: 'SMS NOTIFICATION NOT WORKING', dotColor: 'bg-[#00B8D9]' },
                    { label: 'ALL NOT WORKING', value: 'NOT_WORKING_ANY', dotColor: 'bg-[#BF2600]' },
                  ].map(({ label, value, dotColor }) => {
                    const count = statusCounts[value] ?? 0
                    const isSelected = statusFilter === value
                    return (
                      <button
                        key={value}
                        type="button"
                        onClick={() => {
                          setStatusFilter(value)
                          setIsStatusDropdownOpen(false)
                        }}
                        className={`w-full px-3 py-1.5 text-left text-xs flex items-center justify-between hover:bg-[#F4F5F7] transition cursor-pointer ${
                          isSelected ? 'bg-[#EBECF0] font-semibold text-[#0052CC]' : 'text-[#172B4D]'
                        }`}
                      >
                        <div className="flex items-center gap-2 min-w-0 pr-2">
                          <span className={`w-2 h-2 rounded-full shrink-0 ${dotColor}`} />
                          <span className="truncate">{label}</span>
                        </div>
                        <div className="flex items-center gap-2 shrink-0">
                          <span className="text-[11px] font-bold px-1.5 py-0.2 rounded-full bg-[#DFE1E6] text-[#42526E]">
                            {count}
                          </span>
                          {isSelected && (
                            <Check className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
                          )}
                        </div>
                      </button>
                    )
                  })}
                </div>
              </div>
            )}
          </div>

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
            Showing <strong>{filteredScenarios.length}</strong> rows
          </span>
        </div>
      </div>

      {/* Spreadsheet Table Container */}
      <div
        className="flex-1 overflow-auto bg-white pb-36"
        ref={tableContainerRef}
        onScroll={() => setHoveredInfo(null)}
      >
        <table className="w-full border-collapse text-left text-xs font-sans">
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
                className="w-12 px-2 py-2.5 font-bold text-center border-r border-[#0D6535] bg-[#0E6C38] text-white cursor-pointer hover:bg-[#0A542B] transition select-none sticky left-0 z-30 shadow-[1px_0_0_0_#0D6535]"
                title={selectedRowIds.size > 0 ? 'Click to deselect all rows' : 'Click to select all rows'}
              >
                #
              </th>

              {/* Engine Column with Quick Status Dropdown */}
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[130px] lg:min-w-[140px] bg-[#107C41] text-white">
                Engine
              </th>

              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[190px] xl:min-w-[220px]">
                {eventColumnHeader}
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[130px] xl:min-w-[150px]">
                Trigger
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[120px] xl:min-w-[140px]">
                Audience
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[160px] xl:min-w-[180px]">
                Communication Objective
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[130px] xl:min-w-[150px]">
                Desired Outcome
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[180px] xl:min-w-[200px]">
                Push Notification Subject Line
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[210px] xl:min-w-[240px]">
                Push Notification
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[180px] xl:min-w-[200px]">
                Email Subject Line
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[220px] xl:min-w-[250px]">
                Email Message
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[150px] xl:min-w-[180px]">
                In-App Experience
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[110px] xl:min-w-[130px]">
                Call to Action
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[170px] xl:min-w-[200px]">
                Comments
              </th>
              <th className="px-3 py-2.5 font-bold uppercase text-[11px] tracking-wider border-r border-[#0D6535] whitespace-nowrap min-w-[120px] xl:min-w-[130px] bg-[#107C41] text-white">
                Status
              </th>
              <th className="px-2 py-2.5 font-bold uppercase text-[11px] tracking-wider text-center whitespace-nowrap bg-[#107C41] text-white min-w-[70px] xl:min-w-[76px]">
                Action
              </th>
            </tr>
          </thead>

          {/* Table Body: Excel Sheet Row Cells */}
          <tbody className="divide-y divide-[#E1E4E8] bg-white">
            {filteredScenarios.length === 0 ? (
              <tr>
                <td colSpan={16} className="py-12 text-center text-[#6B778C]">
                  <p className="font-semibold text-sm">No matching notification rows</p>
                  <p className="text-xs text-slate-400 mt-1">Adjust search query or status filter to view scenarios</p>
                </td>
              </tr>
            ) : (
              filteredScenarios.map((row, index) => {
                // Show original spreadsheet row number (Excel-style)
                const engineList =
                  selectedEngine === 'ALL'
                    ? scenarios
                    : scenarios.filter(
                        (s) => (s.engineCategory || 'Governance') === selectedEngine
                      )
                const originalIndex = engineList.findIndex((s) => s.id === row.id)
                const rowNumber = originalIndex >= 0 ? originalIndex + 1 : index + 1

                const isSelected = selectedRowIds.has(row.id)
                const isTested = row.status === 'TESTED'
                const isNotWorking = row.status.includes('NOT WORKING')
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
                        className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md bg-[#FFF0ED] text-[#D70015] border border-[#FF3B30]/40 font-medium min-h-[22px] max-w-full truncate select-text cursor-pointer hover:bg-[#FFE5E0] transition-all shadow-2xs group/mismatch"
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
                      title={`Row #${rowNumber} • Click to ${isSelected ? 'unselect row' : 'highlight full row (DBeaver style)'}`}
                      className={`px-2 py-2 font-mono text-[11px] text-center font-bold border-r border-[#E1E4E8] select-none transition-colors cursor-pointer sticky left-0 z-10 shadow-[1px_0_0_0_#E1E4E8] ${
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
                      {rowNumber}
                    </td>

                    {/* Engine Column with Quick Status Dropdown */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] whitespace-nowrap">
                      <EngineBadge
                        category={row.engineCategory || 'Governance'}
                        currentStatus={row.status}
                        onUpdateStatus={(st) => onUpdateStatus(row.id, st)}
                        onCreateDefect={() => setDefectScenario(row)}
                        onOpenLog={() => setHistoryScenario(row)}
                      />
                    </td>

                    {/* Event Name with (i) Info Brief Button */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8] font-medium group/event">
                      <div className="flex items-center justify-between gap-1.5">
                        <div className="flex-1 min-w-0">
                          {renderCell('governanceEvent', row.governanceEvent)}
                        </div>
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
                    </td>

                    {/* Trigger */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('trigger', row.trigger)}
                    </td>

                    {/* Audience */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('audience', row.audience)}
                    </td>

                    {/* Communication Objective */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('communicationObjective', row.communicationObjective)}
                    </td>

                    {/* Desired Outcome */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('desiredOutcome', row.desiredOutcome)}
                    </td>

                    {/* Push Notification Subject Line */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('pushSubject', row.pushSubject)}
                    </td>

                    {/* Push Notification */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('pushBody', row.pushBody)}
                    </td>

                    {/* Email Subject Line */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('emailSubject', row.emailSubject)}
                    </td>

                    {/* Email Message */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('emailBody', row.emailBody)}
                    </td>

                    {/* In-App Experience */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('inAppExperience', row.inAppExperience)}
                    </td>

                    {/* Call to Action */}
                    <td className="px-3 py-2 border-r border-[#E1E4E8]">
                      {renderCell('cta', row.cta)}
                    </td>

                    {/* Manual Comments */}
                    <td className="px-2 py-1.5 border-r border-[#E1E4E8] min-w-[200px] max-w-[320px]">
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
                          onClick={() => startEditingComment(row)}
                          className="flex items-center justify-between gap-1 group-hover/comment:bg-blue-50/60 px-1 py-0.5 rounded transition cursor-pointer group/comment"
                        >
                          <div
                            className={`truncate text-xs ${
                              row.comments
                                ? 'text-[#172B4D] font-medium'
                                : 'text-slate-400 italic group-hover/comment:text-[#0052CC]'
                            }`}
                            title={row.comments ? row.comments : 'Click to add/edit comment'}
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
                    <td className="px-3 py-2 border-r border-[#E1E4E8] whitespace-nowrap">
                      <JiraStatusBadge
                        status={row.status}
                        onChange={(st) => onUpdateStatus(row.id, st)}
                        onCreateDefect={() => setDefectScenario(row)}
                        onOpenLog={() => setHistoryScenario(row)}
                        size="sm"
                      />
                    </td>

                    {/* Actions: History, Copy & Delete */}
                    <td className="px-2 py-2 text-center whitespace-nowrap">
                      <div className="flex items-center justify-center gap-1">
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
      {contextMenu && (
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
            style={{ top: contextMenu.y, left: contextMenu.x }}
            className="fixed z-50 w-56 bg-white rounded-lg shadow-2xl border border-[#DFE1E6] py-1 text-xs text-[#172B4D] animate-in fade-in zoom-in-95 duration-100 divide-y divide-slate-100"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Header with (i) Info Log button and Close X button */}
            <div className="px-3 py-2 bg-[#FAFBFC] text-[10px] font-bold text-[#6B778C] uppercase tracking-wider flex items-center justify-between border-b border-slate-100 rounded-t-lg">
              <span className="font-semibold">{contextMenu.scenario.key} &bull; Quick Actions</span>
              <div className="flex items-center gap-1.5">
                <button
                  type="button"
                  onClick={() => {
                    setHistoryScenario(contextMenu.scenario)
                    setContextMenu(null)
                  }}
                  className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded bg-blue-50 text-[#0052CC] hover:bg-blue-100 border border-blue-200 text-[10px] font-bold transition cursor-pointer shadow-2xs"
                  title="View Jira + GitHub Log Page"
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
            {(['Governance', 'Contribution'] as const).map((cat) => {
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

          {/* Close Menu Button */}
          <div className="py-1 bg-slate-50 rounded-b-lg">
            <button
              type="button"
              onClick={() => setContextMenu(null)}
              className="w-full flex items-center justify-center gap-1.5 px-3 py-1.5 hover:bg-slate-100 text-slate-500 hover:text-slate-800 cursor-pointer transition text-xs font-semibold"
            >
              <X className="w-3.5 h-3.5 text-slate-400" />
              <span>Close Menu</span>
            </button>
          </div>
        </div>
        </>
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
