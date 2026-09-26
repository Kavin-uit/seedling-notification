import React, { useState, useEffect, useMemo } from 'react'
import { createPortal } from 'react-dom'
import type { NotificationScenario, NotificationRule } from '../../types/notification'
import { rulesApi, RULE_BOOK_SHEET_URL } from '../../api/rulesApi'
import {
  X,
  ExternalLink,
  Copy,
  Check,
  ChevronLeft,
  ChevronRight,
  ChevronUp,
  ChevronDown,
  FileSpreadsheet,
  ArrowRight,
  Bookmark,
} from 'lucide-react'

export interface NotificationRuleModalProps {
  scenario?: NotificationScenario | null
  rule?: NotificationRule | null
  mappedScenario?: NotificationScenario | null
  rowNumber?: number
  isOpen: boolean
  onClose: () => void
  onNavigatePrev?: () => void
  onNavigateNext?: () => void
  hasPrev?: boolean
  hasNext?: boolean
  onJumpToScenario?: (scenario: NotificationScenario) => void
}

// Authentic Atlassian Design System Jira lozenges
const ENGINE_LOZENGES: Record<string, { bg: string; text: string }> = {
  Governance: { bg: 'bg-[#E3FCEF]', text: 'text-[#006644]' },
  Contribution: { bg: 'bg-[#DEEBFF]', text: 'text-[#0747A6]' },
  Participation: { bg: 'bg-[#EAE6FF]', text: 'text-[#403294]' },
  Identity: { bg: 'bg-[#FFF0B3]', text: 'text-[#172B4D]' },
  Opportunity: { bg: 'bg-[#E6FCFF]', text: 'text-[#0065FF]' },
  Discovery: { bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]' },
  Campaign: { bg: 'bg-[#DEEBFF]', text: 'text-[#0052CC]' },
  Narrative: { bg: 'bg-[#E3FCEF]', text: 'text-[#00875A]' },
}

function renderJiraPriority(priority?: string) {
  const p = (priority || 'Medium').toLowerCase()
  if (p.includes('highest')) {
    return (
      <span className="inline-flex items-center gap-1.5 text-xs text-[#172B4D] font-normal">
        <ChevronUp className="w-3.5 h-3.5 text-[#DE350B] stroke-[2.5]" />
        <span>Highest</span>
      </span>
    )
  }
  if (p.includes('high')) {
    return (
      <span className="inline-flex items-center gap-1.5 text-xs text-[#172B4D] font-normal">
        <ChevronUp className="w-3.5 h-3.5 text-[#FF5630] stroke-[2.5]" />
        <span>High</span>
      </span>
    )
  }
  if (p.includes('low')) {
    return (
      <span className="inline-flex items-center gap-1.5 text-xs text-[#172B4D] font-normal">
        <ChevronDown className="w-3.5 h-3.5 text-[#006644] stroke-[2.5]" />
        <span>Low</span>
      </span>
    )
  }
  return (
    <span className="inline-flex items-center gap-1.5 text-xs text-[#172B4D] font-normal">
      <span className="text-[#FFAB00] font-bold text-xs leading-none">＝</span>
      <span>Medium</span>
    </span>
  )
}

export const NotificationRuleModal: React.FC<NotificationRuleModalProps> = ({
  scenario,
  rule: directRule,
  mappedScenario: directMappedScenario,
  rowNumber,
  isOpen,
  onClose,
  onNavigatePrev,
  onNavigateNext,
  hasPrev = false,
  hasNext = false,
  onJumpToScenario,
}) => {
  const [copiedField, setCopiedField] = useState<string | null>(null)
  const [activeTab, setActiveTab] = useState<'delivery' | 'audience' | 'decision' | 'specs'>('delivery')

  const rule: NotificationRule | undefined = useMemo(() => {
    if (directRule) return directRule
    if (scenario?.rule) return scenario.rule
    if (scenario) return rulesApi.getRuleForScenario(scenario)
    return undefined
  }, [directRule, scenario])

  const mappedScenario = useMemo(() => {
    if (directMappedScenario) return directMappedScenario
    if (scenario) return scenario
    return undefined
  }, [directMappedScenario, scenario])

  useEffect(() => {
    if (!isOpen) return
    const originalOverflow = document.body.style.overflow
    const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth
    if (scrollbarWidth > 0) {
      document.body.style.paddingRight = `${scrollbarWidth}px`
    }
    document.body.style.overflow = 'hidden'

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose()
      } else if (e.key === 'ArrowLeft' && hasPrev && onNavigatePrev) {
        onNavigatePrev()
      } else if (e.key === 'ArrowRight' && hasNext && onNavigateNext) {
        onNavigateNext()
      }
    }
    window.addEventListener('keydown', handleKeyDown)

    return () => {
      document.body.style.overflow = originalOverflow
      document.body.style.paddingRight = ''
      window.removeEventListener('keydown', handleKeyDown)
    }
  }, [isOpen, hasPrev, hasNext, onNavigatePrev, onNavigateNext, onClose])

  const copyToClipboard = (text: string, label: string) => {
    navigator.clipboard.writeText(text).then(() => {
      setCopiedField(label)
      setTimeout(() => setCopiedField(null), 2000)
    })
  }

  if (!isOpen || (!scenario && !rule)) return null

  const engineName = rule?.engine || scenario?.engineCategory || 'Identity'
  const ruleTitle = rule?.ruleName || scenario?.governanceEvent || 'Notification Rule'
  const ruleIdText = rule?.ruleId || scenario?.ruleId || 'CI-RULE'
  const scenarioKey = mappedScenario?.key || scenario?.key

  const engineLozenge = ENGINE_LOZENGES[engineName] || {
    bg: 'bg-[#EBECF0]',
    text: 'text-[#42526E]',
  }

  return createPortal(
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="jira-rule-modal-title"
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-900/40 backdrop-blur-xs transition-opacity duration-150 font-sans"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-[4px] shadow-[0_12px_32px_-4px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] w-full max-w-[980px] max-h-[92vh] flex flex-col overflow-hidden text-[#172B4D]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Authentic Jira Issue Header */}
        <div className="px-5 py-3.5 border-b border-[#EBECF0] bg-white flex flex-wrap items-center justify-between gap-3 shrink-0">
          <div className="min-w-0 flex-1">
            {/* Breadcrumb row: Engine / Rule ID / Mapped Scenario */}
            <div className="flex items-center gap-1.5 text-xs text-[#5E6C84]">
              <Bookmark className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
              <span className="font-semibold text-[#172B4D]">Rule Book</span>
              <span>/</span>
              <span className="text-[#0052CC] font-medium">{engineName} Engine</span>
              <span>/</span>
              <span className="font-mono text-[#172B4D] font-bold">{ruleIdText}</span>
              {rowNumber && (
                <>
                  <span className="text-[#A5ADBA]">•</span>
                  <span className="text-[#6B778C]">Row #{rowNumber}</span>
                </>
              )}
              {scenarioKey && (
                <>
                  <span className="text-[#A5ADBA]">•</span>
                  <span className="inline-flex items-center gap-1 text-[11px] font-medium text-[#0052CC] bg-[#DEEBFF] px-1.5 py-0.2 rounded">
                    Mapped: {scenarioKey}
                  </span>
                </>
              )}
            </div>

            {/* Issue Title & Lozenges */}
            <div className="flex items-center gap-2.5 flex-wrap mt-1.5">
              <h1
                id="jira-rule-modal-title"
                className="text-lg font-semibold text-[#172B4D] tracking-tight truncate max-w-full"
                title={ruleTitle}
              >
                {ruleTitle}
              </h1>
              <span
                className={`inline-flex items-center px-1.5 py-0.5 rounded-[3px] text-[11px] font-bold uppercase tracking-wide ${engineLozenge.bg} ${engineLozenge.text}`}
              >
                {engineName}
              </span>
              {rule?.channelTier && (
                <span className="inline-flex items-center px-1.5 py-0.5 rounded-[3px] text-[11px] font-semibold bg-[#E3FCEF] text-[#006644]">
                  {rule.channelTier}
                </span>
              )}
              {mappedScenario && onJumpToScenario && (
                <button
                  type="button"
                  onClick={() => {
                    onClose()
                    onJumpToScenario(mappedScenario)
                  }}
                  className="cursor-pointer inline-flex items-center gap-1 px-2 py-0.5 rounded-[3px] text-[11px] font-medium text-[#0052CC] bg-[#DEEBFF] hover:bg-[#B3D4FF] transition"
                  title={`Open QA test scenario ${mappedScenario.key}`}
                >
                  <span>Open {mappedScenario.key} in QA</span>
                  <ArrowRight className="w-3 h-3" />
                </button>
              )}
            </div>
          </div>

          {/* Quick Actions & Navigation */}
          <div className="flex items-center gap-1.5 shrink-0 ml-auto">
            <a
              href={RULE_BOOK_SHEET_URL}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-medium text-[#42526E] hover:text-[#172B4D] bg-white hover:bg-[#F4F5F7] border border-[#DFE1E6] rounded-[3px] transition-colors"
              title="Open Master Rule Book in Google Sheets"
            >
              <FileSpreadsheet className="w-3.5 h-3.5 text-[#0052CC]" />
              <span className="hidden sm:inline">Google Sheet</span>
              <ExternalLink className="w-3 h-3 text-[#6B778C]" />
            </a>

            {onNavigatePrev && (
              <button
                type="button"
                onClick={onNavigatePrev}
                disabled={!hasPrev}
                className="w-7 h-7 rounded-[3px] border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] disabled:opacity-30 disabled:hover:bg-white transition cursor-pointer disabled:cursor-not-allowed"
                title="Previous rule (← Arrow)"
                aria-label="Previous rule"
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
            )}
            {onNavigateNext && (
              <button
                type="button"
                onClick={onNavigateNext}
                disabled={!hasNext}
                className="w-7 h-7 rounded-[3px] border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] disabled:opacity-30 disabled:hover:bg-white transition cursor-pointer disabled:cursor-not-allowed"
                title="Next rule (→ Arrow)"
                aria-label="Next rule"
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              className="w-7 h-7 rounded-[3px] border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] transition cursor-pointer ml-0.5"
              title="Close (Esc)"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Authentic Jira Issue Tabs */}
        <div className="shrink-0 px-5 border-b border-[#EBECF0] bg-white flex gap-6 text-xs font-medium">
          <button
            type="button"
            onClick={() => setActiveTab('delivery')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'delivery'
                ? 'border-[#0052CC] text-[#0052CC] font-semibold'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Delivery & channels
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('audience')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'audience'
                ? 'border-[#0052CC] text-[#0052CC] font-semibold'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Trigger & audience
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('decision')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'decision'
                ? 'border-[#0052CC] text-[#0052CC] font-semibold'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Decision policy
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('specs')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'specs'
                ? 'border-[#0052CC] text-[#0052CC] font-semibold'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Technical specifications
          </button>
        </div>

        {/* Modal Main Body: Classic Jira 2-Column Split */}
        <div className="flex-1 overflow-y-auto p-5 bg-[#FAFBFC]">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-5 items-start">
            {/* Left Content Area (7 Cols) */}
            <div className="lg:col-span-7 space-y-4">
              {activeTab === 'delivery' && (
                <div className="space-y-4">
                  {/* Email Delivery Policy */}
                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Email delivery policy
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 text-xs text-[#172B4D] leading-relaxed">
                      {rule?.emailDeliveryPolicy ||
                        'Standard delivery policy applies. Direct notification sent based on user preference and channel tier.'}
                    </div>
                  </div>

                  {/* Channels and Delivery */}
                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Channels and delivery
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3">
                      <div className="grid grid-cols-2 gap-3.5 text-xs">
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Delivery mode</span>
                          <span className="text-[#172B4D] font-normal">{rule?.delivery || 'In-App + Push'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Channel tier</span>
                          <span className="text-[#172B4D] font-normal">{rule?.channelTier || 'Tier 1 - Guaranteed'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Cooldown period</span>
                          <span className="text-[#172B4D] font-normal">{rule?.cooldown || 'None'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Suppression rule</span>
                          <span className="text-[#172B4D] font-normal">{rule?.suppression || 'None'}</span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Notification Message Copy (From Mapped Scenario if available) */}
                  {mappedScenario && (mappedScenario.pushSubject || mappedScenario.emailSubject) ? (
                    <div>
                      <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                        Active QA scenario copy ({mappedScenario.key})
                      </h3>
                      <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 space-y-3">
                        {mappedScenario.pushSubject && (
                          <div>
                            <span className="text-[#6B778C] block text-[11px] mb-1 font-medium">Push notification</span>
                            <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded-[3px] p-2.5 text-xs text-[#172B4D]">
                              <div className="font-medium text-[#172B4D]">{mappedScenario.pushSubject}</div>
                              {mappedScenario.pushBody && <div className="text-[#5E6C84] mt-1">{mappedScenario.pushBody}</div>}
                            </div>
                          </div>
                        )}
                        {mappedScenario.emailSubject && (
                          <div>
                            <span className="text-[#6B778C] block text-[11px] mb-1 font-medium">Email notification</span>
                            <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded-[3px] p-2.5 text-xs text-[#172B4D]">
                              <div className="font-medium text-[#172B4D]">{mappedScenario.emailSubject}</div>
                              {mappedScenario.emailBody && <div className="text-[#5E6C84] mt-1">{mappedScenario.emailBody}</div>}
                            </div>
                          </div>
                        )}
                      </div>
                    </div>
                  ) : (
                    <div>
                      <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                        Notification template mapping
                      </h3>
                      <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 text-xs text-[#5E6C84] leading-relaxed">
                        Template specification is registered under <span className="font-mono text-[#0052CC] font-medium">{rule?.templateId || `TPL-${ruleIdText}`}</span>. This rule governs messaging triggers, frequency caps, and channel routing for {engineName} engine.
                      </div>
                    </div>
                  )}
                </div>
              )}

              {activeTab === 'audience' && (
                <div className="space-y-4">
                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Trigger and audience
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 space-y-3 text-xs">
                      <div>
                        <span className="text-[#6B778C] block text-[11px] mb-0.5">Trigger event</span>
                        <div className="text-[#172B4D] font-normal">
                          {rule?.trigger || scenario?.trigger || 'Event-triggered'}
                        </div>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block text-[11px] mb-0.5">Target audience</span>
                        <div className="text-[#172B4D] font-normal">
                          {rule?.audience || scenario?.audience || 'All users'}
                        </div>
                      </div>
                      {rule?.candidateAudiences && (
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Candidate audiences</span>
                          <div className="text-[#172B4D] font-normal">
                            {rule.candidateAudiences}
                          </div>
                        </div>
                      )}
                    </div>
                  </div>

                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Communication objectives
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 space-y-3 text-xs">
                      <div>
                        <span className="text-[#6B778C] block text-[11px] mb-0.5">Objective</span>
                        <p className="text-[#172B4D] leading-relaxed font-normal">
                          {rule?.communicationObjective || scenario?.communicationObjective || 'Inform user'}
                        </p>
                      </div>
                      {scenario?.desiredOutcome && (
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Desired outcome</span>
                          <p className="text-[#172B4D] leading-relaxed font-normal">
                            {scenario.desiredOutcome}
                          </p>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              )}

              {activeTab === 'decision' && (
                <div className="space-y-4">
                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Decision policy
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 text-xs text-[#172B4D] leading-relaxed">
                      {rule?.defaultDecisionReason ||
                        'Standard decision policy evaluates queue priority against active user engagement window.'}
                    </div>
                  </div>

                  {rule?.decisionReasonTemplate && (
                    <div>
                      <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                        Decision reason template
                      </h3>
                      <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 text-xs text-[#172B4D] leading-relaxed">
                        {rule.decisionReasonTemplate}
                      </div>
                    </div>
                  )}

                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Attention and timing
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3">
                      <div className="grid grid-cols-2 gap-3.5 text-xs">
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Attention class</span>
                          <span className="text-[#172B4D] font-normal">{rule?.attentionClass || 'Reflective'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Candidate score</span>
                          <span className="text-[#172B4D] font-normal">{rule?.candidateScore || '50'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Attention queue group</span>
                          <span className="text-[#172B4D] font-normal">{rule?.attentionQueueGroup || 'Standard Queue'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Rotation group</span>
                          <span className="text-[#172B4D] font-normal">{rule?.rotationGroup || 'None'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Timing</span>
                          <span className="text-[#172B4D] font-normal">{rule?.timing || 'Immediate on event'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Merge policy</span>
                          <span className="text-[#172B4D] font-normal">{rule?.mergePolicy || 'None'}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {activeTab === 'specs' && (
                <div className="space-y-4">
                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Runtime memory dependency
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 text-xs font-mono text-[#172B4D] whitespace-pre-wrap">
                      {rule?.runtimeMemoryDependency || 'None (stateless trigger)'}
                    </div>
                  </div>

                  <div>
                    <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                      Technical attributes
                    </h3>
                    <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3">
                      <div className="grid grid-cols-2 gap-3.5 text-xs">
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Memory keys</span>
                          <span className="font-mono text-[11px] text-[#172B4D]">{rule?.memoryKeys || 'N/A'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Experience type</span>
                          <span className="text-[#172B4D] font-normal">{rule?.experienceType || 'Standard'}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Template ID</span>
                          <span className="font-mono text-[11px] text-[#0052CC]">{rule?.templateId || `TPL-${ruleIdText}`}</span>
                        </div>
                        <div>
                          <span className="text-[#6B778C] block text-[11px] mb-0.5">Source workbook</span>
                          <span className="text-[#5E6C84] truncate block" title={rule?.sourceWorkbook}>
                            {rule?.sourceWorkbook || 'Seedling_Messaging.xlsx'}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {rule?.changeNotes && (
                    <div>
                      <h3 className="text-xs font-semibold text-[#172B4D] mb-1.5">
                        Revision notes
                      </h3>
                      <div className="bg-white border border-[#DFE1E6] rounded-[3px] p-3 text-xs text-[#5E6C84] leading-relaxed">
                        {rule.changeNotes}
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>

            {/* Right Side: Standard Jira "Details" Panel (5 Cols) */}
            <div className="lg:col-span-5 bg-white border border-[#DFE1E6] rounded-[3px] p-3.5 space-y-3">
              <h3 className="text-xs font-semibold text-[#172B4D] pb-2 border-b border-[#EBECF0]">
                Details
              </h3>

              <div className="space-y-2 text-xs">
                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Rule ID</span>
                  <div className="flex items-center gap-1 font-mono text-[#172B4D]">
                    <span className="font-bold">{ruleIdText}</span>
                    <button
                      type="button"
                      onClick={() => copyToClipboard(ruleIdText, 'ruleId')}
                      className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded cursor-pointer"
                      title="Copy Rule ID"
                    >
                      {copiedField === 'ruleId' ? (
                        <Check className="w-3.5 h-3.5 text-[#006644]" />
                      ) : (
                        <Copy className="w-3.5 h-3.5" />
                      )}
                    </button>
                  </div>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Engine</span>
                  <span className="text-[#172B4D] font-medium">{engineName}</span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Priority</span>
                  <div>{renderJiraPriority(rule?.priority || scenario?.priority)}</div>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Channel tier</span>
                  <span className="text-[#172B4D] font-normal">{rule?.channelTier || 'Tier 1 - Guaranteed'}</span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Cooldown</span>
                  <span className="text-[#172B4D] font-normal">{rule?.cooldown || 'None'}</span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Guaranteed experience</span>
                  <span className="text-[#172B4D] font-normal">
                    {rule?.guaranteedExperience || 'No'}
                  </span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Batch eligible</span>
                  <span className="text-[#172B4D] font-normal">
                    {rule?.batchEligible || 'No'}
                  </span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Candidate score</span>
                  <span className="font-mono text-[#172B4D] font-normal">{rule?.candidateScore || '50'}</span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Attention class</span>
                  <span className="text-[#172B4D] font-normal">{rule?.attentionClass || 'Reflective'}</span>
                </div>

                <div className="flex items-center justify-between gap-2 py-0.5">
                  <span className="text-[#6B778C] font-normal">Template ID</span>
                  <span className="font-mono text-[11px] text-[#0052CC]">{rule?.templateId || `TPL-${ruleIdText}`}</span>
                </div>

                {scenarioKey && (
                  <div className="flex items-center justify-between gap-2 py-0.5">
                    <span className="text-[#6B778C] font-normal">Mapped scenario</span>
                    <span className="font-mono text-[11px] text-[#0052CC] font-bold">{scenarioKey}</span>
                  </div>
                )}

                <div className="flex items-center justify-between gap-2 border-t border-[#EBECF0] pt-2 mt-1">
                  <span className="text-[#6B778C] font-normal">Source sheet</span>
                  <a
                    href={RULE_BOOK_SHEET_URL}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-[#0052CC] hover:underline flex items-center gap-1 text-xs"
                  >
                    <span>Google Sheets</span>
                    <ExternalLink className="w-3 h-3 text-[#6B778C]" />
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Authentic Jira Modal Footer */}
        <div className="shrink-0 px-5 py-3 border-t border-[#EBECF0] bg-white flex items-center justify-end text-xs">
          <button
            type="button"
            onClick={onClose}
            className="px-3.5 py-1.5 rounded-[3px] bg-[#0052CC] hover:bg-[#0065FF] active:bg-[#0747A6] text-white font-medium transition-colors cursor-pointer"
          >
            Close
          </button>
        </div>
      </div>
    </div>,
    document.body
  )
}
