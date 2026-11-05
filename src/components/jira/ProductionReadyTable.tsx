import React, { useState, useMemo, useRef, useEffect } from 'react'
import type { ProductionNotification, NotificationScenario, ScenarioStatus } from '../../types/notification'
import { JiraDetailModal } from './JiraDetailModal'
import { NotificationRuleModal } from './NotificationRuleModal'
import { ProductionActivityLogModal } from './ProductionActivityLogModal'
import * as XLSX from 'xlsx'
import {
  Search,
  X,
  FileSpreadsheet,
  Trash2,
  Eye,
  BookOpen,
  Copy,
  Check,
} from 'lucide-react'

export type ProdTableColumnKey =
  | 'index'
  | 'key'
  | 'engine'
  | 'event'
  | 'trigger'
  | 'audience'
  | 'communicationObjective'
  | 'pushSubject'
  | 'pushBody'
  | 'emailSubject'
  | 'emailBody'
  | 'inAppExperience'
  | 'cta'
  | 'status'
  | 'clonedAt'
  | 'action'

const DEFAULT_PROD_COLUMN_WIDTHS: Record<ProdTableColumnKey, number> = {
  index: 48,
  key: 110,
  engine: 120,
  event: 220,
  trigger: 150,
  audience: 130,
  communicationObjective: 180,
  pushSubject: 190,
  pushBody: 220,
  emailSubject: 190,
  emailBody: 240,
  inAppExperience: 170,
  cta: 130,
  status: 160,
  clonedAt: 140,
  action: 96,
}

const MIN_PROD_COLUMN_WIDTHS: Record<ProdTableColumnKey, number> = {
  index: 36,
  key: 70,
  engine: 80,
  event: 120,
  trigger: 90,
  audience: 80,
  communicationObjective: 100,
  pushSubject: 100,
  pushBody: 110,
  emailSubject: 100,
  emailBody: 110,
  inAppExperience: 90,
  cta: 75,
  status: 100,
  clonedAt: 90,
  action: 80,
}

const PROD_STORAGE_KEY_WIDTHS = 'seedling_prod_col_widths_v1'

const PROD_STATUS_OPTIONS = [
  'READY FOR PROD',
  'LIVE IN PROD',
  'STAGING VERIFIED',
  'DEPLOYED',
  'PENDING REVIEW',
]

// Returns inline style object for each production status — distinct colours per state
const getStatusStyle = (status: string): React.CSSProperties => {
  switch ((status || '').toUpperCase()) {
    case 'LIVE IN PROD':
      return { background: '#dcfce7', color: '#14532d', border: '1px solid #86efac' } // green
    case 'DEPLOYED':
      return { background: '#dbeafe', color: '#1e3a8a', border: '1px solid #93c5fd' } // blue
    case 'STAGING VERIFIED':
      return { background: '#fef9c3', color: '#713f12', border: '1px solid #fde047' } // yellow
    case 'PENDING REVIEW':
      return { background: '#fee2e2', color: '#7f1d1d', border: '1px solid #fca5a5' } // red
    case 'READY FOR PROD':
    default:
      return { background: '#f3e8ff', color: '#581c87', border: '1px solid #c084fc' } // purple
  }
}

interface ProductionReadyTableProps {
  productionNotifications: ProductionNotification[]
  onUpdateProductionNotification: (item: ProductionNotification) => void
  onDeleteProductionNotification: (id: string) => void
  onSwitchToScenarios: () => void
  onShowToast?: (message: string) => void
  availableEngines?: string[]
}

export const ProductionReadyTable: React.FC<ProductionReadyTableProps> = ({
  productionNotifications,
  onUpdateProductionNotification,
  onDeleteProductionNotification,
  onSwitchToScenarios,
  onShowToast,
  availableEngines = [
    'Governance',
    'Contribution',
    'Participation',
    'Identity',
    'Opportunity',
    'Discovery',
    'Campaign',
    'Manual',
  ],
}) => {
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedEngine, setSelectedEngine] = useState<string>('ALL')
  const [statusFilter, setStatusFilter] = useState<string>('ALL')
  const [selectedRowIds, setSelectedRowIds] = useState<Set<string>>(new Set())
  const [detailItem, setDetailItem] = useState<{ scenario: NotificationScenario; rowNumber: number } | null>(null)
  const [selectedRuleItem, setSelectedRuleItem] = useState<{ scenario: NotificationScenario; rowNumber: number } | null>(null)
  const [copiedId, setCopiedId] = useState<string | null>(null)
  const [activeResizingCol, setActiveResizingCol] = useState<ProdTableColumnKey | null>(null)
  const [showActivityLog, setShowActivityLog] = useState(false)

  // Column widths state
  const [columnWidths, setColumnWidths] = useState<Record<ProdTableColumnKey, number>>(() => {
    try {
      const saved = localStorage.getItem(PROD_STORAGE_KEY_WIDTHS)
      if (saved) {
        const parsed = JSON.parse(saved)
        return { ...DEFAULT_PROD_COLUMN_WIDTHS, ...parsed }
      }
    } catch {}
    return { ...DEFAULT_PROD_COLUMN_WIDTHS }
  })

  const tableContainerRef = useRef<HTMLDivElement>(null)
  const resizeStartXRef = useRef<number>(0)
  const resizeStartWidthRef = useRef<number>(0)

  const handleResizeStart = (colKey: ProdTableColumnKey, e: React.PointerEvent) => {
    e.preventDefault()
    e.stopPropagation()
    setActiveResizingCol(colKey)
    resizeStartXRef.current = e.clientX
    resizeStartWidthRef.current = columnWidths[colKey] ?? DEFAULT_PROD_COLUMN_WIDTHS[colKey]
  }

  useEffect(() => {
    if (!activeResizingCol) return

    const handlePointerMove = (e: PointerEvent) => {
      const deltaX = e.clientX - resizeStartXRef.current
      const minW = MIN_PROD_COLUMN_WIDTHS[activeResizingCol] ?? 40
      const newWidth = Math.max(minW, resizeStartWidthRef.current + deltaX)
      setColumnWidths((prev) => {
        const updated = { ...prev, [activeResizingCol]: newWidth }
        try {
          localStorage.setItem(PROD_STORAGE_KEY_WIDTHS, JSON.stringify(updated))
        } catch {}
        return updated
      })
    }

    const handlePointerUp = () => {
      setActiveResizingCol(null)
    }

    window.addEventListener('pointermove', handlePointerMove)
    window.addEventListener('pointerup', handlePointerUp)
    return () => {
      window.removeEventListener('pointermove', handlePointerMove)
      window.removeEventListener('pointerup', handlePointerUp)
    }
  }, [activeResizingCol])

  const totalTableWidth = useMemo(() => {
    return (Object.keys(DEFAULT_PROD_COLUMN_WIDTHS) as ProdTableColumnKey[]).reduce(
      (sum, key) => sum + (columnWidths[key] ?? DEFAULT_PROD_COLUMN_WIDTHS[key]),
      0
    )
  }, [columnWidths])

  // Filtering
  const filteredNotifications = useMemo(() => {
    let result = [...productionNotifications]

    if (selectedEngine !== 'ALL') {
      result = result.filter(
        (n) => n.engineCategory.toLowerCase() === selectedEngine.toLowerCase()
      )
    }

    if (statusFilter !== 'ALL') {
      result = result.filter(
        (n) => (n.status || '').toLowerCase() === statusFilter.toLowerCase()
      )
    }

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase().trim()
      result = result.filter((n) => {
        return (
          (n.key || '').toLowerCase().includes(q) ||
          (n.governanceEvent || '').toLowerCase().includes(q) ||
          (n.trigger || '').toLowerCase().includes(q) ||
          (n.audience || '').toLowerCase().includes(q) ||
          (n.communicationObjective || '').toLowerCase().includes(q) ||
          (n.pushSubject || '').toLowerCase().includes(q) ||
          (n.pushBody || '').toLowerCase().includes(q) ||
          (n.emailSubject || '').toLowerCase().includes(q) ||
          (n.emailBody || '').toLowerCase().includes(q) ||
          (n.inAppExperience || '').toLowerCase().includes(q) ||
          (n.cta || '').toLowerCase().includes(q) ||
          (n.comments || '').toLowerCase().includes(q)
        )
      })
    }

    return result
  }, [productionNotifications, selectedEngine, statusFilter, searchQuery])

  // Engine counts
  const engineCounts = useMemo(() => {
    const map: Record<string, number> = {}
    productionNotifications.forEach((n) => {
      const eng = n.engineCategory || 'Unassigned'
      map[eng] = (map[eng] || 0) + 1
    })
    return map
  }, [productionNotifications])

  // Copy row content
  const handleCopyRow = (item: ProductionNotification) => {
    const text = JSON.stringify(item, null, 2)
    navigator.clipboard.writeText(text).then(() => {
      setCopiedId(item.id)
      onShowToast?.(`Copied ${item.key} notification data to clipboard`)
      setTimeout(() => setCopiedId(null), 2000)
    })
  }

  // Export to Excel
  const handleExportToExcel = () => {
    if (filteredNotifications.length === 0) {
      onShowToast?.('No notifications to export')
      return
    }

    const exportRows = filteredNotifications.map((n, idx) => ({
      '#': idx + 1,
      'Key': n.key,
      'Engine': n.engineCategory,
      'Event / Scenario': n.governanceEvent,
      'Trigger': n.trigger,
      'Audience': n.audience,
      'Communication Objective': n.communicationObjective,
      'Push Subject': n.pushSubject,
      'Push Body': n.pushBody,
      'Email Subject': n.emailSubject,
      'Email Body': n.emailBody,
      'In-App Experience': n.inAppExperience,
      'CTA': n.cta,
      'Status': n.status,
      'Cloned Date': n.clonedAt || n.createdAt,
      'Original Scenario ID': n.originalScenarioId || '',
    }))

    const worksheet = XLSX.utils.json_to_sheet(exportRows)
    const workbook = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Production Notifications')
    XLSX.writeFile(workbook, `seedling-production-ready-${Date.now()}.xlsx`)
    onShowToast?.(`Exported ${filteredNotifications.length} production notifications to Excel`)
  }

  const renderResizeHandle = (colKey: ProdTableColumnKey, colTitle: string) => {
    const isResizing = activeResizingCol === colKey
    return (
      <div
        onPointerDown={(e) => handleResizeStart(colKey, e)}
        onDoubleClick={() => {
          setColumnWidths((prev) => {
            const updated = { ...prev, [colKey]: DEFAULT_PROD_COLUMN_WIDTHS[colKey] }
            try {
              localStorage.setItem(PROD_STORAGE_KEY_WIDTHS, JSON.stringify(updated))
            } catch {}
            return updated
          })
        }}
        className="absolute top-0 bottom-0 -right-2.5 w-5 z-40 cursor-col-resize select-none flex items-center justify-center group/resizer touch-none"
        title={`Drag to adjust ${colTitle} width • Double-click to reset`}
      >
        <div
          className={`w-[2px] h-full transition-colors ${
            isResizing ? 'bg-amber-300 w-[3px]' : 'bg-white/40 group-hover/resizer:bg-white'
          }`}
        />
      </div>
    )
  }

  const getEngineBadgeColor = (engine: string) => {
    switch (engine.toLowerCase()) {
      case 'governance':
        return 'bg-purple-100 text-purple-800 border-purple-200'
      case 'contribution':
        return 'bg-emerald-100 text-emerald-800 border-emerald-200'
      case 'participation':
        return 'bg-blue-100 text-blue-800 border-blue-200'
      case 'identity':
        return 'bg-teal-100 text-teal-800 border-teal-200'
      case 'opportunity':
        return 'bg-amber-100 text-amber-800 border-amber-200'
      case 'discovery':
        return 'bg-indigo-100 text-indigo-800 border-indigo-200'
      case 'campaign':
        return 'bg-rose-100 text-rose-800 border-rose-200'
      default:
        return 'bg-slate-100 text-slate-800 border-slate-200'
    }
  }

  return (
    <div className="flex-1 flex flex-col min-w-0 overflow-hidden bg-white">
      {/* 1. Header Toolbar */}
      <div className="bg-[#FAFBFC] border-b border-[#DFE1E6] px-4 py-3 shrink-0 flex flex-col md:flex-row md:items-center justify-between gap-3">
        <div>
          <h1 className="text-base font-bold text-[#172B4D] tracking-tight flex items-center gap-1.5">
            Production Ready Notifications
            {/* ⓘ Activity Log button — intentionally plain, like a hand-made sheet control */}
            <button
              type="button"
              onClick={() => setShowActivityLog(true)}
              title="View activity log — records each time a notification is added"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                justifyContent: 'center',
                width: '17px',
                height: '17px',
                fontSize: '10px',
                lineHeight: '1',
                fontFamily: 'Arial, sans-serif',
                fontWeight: 'bold',
                border: '1px solid #999',
                borderRadius: '50%',
                background: '#fff',
                color: '#555',
                cursor: 'pointer',
                flexShrink: 0,
                padding: 0,
                verticalAlign: 'middle',
              }}
            >
              i
            </button>
          </h1>
          <p className="text-xs text-[#6B778C]">
            Notifications cloned &amp; approved for production deployment
          </p>
        </div>

        {/* Toolbar Actions */}
        <div className="flex items-center flex-wrap gap-2">
          {/* Search Box */}
          <div className="relative w-48 sm:w-60">
            <Search className="w-3.5 h-3.5 text-slate-400 absolute left-2.5 top-1/2 -translate-y-1/2 pointer-events-none" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search production notifications..."
              className="w-full h-8 pl-8 pr-7 text-xs bg-white border border-[#DFE1E6] rounded-[3px] text-[#172B4D] placeholder-slate-400 focus:outline-none focus:border-[#0052CC] focus:ring-1 focus:ring-[#0052CC] transition"
            />
            {searchQuery && (
              <button
                type="button"
                onClick={() => setSearchQuery('')}
                className="absolute right-2 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
              >
                <X className="w-3.5 h-3.5" />
              </button>
            )}
          </div>

          {/* Engine Filter */}
          <select
            value={selectedEngine}
            onChange={(e) => setSelectedEngine(e.target.value)}
            className="h-8 px-2.5 text-xs bg-white border border-[#DFE1E6] rounded-[3px] text-[#172B4D] font-medium focus:outline-none focus:border-[#0052CC] cursor-pointer"
          >
            <option value="ALL">All Engines ({productionNotifications.length})</option>
            {availableEngines.map((eng) => (
              <option key={eng} value={eng}>
                {eng} ({engineCounts[eng] || 0})
              </option>
            ))}
          </select>

          {/* Status Filter */}
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="h-8 px-2.5 text-xs bg-white border border-[#DFE1E6] rounded-[3px] text-[#172B4D] font-medium focus:outline-none focus:border-[#0052CC] cursor-pointer"
          >
            <option value="ALL">All Statuses</option>
            {PROD_STATUS_OPTIONS.map((st) => (
              <option key={st} value={st}>
                {st}
              </option>
            ))}
          </select>

          {/* Export to Excel */}
          <button
            type="button"
            onClick={handleExportToExcel}
            className="h-8 px-3 text-xs font-semibold bg-white hover:bg-slate-50 text-[#172B4D] border border-[#DFE1E6] rounded-[3px] shadow-2xs transition flex items-center gap-1.5 cursor-pointer"
            title="Export production notifications to Excel"
          >
            <FileSpreadsheet className="w-3.5 h-3.5 text-emerald-600" />
            <span className="hidden sm:inline">Export Excel</span>
          </button>
        </div>
      </div>

      {/* 2. Main Content: Table */}
      <div
        className="flex-1 overflow-auto bg-white"
        ref={tableContainerRef}
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
              <col style={{ width: `${columnWidths.key}px` }} />
              <col style={{ width: `${columnWidths.engine}px` }} />
              <col style={{ width: `${columnWidths.event}px` }} />
              <col style={{ width: `${columnWidths.trigger}px` }} />
              <col style={{ width: `${columnWidths.audience}px` }} />
              <col style={{ width: `${columnWidths.communicationObjective}px` }} />
              <col style={{ width: `${columnWidths.pushSubject}px` }} />
              <col style={{ width: `${columnWidths.pushBody}px` }} />
              <col style={{ width: `${columnWidths.emailSubject}px` }} />
              <col style={{ width: `${columnWidths.emailBody}px` }} />
              <col style={{ width: `${columnWidths.inAppExperience}px` }} />
              <col style={{ width: `${columnWidths.cta}px` }} />
              <col style={{ width: `${columnWidths.status}px` }} />
              <col style={{ width: `${columnWidths.clonedAt}px` }} />
              <col style={{ width: `${columnWidths.action}px` }} />
            </colgroup>

            {/* Table Header: Emerald / Dark Green theme */}
            <thead className="bg-[#0A542B] text-white sticky top-0 z-20 shadow-xs select-none border-b border-[#084222]">
              <tr className="border-b border-[#084222]">
                <th
                  style={{
                    width: `${columnWidths.index}px`,
                    minWidth: `${columnWidths.index}px`,
                    maxWidth: `${columnWidths.index}px`,
                  }}
                  className="relative px-2 py-2.5 font-bold text-center border-r border-[#084222] bg-[#073B1E] text-white cursor-pointer select-none sticky left-0 z-30"
                  onClick={() => {
                    if (selectedRowIds.size > 0) {
                      setSelectedRowIds(new Set())
                    } else {
                      setSelectedRowIds(new Set(filteredNotifications.map((n) => n.id)))
                    }
                  }}
                  title={selectedRowIds.size > 0 ? 'Deselect all' : 'Select all'}
                >
                  <span>#</span>
                  {renderResizeHandle('index', 'Row Number')}
                </th>

                <th
                  style={{ width: `${columnWidths.key}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Production Key">Prod Key</span>
                  {renderResizeHandle('key', 'Key')}
                </th>

                <th
                  style={{ width: `${columnWidths.engine}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Engine">Engine</span>
                  {renderResizeHandle('engine', 'Engine')}
                </th>

                <th
                  style={{ width: `${columnWidths.event}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Notification Event">Event / Notification</span>
                  {renderResizeHandle('event', 'Event')}
                </th>

                <th
                  style={{ width: `${columnWidths.trigger}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Trigger">Trigger</span>
                  {renderResizeHandle('trigger', 'Trigger')}
                </th>

                <th
                  style={{ width: `${columnWidths.audience}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Audience">Audience</span>
                  {renderResizeHandle('audience', 'Audience')}
                </th>

                <th
                  style={{ width: `${columnWidths.communicationObjective}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Communication Objective">Communication Objective</span>
                  {renderResizeHandle('communicationObjective', 'Communication Objective')}
                </th>

                <th
                  style={{ width: `${columnWidths.pushSubject}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Push Subject">Push Subject</span>
                  {renderResizeHandle('pushSubject', 'Push Subject')}
                </th>

                <th
                  style={{ width: `${columnWidths.pushBody}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Push Message">Push Message</span>
                  {renderResizeHandle('pushBody', 'Push Message')}
                </th>

                <th
                  style={{ width: `${columnWidths.emailSubject}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Email Subject">Email Subject</span>
                  {renderResizeHandle('emailSubject', 'Email Subject')}
                </th>

                <th
                  style={{ width: `${columnWidths.emailBody}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Email Message">Email Message</span>
                  {renderResizeHandle('emailBody', 'Email Message')}
                </th>

                <th
                  style={{ width: `${columnWidths.inAppExperience}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="In-App Experience">In-App Experience</span>
                  {renderResizeHandle('inAppExperience', 'In-App Experience')}
                </th>

                <th
                  style={{ width: `${columnWidths.cta}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Call to Action">CTA</span>
                  {renderResizeHandle('cta', 'CTA')}
                </th>

                <th
                  style={{ width: `${columnWidths.status}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Production Status">Production Status</span>
                  {renderResizeHandle('status', 'Production Status')}
                </th>

                <th
                  style={{ width: `${columnWidths.clonedAt}px` }}
                  className="relative px-3 py-2.5 font-semibold text-xs tracking-normal border-r border-[#084222] whitespace-nowrap"
                >
                  <span className="truncate block" title="Cloned Date">Cloned Date</span>
                  {renderResizeHandle('clonedAt', 'Cloned Date')}
                </th>

                <th
                  style={{ width: `${columnWidths.action}px` }}
                  className="relative px-2 py-2.5 font-semibold text-xs tracking-normal text-center whitespace-nowrap"
                >
                  <span className="block" title="Actions">Actions</span>
                  {renderResizeHandle('action', 'Actions')}
                </th>
              </tr>
            </thead>

            {/* Table Body */}
            <tbody className="divide-y divide-[#E1E4E8] bg-white">
              {filteredNotifications.length === 0 ? (
                <tr>
                  <td colSpan={16} className="py-14 text-center text-[#6B778C]">
                    <p className="font-semibold text-sm">No production ready notifications yet</p>
                    <p className="text-xs text-slate-400 mt-1 max-w-md mx-auto">
                      {searchQuery || selectedEngine !== 'ALL' || statusFilter !== 'ALL'
                        ? 'No notifications match your current filter criteria.'
                        : 'Go to the Scenarios tab and click the + icon on any row to clone it into Production Ready.'}
                    </p>
                    {onSwitchToScenarios && (
                      <button
                        type="button"
                        onClick={onSwitchToScenarios}
                        className="mt-3 px-3 py-1.5 bg-[#DEEBFF] hover:bg-[#B3D4FF] text-[#0052CC] font-semibold text-xs rounded transition cursor-pointer"
                      >
                        Go to All Scenarios
                      </button>
                    )}
                  </td>
                </tr>
              ) : (
                filteredNotifications.map((row, idx) => {
                const rowNumber = idx + 1
                const isSelected = selectedRowIds.has(row.id)

                return (
                  <tr
                    key={row.id}
                    className={`group transition-colors ${
                      isSelected
                        ? 'bg-blue-50/70 hover:bg-blue-100/60'
                        : idx % 2 === 0
                        ? 'bg-white hover:bg-slate-50/80'
                        : 'bg-[#FAFBFC] hover:bg-slate-50/80'
                    }`}
                  >
                    {/* Index */}
                    <td
                      style={{
                        width: `${columnWidths.index}px`,
                        minWidth: `${columnWidths.index}px`,
                        maxWidth: `${columnWidths.index}px`,
                      }}
                      className="px-2 py-2 font-mono text-[11px] text-center text-slate-500 border-r border-[#E1E4E8] bg-inherit sticky left-0 z-10 shadow-[1px_0_0_0_#E1E4E8]"
                    >
                      {rowNumber}
                    </td>

                    {/* Key */}
                    <td className="px-3 py-2 font-mono font-semibold text-[11px] text-[#0052CC] border-r border-[#E1E4E8] whitespace-nowrap overflow-hidden">
                      <button
                        type="button"
                        onClick={() => setDetailItem({ scenario: row, rowNumber })}
                        className="hover:underline cursor-pointer"
                        title={`View details for ${row.key}`}
                      >
                        {row.key}
                      </button>
                    </td>

                    {/* Engine */}
                    <td className="px-2.5 py-2 border-r border-[#E1E4E8] whitespace-nowrap overflow-hidden">
                      <span
                        className={`inline-block px-2 py-0.5 text-[10px] font-bold rounded-[3px] border ${getEngineBadgeColor(
                          row.engineCategory
                        )}`}
                      >
                        {row.engineCategory}
                      </span>
                    </td>

                    {/* Event */}
                    <td className="px-3 py-2 font-medium text-slate-900 border-r border-[#E1E4E8] truncate">
                      <span title={row.governanceEvent}>{row.governanceEvent || '—'}</span>
                    </td>

                    {/* Trigger */}
                    <td className="px-3 py-2 text-slate-700 border-r border-[#E1E4E8] truncate">
                      <span title={row.trigger}>{row.trigger || '—'}</span>
                    </td>

                    {/* Audience */}
                    <td className="px-3 py-2 text-slate-700 border-r border-[#E1E4E8] truncate">
                      <span title={row.audience}>{row.audience || '—'}</span>
                    </td>

                    {/* Objective */}
                    <td className="px-3 py-2 text-slate-600 border-r border-[#E1E4E8] truncate">
                      <span title={row.communicationObjective}>{row.communicationObjective || '—'}</span>
                    </td>

                    {/* Push Subject */}
                    <td className="px-3 py-2 text-slate-800 border-r border-[#E1E4E8] truncate">
                      <span title={row.pushSubject}>{row.pushSubject || '—'}</span>
                    </td>

                    {/* Push Body */}
                    <td className="px-3 py-2 text-slate-600 border-r border-[#E1E4E8] truncate">
                      <span title={row.pushBody}>{row.pushBody || '—'}</span>
                    </td>

                    {/* Email Subject */}
                    <td className="px-3 py-2 text-slate-800 border-r border-[#E1E4E8] truncate">
                      <span title={row.emailSubject}>{row.emailSubject || '—'}</span>
                    </td>

                    {/* Email Body */}
                    <td className="px-3 py-2 text-slate-600 border-r border-[#E1E4E8] truncate">
                      <span title={row.emailBody}>{row.emailBody || '—'}</span>
                    </td>

                    {/* In-App Experience */}
                    <td className="px-3 py-2 text-slate-600 border-r border-[#E1E4E8] truncate">
                      <span title={row.inAppExperience}>{row.inAppExperience || '—'}</span>
                    </td>

                    {/* CTA */}
                    <td className="px-3 py-2 text-slate-600 border-r border-[#E1E4E8] truncate">
                      <span title={row.cta}>{row.cta || '—'}</span>
                    </td>

                    {/* Production Status (Dropdown inline) */}
                    <td className="px-2.5 py-1.5 border-r border-[#E1E4E8] whitespace-nowrap overflow-hidden">
                      <select
                        value={row.status || 'READY FOR PROD'}
                        onChange={(e) => {
                          const newStatus = e.target.value
                          onUpdateProductionNotification({
                            ...row,
                            status: newStatus,
                          })
                          onShowToast?.(`Updated ${row.key} status to ${newStatus}`)
                        }}
                        className="text-[11px] font-semibold py-1 px-2 rounded-[3px] focus:outline-none cursor-pointer"
                        style={getStatusStyle(row.status || 'READY FOR PROD')}
                      >
                        {PROD_STATUS_OPTIONS.map((st) => (
                          <option key={st} value={st}>
                            {st}
                          </option>
                        ))}
                      </select>
                    </td>

                    {/* Cloned At */}
                    <td className="px-3 py-2 font-mono text-[10px] text-slate-500 border-r border-[#E1E4E8] whitespace-nowrap">
                      {row.clonedAt ? new Date(row.clonedAt).toLocaleDateString() : '—'}
                    </td>

                    {/* Actions */}
                    <td className="px-2 py-2 text-center whitespace-nowrap overflow-hidden">
                      <div className="flex items-center justify-center gap-1">
                        <button
                          type="button"
                          onClick={() => setDetailItem({ scenario: row, rowNumber })}
                          className="p-1 text-slate-400 hover:text-[#0052CC] hover:bg-blue-50 rounded transition cursor-pointer"
                          title={`View details #${rowNumber} (${row.key})`}
                          aria-label="View details"
                        >
                          <Eye className="w-3.5 h-3.5" />
                        </button>

                        <button
                          type="button"
                          onClick={() => setSelectedRuleItem({ scenario: row, rowNumber })}
                          className="p-1 text-slate-400 hover:text-[#0052CC] hover:bg-blue-50 rounded transition cursor-pointer"
                          title="View notification rule book"
                          aria-label="View rule book"
                        >
                          <BookOpen className="w-3.5 h-3.5" />
                        </button>

                        <button
                          type="button"
                          onClick={() => handleCopyRow(row)}
                          className="p-1 text-slate-400 hover:text-[#0052CC] rounded transition cursor-pointer"
                          title={`Copy JSON payload (${row.key})`}
                        >
                          {copiedId === row.id ? (
                            <Check className="w-3.5 h-3.5 text-emerald-600" />
                          ) : (
                            <Copy className="w-3.5 h-3.5" />
                          )}
                        </button>

                        <button
                          type="button"
                          onClick={() => {
                            if (window.confirm(`Remove ${row.key} from Production Ready?`)) {
                              onDeleteProductionNotification(row.id)
                              onShowToast?.(`Removed ${row.key} from Production Ready`)
                            }
                          }}
                          className="p-1 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded transition cursor-pointer"
                          title={`Remove ${row.key} from Production Ready`}
                          aria-label="Delete"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    </td>
                  </tr>
                )
              }))}
            </tbody>
          </table>
        </div>

      {/* Detail Modal */}
      {detailItem && (
        <JiraDetailModal
          isOpen={true}
          scenario={detailItem.scenario}
          rowNumber={detailItem.rowNumber}
          onClose={() => setDetailItem(null)}
          onUpdateStatus={(st: ScenarioStatus) => {
            onUpdateProductionNotification({
              ...detailItem.scenario,
              status: st,
            } as ProductionNotification)
          }}
          onUpdateScenario={(updated: NotificationScenario) => {
            onUpdateProductionNotification(updated as ProductionNotification)
            setDetailItem((prev) =>
              prev ? { ...prev, scenario: updated } : null
            )
          }}
          onDeleteScenario={(id: string) => {
            onDeleteProductionNotification(id)
            onShowToast?.(`Removed ${detailItem.scenario.key} from Production Ready`)
          }}
          onOpenRuleBook={(scen: NotificationScenario) => {
            setSelectedRuleItem({ scenario: scen, rowNumber: detailItem.rowNumber })
          }}
        />
      )}

      {/* Rule Book Modal */}
      {selectedRuleItem && (
        <NotificationRuleModal
          isOpen={true}
          onClose={() => setSelectedRuleItem(null)}
          scenario={selectedRuleItem.scenario}
        />
      )}

      {/* Activity Log Modal */}
      {showActivityLog && (
        <ProductionActivityLogModal onClose={() => setShowActivityLog(false)} />
      )}
    </div>
  )
}
