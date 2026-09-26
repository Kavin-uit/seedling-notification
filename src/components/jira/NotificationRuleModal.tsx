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
  FileSpreadsheet,
} from 'lucide-react'

interface NotificationRuleModalProps {
  scenario: NotificationScenario | null
  rowNumber?: number
  isOpen: boolean
  onClose: () => void
  onNavigatePrev?: () => void
  onNavigateNext?: () => void
  hasPrev?: boolean
  hasNext?: boolean
}

// Authentic Atlassian Design System lozenges
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

export const NotificationRuleModal: React.FC<NotificationRuleModalProps> = ({
  scenario,
  rowNumber,
  isOpen,
  onClose,
  onNavigatePrev,
  onNavigateNext,
  hasPrev = false,
  hasNext = false,
}) => {
  const [copiedField, setCopiedField] = useState<string | null>(null)
  const [activeTab, setActiveTab] = useState<'delivery' | 'audience' | 'decision' | 'specs'>('delivery')

  const rule: NotificationRule | undefined = useMemo(() => {
    if (!scenario) return undefined
    if (scenario.rule) return scenario.rule
    return rulesApi.getRuleForScenario(scenario)
  }, [scenario])

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

  if (!isOpen || !scenario) return null

  const engineLozenge = ENGINE_LOZENGES[scenario.engineCategory] || {
    bg: 'bg-[#DFE1E6]',
    text: 'text-[#42526E]',
  }

  return createPortal(
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="jira-rule-modal-title"
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-900/40 backdrop-blur-xs transition-opacity duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-xl shadow-[0_20px_60px_-15px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] w-full max-w-[980px] max-h-[92vh] flex flex-col overflow-hidden text-[#172B4D]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Authentic Jira Header */}
        <div className="px-5 py-3.5 border-b border-[#EBECF0] bg-white flex flex-wrap items-center justify-between gap-3 shrink-0">
          <div className="min-w-0 flex-1">
            {/* Breadcrumb row */}
            <div className="flex items-center gap-2 text-xs text-[#5E6C84]">
              <span className="font-semibold text-[#0052CC] hover:underline cursor-pointer">
                {scenario.key}
              </span>
              <span>/</span>
              <span className="font-mono text-[#172B4D] font-medium">
                {rule?.ruleId || 'RULE'}
              </span>
              {rowNumber && (
                <>
                  <span>•</span>
                  <span>Row #{rowNumber}</span>
                </>
              )}
            </div>

            {/* Title & Lozenges */}
            <div className="flex items-center gap-2.5 flex-wrap mt-1">
              <h2
                id="jira-rule-modal-title"
                className="text-base sm:text-lg font-bold text-[#172B4D] tracking-tight truncate"
                title={scenario.governanceEvent}
              >
                {scenario.governanceEvent}
              </h2>
              <span
                className={`inline-flex items-center px-1.5 py-0.5 rounded-[3px] text-[11px] font-bold uppercase tracking-wide ${engineLozenge.bg} ${engineLozenge.text}`}
              >
                {scenario.engineCategory}
              </span>
              {rule?.channelTier && (
                <span className="inline-flex items-center px-1.5 py-0.5 rounded-[3px] text-[11px] font-semibold bg-[#E3FCEF] text-[#006644]">
                  {rule.channelTier}
                </span>
              )}
            </div>
          </div>

          {/* Quick Actions & Navigation */}
          <div className="flex items-center gap-1.5 shrink-0 ml-auto">
            <a
              href={RULE_BOOK_SHEET_URL}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-semibold text-[#0052CC] bg-[#F4F5F7] hover:bg-[#EBECF0] border border-[#DFE1E6] rounded-[3px] transition-colors"
              title="Open Rule Book in Google Sheets"
            >
              <FileSpreadsheet className="w-3.5 h-3.5 text-[#0052CC]" />
              <span className="hidden sm:inline">Google Sheet</span>
              <ExternalLink className="w-3 h-3 text-[#5E6C84]" />
            </a>

            {onNavigatePrev && (
              <button
                type="button"
                onClick={onNavigatePrev}
                disabled={!hasPrev}
                className="w-7 h-7 rounded border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] disabled:opacity-25 disabled:hover:bg-white transition cursor-pointer disabled:cursor-not-allowed shadow-2xs"
                title="Previous scenario (← Arrow)"
                aria-label="Previous scenario"
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
            )}
            {onNavigateNext && (
              <button
                type="button"
                onClick={onNavigateNext}
                disabled={!hasNext}
                className="w-7 h-7 rounded border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] disabled:opacity-25 disabled:hover:bg-white transition cursor-pointer disabled:cursor-not-allowed shadow-2xs"
                title="Next scenario (→ Arrow)"
                aria-label="Next scenario"
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              className="w-7 h-7 rounded border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] transition cursor-pointer ml-0.5 shadow-2xs"
              title="Close (Esc)"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Authentic Jira Tabs */}
        <div className="shrink-0 px-5 border-b border-[#EBECF0] bg-white flex gap-6 text-xs font-semibold">
          <button
            type="button"
            onClick={() => setActiveTab('delivery')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'delivery'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Delivery & Channels
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('audience')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'audience'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Trigger & Audience
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('decision')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'decision'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Decision & Attention Engine
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('specs')}
            className={`py-2.5 border-b-2 transition cursor-pointer ${
              activeTab === 'specs'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#5E6C84] hover:text-[#172B4D]'
            }`}
          >
            Runtime Memory & Specs
          </button>
        </div>

        {/* Modal Main Body: Classic Jira 2-Column Split */}
        <div className="flex-1 overflow-y-auto p-5 bg-[#FAFBFC]">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
            {/* Left Content Area (7 Cols) */}
            <div className="lg:col-span-7 space-y-4">
              {activeTab === 'delivery' && (
                <div className="space-y-4">
                  {/* Email Delivery Policy Box - Classic Jira Info Panel */}
                  <div>
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider mb-1.5">
                      Email Delivery Policy
                    </h3>
                    <div className="bg-[#DEEBFF] border-l-4 border-[#0052CC] p-3 rounded-r text-xs text-[#0747A6] leading-relaxed">
                      {rule?.emailDeliveryPolicy ||
                        'Standard delivery policy applies. Direct notification sent based on user preference and channel tier.'}
                    </div>
                  </div>

                  {/* Delivery Methods Card */}
                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-3">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Channels & Delivery
                    </h3>
                    <div className="grid grid-cols-2 gap-3 text-xs">
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Delivery Mode</span>
                        <span className="font-medium text-[#172B4D]">{rule?.delivery || 'In-App + Push'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Channel Tier</span>
                        <span className="font-medium text-[#006644]">{rule?.channelTier || 'Tier 1 - Guaranteed'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Cooldown Period</span>
                        <span className="font-medium text-[#172B4D]">{rule?.cooldown || 'None'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Suppression Rule</span>
                        <span className="font-medium text-[#172B4D]">{rule?.suppression || 'None'}</span>
                      </div>
                    </div>
                  </div>

                  {/* Notification Copy Previews from Database */}
                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-2.5">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Database Message Copy
                    </h3>
                    {scenario.pushSubject && (
                      <div className="text-xs">
                        <span className="text-[#6B778C] block mb-0.5 font-medium">Push Notification</span>
                        <div className="bg-[#F4F5F7] p-2 rounded text-[#172B4D] border border-[#EBECF0]">
                          <div className="font-semibold">{scenario.pushSubject}</div>
                          {scenario.pushBody && <div className="text-[#5E6C84] mt-0.5">{scenario.pushBody}</div>}
                        </div>
                      </div>
                    )}
                    {scenario.emailSubject && (
                      <div className="text-xs">
                        <span className="text-[#6B778C] block mb-0.5 font-medium">Email Subject</span>
                        <div className="bg-[#F4F5F7] p-2 rounded text-[#172B4D] border border-[#EBECF0] font-semibold">
                          {scenario.emailSubject}
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              )}

              {activeTab === 'audience' && (
                <div className="space-y-4">
                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-3">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Audience & Trigger Rules
                    </h3>
                    <div className="space-y-2.5 text-xs">
                      <div>
                        <span className="text-[#6B778C] block mb-0.5 font-medium">Trigger Event</span>
                        <div className="p-2 bg-[#F4F5F7] rounded text-[#172B4D] border border-[#EBECF0]">
                          {rule?.trigger || scenario.trigger}
                        </div>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5 font-medium">Target Audience</span>
                        <div className="p-2 bg-[#F4F5F7] rounded text-[#172B4D] border border-[#EBECF0]">
                          {rule?.audience || scenario.audience}
                        </div>
                      </div>
                      {rule?.candidateAudiences && (
                        <div>
                          <span className="text-[#6B778C] block mb-0.5 font-medium">Candidate Audiences</span>
                          <div className="p-2 bg-[#F4F5F7] rounded text-[#172B4D] border border-[#EBECF0]">
                            {rule.candidateAudiences}
                          </div>
                        </div>
                      )}
                    </div>
                  </div>

                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-3">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Communication Objectives
                    </h3>
                    <div className="space-y-2 text-xs">
                      <div>
                        <span className="text-[#6B778C] block mb-0.5 font-medium">Objective</span>
                        <p className="text-[#172B4D] leading-relaxed">
                          {rule?.communicationObjective || scenario.communicationObjective}
                        </p>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5 font-medium">Desired Outcome</span>
                        <p className="text-[#172B4D] leading-relaxed">
                          {scenario.desiredOutcome || 'User engagement'}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {activeTab === 'decision' && (
                <div className="space-y-4">
                  {/* Default Decision Reason Panel */}
                  <div>
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider mb-1.5">
                      Decision Policy & Reason
                    </h3>
                    <div className="bg-[#FFF0B3] border-l-4 border-[#FFAB00] p-3 rounded-r text-xs text-[#172B4D] leading-relaxed">
                      {rule?.defaultDecisionReason ||
                        'Standard decision policy evaluates queue priority against active user engagement window.'}
                    </div>
                  </div>

                  {rule?.decisionReasonTemplate && (
                    <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-1.5">
                      <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                        Decision Reason Template
                      </h3>
                      <p className="text-xs text-[#172B4D] leading-relaxed bg-[#F4F5F7] p-2 rounded border border-[#EBECF0]">
                        {rule.decisionReasonTemplate}
                      </p>
                    </div>
                  )}

                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-3">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Attention & Timing
                    </h3>
                    <div className="grid grid-cols-2 gap-3 text-xs">
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Attention Class</span>
                        <span className="font-semibold text-[#0052CC]">{rule?.attentionClass || 'Reflective'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Candidate Score</span>
                        <span className="font-semibold text-[#172B4D]">{rule?.candidateScore || '50'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Queue Group</span>
                        <span className="font-medium text-[#172B4D]">{rule?.attentionQueueGroup || 'Standard Queue'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Rotation Group</span>
                        <span className="font-medium text-[#172B4D]">{rule?.rotationGroup || 'None'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Timing</span>
                        <span className="font-medium text-[#172B4D]">{rule?.timing || 'Immediate on event'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Merge Policy</span>
                        <span className="font-medium text-[#172B4D]">{rule?.mergePolicy || 'None'}</span>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {activeTab === 'specs' && (
                <div className="space-y-4">
                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-2">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Runtime Memory Dependency
                    </h3>
                    <div className="text-xs font-mono text-[#172B4D] bg-[#F4F5F7] p-2.5 rounded border border-[#EBECF0] whitespace-pre-wrap">
                      {rule?.runtimeMemoryDependency || 'None (stateless trigger)'}
                    </div>
                  </div>

                  <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-3">
                    <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Technical Attributes
                    </h3>
                    <div className="grid grid-cols-2 gap-3 text-xs">
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Memory Keys</span>
                        <span className="font-mono text-[11px] text-[#172B4D]">{rule?.memoryKeys || 'N/A'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Experience Type</span>
                        <span className="font-medium text-[#172B4D]">{rule?.experienceType || 'Standard'}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Template ID</span>
                        <span className="font-mono font-semibold text-[#0052CC]">{rule?.templateId || 'TPL-' + (rule?.ruleId || scenario.key)}</span>
                      </div>
                      <div>
                        <span className="text-[#6B778C] block mb-0.5">Source Workbook</span>
                        <span className="text-[#5E6C84] truncate block" title={rule?.sourceWorkbook}>
                          {rule?.sourceWorkbook || 'Seedling_Messaging.xlsx'}
                        </span>
                      </div>
                    </div>
                  </div>

                  {rule?.changeNotes && (
                    <div className="bg-white border border-[#DFE1E6] rounded p-3.5 space-y-1">
                      <h3 className="text-[11px] font-bold text-[#6B778C] uppercase tracking-wider">
                        Revision Notes
                      </h3>
                      <p className="text-xs text-[#5E6C84] leading-relaxed">{rule.changeNotes}</p>
                    </div>
                  )}
                </div>
              )}
            </div>

            {/* Right Side: Standard Jira "Details" Panel (5 Cols) */}
            <div className="lg:col-span-5 bg-white border border-[#DFE1E6] rounded p-4 space-y-3">
              <h3 className="text-xs font-bold text-[#172B4D] uppercase tracking-wide border-b border-[#EBECF0] pb-2">
                Rule Details
              </h3>

              <div className="space-y-2.5 text-xs">
                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Rule ID</span>
                  <div className="flex items-center gap-1 font-mono font-semibold text-[#172B4D]">
                    <span>{rule?.ruleId || 'N/A'}</span>
                    {rule?.ruleId && (
                      <button
                        type="button"
                        onClick={() => copyToClipboard(rule.ruleId, 'ruleId')}
                        className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded cursor-pointer"
                        title="Copy Rule ID"
                      >
                        {copiedField === 'ruleId' ? (
                          <Check className="w-3.5 h-3.5 text-[#006644]" />
                        ) : (
                          <Copy className="w-3.5 h-3.5" />
                        )}
                      </button>
                    )}
                  </div>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Engine</span>
                  <span className="font-medium text-[#172B4D]">{scenario.engineCategory}</span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Priority</span>
                  <span className="font-medium text-[#172B4D]">{rule?.priority || scenario.priority}</span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Channel Tier</span>
                  <span className="font-semibold text-[#006644]">{rule?.channelTier || 'Tier 1 - Guaranteed'}</span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Cooldown</span>
                  <span className="font-medium text-[#172B4D]">{rule?.cooldown || 'None'}</span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Guaranteed Experience</span>
                  <span
                    className={`px-1.5 py-0.5 rounded text-[11px] font-semibold ${
                      rule?.guaranteedExperience?.toLowerCase() === 'yes'
                        ? 'bg-[#E3FCEF] text-[#006644]'
                        : 'bg-[#DFE1E6] text-[#42526E]'
                    }`}
                  >
                    {rule?.guaranteedExperience || 'No'}
                  </span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Batch Eligible</span>
                  <span
                    className={`px-1.5 py-0.5 rounded text-[11px] font-semibold ${
                      rule?.batchEligible?.toLowerCase() === 'yes'
                        ? 'bg-[#EAE6FF] text-[#403294]'
                        : 'bg-[#DFE1E6] text-[#42526E]'
                    }`}
                  >
                    {rule?.batchEligible || 'No'}
                  </span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Candidate Score</span>
                  <span className="font-mono font-semibold text-[#172B4D]">{rule?.candidateScore || '50'}</span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Attention Class</span>
                  <span className="font-medium text-[#172B4D]">{rule?.attentionClass || 'Reflective'}</span>
                </div>

                <div className="flex items-center justify-between gap-2">
                  <span className="text-[#6B778C] font-medium">Template ID</span>
                  <span className="font-mono text-[11px] text-[#0052CC]">{rule?.templateId || 'N/A'}</span>
                </div>

                <div className="flex items-center justify-between gap-2 border-t border-[#EBECF0] pt-2">
                  <span className="text-[#6B778C] font-medium">Source Sheet</span>
                  <a
                    href={RULE_BOOK_SHEET_URL}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-[#0052CC] hover:underline flex items-center gap-1 text-xs"
                  >
                    <span>View in Sheets</span>
                    <ExternalLink className="w-3 h-3" />
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Authentic Jira Modal Footer */}
        <div className="shrink-0 px-5 py-3 border-t border-[#EBECF0] bg-[#FAFBFC] flex items-center justify-end text-xs">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 rounded-[3px] bg-[#0052CC] hover:bg-[#0065FF] text-white font-semibold transition cursor-pointer shadow-2xs"
          >
            Close
          </button>
        </div>
      </div>
    </div>,
    document.body
  )
}
