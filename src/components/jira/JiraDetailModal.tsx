import React, { useEffect } from 'react'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { JiraStatusBadge } from './JiraStatusBadge'
import {
  X,
  Copy,
  Check,
  ChevronLeft,
  ChevronRight,
  Bell,
  Mail,
  Smartphone,
  ExternalLink,
  MessageSquare,
  FileText,
} from 'lucide-react'

interface JiraDetailModalProps {
  scenario: NotificationScenario | null
  rowNumber?: number
  allStatuses?: ScenarioStatus[]
  isOpen: boolean
  onClose: () => void
  onUpdateStatus?: (newStatus: ScenarioStatus) => void
  onNavigatePrev?: () => void
  onNavigateNext?: () => void
  hasPrev?: boolean
  hasNext?: boolean
}

export const JiraDetailModal: React.FC<JiraDetailModalProps> = ({
  scenario,
  rowNumber,
  allStatuses,
  isOpen,
  onClose,
  onUpdateStatus,
  onNavigatePrev,
  onNavigateNext,
  hasPrev = false,
  hasNext = false,
}) => {
  const [copiedField, setCopiedField] = React.useState<string | null>(null)

  // Keyboard navigation & close on Escape
  useEffect(() => {
    if (!isOpen) return
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
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isOpen, hasPrev, hasNext, onNavigatePrev, onNavigateNext, onClose])

  if (!isOpen || !scenario) return null

  const handleCopy = (label: string, text: string) => {
    if (!text) return
    navigator.clipboard.writeText(text)
    setCopiedField(label)
    setTimeout(() => setCopiedField(null), 1500)
  }

  const formatDate = (isoString?: string) => {
    if (!isoString) return '—'
    try {
      const d = new Date(isoString)
      if (isNaN(d.getTime())) return isoString
      return d.toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
        hour: 'numeric',
        minute: '2-digit',
      })
    } catch {
      return isoString
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-6 bg-[#091E42]/60 backdrop-blur-[2px] animate-in fade-in duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-lg shadow-2xl border border-[#DFE1E6] w-full max-w-5xl max-h-[92vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-150"
        onClick={(e) => e.stopPropagation()}
        style={{
          fontFamily:
            "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif",
        }}
      >
        {/* Jira Modal Top Bar */}
        <div className="px-5 py-3 border-b border-[#DFE1E6] bg-white flex items-center justify-between gap-3 shrink-0">
          {/* Breadcrumb / Issue Key */}
          <div className="flex items-center gap-2 min-w-0">
            <span className="inline-flex items-center px-2 py-0.5 rounded text-[11px] font-semibold bg-[#EBECF0] text-[#42526E] uppercase tracking-wide">
              {scenario.engineCategory}
            </span>
            <span className="text-[#6B778C] text-xs">/</span>
            <span className="font-semibold text-[#0052CC] text-xs font-mono">
              {scenario.key}
            </span>
            {rowNumber !== undefined && (
              <>
                <span className="text-[#6B778C] text-xs">/</span>
                <span className="text-[#5E6C84] text-xs font-mono font-medium">
                  Row #{rowNumber}
                </span>
              </>
            )}
          </div>

          {/* Navigation & Close */}
          <div className="flex items-center gap-1.5">
            {onNavigatePrev && (
              <button
                type="button"
                onClick={onNavigatePrev}
                disabled={!hasPrev}
                className="w-7 h-7 rounded flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#EBECF0] disabled:opacity-30 disabled:hover:bg-transparent disabled:hover:text-[#5E6C84] transition cursor-pointer disabled:cursor-not-allowed"
                title="Previous scenario (Left Arrow)"
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
                className="w-7 h-7 rounded flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#EBECF0] disabled:opacity-30 disabled:hover:bg-transparent disabled:hover:text-[#5E6C84] transition cursor-pointer disabled:cursor-not-allowed"
                title="Next scenario (Right Arrow)"
                aria-label="Next scenario"
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              className="w-7 h-7 rounded flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#EBECF0] transition cursor-pointer ml-1"
              title="Close (Esc)"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Jira Issue Title / Summary */}
        <div className="px-6 pt-4 pb-3 border-b border-[#DFE1E6] bg-white shrink-0">
          <h2 className="text-xl sm:text-2xl font-semibold text-[#172B4D] leading-snug tracking-tight">
            {scenario.governanceEvent}
          </h2>
        </div>

        {/* Modal Main Body (Two Columns: Content 68% / Sidebar 32%) */}
        <div className="flex-1 overflow-y-auto flex flex-col md:flex-row divide-y md:divide-y-0 md:divide-x divide-[#DFE1E6]">
          {/* Main Content Column */}
          <div className="flex-1 p-6 space-y-6 overflow-y-auto">
            {/* Overview / Context Grid */}
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#5E6C84] mb-3">
                Overview & Triggers
              </h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Trigger */}
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3 relative group">
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                      Trigger
                    </span>
                    {scenario.trigger && (
                      <button
                        type="button"
                        onClick={() => handleCopy('trigger', scenario.trigger)}
                        className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition"
                        title="Copy trigger"
                      >
                        {copiedField === 'trigger' ? (
                          <Check className="w-3 h-3 text-[#00875A]" />
                        ) : (
                          <Copy className="w-3 h-3" />
                        )}
                      </button>
                    )}
                  </div>
                  <p className="text-[13px] text-[#172B4D] font-medium leading-relaxed">
                    {scenario.trigger || <span className="text-slate-400 italic">None</span>}
                  </p>
                </div>

                {/* Audience */}
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3 relative group">
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                      Audience
                    </span>
                    {scenario.audience && (
                      <button
                        type="button"
                        onClick={() => handleCopy('audience', scenario.audience)}
                        className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition"
                        title="Copy audience"
                      >
                        {copiedField === 'audience' ? (
                          <Check className="w-3 h-3 text-[#00875A]" />
                        ) : (
                          <Copy className="w-3 h-3" />
                        )}
                      </button>
                    )}
                  </div>
                  <p className="text-[13px] text-[#172B4D] font-medium leading-relaxed">
                    {scenario.audience || <span className="text-slate-400 italic">None</span>}
                  </p>
                </div>

                {/* Communication Objective */}
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3 relative group">
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                      Communication Objective
                    </span>
                    {scenario.communicationObjective && (
                      <button
                        type="button"
                        onClick={() => handleCopy('objective', scenario.communicationObjective)}
                        className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition"
                        title="Copy objective"
                      >
                        {copiedField === 'objective' ? (
                          <Check className="w-3 h-3 text-[#00875A]" />
                        ) : (
                          <Copy className="w-3 h-3" />
                        )}
                      </button>
                    )}
                  </div>
                  <p className="text-[13px] text-[#172B4D] leading-relaxed">
                    {scenario.communicationObjective || (
                      <span className="text-slate-400 italic">None</span>
                    )}
                  </p>
                </div>

                {/* Desired Outcome */}
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3 relative group">
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                      Desired Outcome
                    </span>
                    {scenario.desiredOutcome && (
                      <button
                        type="button"
                        onClick={() => handleCopy('outcome', scenario.desiredOutcome)}
                        className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition"
                        title="Copy outcome"
                      >
                        {copiedField === 'outcome' ? (
                          <Check className="w-3 h-3 text-[#00875A]" />
                        ) : (
                          <Copy className="w-3 h-3" />
                        )}
                      </button>
                    )}
                  </div>
                  <p className="text-[13px] text-[#172B4D] leading-relaxed">
                    {scenario.desiredOutcome || <span className="text-slate-400 italic">None</span>}
                  </p>
                </div>
              </div>
            </div>

            {/* Notification Messages */}
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#5E6C84] mb-3">
                Notification Channels
              </h3>
              <div className="space-y-4">
                {/* Push Notification Card */}
                <div className="border border-[#DFE1E6] rounded overflow-hidden">
                  <div className="bg-[#FAFBFC] px-3.5 py-2 border-b border-[#DFE1E6] flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <Bell className="w-3.5 h-3.5 text-[#5E6C84]" />
                      <span className="text-xs font-semibold text-[#172B4D]">
                        Push Notification
                      </span>
                    </div>
                    {scenario.pushBody && (
                      <button
                        type="button"
                        onClick={() => handleCopy('pushBody', scenario.pushBody)}
                        className="text-xs text-[#0052CC] hover:underline flex items-center gap-1 cursor-pointer"
                      >
                        {copiedField === 'pushBody' ? (
                          <>
                            <Check className="w-3 h-3 text-[#00875A]" />
                            <span className="text-[#00875A]">Copied</span>
                          </>
                        ) : (
                          <>
                            <Copy className="w-3 h-3" />
                            <span>Copy Body</span>
                          </>
                        )}
                      </button>
                    )}
                  </div>
                  <div className="p-3.5 space-y-2.5 bg-white">
                    <div>
                      <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] block mb-0.5">
                        Subject Line
                      </span>
                      <p className="text-xs font-medium text-[#172B4D]">
                        {scenario.pushSubject || <span className="text-slate-400 italic">None</span>}
                      </p>
                    </div>
                    <div>
                      <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] block mb-0.5">
                        Push Message Body
                      </span>
                      <p className="text-[13px] text-[#172B4D] leading-relaxed bg-[#FAFBFC] p-2.5 rounded border border-[#DFE1E6]/60 whitespace-pre-wrap">
                        {scenario.pushBody || <span className="text-slate-400 italic">None</span>}
                      </p>
                    </div>
                  </div>
                </div>

                {/* Email Notification Card */}
                <div className="border border-[#DFE1E6] rounded overflow-hidden">
                  <div className="bg-[#FAFBFC] px-3.5 py-2 border-b border-[#DFE1E6] flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <Mail className="w-3.5 h-3.5 text-[#5E6C84]" />
                      <span className="text-xs font-semibold text-[#172B4D]">
                        Email Notification
                      </span>
                    </div>
                    {scenario.emailBody && (
                      <button
                        type="button"
                        onClick={() => handleCopy('emailBody', scenario.emailBody)}
                        className="text-xs text-[#0052CC] hover:underline flex items-center gap-1 cursor-pointer"
                      >
                        {copiedField === 'emailBody' ? (
                          <>
                            <Check className="w-3 h-3 text-[#00875A]" />
                            <span className="text-[#00875A]">Copied</span>
                          </>
                        ) : (
                          <>
                            <Copy className="w-3 h-3" />
                            <span>Copy Body</span>
                          </>
                        )}
                      </button>
                    )}
                  </div>
                  <div className="p-3.5 space-y-2.5 bg-white">
                    <div>
                      <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] block mb-0.5">
                        Subject Line
                      </span>
                      <p className="text-xs font-medium text-[#172B4D]">
                        {scenario.emailSubject || (
                          <span className="text-slate-400 italic">None</span>
                        )}
                      </p>
                    </div>
                    <div>
                      <span className="text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] block mb-0.5">
                        Email Message
                      </span>
                      <p className="text-[13px] text-[#172B4D] leading-relaxed bg-[#FAFBFC] p-2.5 rounded border border-[#DFE1E6]/60 whitespace-pre-wrap">
                        {scenario.emailBody || <span className="text-slate-400 italic">None</span>}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* In-App & Call to Action */}
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#5E6C84] mb-3">
                In-App & Call to Action
              </h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* In-App Experience */}
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3">
                  <div className="flex items-center gap-1.5 mb-1 text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                    <Smartphone className="w-3.5 h-3.5" />
                    <span>In-App Experience</span>
                  </div>
                  <p className="text-[13px] text-[#172B4D] leading-relaxed">
                    {scenario.inAppExperience || (
                      <span className="text-slate-400 italic">None</span>
                    )}
                  </p>
                </div>

                {/* Call to Action */}
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3">
                  <div className="flex items-center gap-1.5 mb-1 text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                    <ExternalLink className="w-3.5 h-3.5" />
                    <span>Call to Action (CTA)</span>
                  </div>
                  <p className="text-[13px] text-[#172B4D] font-medium leading-relaxed">
                    {scenario.cta || <span className="text-slate-400 italic">None</span>}
                  </p>
                </div>
              </div>
            </div>

            {/* Comments / QA Remarks */}
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#5E6C84] mb-3">
                QA Remarks & Comments
              </h3>
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3.5">
                <div className="flex items-center gap-1.5 mb-1 text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                  <MessageSquare className="w-3.5 h-3.5" />
                  <span>Comments</span>
                </div>
                {scenario.comments && scenario.comments.trim() ? (
                  <p className="text-[13px] text-[#172B4D] leading-relaxed whitespace-pre-wrap bg-white p-2.5 rounded border border-[#DFE1E6]">
                    {scenario.comments}
                  </p>
                ) : (
                  <p className="text-xs text-slate-400 italic">
                    No QA remarks or comments entered yet.
                  </p>
                )}
              </div>
            </div>

            {/* Notes if available */}
            {scenario.notes && scenario.notes.trim() && (
              <div>
                <h3 className="text-xs font-bold uppercase tracking-wider text-[#5E6C84] mb-2">
                  Extra Notes
                </h3>
                <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-3">
                  <div className="flex items-center gap-1.5 mb-1 text-[11px] font-bold uppercase tracking-wider text-[#5E6C84]">
                    <FileText className="w-3.5 h-3.5" />
                    <span>Notes</span>
                  </div>
                  <p className="text-[13px] text-[#172B4D] leading-relaxed whitespace-pre-wrap">
                    {scenario.notes}
                  </p>
                </div>
              </div>
            )}
          </div>

          {/* Right Sidebar: Details & Metadata */}
          <div className="w-full md:w-80 bg-[#FAFBFC] p-5 space-y-5 shrink-0 overflow-y-auto text-xs">
            <div>
              <h3 className="font-bold text-[11px] uppercase tracking-wider text-[#5E6C84] pb-2 border-b border-[#DFE1E6]">
                Details
              </h3>

              <div className="mt-3 space-y-3.5">
                {/* Status */}
                <div>
                  <span className="text-[#5E6C84] text-[11px] block mb-1 font-medium">Status</span>
                  {onUpdateStatus && allStatuses ? (
                    <JiraStatusBadge
                      status={scenario.status}
                      onChange={onUpdateStatus}
                      availableStatuses={allStatuses}
                      size="sm"
                    />
                  ) : (
                    <span className="inline-block px-2 py-0.5 rounded text-[11px] font-bold bg-[#DFE1E6] text-[#42526E] uppercase">
                      {scenario.status}
                    </span>
                  )}
                </div>

                {/* Priority */}
                <div>
                  <span className="text-[#5E6C84] text-[11px] block mb-1 font-medium">Priority</span>
                  <span className="font-medium text-[#172B4D]">{scenario.priority || 'Medium'}</span>
                </div>

                {/* Engine Category */}
                <div>
                  <span className="text-[#5E6C84] text-[11px] block mb-1 font-medium">Engine</span>
                  <span className="inline-flex items-center px-2 py-0.5 rounded text-[11px] font-semibold bg-white border border-[#DFE1E6] text-[#172B4D]">
                    {scenario.engineCategory}
                  </span>
                </div>

                {/* Environment */}
                <div>
                  <span className="text-[#5E6C84] text-[11px] block mb-1 font-medium">
                    Environment
                  </span>
                  <span className="font-mono text-[11px] font-semibold text-[#172B4D]">
                    {scenario.environment || 'STAGING'}
                  </span>
                </div>

                {/* Scenario Key */}
                <div>
                  <span className="text-[#5E6C84] text-[11px] block mb-1 font-medium">Key</span>
                  <span className="font-mono text-xs font-semibold text-[#0052CC]">
                    {scenario.key}
                  </span>
                </div>

                {/* Row Number */}
                {rowNumber !== undefined && (
                  <div>
                    <span className="text-[#5E6C84] text-[11px] block mb-1 font-medium">
                      Row Number
                    </span>
                    <span className="font-mono text-xs font-semibold text-[#172B4D]">
                      #{rowNumber}
                    </span>
                  </div>
                )}
              </div>
            </div>

            {/* Dates */}
            <div>
              <h3 className="font-bold text-[11px] uppercase tracking-wider text-[#5E6C84] pb-2 border-b border-[#DFE1E6]">
                Dates
              </h3>
              <div className="mt-3 space-y-2.5 text-[11px]">
                <div>
                  <span className="text-[#5E6C84] block font-medium">Created:</span>
                  <span className="text-[#172B4D]">{formatDate(scenario.createdAt)}</span>
                </div>
                <div>
                  <span className="text-[#5E6C84] block font-medium">Updated:</span>
                  <span className="text-[#172B4D]">{formatDate(scenario.updatedAt)}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Modal Bottom Bar */}
        <div className="px-5 py-3 border-t border-[#DFE1E6] bg-white flex items-center justify-between shrink-0">
          <div className="text-[11px] text-[#5E6C84]">
            Press <kbd className="px-1.5 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] font-mono">Esc</kbd> to close,{' '}
            <kbd className="px-1.5 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] font-mono">←</kbd>{' '}
            <kbd className="px-1.5 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] font-mono">→</kbd> to navigate
          </div>
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 text-xs font-semibold text-[#172B4D] bg-[#EBECF0] hover:bg-[#DFE1E6] rounded transition cursor-pointer"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}
