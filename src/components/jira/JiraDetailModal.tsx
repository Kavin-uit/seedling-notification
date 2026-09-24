import React, { useEffect, useState } from 'react'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { JiraStatusBadge } from './JiraStatusBadge'
import {
  X,
  Copy,
  Check,
  ChevronLeft,
  ChevronRight,
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

  // Parse bold introductory lead (first sentence) and remaining body
  let boldLead = ''
  let remainingBody = rawBody

  if (rawBody) {
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
        className="bg-white rounded-xl shadow-[0_20px_60px_-15px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] w-full max-w-[1020px] max-h-[94vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-150"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Clean Header: Event Title + Interactive Status & Navigation */}
        <div className="px-5 py-3.5 border-b border-[#EBECF0] bg-white flex items-center justify-between gap-4 shrink-0">
          <div className="flex items-center gap-3 min-w-0 flex-1">
            <h1 className="text-base sm:text-lg font-bold text-[#172B4D] tracking-tight truncate" title={scenario.governanceEvent}>
              {scenario.governanceEvent}
            </h1>
            {onUpdateStatus && allStatuses && (
              <div className="shrink-0 flex items-center gap-2">
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
              className="w-7 h-7 rounded border border-[#DFE1E6] bg-white flex items-center justify-center text-[#5E6C84] hover:text-[#172B4D] hover:bg-[#F4F5F7] transition cursor-pointer ml-1 shadow-2xs"
              title="Close (Esc)"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Modal Main Body */}
        <div className="flex-1 p-4 sm:p-5 space-y-4 overflow-y-auto bg-[#F4F5F7]">
          {/* SECTION 1: Strategic Specification Strip (5 Parameters with Target CTA integrated) */}
          <div className="bg-white border border-[#DFE1E6] rounded-xl p-3.5 shadow-2xs">
            <div className="grid grid-cols-2 md:grid-cols-5 gap-3 divide-y md:divide-y-0 md:divide-x divide-[#EBECF0]">
              {/* Trigger */}
              <div className="px-2 pt-1 md:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                    Trigger
                  </span>
                  {scenario.trigger && (
                    <button
                      type="button"
                      onClick={() => handleCopy('trigger', scenario.trigger)}
                      className="text-[#6B778C] hover:text-[#0052CC] opacity-0 group-hover:opacity-100 transition p-0.5 rounded cursor-pointer"
                      title="Copy trigger"
                    >
                      {copiedField === 'trigger' ? <Check className="w-3 h-3 text-[#00875A]" /> : <Copy className="w-3 h-3" />}
                    </button>
                  )}
                </div>
                <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                  {scenario.trigger || <span className="text-[#8E8E93] italic font-normal">None</span>}
                </p>
              </div>

              {/* Audience */}
              <div className="px-2 pt-2 md:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                    Audience
                  </span>
                  {scenario.audience && (
                    <button
                      type="button"
                      onClick={() => handleCopy('audience', scenario.audience)}
                      className="text-[#6B778C] hover:text-[#0052CC] opacity-0 group-hover:opacity-100 transition p-0.5 rounded cursor-pointer"
                      title="Copy audience"
                    >
                      {copiedField === 'audience' ? <Check className="w-3 h-3 text-[#00875A]" /> : <Copy className="w-3 h-3" />}
                    </button>
                  )}
                </div>
                <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                  {scenario.audience || <span className="text-[#8E8E93] italic font-normal">None</span>}
                </p>
              </div>

              {/* Objective */}
              <div className="px-2 pt-2 md:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                    Objective
                  </span>
                  {scenario.communicationObjective && (
                    <button
                      type="button"
                      onClick={() => handleCopy('objective', scenario.communicationObjective)}
                      className="text-[#6B778C] hover:text-[#0052CC] opacity-0 group-hover:opacity-100 transition p-0.5 rounded cursor-pointer"
                      title="Copy objective"
                    >
                      {copiedField === 'objective' ? <Check className="w-3 h-3 text-[#00875A]" /> : <Copy className="w-3 h-3" />}
                    </button>
                  )}
                </div>
                <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                  {scenario.communicationObjective || <span className="text-[#8E8E93] italic font-normal">None</span>}
                </p>
              </div>

              {/* Desired Outcome */}
              <div className="px-2 pt-2 md:pt-0 relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                    Desired Outcome
                  </span>
                  {scenario.desiredOutcome && (
                    <button
                      type="button"
                      onClick={() => handleCopy('outcome', scenario.desiredOutcome)}
                      className="text-[#6B778C] hover:text-[#0052CC] opacity-0 group-hover:opacity-100 transition p-0.5 rounded cursor-pointer"
                      title="Copy outcome"
                    >
                      {copiedField === 'outcome' ? <Check className="w-3 h-3 text-[#00875A]" /> : <Copy className="w-3 h-3" />}
                    </button>
                  )}
                </div>
                <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                  {scenario.desiredOutcome || <span className="text-[#8E8E93] italic font-normal">None</span>}
                </p>
              </div>

              {/* Target CTA Action */}
              <div className="px-2.5 pt-2 md:pt-0 col-span-2 md:col-span-1 bg-[#FAFBFC] -my-1 -mr-1 p-2 rounded-lg border border-[#EBECF0] relative group">
                <div className="flex items-center justify-between">
                  <span className="text-[10.5px] font-bold text-[#0052CC] uppercase tracking-wider flex items-center gap-1">
                    <ExternalLink className="w-3 h-3" />
                    <span>Target CTA</span>
                  </span>
                  {scenario.cta && (
                    <button
                      type="button"
                      onClick={() => handleCopy('cta', scenario.cta)}
                      className="text-[#6B778C] hover:text-[#0052CC] p-0.5 rounded transition cursor-pointer"
                      title="Copy CTA action"
                    >
                      {copiedField === 'cta' ? <Check className="w-3 h-3 text-[#00875A]" /> : <Copy className="w-3 h-3" />}
                    </button>
                  )}
                </div>
                <p className="text-[12px] font-semibold text-[#0052CC] mt-1 leading-snug break-words">
                  {scenario.cta || <span className="text-[#8E8E93] italic font-normal">None</span>}
                </p>
              </div>
            </div>
          </div>

          {/* SECTION 2: Notification Channels (Balanced 2-Column Architecture) */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 items-start">
            {/* LEFT COLUMN: Mobile Channels + QA Notes */}
            <div className="space-y-4">
              {/* 1. iOS iPhone Push Notification Banner Preview */}
              <div className="space-y-1.5">
                <div className="flex items-center justify-between px-0.5">
                  <span className="text-xs font-semibold text-[#6B778C]">
                    Push Notification Preview
                  </span>
                  {(scenario.pushBody || scenario.pushSubject) && (
                    <button
                      type="button"
                      onClick={() => {
                        const fullPush = [
                          scenario.pushSubject ? `Title: ${scenario.pushSubject}` : '',
                          scenario.pushBody || '',
                        ]
                          .filter(Boolean)
                          .join('\n\n')
                        handleCopy('pushBody', fullPush)
                      }}
                      className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                      title="Copy push notification"
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
                <div className="bg-[#F2F2F7]/95 border border-black/5 rounded-[20px] p-4 shadow-[0_4px_20px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)] transition-all">
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
                  <div className="font-semibold text-[13.5px] text-[#1C1C1E] leading-snug tracking-tight mt-1">
                    {scenario.pushSubject || <span className="text-[#8E8E93] italic font-normal">No subject line</span>}
                  </div>

                  {/* iOS Message Body */}
                  <div className="text-[13px] text-[#3A3A3C] leading-snug mt-0.5 whitespace-pre-wrap">
                    {scenario.pushBody || <span className="text-[#8E8E93] italic">No message body</span>}
                  </div>
                </div>
              </div>

              {/* 2. Official Seedling In-App Notification Feed Preview */}
              <div className="space-y-1.5">
                <div className="flex items-center justify-between px-0.5">
                  <span className="text-xs font-semibold text-[#6B778C]">
                    In-App Notification Preview
                  </span>
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
                  <div className="bg-white border border-[#4D9873] rounded-lg p-3 sm:px-4 sm:py-3.5 flex items-center gap-3.5 shadow-2xs transition-all">
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
                    <div className="text-[13.5px] text-[#11221C] leading-snug font-normal select-text break-words min-w-0 flex-1">
                      {scenario.inAppExperience}
                    </div>
                  </div>
                ) : (
                  <div className="bg-white border border-dashed border-[#DFE1E6] rounded-lg p-3.5 flex items-center justify-center text-xs text-[#6B778C] italic">
                    No in-app notification configured
                  </div>
                )}
              </div>

              {/* 3. QA Notes & Verification Logic (Balances left column with Email) */}
              <div className="space-y-1.5">
                <div className="flex items-center justify-between px-0.5">
                  <span className="text-xs font-semibold text-[#6B778C] flex items-center gap-1.5">
                    <MessageSquare className="w-3.5 h-3.5 text-[#6B778C]" />
                    <span>QA Notes & Verification Logic</span>
                  </span>
                  {(scenario.comments || scenario.notes) && (
                    <button
                      type="button"
                      onClick={() => {
                        const fullNotes = [
                          scenario.notes ? `Logic Note: ${scenario.notes}` : '',
                          scenario.comments ? `QA Comments: ${scenario.comments}` : '',
                        ]
                          .filter(Boolean)
                          .join('\n\n')
                        handleCopy('qaNotes', fullNotes)
                      }}
                      className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                      title="Copy notes and comments"
                    >
                      {copiedField === 'qaNotes' ? (
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

                <div className="bg-white border border-[#DFE1E6] rounded-xl p-3.5 shadow-2xs space-y-2.5">
                  {scenario.notes && scenario.notes.trim() && (
                    <div className="flex items-start gap-2.5 text-xs">
                      <FileText className="w-3.5 h-3.5 text-[#0052CC] shrink-0 mt-0.5" />
                      <div className="min-w-0 flex-1">
                        <span className="text-[10px] font-bold uppercase tracking-wider text-[#6B778C] block">
                          Business Rule / Trigger Note
                        </span>
                        <p className="text-xs text-[#172B4D] leading-relaxed whitespace-pre-wrap mt-0.5">
                          {scenario.notes}
                        </p>
                      </div>
                    </div>
                  )}

                  {scenario.comments && scenario.comments.trim() ? (
                    <div className={`flex items-start gap-2.5 text-xs ${scenario.notes && scenario.notes.trim() ? 'pt-2.5 border-t border-[#EBECF0]' : ''}`}>
                      <MessageSquare className="w-3.5 h-3.5 text-[#00875A] shrink-0 mt-0.5" />
                      <div className="min-w-0 flex-1">
                        <span className="text-[10px] font-bold uppercase tracking-wider text-[#6B778C] block">
                          QA Comments
                        </span>
                        <p className="text-xs text-[#172B4D] leading-relaxed whitespace-pre-wrap mt-0.5">
                          {scenario.comments}
                        </p>
                      </div>
                    </div>
                  ) : !scenario.notes ? (
                    <p className="text-xs text-[#6B778C] italic">
                      No QA comments or special trigger notes recorded for this scenario.
                    </p>
                  ) : null}
                </div>
              </div>
            </div>

            {/* RIGHT COLUMN: Email Notification Preview (Official Seedling Social Giving Email Template) */}
            <div className="space-y-1.5 flex flex-col h-full">
              <div className="flex items-center justify-between px-0.5">
                <span className="text-xs font-semibold text-[#6B778C]">
                  Email Notification Preview
                </span>
                {(scenario.emailBody || scenario.emailSubject) && (
                  <button
                    type="button"
                    onClick={() => {
                      const fullEmail = [
                        scenario.emailSubject ? `Subject: ${scenario.emailSubject}` : '',
                        scenario.emailBody || '',
                      ]
                        .filter(Boolean)
                        .join('\n\n')
                      handleCopy('emailFull', fullEmail)
                    }}
                    className="text-xs font-medium text-[#0052CC] hover:text-[#0747A6] flex items-center gap-1 cursor-pointer transition"
                    title="Copy full email (Subject + Body)"
                  >
                    {copiedField === 'emailFull' ? (
                      <>
                        <Check className="w-3 h-3 text-[#00875A]" />
                        <span className="text-[#00875A] font-semibold">Copied</span>
                      </>
                    ) : (
                      <>
                        <Copy className="w-3 h-3" />
                        <span>Copy All</span>
                      </>
                    )}
                  </button>
                )}
              </div>

              {/* Exact Seedling Social Giving Email Template Card */}
              <div className="bg-white border border-[#DFE1E6] rounded-xl overflow-hidden shadow-[0_4px_20px_rgba(0,0,0,0.06)] flex flex-col flex-1 transition-all">
                {/* Email Client Envelope Header */}
                <div className="px-4 py-3 bg-[#FAFBFC] border-b border-[#EBECF0] space-y-1.5 shrink-0">
                  <div className="flex items-center justify-between text-[11px] text-[#6B778C]">
                    <div className="flex items-center gap-1.5 truncate">
                      <span className="font-semibold text-[#42526E]">From:</span>
                      <span className="text-[#172B4D] font-medium">Seedling Social Giving</span>
                      <span className="text-[#8E8E93] hidden sm:inline">&lt;notifications@seedlingsocial.org&gt;</span>
                    </div>
                    <div className="flex items-center gap-1 shrink-0">
                      <span className="font-semibold text-[#42526E]">To:</span>
                      <span className="text-[#172B4D] font-medium">{scenario.audience || 'User'}</span>
                    </div>
                  </div>

                  {/* Subject Line */}
                  <div className="flex items-center justify-between gap-3 pt-1.5 border-t border-[#EBECF0]">
                    <div className="flex items-baseline gap-2 min-w-0 flex-1">
                      <span className="text-[11px] font-bold text-[#5E6C84] uppercase tracking-wider shrink-0 select-none">
                        Subject:
                      </span>
                      <span
                        className="text-xs sm:text-[13.5px] font-semibold text-[#172B4D] truncate select-text"
                        title={scenario.emailSubject}
                      >
                        {scenario.emailSubject || (
                          <span className="text-[#8E8E93] italic font-normal">
                            No subject line configured
                          </span>
                        )}
                      </span>
                    </div>
                    {scenario.emailSubject && (
                      <button
                        type="button"
                        onClick={() => handleCopy('emailSubject', scenario.emailSubject)}
                        className="text-[#6B778C] hover:text-[#0052CC] p-1 rounded hover:bg-[#EBECF0] transition cursor-pointer shrink-0"
                        title="Copy email subject"
                      >
                        {copiedField === 'emailSubject' ? (
                          <Check className="w-3.5 h-3.5 text-[#00875A]" />
                        ) : (
                          <Copy className="w-3.5 h-3.5" />
                        )}
                      </button>
                    )}
                  </div>
                </div>

                {/* Solid Green Header Banner with Given Logo Without Modifications */}
                <div className="bg-[#1E874B] px-5 py-3.5 sm:py-4 flex items-center justify-center gap-2.5 select-none shadow-xs shrink-0">
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
                <div className="px-6 py-6 sm:px-8 sm:py-7 bg-white flex flex-col justify-between flex-1">
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
        </div>
      </div>
    </div>
  )
}
