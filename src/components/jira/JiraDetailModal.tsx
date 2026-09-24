import React, { useEffect, useState } from 'react'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { JiraStatusBadge } from './JiraStatusBadge'
import {
  X,
  Copy,
  Check,
  ChevronLeft,
  ChevronRight,
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

function parseEmailTemplate(scenario: NotificationScenario) {
  let rawBody = scenario.emailBody?.trim() || ''
  let buttonText: string | null = null

  // Extract button ONLY if email content explicitly specifies "BOX: <Button Name>"
  const boxMatch = rawBody.match(/(?:^|\s+)BOX\s*:\s*([^\n\r]+?)(?:\s*$|\.\s*$)/i)
  if (boxMatch) {
    buttonText = boxMatch[1].replace(/[."']+$/, '').trim()
    rawBody = rawBody.replace(/(?:^|\s+)BOX\s*:\s*[^\n\r]+?(?:\s*$|\.\s*$)/i, '').trim()
  }

  const subject = scenario.emailSubject?.trim() || ''
  let boldLead = ''
  let remainingBody = rawBody

  if (subject && rawBody) {
    const cleanSubj = subject.replace(/[.!?]+$/, '').toLowerCase()
    const bodyLower = rawBody.toLowerCase()
    if (bodyLower.startsWith(cleanSubj)) {
      let matchEnd = cleanSubj.length
      if (rawBody[matchEnd] === '.' || rawBody[matchEnd] === '!' || rawBody[matchEnd] === '?') {
        matchEnd += 1
      }
      boldLead = rawBody.slice(0, matchEnd).trim()
      remainingBody = rawBody.slice(matchEnd).trim()
    } else {
      boldLead = subject.endsWith('.') || subject.endsWith('!') || subject.endsWith('?') ? subject : `${subject}.`
      remainingBody = rawBody
    }
  } else if (subject && !rawBody) {
    boldLead = subject
    remainingBody = ''
  } else if (rawBody) {
    const firstSentenceMatch = rawBody.match(/^([^.!?]+[.!?])\s*(.*)$/s)
    if (firstSentenceMatch) {
      boldLead = firstSentenceMatch[1].trim()
      remainingBody = firstSentenceMatch[2].trim()
    } else {
      boldLead = rawBody
      remainingBody = ''
    }
  }

  return { boldLead, remainingBody, buttonText }
}

export const JiraDetailModal: React.FC<JiraDetailModalProps> = ({
  scenario,
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

  const emailTemplate = parseEmailTemplate(scenario)

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-900/40 backdrop-blur-xs animate-in fade-in duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-xl shadow-[0_20px_60px_-15px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] w-full max-w-[1000px] max-h-[94vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-150"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Simple Human Header: Clean Event Title + Interactive Status */}
        <div className="px-5 py-3.5 border-b border-[#DFE1E6] bg-white flex items-center justify-between gap-3 shrink-0">
          <div className="flex items-center gap-3 min-w-0 flex-1">
            <h2 className="text-base sm:text-lg font-bold text-[#172B4D] truncate" title={scenario.governanceEvent}>
              {scenario.governanceEvent}
            </h2>
            {onUpdateStatus && allStatuses && (
              <div className="shrink-0">
                <JiraStatusBadge
                  status={scenario.status}
                  onChange={onUpdateStatus}
                  availableStatuses={allStatuses}
                  size="sm"
                />
              </div>
            )}
          </div>

          {/* Quick Actions & Navigation */}
          <div className="flex items-center gap-1 shrink-0">
            {onNavigatePrev && (
              <button
                type="button"
                onClick={onNavigatePrev}
                disabled={!hasPrev}
                className="w-7 h-7 rounded flex items-center justify-center text-[#6B778C] hover:text-[#172B4D] hover:bg-[#EBECF0] disabled:opacity-20 disabled:hover:bg-transparent transition cursor-pointer disabled:cursor-not-allowed"
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
                className="w-7 h-7 rounded flex items-center justify-center text-[#6B778C] hover:text-[#172B4D] hover:bg-[#EBECF0] disabled:opacity-20 disabled:hover:bg-transparent transition cursor-pointer disabled:cursor-not-allowed"
                title="Next row (→ Arrow)"
                aria-label="Next row"
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              className="w-7 h-7 rounded flex items-center justify-center text-[#6B778C] hover:text-[#172B4D] hover:bg-[#EBECF0] transition cursor-pointer ml-1"
              title="Close (Esc)"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Modal Main Body (Single clean layout without AI metadata sidebar) */}
        <div className="flex-1 p-5 space-y-4 overflow-y-auto bg-[#F4F5F7]">
          {/* ROW 1: Context & Strategy */}
          <div className="bg-white border border-[#DFE1E6] rounded-xl p-4 shadow-2xs grid grid-cols-2 lg:grid-cols-4 gap-4 divide-y sm:divide-y-0 sm:divide-x divide-[#DFE1E6]">
            {/* Trigger */}
            <div className="sm:pr-3 relative group">
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-[#6B778C]">Trigger</span>
                {scenario.trigger && (
                  <button
                    type="button"
                    onClick={() => handleCopy('trigger', scenario.trigger)}
                    className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
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
              <p className="text-xs text-[#172B4D] leading-relaxed mt-1" title={scenario.trigger}>
                {scenario.trigger || <span className="text-[#6B778C] italic">None</span>}
              </p>
            </div>

            {/* Audience */}
            <div className="sm:px-3 pt-2 sm:pt-0 relative group">
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-[#6B778C]">Audience</span>
                {scenario.audience && (
                  <button
                    type="button"
                    onClick={() => handleCopy('audience', scenario.audience)}
                    className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
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
              <p className="text-xs text-[#172B4D] leading-relaxed mt-1" title={scenario.audience}>
                {scenario.audience || <span className="text-[#6B778C] italic">None</span>}
              </p>
            </div>

            {/* Communication Objective */}
            <div className="sm:px-3 pt-2 sm:pt-0 relative group">
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-[#6B778C]">Objective</span>
                {scenario.communicationObjective && (
                  <button
                    type="button"
                    onClick={() => handleCopy('objective', scenario.communicationObjective)}
                    className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
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
              <p className="text-xs text-[#172B4D] leading-relaxed mt-1" title={scenario.communicationObjective}>
                {scenario.communicationObjective || <span className="text-[#6B778C] italic">None</span>}
              </p>
            </div>

            {/* Desired Outcome */}
            <div className="sm:pl-3 pt-2 sm:pt-0 relative group">
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-[#6B778C]">Desired Outcome</span>
                {scenario.desiredOutcome && (
                  <button
                    type="button"
                    onClick={() => handleCopy('outcome', scenario.desiredOutcome)}
                    className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded opacity-0 group-hover:opacity-100 transition cursor-pointer"
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
              <p className="text-xs text-[#172B4D] leading-relaxed mt-1" title={scenario.desiredOutcome}>
                {scenario.desiredOutcome || <span className="text-[#6B778C] italic">None</span>}
              </p>
            </div>
          </div>

          {/* ROW 2: Notification Previews (Push Notification exact iOS iPhone Notification Banner + Email) */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            {/* iOS iPhone Push Notification Banner Preview */}
            <div className="space-y-1.5">
              <div className="flex items-center justify-between px-0.5">
                <span className="text-xs font-semibold text-[#6B778C]">
                  Push Notification Preview
                </span>
                {scenario.pushBody && (
                  <button
                    type="button"
                    onClick={() => handleCopy('pushBody', scenario.pushBody)}
                    className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                  >
                    {copiedField === 'pushBody' ? (
                      <>
                        <Check className="w-3 h-3 text-[#00875A]" />
                        <span className="text-[#00875A] font-semibold">Copied</span>
                      </>
                    ) : (
                      <>
                        <Copy className="w-3 h-3" />
                        <span>Copy</span>
                      </>
                    )}
                  </button>
                )}
              </div>

              {/* Exact Apple iOS iPhone Notification Banner Card */}
              <div className="bg-[#F2F2F7]/95 border border-black/5 rounded-[22px] p-4 shadow-[0_4px_24px_rgba(0,0,0,0.07),0_1px_2px_rgba(0,0,0,0.06)] transition-all">
                {/* iOS Header */}
                <div className="flex items-center justify-between pb-1.5">
                  <div className="flex items-center gap-2">
                    {/* Seedling App Icon */}
                    <div className="w-5 h-5 rounded-[5px] bg-[#107C41] flex items-center justify-center text-white shadow-xs p-0.5 shrink-0 overflow-hidden">
                      <img
                        src="https://qa.seedlingsocial.org/static/media/seedling-icon.19cfcf4c.svg"
                        onError={(e) => {
                          e.currentTarget.src = '/seedling-icon.19cfcf4c.svg'
                        }}
                        alt="Seedling"
                        className="w-full h-full object-contain"
                      />
                    </div>
                    <span className="text-[13px] font-semibold text-[#1C1C1E] tracking-tight">
                      Seedling
                    </span>
                  </div>
                  <span className="text-[12px] text-[#8E8E93] font-normal">
                    now
                  </span>
                </div>

                {/* iOS Subject Line / Title */}
                <div className="font-semibold text-[14px] text-[#1C1C1E] leading-snug tracking-tight mt-1">
                  {scenario.pushSubject || <span className="text-[#8E8E93] italic font-normal">No subject line</span>}
                </div>

                {/* iOS Message Body */}
                <div className="text-[13px] text-[#3A3A3C] leading-snug mt-0.5 whitespace-pre-wrap">
                  {scenario.pushBody || <span className="text-[#8E8E93] italic">No message body</span>}
                </div>
              </div>
            </div>

            {/* Email Notification Preview (Official Seedling Social Giving Email Template) */}
            <div className="space-y-1.5">
              <div className="flex items-center justify-between px-0.5">
                <span className="text-xs font-semibold text-[#6B778C]">
                  Email Notification Preview
                </span>
                {(scenario.emailBody || scenario.emailSubject) && (
                  <button
                    type="button"
                    onClick={() => handleCopy('emailBody', scenario.emailBody || scenario.emailSubject || '')}
                    className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                  >
                    {copiedField === 'emailBody' ? (
                      <>
                        <Check className="w-3 h-3 text-[#00875A]" />
                        <span className="text-[#00875A] font-semibold">Copied</span>
                      </>
                    ) : (
                      <>
                        <Copy className="w-3 h-3" />
                        <span>Copy</span>
                      </>
                    )}
                  </button>
                )}
              </div>

              {/* Exact Seedling Social Giving Email Template Card */}
              <div className="bg-white border border-[#DFE1E6] rounded-xl overflow-hidden shadow-[0_4px_20px_rgba(0,0,0,0.06)] transition-all">
                {/* Solid Green Header Banner with Given Logo Without Modifications */}
                <div className="bg-[#1E874B] px-5 py-3.5 sm:py-4 flex items-center justify-center gap-2.5 select-none shadow-xs">
                  <img
                    src="https://qa.seedlingsocial.org/static/media/seedling-icon.19cfcf4c.svg"
                    onError={(e) => {
                      e.currentTarget.src = '/seedling-icon.19cfcf4c.svg'
                    }}
                    alt="Seedling"
                    className="w-6 h-6 object-contain shrink-0"
                  />
                  <span className="font-bold text-white text-[16px] sm:text-[17px] tracking-tight">
                    Seedling Social Giving
                  </span>
                </div>

                {/* Email Body Content */}
                <div className="px-6 py-6 sm:px-8 sm:py-7 bg-white">
                  {emailTemplate.boldLead || emailTemplate.remainingBody ? (
                    <p className="text-[13.5px] sm:text-[14.5px] text-[#1C1C1E] leading-relaxed">
                      {emailTemplate.boldLead && (
                        <strong className="font-bold text-[#1C1C1E]">
                          {emailTemplate.boldLead}{' '}
                        </strong>
                      )}
                      <span>{emailTemplate.remainingBody}</span>
                    </p>
                  ) : (
                    <p className="text-xs text-[#8E8E93] italic">
                      No email message configured
                    </p>
                  )}

                  {/* Centered Green CTA Button */}
                  {emailTemplate.buttonText && (
                    <div className="mt-6 flex justify-center">
                      <button
                        type="button"
                        className="bg-[#2D8040] hover:bg-[#236B34] text-white font-semibold text-sm px-6 py-2.5 rounded-md shadow-xs transition cursor-pointer"
                      >
                        {emailTemplate.buttonText}
                      </button>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>

          {/* ROW 3: In-App, CTA & Comments */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {/* In-App Experience (Styled to match Seedling's official in-app notification card) */}
            <div className="bg-white border border-[#DFE1E6] rounded-xl p-3.5 shadow-2xs flex flex-col">
              <div className="flex items-center justify-between mb-2">
                <div className="flex items-center gap-1.5 text-xs font-semibold text-[#6B778C]">
                  <Smartphone className="w-3.5 h-3.5 text-[#6B778C]" />
                  <span>In-App Experience</span>
                </div>
                {scenario.inAppExperience && (
                  <button
                    type="button"
                    onClick={() => handleCopy('inApp', scenario.inAppExperience)}
                    className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                    title="Copy in-app message"
                  >
                    {copiedField === 'inApp' ? (
                      <>
                        <Check className="w-3 h-3 text-[#00875A]" />
                        <span className="text-[#00875A] font-semibold">Copied</span>
                      </>
                    ) : (
                      <>
                        <Copy className="w-3 h-3" />
                        <span>Copy</span>
                      </>
                    )}
                  </button>
                )}
              </div>

              {scenario.inAppExperience ? (
                /* Official Seedling In-App Notification Card */
                <div className="bg-white border border-[#4D9873] rounded-lg p-3 sm:px-4 sm:py-3.5 flex items-center gap-3.5 shadow-2xs flex-1 transition-all">
                  {/* Round Seedling Avatar */}
                  <div className="w-11 h-11 rounded-full border border-[#DCDEE0] bg-white flex items-center justify-center p-2.5 shrink-0 shadow-2xs">
                    <img
                      src="https://qa.seedlingsocial.org/static/media/seedling-icon.19cfcf4c.svg"
                      onError={(e) => {
                        e.currentTarget.src = '/seedling-icon.19cfcf4c.svg'
                      }}
                      alt="Seedling"
                      className="w-full h-full object-contain"
                    />
                  </div>
                  {/* Notification Content */}
                  <div className="text-[13.5px] sm:text-[14px] text-[#11221C] leading-snug font-normal select-text break-words min-w-0">
                    {scenario.inAppExperience}
                  </div>
                </div>
              ) : (
                <div className="border border-dashed border-[#DFE1E6] rounded-lg p-4 flex items-center justify-center text-xs text-[#6B778C] italic flex-1">
                  None
                </div>
              )}
            </div>

            {/* Call to Action (CTA) */}
            <div className="bg-white border border-[#DFE1E6] rounded-xl p-3.5 shadow-2xs flex flex-col">
              <div className="flex items-center justify-between mb-1.5">
                <div className="flex items-center gap-1.5 text-xs font-semibold text-[#6B778C]">
                  <ExternalLink className="w-3.5 h-3.5 text-[#6B778C]" />
                  <span>Call to Action (CTA)</span>
                </div>
                {scenario.cta && (
                  <button
                    type="button"
                    onClick={() => handleCopy('cta', scenario.cta)}
                    className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                    title="Copy CTA"
                  >
                    {copiedField === 'cta' ? (
                      <>
                        <Check className="w-3 h-3 text-[#00875A]" />
                        <span className="text-[#00875A] font-semibold">Copied</span>
                      </>
                    ) : (
                      <>
                        <Copy className="w-3 h-3" />
                        <span>Copy</span>
                      </>
                    )}
                  </button>
                )}
              </div>
              <p className="text-xs text-[#172B4D] leading-relaxed flex-1 whitespace-pre-wrap">
                {scenario.cta || <span className="text-[#6B778C] italic">None</span>}
              </p>
            </div>

            {/* QA Comments */}
            <div className="bg-white border border-[#DFE1E6] rounded-xl p-3.5 shadow-2xs flex flex-col">
              <div className="flex items-center justify-between mb-1.5">
                <div className="flex items-center gap-1.5 text-xs font-semibold text-[#6B778C]">
                  <MessageSquare className="w-3.5 h-3.5 text-[#6B778C]" />
                  <span>Comments & Notes</span>
                </div>
                {scenario.comments && scenario.comments.trim() && (
                  <button
                    type="button"
                    onClick={() => handleCopy('comments', scenario.comments || '')}
                    className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                    title="Copy comments"
                  >
                    {copiedField === 'comments' ? (
                      <>
                        <Check className="w-3 h-3 text-[#00875A]" />
                        <span className="text-[#00875A] font-semibold">Copied</span>
                      </>
                    ) : (
                      <>
                        <Copy className="w-3 h-3" />
                        <span>Copy</span>
                      </>
                    )}
                  </button>
                )}
              </div>
              {scenario.comments && scenario.comments.trim() ? (
                <p className="text-xs text-[#172B4D] leading-relaxed whitespace-pre-wrap flex-1">
                  {scenario.comments}
                </p>
              ) : (
                <p className="text-xs text-[#6B778C] italic flex-1 flex items-center">
                  No comments added.
                </p>
              )}
            </div>
          </div>

          {/* Extra Notes (if present) */}
          {scenario.notes && scenario.notes.trim() && (
            <div className="bg-[#FFF0B3]/50 border border-[#FFAB00]/50 rounded-xl p-3 flex items-start gap-2.5 text-xs">
              <FileText className="w-3.5 h-3.5 text-[#FF8B00] shrink-0 mt-0.5" />
              <div className="min-w-0 flex-1">
                <span className="text-xs font-semibold text-[#172B4D] block">Notes</span>
                <p className="text-xs text-[#172B4D] leading-relaxed whitespace-pre-wrap mt-0.5">
                  {scenario.notes}
                </p>
              </div>
            </div>
          )}
        </div>

        {/* Simple Footer */}
        <div className="px-5 py-3 border-t border-[#DFE1E6] bg-white flex items-center justify-between shrink-0 text-xs">
          <div className="text-xs text-[#6B778C]">
            Press <kbd className="px-1.5 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] text-xs font-medium border border-[#DFE1E6]">Esc</kbd> to close,{' '}
            <kbd className="px-1.5 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] text-xs font-medium border border-[#DFE1E6]">←</kbd>{' '}
            <kbd className="px-1.5 py-0.5 bg-[#EBECF0] rounded text-[#172B4D] text-xs font-medium border border-[#DFE1E6]">→</kbd> to navigate
          </div>
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 text-xs font-semibold text-[#42526E] bg-[#EBECF0] hover:bg-[#DFE1E6] hover:text-[#172B4D] rounded transition cursor-pointer"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}
