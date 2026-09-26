import React, { useEffect, useState } from 'react'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { JiraStatusBadge } from './JiraStatusBadge'
import {
  X,
  ChevronLeft,
  ChevronRight,
  ChevronDown,
  ExternalLink,
  MessageSquare,
  FileText,
  BookOpen,
} from 'lucide-react'
import { ScenarioAttachmentsSection } from './ScenarioAttachmentsSection'

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
  onAttachmentCountChange?: (scenarioId: string, count: number) => void
  onOpenRuleBook?: (scenario: NotificationScenario) => void
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
  onAttachmentCountChange,
  onOpenRuleBook,
}) => {
  const [isSpecsExpanded, setIsSpecsExpanded] = useState<boolean>(false)

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

  // Prevent background scrollbar jump & page jitter when modal opens
  useEffect(() => {
    if (!isOpen) return
    const originalOverflow = document.body.style.overflow
    const originalPaddingRight = document.body.style.paddingRight
    const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth
    if (scrollbarWidth > 0) {
      document.body.style.paddingRight = `${scrollbarWidth}px`
    }
    document.body.style.overflow = 'hidden'

    return () => {
      document.body.style.overflow = originalOverflow
      document.body.style.paddingRight = originalPaddingRight
    }
  }, [isOpen])

  if (!isOpen || !scenario) return null

  const emailTemplate = parseEmailTemplate(scenario)

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-900/40 backdrop-blur-xs transition-opacity duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-xl shadow-[0_20px_60px_-15px_rgba(9,30,66,0.25),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] w-full max-w-[1040px] max-h-[92vh] sm:max-h-[94vh] flex flex-col overflow-hidden transition-all duration-150"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Clean Header: Event Title + Interactive Status & Navigation */}
        <div className="px-3.5 sm:px-5 py-3 sm:py-3.5 border-b border-[#EBECF0] bg-white flex flex-wrap items-center justify-between gap-2.5 sm:gap-4 shrink-0">
          <div className="flex flex-wrap items-center gap-2 sm:gap-3 min-w-0 flex-1">
            <h1 className="text-sm sm:text-base md:text-lg font-bold text-[#172B4D] tracking-tight truncate max-w-full" title={scenario.governanceEvent}>
              {scenario.governanceEvent}
            </h1>
            {onUpdateStatus && allStatuses && (
              <div className="shrink-0 flex items-center gap-1.5 flex-wrap">
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
          <div className="flex items-center gap-1.5 shrink-0 ml-auto">
            {onOpenRuleBook && (
              <button
                type="button"
                onClick={() => onOpenRuleBook(scenario)}
                className="inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-semibold text-[#0052CC] bg-[#F4F5F7] hover:bg-[#EBECF0] border border-[#DFE1E6] rounded-[3px] transition-colors shadow-2xs cursor-pointer mr-1"
                title={`View Notification Rule Book (${scenario.rule?.ruleId || scenario.ruleId || 'Rules'})`}
              >
                <BookOpen className="w-3.5 h-3.5 text-[#0052CC]" />
                <span>Rule Book</span>
              </button>
            )}
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
        <div className="flex-1 p-3.5 sm:p-4 md:p-5 space-y-4 overflow-y-auto overscroll-contain bg-[#F4F5F7]">
          {/* SECTION 1: Notification Channels (Balanced 2-Column Architecture) */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 items-start">
            {/* LEFT COLUMN: Mobile Channels + QA Notes */}
            <div className="space-y-4">
              {/* 1. iOS iPhone Push Notification Banner Preview */}
              <div className="space-y-1.5">
                <div className="px-0.5">
                  <span className="text-xs font-semibold text-[#6B778C]">
                    Push Notification Preview
                  </span>
                </div>

                {/* Exact Apple iOS iPhone Notification Banner Card */}
                <div className="bg-[#F2F2F7]/95 border border-black/5 rounded-[20px] p-4 shadow-[0_4px_20px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)] transition-all">
                  {/* iOS Header */}
                  <div className="flex items-center justify-between pb-1.5">
                    <div className="flex items-center gap-2">
                      {/* Seedling App Icon */}
                      <div className="w-5 h-5 rounded-[5px] flex items-center justify-center shadow-xs shrink-0 overflow-hidden">
                        <img
                          src="/seedling-logo.png"
                          onError={(e) => {
                            e.currentTarget.src =
                              'https://ci3.googleusercontent.com/meips/ADKq_Nb8_5vcgoSXqTmjjfnfqvHf0u5rSIkhLTzmMlql4lKWOoA8wILaqJiXfu_TZSJ7DriKUCZsks4KyVAgqw4PYBo6DAaWTvLh2wbCRcUkRIYu=s0-d-e1-ft#https://dev.seedlingsocial.org/seedling/static/favicon.png'
                          }}
                          alt="Seedling"
                          className="w-full h-full object-cover"
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
                <div className="px-0.5">
                  <span className="text-xs font-semibold text-[#6B778C]">
                    In-App Notification Preview
                  </span>
                </div>

                {scenario.inAppExperience ? (
                  /* Official Seedling In-App Notification Card */
                  <div className="bg-[#F2F2F7]/95 border border-[#4D9873] rounded-[18px] p-3 sm:px-4 sm:py-3.5 flex items-center gap-3.5 shadow-[0_4px_20px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)] transition-all">
                    {/* Round Seedling Avatar */}
                    <div className="w-11 h-11 rounded-full border border-black/5 bg-[#F2F2F7] flex items-center justify-center p-2.5 shrink-0 shadow-2xs">
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
                  <div className="bg-[#F2F2F7]/95 border border-dashed border-black/10 rounded-[18px] p-3.5 flex items-center justify-center text-xs text-[#6B778C] italic">
                    No in-app notification configured
                  </div>
                )}
              </div>

              {/* 3. Target CTA */}
              <div className="space-y-1.5">
                <div className="px-0.5">
                  <span className="text-xs font-semibold text-[#6B778C]">
                    Target CTA
                  </span>
                </div>

                <div className="bg-[#F2F2F7]/95 border border-black/5 rounded-[18px] p-3 sm:p-3.5 shadow-[0_4px_20px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)]">
                  <div className="flex items-center gap-2 min-w-0">
                    <ExternalLink className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
                    <p className="text-[13px] font-semibold text-[#0052CC] break-words select-text">
                      {scenario.cta || (
                        <span className="text-[#8E8E93] italic font-normal">
                          No target CTA specified
                        </span>
                      )}
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* RIGHT COLUMN: Email Notification Preview (Official Seedling Social Giving Email Template) */}
            <div className="space-y-1.5 flex flex-col h-full">
              <div className="px-0.5">
                <span className="text-xs font-semibold text-[#6B778C]">
                  Email Notification Preview
                </span>
              </div>

              {/* Exact Seedling Social Giving Email Template Card */}
              <div className="bg-[#F2F2F7]/95 border border-black/5 rounded-[20px] overflow-hidden shadow-[0_4px_20px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)] flex flex-col flex-1 transition-all">
                {/* Email Subject Line Header Bar */}
                <div className="px-4 py-2.5 bg-[#EAEAEE]/70 border-b border-black/5 flex items-center justify-between gap-3 shrink-0">
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
                </div>

                {/* Solid Green Header Banner with Seedling Logo */}
                <div className="bg-[#1E874B] px-5 py-3.5 sm:py-4 flex items-center justify-center gap-2.5 select-none shadow-xs shrink-0">
                  <img
                    src="/seedling-logo.png"
                    onError={(e) => {
                      e.currentTarget.src =
                        'https://ci3.googleusercontent.com/meips/ADKq_Nb8_5vcgoSXqTmjjfnfqvHf0u5rSIkhLTzmMlql4lKWOoA8wILaqJiXfu_TZSJ7DriKUCZsks4KyVAgqw4PYBo6DAaWTvLh2wbCRcUkRIYu=s0-d-e1-ft#https://dev.seedlingsocial.org/seedling/static/favicon.png'
                    }}
                    alt="Seedling"
                    className="w-6 h-6 object-contain shrink-0 rounded-xs"
                  />
                  <span className="font-bold text-white text-[16px] sm:text-[17px] tracking-tight">
                    Seedling Social Giving
                  </span>
                </div>

                {/* Email Body Content */}
                <div className="px-6 py-6 sm:px-8 sm:py-7 bg-[#F2F2F7]/95 flex flex-col justify-between flex-1">
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

          {/* SECTION 2: Expandable Specifications & Notes Section */}
          <div className="pt-0.5">
            <button
              type="button"
              onClick={() => setIsSpecsExpanded((prev) => !prev)}
              className="inline-flex items-center gap-1.5 text-xs font-semibold text-[#6B778C] hover:text-[#0052CC] transition cursor-pointer py-1 px-1 rounded hover:bg-slate-200/50 select-none"
            >
              <ChevronDown
                className={`w-3.5 h-3.5 transition-transform duration-200 ${
                  isSpecsExpanded ? 'rotate-180' : ''
                }`}
              />
              <span>{isSpecsExpanded ? 'Hide Specifications & Notes' : 'Expand Specifications & Notes'}</span>
            </button>

            {isSpecsExpanded && (
              <div className="space-y-3 pt-2 mt-1 border-t border-[#EBECF0]">
                {/* 4 Strategic Parameters */}
                <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4 px-1">
                  {/* Trigger */}
                  <div>
                    <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Trigger
                    </span>
                    <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                      {scenario.trigger || <span className="text-[#8E8E93] italic font-normal">None</span>}
                    </p>
                  </div>

                  {/* Audience */}
                  <div>
                    <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Audience
                    </span>
                    <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                      {scenario.audience || <span className="text-[#8E8E93] italic font-normal">None</span>}
                    </p>
                  </div>

                  {/* Objective */}
                  <div>
                    <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Objective
                    </span>
                    <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                      {scenario.communicationObjective || <span className="text-[#8E8E93] italic font-normal">None</span>}
                    </p>
                  </div>

                  {/* Desired Outcome */}
                  <div>
                    <span className="text-[10.5px] font-bold text-[#6B778C] uppercase tracking-wider">
                      Desired Outcome
                    </span>
                    <p className="text-[12.5px] font-medium text-[#172B4D] mt-1 leading-snug break-words">
                      {scenario.desiredOutcome || <span className="text-[#8E8E93] italic font-normal">None</span>}
                    </p>
                  </div>
                </div>

                {/* Notes Block */}
                <div className="bg-[#F2F2F7]/95 border border-black/5 rounded-[18px] p-3.5 shadow-[0_4px_20px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)] space-y-2.5">
                  <div className="flex items-center gap-1.5">
                    <span className="text-xs font-semibold text-[#6B778C]">Notes</span>
                  </div>

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
                    <div className={`flex items-start gap-2.5 text-xs ${scenario.notes && scenario.notes.trim() ? 'pt-2.5 border-t border-black/5' : ''}`}>
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
                      No notes recorded for this scenario.
                    </p>
                  ) : null}
                </div>
              </div>
            )}
          </div>

          {/* Cloudflare R2 Visual Proof & Screenshots Section */}
          <div className="pt-2.5 sm:pt-3 border-t border-[#EBECF0]">
            <ScenarioAttachmentsSection
              scenarioId={scenario.id}
              scenarioKey={scenario.key}
              onAttachmentsChange={(count) => onAttachmentCountChange?.(scenario.id, count)}
            />
          </div>
        </div>
      </div>
    </div>
  )
}
