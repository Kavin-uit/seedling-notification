import React, { useEffect, useState } from 'react'
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
  const [copiedField, setCopiedField] = useState<string | null>(null)

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
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-[#091E42]/60 backdrop-blur-[2px] animate-in fade-in duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-lg shadow-2xl border border-[#DFE1E6] w-full max-w-[1180px] max-h-[96vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-150"
        onClick={(e) => e.stopPropagation()}
        style={{
          fontFamily:
            "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif",
        }}
      >
        {/* Compact Jira Header */}
        <div className="px-4 py-2.5 border-b border-[#DFE1E6] bg-white flex items-center justify-between gap-3 shrink-0">
          {/* Breadcrumbs + Event Title inline */}
          <div className="flex items-center gap-2 min-w-0 flex-1">
            <span className="inline-flex items-center px-2 py-0.5 rounded text-[11px] font-semibold bg-[#EBECF0] text-[#42526E] uppercase tracking-wide shrink-0">
              {scenario.engineCategory}
            </span>
            <span className="text-[#6B778C] text-xs">/</span>
            <span className="font-semibold text-[#0052CC] text-xs font-mono shrink-0">
              {scenario.key}
            </span>
            {rowNumber !== undefined && (
              <>
                <span className="text-[#6B778C] text-xs">/</span>
                <span className="text-[#5E6C84] text-xs font-mono font-medium shrink-0">
                  Row #{rowNumber}
                </span>
              </>
            )}
            <span className="text-[#6B778C] text-xs hidden sm:inline">&bull;</span>
            <h2 className="text-sm sm:text-base font-bold text-[#172B4D] truncate" title={scenario.governanceEvent}>
              {scenario.governanceEvent}
            </h2>
          </div>

          {/* Quick Actions & Navigation */}
          <div className="flex items-center gap-1 shrink-0">
            {onNavigatePrev && (
              <button
                type="button"
                onClick={onNavigatePrev}
                disabled={!hasPrev}
                className="w-7 h-7 rounded flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#EBECF0] disabled:opacity-25 disabled:hover:bg-transparent disabled:hover:text-[#5E6C84] transition cursor-pointer disabled:cursor-not-allowed"
                title="Previous row (← Arrow)"
                aria-label="Previous row"
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
            )}
            {onNavigateNext && (
              <button
                type="button"
                onClick={onNavigateNext}
                disabled={!hasNext}
                className="w-7 h-7 rounded flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#EBECF0] disabled:opacity-25 disabled:hover:bg-transparent disabled:hover:text-[#5E6C84] transition cursor-pointer disabled:cursor-not-allowed"
                title="Next row (→ Arrow)"
                aria-label="Next row"
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

        {/* Modal Main Body (Left: Content 77% / Right: Sidebar 23%) */}
        <div className="flex-1 flex flex-col md:flex-row divide-y md:divide-y-0 md:divide-x divide-[#DFE1E6] overflow-y-auto">
          {/* Main Content Area: Compact, All-at-a-Glance */}
          <div className="flex-1 p-3.5 sm:p-4 space-y-3 overflow-y-auto">
            {/* ROW 1: Context & Strategy (4 Columns side-by-side) */}
            <div className="grid grid-cols-2 lg:grid-cols-4 gap-2">
              {/* Trigger */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded px-2.5 py-1.5 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
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
                        <Check className="w-2.5 h-2.5 text-[#00875A]" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-[#172B4D] font-medium leading-snug line-clamp-2 mt-0.5" title={scenario.trigger}>
                  {scenario.trigger || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>

              {/* Audience */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded px-2.5 py-1.5 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
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
                        <Check className="w-2.5 h-2.5 text-[#00875A]" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-[#172B4D] font-medium leading-snug line-clamp-2 mt-0.5" title={scenario.audience}>
                  {scenario.audience || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>

              {/* Communication Objective */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded px-2.5 py-1.5 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
                    Objective
                  </span>
                  {scenario.communicationObjective && (
                    <button
                      type="button"
                      onClick={() => handleCopy('objective', scenario.communicationObjective)}
                      className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition"
                      title="Copy objective"
                    >
                      {copiedField === 'objective' ? (
                        <Check className="w-2.5 h-2.5 text-[#00875A]" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-[#172B4D] leading-snug line-clamp-2 mt-0.5" title={scenario.communicationObjective}>
                  {scenario.communicationObjective || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>

              {/* Desired Outcome */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded px-2.5 py-1.5 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
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
                        <Check className="w-2.5 h-2.5 text-[#00875A]" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-[#172B4D] leading-snug line-clamp-2 mt-0.5" title={scenario.desiredOutcome}>
                  {scenario.desiredOutcome || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>
            </div>

            {/* ROW 2: Notification Channels (Push & Email side-by-side) */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-2.5">
              {/* Push Notification Card */}
              <div className="border border-[#DFE1E6] rounded bg-white flex flex-col">
                <div className="bg-[#FAFBFC] px-3 py-1.5 border-b border-[#DFE1E6] flex items-center justify-between">
                  <div className="flex items-center gap-1.5">
                    <Bell className="w-3.5 h-3.5 text-[#0052CC]" />
                    <span className="text-[11px] font-bold text-[#172B4D] uppercase tracking-wider">
                      Push Notification
                    </span>
                  </div>
                  {scenario.pushBody && (
                    <button
                      type="button"
                      onClick={() => handleCopy('pushBody', scenario.pushBody)}
                      className="text-[11px] text-[#0052CC] hover:underline flex items-center gap-1 cursor-pointer"
                    >
                      {copiedField === 'pushBody' ? (
                        <>
                          <Check className="w-2.5 h-2.5 text-[#00875A]" />
                          <span className="text-[#00875A] font-semibold">Copied</span>
                        </>
                      ) : (
                        <>
                          <Copy className="w-2.5 h-2.5" />
                          <span>Copy</span>
                        </>
                      )}
                    </button>
                  )}
                </div>
                <div className="p-2.5 space-y-1.5 text-xs flex-1">
                  <div>
                    <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84] block">
                      Subject Line
                    </span>
                    <p className="font-semibold text-[#172B4D] text-[12px] mt-0.5">
                      {scenario.pushSubject || <span className="text-slate-400 italic font-normal">None</span>}
                    </p>
                  </div>
                  <div>
                    <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84] block">
                      Push Message Body
                    </span>
                    <div className="text-[12px] text-[#172B4D] leading-relaxed bg-[#FAFBFC] p-2 rounded border border-[#DFE1E6]/70 mt-0.5 whitespace-pre-wrap">
                      {scenario.pushBody || <span className="text-slate-400 italic">None</span>}
                    </div>
                  </div>
                </div>
              </div>

              {/* Email Notification Card */}
              <div className="border border-[#DFE1E6] rounded bg-white flex flex-col">
                <div className="bg-[#FAFBFC] px-3 py-1.5 border-b border-[#DFE1E6] flex items-center justify-between">
                  <div className="flex items-center gap-1.5">
                    <Mail className="w-3.5 h-3.5 text-[#0052CC]" />
                    <span className="text-[11px] font-bold text-[#172B4D] uppercase tracking-wider">
                      Email Notification
                    </span>
                  </div>
                  {scenario.emailBody && (
                    <button
                      type="button"
                      onClick={() => handleCopy('emailBody', scenario.emailBody)}
                      className="text-[11px] text-[#0052CC] hover:underline flex items-center gap-1 cursor-pointer"
                    >
                      {copiedField === 'emailBody' ? (
                        <>
                          <Check className="w-2.5 h-2.5 text-[#00875A]" />
                          <span className="text-[#00875A] font-semibold">Copied</span>
                        </>
                      ) : (
                        <>
                          <Copy className="w-2.5 h-2.5" />
                          <span>Copy</span>
                        </>
                      )}
                    </button>
                  )}
                </div>
                <div className="p-2.5 space-y-1.5 text-xs flex-1">
                  <div>
                    <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84] block">
                      Subject Line
                    </span>
                    <p className="font-semibold text-[#172B4D] text-[12px] mt-0.5">
                      {scenario.emailSubject || <span className="text-slate-400 italic font-normal">None</span>}
                    </p>
                  </div>
                  <div>
                    <span className="text-[10px] font-bold uppercase tracking-wider text-[#5E6C84] block">
                      Email Message Body
                    </span>
                    <div className="text-[12px] text-[#172B4D] leading-relaxed bg-[#FAFBFC] p-2 rounded border border-[#DFE1E6]/70 mt-0.5 whitespace-pre-wrap">
                      {scenario.emailBody || <span className="text-slate-400 italic">None</span>}
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* ROW 3: In-App, CTA & Comments (3 Columns side-by-side) */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-2.5">
              {/* In-App Experience */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-2.5 flex flex-col">
                <div className="flex items-center gap-1.5 mb-1 text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
                  <Smartphone className="w-3 h-3 text-[#5E6C84]" />
                  <span>In-App Experience</span>
                </div>
                <p className="text-[12px] text-[#172B4D] leading-relaxed flex-1 whitespace-pre-wrap">
                  {scenario.inAppExperience || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>

              {/* Call to Action (CTA) */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-2.5 flex flex-col">
                <div className="flex items-center gap-1.5 mb-1 text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
                  <ExternalLink className="w-3 h-3 text-[#5E6C84]" />
                  <span>Call to Action (CTA)</span>
                </div>
                <p className="text-[12px] text-[#172B4D] font-medium leading-relaxed flex-1 whitespace-pre-wrap">
                  {scenario.cta || <span className="text-slate-400 italic font-normal">None</span>}
                </p>
              </div>

              {/* QA Comments */}
              <div className="bg-[#FAFBFC] border border-[#DFE1E6] rounded p-2.5 flex flex-col">
                <div className="flex items-center gap-1.5 mb-1 text-[10px] font-bold uppercase tracking-wider text-[#5E6C84]">
                  <MessageSquare className="w-3 h-3 text-[#5E6C84]" />
                  <span>Comments & QA Remarks</span>
                </div>
                {scenario.comments && scenario.comments.trim() ? (
                  <p className="text-[12px] text-[#172B4D] leading-relaxed whitespace-pre-wrap bg-white p-2 rounded border border-[#DFE1E6] flex-1">
                    {scenario.comments}
                  </p>
                ) : (
                  <p className="text-xs text-slate-400 italic flex-1 flex items-center">
                    No QA remarks or comments added.
                  </p>
                )}
              </div>
            </div>

            {/* Extra Notes (if present, ultra-compact strip) */}
            {scenario.notes && scenario.notes.trim() && (
              <div className="bg-[#FFF9E6] border border-[#FFE380] rounded p-2 flex items-start gap-2 text-xs">
                <FileText className="w-3.5 h-3.5 text-[#B78103] shrink-0 mt-0.5" />
                <div className="min-w-0 flex-1">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-[#7A5B00] block">
                    Notes
                  </span>
                  <p className="text-[12px] text-[#172B4D] leading-snug whitespace-pre-wrap mt-0.5">
                    {scenario.notes}
                  </p>
                </div>
              </div>
            )}
          </div>

          {/* Right Sidebar: Compact Jira Details Panel */}
          <div className="w-full md:w-64 bg-[#FAFBFC] p-3.5 space-y-3.5 shrink-0 text-xs">
            <div>
              <h3 className="font-bold text-[10px] uppercase tracking-wider text-[#5E6C84] pb-1.5 border-b border-[#DFE1E6]">
                Details
              </h3>

              <div className="mt-2.5 space-y-2.5">
                {/* Status */}
                <div>
                  <span className="text-[#5E6C84] text-[10px] font-bold uppercase block mb-1">
                    Status
                  </span>
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
                <div className="flex items-center justify-between">
                  <span className="text-[#5E6C84] text-[10px] font-bold uppercase">Priority:</span>
                  <span className="font-semibold text-[#172B4D]">{scenario.priority || 'Medium'}</span>
                </div>

                {/* Engine Category */}
                <div className="flex items-center justify-between">
                  <span className="text-[#5E6C84] text-[10px] font-bold uppercase">Engine:</span>
                  <span className="font-medium text-[#172B4D]">{scenario.engineCategory}</span>
                </div>

                {/* Environment */}
                <div className="flex items-center justify-between">
                  <span className="text-[#5E6C84] text-[10px] font-bold uppercase">Environment:</span>
                  <span className="font-mono font-bold text-[#172B4D]">{scenario.environment || 'STAGING'}</span>
                </div>

                {/* Scenario Key */}
                <div className="flex items-center justify-between">
                  <span className="text-[#5E6C84] text-[10px] font-bold uppercase">Key:</span>
                  <span className="font-mono font-bold text-[#0052CC]">{scenario.key}</span>
                </div>

                {/* Row Number */}
                {rowNumber !== undefined && (
                  <div className="flex items-center justify-between">
                    <span className="text-[#5E6C84] text-[10px] font-bold uppercase">Row:</span>
                    <span className="font-mono font-bold text-[#172B4D]">#{rowNumber}</span>
                  </div>
                )}
              </div>
            </div>

            {/* Dates */}
            <div>
              <h3 className="font-bold text-[10px] uppercase tracking-wider text-[#5E6C84] pb-1.5 border-b border-[#DFE1E6]">
                Dates
              </h3>
              <div className="mt-2 space-y-1.5 text-[11px]">
                <div className="flex items-center justify-between">
                  <span className="text-[#5E6C84]">Created:</span>
                  <span className="text-[#172B4D] text-right">{formatDate(scenario.createdAt)}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-[#5E6C84]">Updated:</span>
                  <span className="text-[#172B4D] text-right">{formatDate(scenario.updatedAt)}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Ultra-compact Footer */}
        <div className="px-4 py-2 border-t border-[#DFE1E6] bg-white flex items-center justify-between shrink-0 text-xs">
          <div className="text-[11px] text-[#5E6C84]">
            Press <kbd className="px-1 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] font-mono text-[10px]">Esc</kbd> to close,{' '}
            <kbd className="px-1 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] font-mono text-[10px]">←</kbd>{' '}
            <kbd className="px-1 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] font-mono text-[10px]">→</kbd> to navigate
          </div>
          <button
            type="button"
            onClick={onClose}
            className="px-3.5 py-1 text-xs font-semibold text-[#172B4D] bg-[#EBECF0] hover:bg-[#DFE1E6] rounded transition cursor-pointer"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}
