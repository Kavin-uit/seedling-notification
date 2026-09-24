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
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-900/35 backdrop-blur-md animate-in fade-in duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white/80 backdrop-blur-2xl rounded-2xl shadow-[0_24px_70px_-15px_rgba(15,23,42,0.18),0_0_0_1px_rgba(255,255,255,0.8)_inset] border border-white/70 w-full max-w-[1180px] max-h-[96vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-150"
        onClick={(e) => e.stopPropagation()}
        style={{
          fontFamily:
            "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif",
        }}
      >
        {/* Sleek Frosted Glass Header */}
        <div className="px-5 py-3 border-b border-slate-200/50 bg-white/50 backdrop-blur-md flex items-center justify-between gap-3 shrink-0">
          {/* Breadcrumbs + Event Title inline */}
          <div className="flex items-center gap-2 min-w-0 flex-1">
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-semibold bg-blue-500/10 text-[#0052CC] border border-blue-500/20 uppercase tracking-wide shrink-0">
              {scenario.engineCategory}
            </span>
            <span className="text-slate-300 text-xs">/</span>
            <span className="font-semibold text-[#0052CC] text-xs font-mono shrink-0">
              {scenario.key}
            </span>
            {rowNumber !== undefined && (
              <>
                <span className="text-slate-300 text-xs">/</span>
                <span className="text-slate-500 text-xs font-mono font-medium shrink-0">
                  Row #{rowNumber}
                </span>
              </>
            )}
            <span className="text-slate-300 text-xs hidden sm:inline">&bull;</span>
            <h2 className="text-sm sm:text-base font-bold text-slate-800 truncate" title={scenario.governanceEvent}>
              {scenario.governanceEvent}
            </h2>
          </div>

          {/* Quick Actions & Navigation */}
          <div className="flex items-center gap-1.5 shrink-0">
            {onNavigatePrev && (
              <button
                type="button"
                onClick={onNavigatePrev}
                disabled={!hasPrev}
                className="w-7 h-7 rounded-lg flex items-center justify-center text-slate-500 hover:text-slate-800 hover:bg-slate-900/5 disabled:opacity-20 disabled:hover:bg-transparent transition cursor-pointer disabled:cursor-not-allowed"
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
                className="w-7 h-7 rounded-lg flex items-center justify-center text-slate-500 hover:text-slate-800 hover:bg-slate-900/5 disabled:opacity-20 disabled:hover:bg-transparent transition cursor-pointer disabled:cursor-not-allowed"
                title="Next row (→ Arrow)"
                aria-label="Next row"
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              className="w-7 h-7 rounded-lg flex items-center justify-center text-slate-500 hover:text-slate-800 hover:bg-slate-900/5 transition cursor-pointer ml-1"
              title="Close (Esc)"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Modal Main Body (Left: Content / Right: Sidebar) */}
        <div className="flex-1 flex flex-col md:flex-row divide-y md:divide-y-0 md:divide-x divide-slate-200/40 overflow-y-auto">
          {/* Main Content Area: Airy Glass Look */}
          <div className="flex-1 p-3.5 sm:p-4 space-y-3 overflow-y-auto">
            {/* ROW 1: Context & Strategy (Unified clean glass card without heavy individual box borders) */}
            <div className="bg-white/55 backdrop-blur-md border border-white/80 rounded-xl p-3 shadow-2xs grid grid-cols-2 lg:grid-cols-4 gap-4 divide-y sm:divide-y-0 sm:divide-x divide-slate-200/40">
              {/* Trigger */}
              <div className="sm:pr-3 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                    Trigger
                  </span>
                  {scenario.trigger && (
                    <button
                      type="button"
                      onClick={() => handleCopy('trigger', scenario.trigger)}
                      className="text-slate-400 hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
                      title="Copy trigger"
                    >
                      {copiedField === 'trigger' ? (
                        <Check className="w-2.5 h-2.5 text-emerald-600" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-slate-800 font-medium leading-snug mt-1" title={scenario.trigger}>
                  {scenario.trigger || <span className="text-slate-400 italic font-normal">None</span>}
                </p>
              </div>

              {/* Audience */}
              <div className="sm:px-3 pt-2 sm:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                    Audience
                  </span>
                  {scenario.audience && (
                    <button
                      type="button"
                      onClick={() => handleCopy('audience', scenario.audience)}
                      className="text-slate-400 hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
                      title="Copy audience"
                    >
                      {copiedField === 'audience' ? (
                        <Check className="w-2.5 h-2.5 text-emerald-600" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-slate-800 font-medium leading-snug mt-1" title={scenario.audience}>
                  {scenario.audience || <span className="text-slate-400 italic font-normal">None</span>}
                </p>
              </div>

              {/* Communication Objective */}
              <div className="sm:px-3 pt-2 sm:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                    Objective
                  </span>
                  {scenario.communicationObjective && (
                    <button
                      type="button"
                      onClick={() => handleCopy('objective', scenario.communicationObjective)}
                      className="text-slate-400 hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
                      title="Copy objective"
                    >
                      {copiedField === 'objective' ? (
                        <Check className="w-2.5 h-2.5 text-emerald-600" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-slate-700 leading-snug mt-1" title={scenario.communicationObjective}>
                  {scenario.communicationObjective || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>

              {/* Desired Outcome */}
              <div className="sm:pl-3 pt-2 sm:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                    Desired Outcome
                  </span>
                  {scenario.desiredOutcome && (
                    <button
                      type="button"
                      onClick={() => handleCopy('outcome', scenario.desiredOutcome)}
                      className="text-slate-400 hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
                      title="Copy outcome"
                    >
                      {copiedField === 'outcome' ? (
                        <Check className="w-2.5 h-2.5 text-emerald-600" />
                      ) : (
                        <Copy className="w-2.5 h-2.5" />
                      )}
                    </button>
                  )}
                </div>
                <p className="text-[12px] text-slate-700 leading-snug mt-1" title={scenario.desiredOutcome}>
                  {scenario.desiredOutcome || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>
            </div>

            {/* ROW 2: Notification Channels (Translucent glass panels with zero box-in-box nesting) */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-3">
              {/* Push Notification Glass Panel */}
              <div className="bg-white/55 backdrop-blur-md border border-white/80 rounded-xl p-3.5 shadow-2xs flex flex-col transition hover:bg-white/65">
                <div className="flex items-center justify-between pb-2 mb-2 border-b border-slate-200/40">
                  <div className="flex items-center gap-2">
                    <div className="w-6 h-6 rounded-lg bg-blue-500/10 flex items-center justify-center text-[#0052CC]">
                      <Bell className="w-3.5 h-3.5" />
                    </div>
                    <span className="text-[11px] font-bold text-slate-800 uppercase tracking-wider">
                      Push Notification
                    </span>
                  </div>
                  {scenario.pushBody && (
                    <button
                      type="button"
                      onClick={() => handleCopy('pushBody', scenario.pushBody)}
                      className="text-[11px] font-medium text-[#0052CC] hover:text-blue-700 flex items-center gap-1 cursor-pointer transition"
                    >
                      {copiedField === 'pushBody' ? (
                        <>
                          <Check className="w-2.5 h-2.5 text-emerald-600" />
                          <span className="text-emerald-600 font-semibold">Copied</span>
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

                <div className="space-y-2 text-xs flex-1">
                  <div>
                    <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400 block">
                      Subject Line
                    </span>
                    <p className="font-semibold text-slate-800 text-[12px] mt-0.5">
                      {scenario.pushSubject || <span className="text-slate-400 italic font-normal">None</span>}
                    </p>
                  </div>
                  <div>
                    <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400 block">
                      Push Message Body
                    </span>
                    <p className="text-[12px] text-slate-700 leading-relaxed mt-1 whitespace-pre-wrap">
                      {scenario.pushBody || <span className="text-slate-400 italic">None</span>}
                    </p>
                  </div>
                </div>
              </div>

              {/* Email Notification Glass Panel */}
              <div className="bg-white/55 backdrop-blur-md border border-white/80 rounded-xl p-3.5 shadow-2xs flex flex-col transition hover:bg-white/65">
                <div className="flex items-center justify-between pb-2 mb-2 border-b border-slate-200/40">
                  <div className="flex items-center gap-2">
                    <div className="w-6 h-6 rounded-lg bg-indigo-500/10 flex items-center justify-center text-indigo-600">
                      <Mail className="w-3.5 h-3.5" />
                    </div>
                    <span className="text-[11px] font-bold text-slate-800 uppercase tracking-wider">
                      Email Notification
                    </span>
                  </div>
                  {scenario.emailBody && (
                    <button
                      type="button"
                      onClick={() => handleCopy('emailBody', scenario.emailBody)}
                      className="text-[11px] font-medium text-[#0052CC] hover:text-blue-700 flex items-center gap-1 cursor-pointer transition"
                    >
                      {copiedField === 'emailBody' ? (
                        <>
                          <Check className="w-2.5 h-2.5 text-emerald-600" />
                          <span className="text-emerald-600 font-semibold">Copied</span>
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

                <div className="space-y-2 text-xs flex-1">
                  <div>
                    <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400 block">
                      Subject Line
                    </span>
                    <p className="font-semibold text-slate-800 text-[12px] mt-0.5">
                      {scenario.emailSubject || <span className="text-slate-400 italic font-normal">None</span>}
                    </p>
                  </div>
                  <div>
                    <span className="text-[10px] font-semibold uppercase tracking-wider text-slate-400 block">
                      Email Message Body
                    </span>
                    <p className="text-[12px] text-slate-700 leading-relaxed mt-1 whitespace-pre-wrap">
                      {scenario.emailBody || <span className="text-slate-400 italic">None</span>}
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* ROW 3: In-App, CTA & Comments (Simple airy glass panels) */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
              {/* In-App Experience */}
              <div className="bg-white/55 backdrop-blur-md border border-white/80 rounded-xl p-3 shadow-2xs flex flex-col transition hover:bg-white/65">
                <div className="flex items-center gap-1.5 mb-1.5 text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                  <Smartphone className="w-3.5 h-3.5 text-slate-400" />
                  <span>In-App Experience</span>
                </div>
                <p className="text-[12px] text-slate-700 leading-relaxed flex-1 whitespace-pre-wrap">
                  {scenario.inAppExperience || <span className="text-slate-400 italic">None</span>}
                </p>
              </div>

              {/* Call to Action (CTA) */}
              <div className="bg-white/55 backdrop-blur-md border border-white/80 rounded-xl p-3 shadow-2xs flex flex-col transition hover:bg-white/65">
                <div className="flex items-center gap-1.5 mb-1.5 text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                  <ExternalLink className="w-3.5 h-3.5 text-slate-400" />
                  <span>Call to Action (CTA)</span>
                </div>
                <p className="text-[12px] text-slate-800 font-medium leading-relaxed flex-1 whitespace-pre-wrap">
                  {scenario.cta || <span className="text-slate-400 italic font-normal">None</span>}
                </p>
              </div>

              {/* QA Comments */}
              <div className="bg-white/55 backdrop-blur-md border border-white/80 rounded-xl p-3 shadow-2xs flex flex-col transition hover:bg-white/65">
                <div className="flex items-center gap-1.5 mb-1.5 text-[10px] font-semibold uppercase tracking-wider text-slate-400">
                  <MessageSquare className="w-3.5 h-3.5 text-slate-400" />
                  <span>Comments & QA Remarks</span>
                </div>
                {scenario.comments && scenario.comments.trim() ? (
                  <p className="text-[12px] text-slate-800 leading-relaxed whitespace-pre-wrap flex-1">
                    {scenario.comments}
                  </p>
                ) : (
                  <p className="text-xs text-slate-400 italic flex-1 flex items-center">
                    No QA remarks or comments added.
                  </p>
                )}
              </div>
            </div>

            {/* Extra Notes (if present, frosted amber glass strip) */}
            {scenario.notes && scenario.notes.trim() && (
              <div className="bg-amber-500/10 backdrop-blur-sm border border-amber-500/20 rounded-xl p-2.5 flex items-start gap-2.5 text-xs">
                <FileText className="w-3.5 h-3.5 text-amber-600 shrink-0 mt-0.5" />
                <div className="min-w-0 flex-1">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-amber-700 block">
                    Notes
                  </span>
                  <p className="text-[12px] text-slate-800 leading-snug whitespace-pre-wrap mt-0.5">
                    {scenario.notes}
                  </p>
                </div>
              </div>
            )}
          </div>

          {/* Right Sidebar: Frosted Glass Details Panel */}
          <div className="w-full md:w-64 bg-slate-50/40 backdrop-blur-md p-4 space-y-4 shrink-0 text-xs border-t md:border-t-0 md:border-l border-slate-200/40">
            <div>
              <h3 className="font-bold text-[10px] uppercase tracking-wider text-slate-400 pb-1.5 border-b border-slate-200/40">
                Details
              </h3>

              <div className="mt-3 space-y-2.5">
                {/* Status */}
                <div>
                  <span className="text-slate-400 text-[10px] font-semibold uppercase block mb-1">
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
                    <span className="inline-block px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-slate-200/60 text-slate-700 uppercase">
                      {scenario.status}
                    </span>
                  )}
                </div>

                {/* Priority */}
                <div className="flex items-center justify-between">
                  <span className="text-slate-400 text-[10px] font-semibold uppercase">Priority:</span>
                  <span className="font-semibold text-slate-700">{scenario.priority || 'Medium'}</span>
                </div>

                {/* Engine Category */}
                <div className="flex items-center justify-between">
                  <span className="text-slate-400 text-[10px] font-semibold uppercase">Engine:</span>
                  <span className="font-medium text-slate-700">{scenario.engineCategory}</span>
                </div>

                {/* Environment */}
                <div className="flex items-center justify-between">
                  <span className="text-slate-400 text-[10px] font-semibold uppercase">Environment:</span>
                  <span className="font-mono font-bold text-slate-800">{scenario.environment || 'STAGING'}</span>
                </div>

                {/* Scenario Key */}
                <div className="flex items-center justify-between">
                  <span className="text-slate-400 text-[10px] font-semibold uppercase">Key:</span>
                  <span className="font-mono font-bold text-[#0052CC]">{scenario.key}</span>
                </div>

                {/* Row Number */}
                {rowNumber !== undefined && (
                  <div className="flex items-center justify-between">
                    <span className="text-slate-400 text-[10px] font-semibold uppercase">Row:</span>
                    <span className="font-mono font-bold text-slate-800">#{rowNumber}</span>
                  </div>
                )}
              </div>
            </div>

            {/* Dates */}
            <div>
              <h3 className="font-bold text-[10px] uppercase tracking-wider text-slate-400 pb-1.5 border-b border-slate-200/40">
                Dates
              </h3>
              <div className="mt-2.5 space-y-1.5 text-[11px]">
                <div className="flex items-center justify-between">
                  <span className="text-slate-400">Created:</span>
                  <span className="text-slate-700 text-right">{formatDate(scenario.createdAt)}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-slate-400">Updated:</span>
                  <span className="text-slate-700 text-right">{formatDate(scenario.updatedAt)}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Frosted Glass Footer */}
        <div className="px-5 py-2.5 border-t border-slate-200/50 bg-white/40 backdrop-blur-md flex items-center justify-between shrink-0 text-xs">
          <div className="text-[11px] text-slate-400">
            Press <kbd className="px-1.5 py-0.5 bg-slate-200/50 rounded text-slate-700 font-mono text-[10px]">Esc</kbd> to close,{' '}
            <kbd className="px-1.5 py-0.5 bg-slate-200/50 rounded text-slate-700 font-mono text-[10px]">←</kbd>{' '}
            <kbd className="px-1.5 py-0.5 bg-slate-200/50 rounded text-slate-700 font-mono text-[10px]">→</kbd> to navigate
          </div>
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 text-xs font-semibold text-slate-700 bg-slate-200/60 hover:bg-slate-300/70 rounded-lg transition cursor-pointer active:scale-95"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}
