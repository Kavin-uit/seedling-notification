import React, { useState, useMemo, useRef, useEffect } from 'react'
import type { NotificationRule, NotificationScenario } from '../../types/notification'
import { ALL_NOTIFICATION_RULES, RULE_BOOK_SHEET_URL, SCENARIO_ID_TO_RULE_ID, getRuleForScenario } from '../../data/notificationRules'
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
  Download,
  RotateCcw,
} from 'lucide-react'

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
  const [mappingFilter, setMappingFilter] = useState<'ALL' | 'MAPPED' | 'UNMAPPED'>('ALL')
  const [pageSize, setPageSize] = useState<number>(100)
  const [currentPage, setCurrentPage] = useState<number>(1)
  const [selectedRowId, setSelectedRowId] = useState<string | null>(null)

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

    // Mapping Filter
    if (mappingFilter === 'MAPPED') {
      list = list.filter((r) => ruleToScenarioMap.has(r.ruleId.trim().toUpperCase()))
    } else if (mappingFilter === 'UNMAPPED') {
      list = list.filter((r) => !ruleToScenarioMap.has(r.ruleId.trim().toUpperCase()))
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
  }, [selectedEngine, tierFilter, mappingFilter, searchQuery, ruleToScenarioMap])

  // Reset pagination when filters change
  useEffect(() => {
    setCurrentPage(1)
  }, [selectedEngine, tierFilter, mappingFilter, searchQuery, pageSize])

  // Paginated slice
  const paginatedRules = useMemo(() => {
    if (pageSize === 0) return filteredRules
    const start = (currentPage - 1) * pageSize
    return filteredRules.slice(start, start + pageSize)
  }, [filteredRules, currentPage, pageSize])

  const totalPages = pageSize === 0 ? 1 : Math.ceil(filteredRules.length / pageSize)

  // Export filtered rules to CSV
  const handleExportCsv = () => {
    const headers = [
      'Rule ID',
      'Engine',
      'Rule Name',
      'Mapped Scenario',
      'Trigger',
      'Audience',
      'Communication Objective',
      'Priority',
      'Channel Tier',
      'Delivery Mode',
      'Cooldown',
      'Suppression',
      'Attention Class',
      'Score',
      'Template ID',
    ]

    const rows = filteredRules.map((r) => {
      const mapped = ruleToScenarioMap.get(r.ruleId.trim().toUpperCase())
      return [
        `"${r.ruleId}"`,
        `"${r.engine}"`,
        `"${r.ruleName.replace(/"/g, '""')}"`,
        `"${mapped ? mapped.key : 'Unmapped'}"`,
        `"${r.trigger.replace(/"/g, '""')}"`,
        `"${r.audience.replace(/"/g, '""')}"`,
        `"${r.communicationObjective.replace(/"/g, '""')}"`,
        `"${r.priority}"`,
        `"${r.channelTier}"`,
        `"${r.delivery.replace(/"/g, '""')}"`,
        `"${r.cooldown}"`,
        `"${r.suppression.replace(/"/g, '""')}"`,
        `"${r.attentionClass}"`,
        `"${r.candidateScore}"`,
        `"${r.templateId}"`,
      ].join(',')
    })

    const csvContent = 'data:text/csv;charset=utf-8,' + [headers.join(','), ...rows].join('\n')
    const encodedUri = encodeURI(csvContent)
    const link = document.createElement('a')
    link.setAttribute('href', encodedUri)
    link.setAttribute(
      'download',
      `Seedling_Master_RuleBook_${selectedEngine === 'ALL' ? 'AllEngines' : selectedEngine}_${filteredRules.length}_rules.csv`
    )
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    if (onShowToast) onShowToast(`Exported ${filteredRules.length} rules to CSV`)
  }

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

      {/* 2. Excel Ribbon / Toolbar: AutoFilter Controls & Actions */}
      <div className="bg-[#F8F9FA] border-b border-[#D1D5DB] px-3 py-1.5 shrink-0 flex flex-wrap items-center justify-between gap-2 text-xs">
        {/* Left Side: Excel Formula / Search & Filters */}
        <div className="flex items-center gap-2 flex-1 max-w-2xl min-w-0">
          {/* Search box styled like Excel Find / Cell Search */}
          <div className="relative flex items-center flex-1 min-w-[200px]">
            <Search className="w-3.5 h-3.5 text-slate-400 absolute left-2 pointer-events-none shrink-0" />
            <input
              type="text"
              autoComplete="off"
              spellCheck="false"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Filter rules by ID, trigger, audience, objective..."
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

          {/* Mapping AutoFilter */}
          <div className="flex items-center gap-1 shrink-0">
            <span className="text-[11px] text-slate-500 font-medium">Mapping:</span>
            <select
              value={mappingFilter}
              onChange={(e) => setMappingFilter(e.target.value as any)}
              className="h-7 bg-white border border-[#CBD5E1] rounded-[2px] px-2 text-xs text-slate-800 outline-none focus:border-[#107C41] cursor-pointer"
              title="Filter QA Scenario Mapping"
            >
              <option value="ALL">All Rules (409)</option>
              <option value="MAPPED">Mapped to QA ({ruleToScenarioMap.size})</option>
              <option value="UNMAPPED">Specification Only</option>
            </select>
          </div>

          {(searchQuery || tierFilter !== 'ALL' || mappingFilter !== 'ALL') && (
            <button
              type="button"
              onClick={() => {
                setSearchQuery('')
                setTierFilter('ALL')
                setMappingFilter('ALL')
              }}
              className="cursor-pointer text-[11px] text-[#107C41] hover:underline flex items-center gap-0.5 shrink-0 font-medium"
            >
              <RotateCcw className="w-3 h-3" />
              <span>Clear filters</span>
            </button>
          )}
        </div>

        {/* Right Side: Excel Actions & Summary */}
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

          {/* Export to Excel CSV */}
          <button
            type="button"
            onClick={handleExportCsv}
            className="cursor-pointer h-7 px-2.5 rounded-[2px] bg-white hover:bg-slate-50 border border-[#CBD5E1] text-[#107C41] font-semibold text-xs flex items-center gap-1.5 transition shadow-2xs"
            title="Export filtered rules to Excel CSV"
          >
            <Download className="w-3.5 h-3.5 text-[#107C41]" />
            <span>Export .xlsx</span>
          </button>

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

      {/* 3. Main Spreadsheet Table Grid: Classic Microsoft Excel Style */}
      <div className="flex-1 overflow-auto bg-white relative">
        <table className="w-full border-collapse text-left text-xs min-w-[1400px]">
          {/* Classic Excel Dark Forest Green Table Header */}
          <thead className="sticky top-0 bg-[#107C41] text-white z-20 border-b border-[#0D6535] shadow-xs select-none">
            <tr className="border-b border-[#0D6535] text-[11px] font-semibold">
              <th className="w-12 px-2 py-2 text-center border-r border-[#0D6535] bg-[#0E6C38]">
                #
              </th>
              <th className="w-28 px-2.5 py-2 border-r border-[#0D6535]">
                Rule ID
              </th>
              <th className="w-28 px-2.5 py-2 border-r border-[#0D6535]">
                Engine
              </th>
              <th className="w-60 px-2.5 py-2 border-r border-[#0D6535]">
                Rule / Message Name
              </th>
              <th className="w-36 px-2.5 py-2 border-r border-[#0D6535]">
                Mapped Scenario
              </th>
              <th className="w-44 px-2.5 py-2 border-r border-[#0D6535]">
                Trigger
              </th>
              <th className="w-32 px-2.5 py-2 border-r border-[#0D6535]">
                Audience
              </th>
              <th className="w-64 px-2.5 py-2 border-r border-[#0D6535]">
                Communication Objective
              </th>
              <th className="w-24 px-2.5 py-2 border-r border-[#0D6535]">
                Priority
              </th>
              <th className="w-36 px-2.5 py-2 border-r border-[#0D6535]">
                Channel Tier
              </th>
              <th className="w-40 px-2.5 py-2 border-r border-[#0D6535]">
                Delivery Mode
              </th>
              <th className="w-28 px-2.5 py-2 border-r border-[#0D6535]">
                Attention
              </th>
              <th className="w-20 px-2.5 py-2 text-center border-r border-[#0D6535]">
                Score
              </th>
              <th className="w-20 px-2.5 py-2 text-center">
                Action
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
                    className={`transition-colors cursor-pointer select-none text-[12px] ${
                      isSelected
                        ? 'bg-[#E8F5E9]'
                        : idx % 2 === 0
                        ? 'bg-white hover:bg-[#F0FDF4]'
                        : 'bg-[#F9FAFB] hover:bg-[#F0FDF4]'
                    }`}
                  >
                    {/* Row Header (#) - Excel gray gutter */}
                    <td className="px-2 py-1.5 text-center text-slate-500 font-mono text-[11px] font-medium border-r border-b border-[#E5E7EB] bg-[#F9FAFB] select-none">
                      {globalIndex}
                    </td>

                    {/* Rule ID */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] font-mono text-[11px] font-semibold text-slate-900">
                      <div className="flex items-center justify-between gap-1 group">
                        <span className="hover:text-[#107C41]">{rule.ruleId}</span>
                        <button
                          type="button"
                          onClick={(e) => handleCopyId(rule.ruleId, e)}
                          title={`Copy ${rule.ruleId}`}
                          className="opacity-0 group-hover:opacity-100 p-0.5 rounded hover:bg-slate-200 text-slate-400 hover:text-slate-700 transition"
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
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] font-medium text-slate-800">
                      {rule.engine}
                    </td>

                    {/* Rule / Message Name */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] font-medium text-slate-900">
                      <span className="truncate block" title={rule.ruleName}>
                        {rule.ruleName}
                      </span>
                    </td>

                    {/* Mapped QA Scenario */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB]">
                      {mappedScenario ? (
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation()
                            if (onJumpToScenario) onJumpToScenario(mappedScenario)
                          }}
                          className="cursor-pointer font-mono font-bold text-[11px] text-[#0052CC] hover:text-[#0747A6] hover:underline flex items-center gap-1 transition"
                          title={`Mapped to QA test scenario ${mappedScenario.key} (${mappedScenario.engineCategory}). Click to open.`}
                        >
                          <span>{mappedScenario.key}</span>
                          <ArrowRight className="w-3 h-3" />
                        </button>
                      ) : (
                        <span className="text-slate-400 font-mono text-[11px]">
                          —
                        </span>
                      )}
                    </td>

                    {/* Trigger */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700">
                      <span className="truncate block" title={rule.trigger}>
                        {rule.trigger || '—'}
                      </span>
                    </td>

                    {/* Audience */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700">
                      <span className="truncate block" title={rule.audience}>
                        {rule.audience || 'All users'}
                      </span>
                    </td>

                    {/* Communication Objective */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700">
                      <span className="truncate block" title={rule.communicationObjective}>
                        {rule.communicationObjective || '—'}
                      </span>
                    </td>

                    {/* Priority */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB]">
                      {renderExcelPriority(rule.priority)}
                    </td>

                    {/* Channel Tier */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700 text-[11px]">
                      <span className="truncate block" title={rule.channelTier}>
                        {rule.channelTier || 'Tier 1'}
                      </span>
                    </td>

                    {/* Delivery Mode */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-700 text-[11px]">
                      <span className="truncate block" title={rule.delivery}>
                        {rule.delivery || 'In-App + Push'}
                      </span>
                    </td>

                    {/* Attention Class */}
                    <td className="px-2.5 py-1.5 border-r border-b border-[#E5E7EB] text-slate-600 text-[11px]">
                      <span className="truncate block font-mono" title={rule.attentionClass}>
                        {rule.attentionClass || 'Reflective'}
                      </span>
                    </td>

                    {/* Candidate Score */}
                    <td className="px-2.5 py-1.5 text-center border-r border-b border-[#E5E7EB] font-mono text-[11px] text-slate-800 font-medium">
                      {rule.candidateScore || '50'}
                    </td>

                    {/* Action: Inspect */}
                    <td className="px-2 py-1 text-center border-b border-[#E5E7EB]">
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
          <span>{filteredRules.length} rows loaded</span>
          <span className="text-slate-300">|</span>
          <span className="text-slate-500">Double-click any row to inspect specifications</span>
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
