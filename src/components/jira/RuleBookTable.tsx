import React, { useState, useMemo, useRef, useEffect } from 'react'
import type { NotificationRule, NotificationScenario } from '../../types/notification'
import { ALL_NOTIFICATION_RULES, RULE_BOOK_SHEET_URL, SCENARIO_ID_TO_RULE_ID, getRuleForScenario } from '../../data/notificationRules'
import { NotificationRuleModal } from './NotificationRuleModal'
import {
  Search,
  X,
  FileSpreadsheet,
  ExternalLink,
  BookOpen,
  Copy,
  Check,
  ChevronUp,
  ChevronDown,
  ArrowRight,
  Download,
  Info,
} from 'lucide-react'

interface RuleBookTableProps {
  scenarios: NotificationScenario[]
  initialEngineFilter?: string
  initialSearchQuery?: string
  onJumpToScenario?: (scenario: NotificationScenario) => void
  onShowToast?: (msg: string) => void
}

// Authentic Jira priority renderer
function renderJiraPriority(priority?: string) {
  const p = (priority || 'Medium').toLowerCase()
  if (p.includes('highest')) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-[#172B4D] font-medium" title="Highest priority">
        <ChevronUp className="w-3.5 h-3.5 text-[#DE350B] stroke-[2.5]" />
        <span>Highest</span>
      </span>
    )
  }
  if (p.includes('high')) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-[#172B4D] font-medium" title="High priority">
        <ChevronUp className="w-3.5 h-3.5 text-[#FF5630] stroke-[2.5]" />
        <span>High</span>
      </span>
    )
  }
  if (p.includes('low')) {
    return (
      <span className="inline-flex items-center gap-1 text-[11px] text-[#172B4D] font-medium" title="Low priority">
        <ChevronDown className="w-3.5 h-3.5 text-[#006644] stroke-[2.5]" />
        <span>Low</span>
      </span>
    )
  }
  return (
    <span className="inline-flex items-center gap-1 text-[11px] text-[#172B4D] font-medium" title="Medium priority">
      <span className="text-[#FFAB00] font-bold text-xs leading-none">＝</span>
      <span>Medium</span>
    </span>
  )
}

// Authentic Atlassian Design System lozenges
const ENGINE_LOZENGES: Record<string, { bg: string; text: string; border: string }> = {
  Opportunity: { bg: 'bg-[#E6FCFF]', text: 'text-[#0065FF]', border: 'border-[#B3F5FF]' },
  Identity: { bg: 'bg-[#FFF0B3]', text: 'text-[#172B4D]', border: 'border-[#FFE380]' },
  Participation: { bg: 'bg-[#EAE6FF]', text: 'text-[#403294]', border: 'border-[#C0B6F2]' },
  Discovery: { bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]', border: 'border-[#FFBDAD]' },
  Contribution: { bg: 'bg-[#DEEBFF]', text: 'text-[#0747A6]', border: 'border-[#B3D4FF]' },
  Campaign: { bg: 'bg-[#E3FCEF]', text: 'text-[#006644]', border: 'border-[#ABF5D1]' },
  Narrative: { bg: 'bg-[#EAE6FF]', text: 'text-[#5243AA]', border: 'border-[#DFD8FD]' },
  Governance: { bg: 'bg-[#E3FCEF]', text: 'text-[#006644]', border: 'border-[#ABF5D1]' },
}

function getTierLozenge(tier?: string) {
  const t = (tier || '').toLowerCase()
  if (t.includes('tier 1') || t.includes('urgent')) {
    return { bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]', border: 'border-[#FFBDAD]' }
  }
  if (t.includes('tier 2') || t.includes('timely')) {
    return { bg: 'bg-[#FFF0B3]', text: 'text-[#172B4D]', border: 'border-[#FFE380]' }
  }
  return { bg: 'bg-[#E3FCEF]', text: 'text-[#006644]', border: 'border-[#ABF5D1]' }
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
      if (onShowToast) onShowToast(`Copied Rule ID "${id}" to clipboard`)
    })
  }

  // Precompute reverse scenario mapping: ruleId -> NotificationScenario
  const ruleToScenarioMap = useMemo(() => {
    const map = new Map<string, NotificationScenario>()
    scenarios.forEach((s) => {
      // 1. Direct ruleId
      if (s.ruleId) {
        map.set(s.ruleId.trim().toUpperCase(), s)
      }
      // 2. Map table
      if (s.id && SCENARIO_ID_TO_RULE_ID[s.id]) {
        map.set(SCENARIO_ID_TO_RULE_ID[s.id].trim().toUpperCase(), s)
      }
      // 3. Normalized heuristic lookup
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
    return Object.keys(engineCounts).sort((a, b) => (engineCounts[b] || 0) - (engineCounts[a] || 0))
  }, [engineCounts])

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
      {/* Top Banner: Master Rule Book Title & Direct Sheet Link */}
      <div className="border-b border-[#EBECF0] bg-[#FAFBFC] px-4 py-2.5 shrink-0 flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-2.5 min-w-0">
          <div className="w-8 h-8 rounded-[3px] bg-[#0747A6] flex items-center justify-center text-white shrink-0 shadow-xs">
            <BookOpen className="w-4 h-4" />
          </div>
          <div>
            <div className="flex items-center gap-2 flex-wrap">
              <h1 className="text-sm font-bold text-[#172B4D] tracking-tight">
                Master Notification Rule Book
              </h1>
              <span className="text-[11px] font-semibold px-2 py-0.2 rounded-full bg-[#EAE6FF] text-[#403294] border border-[#C0B6F2]">
                409 Rules Across 8 Engines
              </span>
              <span className="text-[11px] font-semibold px-2 py-0.2 rounded-full bg-[#E3FCEF] text-[#006644] border border-[#ABF5D1]">
                {ruleToScenarioMap.size} Active QA Mappings
              </span>
            </div>
            <p className="text-xs text-[#5E6C84] mt-0.5">
              Engine rule specification and mapping catalog for all notifications. Rule Book governs logic, channel tiering, triggers, and cooldowns.
            </p>
          </div>
        </div>

        <div className="flex items-center gap-2 shrink-0">
          <button
            type="button"
            onClick={handleExportCsv}
            className="cursor-pointer h-7.5 px-2.5 rounded-[3px] bg-white hover:bg-[#F4F5F7] border border-[#DFE1E6] text-[#42526E] text-xs font-medium flex items-center gap-1.5 transition"
            title="Export filtered rules to CSV"
          >
            <Download className="w-3.5 h-3.5 text-[#5E6C84]" />
            <span className="hidden sm:inline">Export CSV</span>
          </button>
          <a
            href={RULE_BOOK_SHEET_URL}
            target="_blank"
            rel="noopener noreferrer"
            className="cursor-pointer h-7.5 px-2.5 rounded-[3px] bg-emerald-700 hover:bg-emerald-600 text-white text-xs font-semibold flex items-center gap-1.5 transition shadow-2xs"
            title="Open official Google Sheet in new tab"
          >
            <FileSpreadsheet className="w-3.5 h-3.5" />
            <span>Google Sheet</span>
            <ExternalLink className="w-3 h-3 opacity-80" />
          </a>
        </div>
      </div>

      {/* Engine Category Filter Tabs */}
      <div className="border-b border-[#EBECF0] bg-white px-4 py-2 shrink-0 flex items-center gap-1.5 overflow-x-auto no-scrollbar">
        <button
          type="button"
          onClick={() => setSelectedEngine('ALL')}
          className={`cursor-pointer px-2.5 py-1 rounded-[3px] text-xs font-semibold shrink-0 transition flex items-center gap-1.5 ${
            selectedEngine === 'ALL'
              ? 'bg-[#0052CC] text-white'
              : 'text-[#42526E] hover:bg-[#F4F5F7] hover:text-[#172B4D]'
          }`}
        >
          <span>All Engines</span>
          <span
            className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
              selectedEngine === 'ALL' ? 'bg-white/25 text-white' : 'bg-[#DFE1E6] text-[#42526E]'
            }`}
          >
            409
          </span>
        </button>

        {engineList.map((eng) => {
          const isSelected = selectedEngine === eng
          const count = engineCounts[eng] || 0
          const style = ENGINE_LOZENGES[eng] || { bg: 'bg-[#EBECF0]', text: 'text-[#42526E]', border: 'border-[#DFE1E6]' }

          return (
            <button
              key={eng}
              type="button"
              onClick={() => setSelectedEngine(eng)}
              className={`cursor-pointer px-2.5 py-1 rounded-[3px] text-xs font-medium shrink-0 transition flex items-center gap-1.5 ${
                isSelected
                  ? 'bg-[#0052CC] text-white font-semibold'
                  : 'text-[#42526E] hover:bg-[#F4F5F7] hover:text-[#172B4D]'
              }`}
            >
              <span>{eng}</span>
              <span
                className={`text-[10px] px-1.5 py-0.2 rounded-full font-bold ${
                  isSelected ? 'bg-white/25 text-white' : `${style.bg} ${style.text}`
                }`}
              >
                {count}
              </span>
            </button>
          )
        })}
      </div>

      {/* Filter and Search Bar */}
      <div className="border-b border-[#EBECF0] bg-[#FAFBFC] px-4 py-2 shrink-0 flex flex-wrap items-center justify-between gap-2.5 text-xs">
        <div className="flex items-center gap-2 flex-1 max-w-xl min-w-0">
          <div className="relative flex items-center flex-1 min-w-0">
            <Search className="w-3.5 h-3.5 text-[#6B778C] absolute left-2.5 pointer-events-none shrink-0" />
            <input
              type="text"
              autoComplete="off"
              spellCheck="false"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Filter rules by ID, name, trigger, audience, objective, tier..."
              className="w-full h-7.5 bg-white text-[#172B4D] placeholder:text-[#6B778C] text-xs rounded-[3px] pl-8 pr-7 transition outline-none border border-[#DFE1E6] focus:border-[#4C9AFF] focus:ring-1 focus:ring-[#4C9AFF]"
            />
            {searchQuery && (
              <button
                type="button"
                onClick={() => setSearchQuery('')}
                className="absolute right-1.5 p-1 rounded-full text-[#6B778C] hover:text-[#172B4D] hover:bg-slate-100 transition cursor-pointer"
                title="Clear search"
              >
                <X className="w-3 h-3 stroke-[2.5]" />
              </button>
            )}
          </div>

          {/* Tier Filter */}
          <select
            value={tierFilter}
            onChange={(e) => setTierFilter(e.target.value)}
            className="h-7.5 bg-white border border-[#DFE1E6] rounded-[3px] px-2 text-xs text-[#172B4D] outline-none focus:border-[#4C9AFF] cursor-pointer"
            title="Filter by Channel Tier"
          >
            <option value="ALL">All Tiers</option>
            <option value="Tier 1">Tier 1 - Urgent / Guaranteed</option>
            <option value="Tier 2">Tier 2 - Timely</option>
            <option value="Tier 3">Tier 3 - Ambient / Digest</option>
          </select>

          {/* Mapping Filter */}
          <select
            value={mappingFilter}
            onChange={(e) => setMappingFilter(e.target.value as any)}
            className="h-7.5 bg-white border border-[#DFE1E6] rounded-[3px] px-2 text-xs text-[#172B4D] outline-none focus:border-[#4C9AFF] cursor-pointer"
            title="Filter by QA Scenario Mapping"
          >
            <option value="ALL">All Rules (409)</option>
            <option value="MAPPED">Mapped to QA Scenarios ({ruleToScenarioMap.size})</option>
            <option value="UNMAPPED">Specification Only</option>
          </select>
        </div>

        <div className="flex items-center gap-2 text-xs text-[#5E6C84] shrink-0">
          <span>
            Showing <strong className="text-[#172B4D]">{filteredRules.length}</strong> of{' '}
            <strong className="text-[#172B4D]">{ALL_NOTIFICATION_RULES.length}</strong> rules
          </span>

          {/* Page size picker */}
          <select
            value={pageSize}
            onChange={(e) => setPageSize(parseInt(e.target.value, 10))}
            className="h-7 bg-white border border-[#DFE1E6] rounded-[3px] px-1.5 text-xs text-[#172B4D] outline-none cursor-pointer"
            title="Rows per page"
          >
            <option value={50}>50 per page</option>
            <option value={100}>100 per page</option>
            <option value={200}>200 per page</option>
            <option value={0}>Show all (409)</option>
          </select>

          {/* Simple pagination controls */}
          {pageSize > 0 && totalPages > 1 && (
            <div className="flex items-center gap-1 ml-1">
              <button
                type="button"
                disabled={currentPage <= 1}
                onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
                className="cursor-pointer px-2 py-0.5 rounded-[3px] bg-white border border-[#DFE1E6] disabled:opacity-40 disabled:cursor-not-allowed hover:bg-[#F4F5F7]"
              >
                ‹ Prev
              </button>
              <span className="text-[11px] font-semibold text-[#172B4D]">
                {currentPage} / {totalPages}
              </span>
              <button
                type="button"
                disabled={currentPage >= totalPages}
                onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
                className="cursor-pointer px-2 py-0.5 rounded-[3px] bg-white border border-[#DFE1E6] disabled:opacity-40 disabled:cursor-not-allowed hover:bg-[#F4F5F7]"
              >
                Next ›
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Main Table Grid */}
      <div className="flex-1 overflow-auto bg-white relative">
        <table className="w-full border-collapse text-left text-xs min-w-[1300px]">
          {/* Table Header: Pure Jira Style */}
          <thead className="sticky top-0 bg-[#F4F5F7] z-20 border-b border-[#DFE1E6] shadow-2xs select-none">
            <tr className="text-[#5E6C84] font-semibold text-[11px] tracking-wide uppercase">
              <th className="w-12 px-3 py-2.5 text-center border-r border-[#DFE1E6]">#</th>
              <th className="w-28 px-3 py-2.5 border-r border-[#DFE1E6]">Rule ID</th>
              <th className="w-28 px-3 py-2.5 border-r border-[#DFE1E6]">Engine</th>
              <th className="w-56 px-3 py-2.5 border-r border-[#DFE1E6]">Rule / Message Name</th>
              <th className="w-36 px-3 py-2.5 border-r border-[#DFE1E6]">Mapped QA Scenario</th>
              <th className="w-44 px-3 py-2.5 border-r border-[#DFE1E6]">Trigger</th>
              <th className="w-32 px-3 py-2.5 border-r border-[#DFE1E6]">Audience</th>
              <th className="w-64 px-3 py-2.5 border-r border-[#DFE1E6]">Communication Objective</th>
              <th className="w-24 px-3 py-2.5 border-r border-[#DFE1E6]">Priority</th>
              <th className="w-36 px-3 py-2.5 border-r border-[#DFE1E6]">Channel Tier</th>
              <th className="w-44 px-3 py-2.5 border-r border-[#DFE1E6]">Delivery Mode</th>
              <th className="w-28 px-3 py-2.5 border-r border-[#DFE1E6]">Attention</th>
              <th className="w-18 px-3 py-2.5 text-center border-r border-[#DFE1E6]">Score</th>
              <th className="w-24 px-3 py-2.5 text-center">Actions</th>
            </tr>
          </thead>

          {/* Table Body */}
          <tbody className="divide-y divide-[#EBECF0]">
            {paginatedRules.length === 0 ? (
              <tr>
                <td colSpan={14} className="text-center py-16 text-[#6B778C]">
                  <div className="flex flex-col items-center gap-2">
                    <Info className="w-6 h-6 text-[#A5ADBA]" />
                    <p className="font-semibold text-[#172B4D]">No notification rules match the current filters.</p>
                    <p className="text-xs text-[#5E6C84]">Try clearing your search query or selecting a different engine.</p>
                    <button
                      type="button"
                      onClick={() => {
                        setSelectedEngine('ALL')
                        setSearchQuery('')
                        setTierFilter('ALL')
                        setMappingFilter('ALL')
                      }}
                      className="cursor-pointer mt-2 px-3 py-1 bg-[#0052CC] text-white rounded-[3px] text-xs font-semibold hover:bg-[#0065FF]"
                    >
                      Reset All Filters
                    </button>
                  </div>
                </td>
              </tr>
            ) : (
              paginatedRules.map((rule, idx) => {
                const globalIndex = (currentPage - 1) * pageSize + idx + 1
                const mappedScenario = ruleToScenarioMap.get(rule.ruleId.trim().toUpperCase())
                const engineStyle = ENGINE_LOZENGES[rule.engine] || {
                  bg: 'bg-[#EBECF0]',
                  text: 'text-[#42526E]',
                  border: 'border-[#DFE1E6]',
                }
                const tierStyle = getTierLozenge(rule.channelTier)

                return (
                  <tr
                    key={rule.ruleId}
                    onClick={() => setInspectedRule({ rule, rowNumber: globalIndex })}
                    className="hover:bg-[#F4F5F7] transition cursor-pointer group border-b border-[#EBECF0]"
                  >
                    {/* Index */}
                    <td className="px-3 py-2 text-center text-[#5E6C84] font-mono text-[11px] border-r border-[#EBECF0]">
                      {globalIndex}
                    </td>

                    {/* Rule ID with copy icon */}
                    <td className="px-3 py-2 border-r border-[#EBECF0]">
                      <div className="flex items-center gap-1 font-mono text-[11px] text-[#0052CC] font-semibold">
                        <span>{rule.ruleId}</span>
                        <button
                          type="button"
                          onClick={(e) => handleCopyId(rule.ruleId, e)}
                          title={`Copy ${rule.ruleId}`}
                          className="opacity-0 group-hover:opacity-100 p-0.5 rounded hover:bg-[#DEEBFF] text-[#6B778C] hover:text-[#0052CC] transition cursor-pointer"
                        >
                          {copiedId === rule.ruleId ? (
                            <Check className="w-3 h-3 text-emerald-600 stroke-[2.5]" />
                          ) : (
                            <Copy className="w-3 h-3" />
                          )}
                        </button>
                      </div>
                    </td>

                    {/* Real Engine */}
                    <td className="px-3 py-2 border-r border-[#EBECF0]">
                      <span
                        className={`inline-flex items-center px-1.5 py-0.5 rounded-[3px] text-[10px] font-bold uppercase tracking-wide border ${engineStyle.bg} ${engineStyle.text} ${engineStyle.border}`}
                      >
                        {rule.engine}
                      </span>
                    </td>

                    {/* Rule / Notification Name */}
                    <td className="px-3 py-2 border-r border-[#EBECF0]">
                      <span className="font-semibold text-[#172B4D] group-hover:text-[#0052CC] transition line-clamp-2">
                        {rule.ruleName}
                      </span>
                    </td>

                    {/* Mapped QA Scenario */}
                    <td className="px-3 py-2 border-r border-[#EBECF0]">
                      {mappedScenario ? (
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation()
                            if (onJumpToScenario) onJumpToScenario(mappedScenario)
                          }}
                          className="cursor-pointer inline-flex items-center gap-1 px-2 py-0.5 rounded-[3px] text-[11px] font-bold text-[#0052CC] bg-[#DEEBFF] hover:bg-[#B3D4FF] border border-[#B3D4FF] transition"
                          title={`Mapped to QA test scenario ${mappedScenario.key} (${mappedScenario.engineCategory}). Click to jump to test execution.`}
                        >
                          <span>{mappedScenario.key}</span>
                          <ArrowRight className="w-3 h-3" />
                        </button>
                      ) : (
                        <span className="inline-flex items-center text-[11px] text-[#6B778C] px-1.5 py-0.2 rounded bg-[#EBECF0]">
                          Specification
                        </span>
                      )}
                    </td>

                    {/* Trigger */}
                    <td className="px-3 py-2 border-r border-[#EBECF0] text-[#172B4D] text-[11px]">
                      <span className="line-clamp-2" title={rule.trigger}>
                        {rule.trigger || '—'}
                      </span>
                    </td>

                    {/* Audience */}
                    <td className="px-3 py-2 border-r border-[#EBECF0] text-[#42526E] text-[11px]">
                      <span className="truncate block" title={rule.audience}>
                        {rule.audience || 'All users'}
                      </span>
                    </td>

                    {/* Communication Objective */}
                    <td className="px-3 py-2 border-r border-[#EBECF0] text-[#172B4D] text-[11px]">
                      <span className="line-clamp-2 leading-relaxed" title={rule.communicationObjective}>
                        {rule.communicationObjective || '—'}
                      </span>
                    </td>

                    {/* Priority */}
                    <td className="px-3 py-2 border-r border-[#EBECF0]">
                      {renderJiraPriority(rule.priority)}
                    </td>

                    {/* Channel Tier */}
                    <td className="px-3 py-2 border-r border-[#EBECF0]">
                      <span
                        className={`inline-flex items-center px-1.5 py-0.5 rounded-[3px] text-[10px] font-semibold border ${tierStyle.bg} ${tierStyle.text} ${tierStyle.border}`}
                      >
                        {rule.channelTier || 'Tier 1'}
                      </span>
                    </td>

                    {/* Delivery Mode */}
                    <td className="px-3 py-2 border-r border-[#EBECF0] text-[#42526E] text-[11px]">
                      <span className="line-clamp-2" title={rule.delivery}>
                        {rule.delivery || 'In-App + Push'}
                      </span>
                    </td>

                    {/* Attention Class */}
                    <td className="px-3 py-2 border-r border-[#EBECF0] text-[#42526E] text-[11px]">
                      <span className="truncate block font-mono text-[10px]" title={rule.attentionClass}>
                        {rule.attentionClass || 'Reflective'}
                      </span>
                    </td>

                    {/* Candidate Score */}
                    <td className="px-3 py-2 text-center border-r border-[#EBECF0] font-mono text-[11px] text-[#172B4D] font-medium">
                      {rule.candidateScore || '50'}
                    </td>

                    {/* Action: Open Rule Specification Modal */}
                    <td className="px-3 py-2 text-center">
                      <button
                        type="button"
                        onClick={(e) => {
                          e.stopPropagation()
                          setInspectedRule({ rule, rowNumber: globalIndex })
                        }}
                        className="cursor-pointer inline-flex items-center gap-1 px-2 py-1 rounded-[3px] bg-white hover:bg-[#F4F5F7] border border-[#DFE1E6] text-[#0052CC] hover:text-[#0747A6] text-[11px] font-semibold transition"
                        title="View all 30 rule parameters & specifications"
                      >
                        <BookOpen className="w-3 h-3" />
                        <span>Inspect</span>
                      </button>
                    </td>
                  </tr>
                )
              })
            )}
          </tbody>
        </table>
      </div>

      {/* Footer Navigation Bar */}
      <div className="border-t border-[#EBECF0] bg-[#FAFBFC] px-4 py-2 shrink-0 flex items-center justify-between text-xs text-[#5E6C84]">
        <div className="flex items-center gap-2">
          <span>
            Rule Book: <strong className="text-[#172B4D]">{filteredRules.length}</strong> rules displayed
          </span>
          <span className="text-[#DFE1E6]">|</span>
          <span>Click any row or &ldquo;Inspect&rdquo; to view complete specifications</span>
        </div>

        {pageSize > 0 && totalPages > 1 && (
          <div className="flex items-center gap-1.5">
            <span className="text-[11px]">
              Page {currentPage} of {totalPages}
            </span>
            <button
              type="button"
              disabled={currentPage <= 1}
              onClick={() => setCurrentPage(1)}
              className="px-2 py-0.5 rounded-[3px] bg-white border border-[#DFE1E6] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-[#F4F5F7]"
              title="First Page"
            >
              «
            </button>
            <button
              type="button"
              disabled={currentPage <= 1}
              onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
              className="px-2 py-0.5 rounded-[3px] bg-white border border-[#DFE1E6] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-[#F4F5F7]"
              title="Previous Page"
            >
              ‹
            </button>
            <button
              type="button"
              disabled={currentPage >= totalPages}
              onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
              className="px-2 py-0.5 rounded-[3px] bg-white border border-[#DFE1E6] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-[#F4F5F7]"
              title="Next Page"
            >
              ›
            </button>
            <button
              type="button"
              disabled={currentPage >= totalPages}
              onClick={() => setCurrentPage(totalPages)}
              className="px-2 py-0.5 rounded-[3px] bg-white border border-[#DFE1E6] disabled:opacity-30 cursor-pointer disabled:cursor-not-allowed hover:bg-[#F4F5F7]"
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
