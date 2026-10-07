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

  // Parse bold introductory lead (actor name or lead phrase) and remaining body
  let boldLead = ''
  let remainingBody = rawBody

  if (rawBody) {
    // If starting with an actor/placeholder like "(Name)", "[Name]", or "First Last" followed by action verb
    // e.g. "(Name) has accepted your invitation" or "Narmatha Uit s has accepted your invitation"
    const actorMatch = rawBody.match(/^((?:\([^\)]+\)|\[[^\]]+\]|[A-Z][A-Za-z0-9\s.]{1,30}))\s+(has\s+[a-z]+|is\s+[a-z]+|accepted|invited|sent|made|commented|joined)\b(.*)$/is)
    if (actorMatch) {
      boldLead = actorMatch[1].trim()
      remainingBody = `${actorMatch[2]} ${actorMatch[3]}`.trim()
    } else {
      const firstSentenceMatch = rawBody.match(/^([^.!?]+[.!?])\s*(.*)$/s)
      if (firstSentenceMatch && firstSentenceMatch[2].trim()) {
        boldLead = firstSentenceMatch[1].trim()
        remainingBody = firstSentenceMatch[2].trim()
      } else {
        const dashMatch = rawBody.match(/^([^-–—]+[-–—])\s*(.*)$/s)
        if (dashMatch) {
          boldLead = dashMatch[1].trim()
          remainingBody = dashMatch[2].trim()
        } else {
          boldLead = ''
          remainingBody = rawBody
        }
      }
    }
  }

  return { boldLead, remainingBody, buttonText }
}

const SeedlingLogoWordmark: React.FC<{ className?: string }> = ({ className = 'h-7 sm:h-[30px] w-auto' }) => (
  <svg
    viewBox="0 0 1848.68 600"
    fill="#FCFCF9"
    xmlns="http://www.w3.org/2000/svg"
    className={`select-none shrink-0 ${className}`}
    aria-label="Seedling"
  >
    <path d="m139.53,326.75l49.35.41c.82,35.07,28.14,54.65,61.58,54.65,28.96,0,57.1-8.56,57.1-34.67s-23.25-38.34-60.36-44.45c-52.2-8.97-101.14-28.14-101.14-79.53,0-54.65,40.38-82.79,99.51-82.79,69.74,0,103.59,36.71,104.81,92.58l-48.94-.41c.41-35.89-29.36-48.12-57.51-48.12-33.03,0-48.53,15.5-48.53,33.44,0,22.02,24.06,32.63,56.69,39.15,55.87,10.2,104.41,23.65,104.41,83.61,0,48.94-35.07,85.24-105.22,85.24-62.4,0-110.52-32.63-111.75-99.1Z"/>
    <path d="m373.72,317.78c0-61.99,38.75-108.08,100.33-108.08s105.63,48.94,99.51,120.72h-152.94c3.26,32.22,18.76,55.06,53.43,55.06,26.1,0,45.68-12.64,50.57-31.4h46.49c-7.75,45.27-45.68,71.78-97.47,71.78-66.07,0-99.92-42.41-99.92-108.08Zm99.92-68.52c-32.63,0-48.12,21.21-51.79,49.76h105.22c-2.85-28.55-21.62-49.76-53.43-49.76Z"/>
    <path d="m596.43,317.78c0-61.99,38.75-108.08,100.33-108.08s105.63,48.94,99.51,120.72h-152.94c3.26,32.22,18.76,55.06,53.43,55.06,26.1,0,45.68-12.64,50.57-31.4h46.49c-7.75,45.27-45.68,71.78-97.47,71.78-66.07,0-99.92-42.41-99.92-108.08Zm99.92-68.52c-32.63,0-48.12,21.21-51.8,49.76h105.22c-2.85-28.55-21.62-49.76-53.43-49.76Z"/>
    <path d="m910.31,425.86c-49.35,0-92.58-40.38-92.58-108.08s43.23-108.08,92.58-108.08c36.71,0,61.18,18.76,73,49.76h4.49v-112.97h46.9v273.25h-46.9v-43.64h-4.49c-11.83,31-36.3,49.76-73,49.76Zm77.49-108.08c0-41.6-24.06-68.52-61.58-68.52-39.97,0-60.77,30.18-60.77,68.52s19.98,68.52,60.36,68.52c37.11,0,61.99-26.92,61.99-68.52Z"/>
    <path d="m1065.33,146.49h46.9v273.25h-46.9V146.49Z"/>
    <path d="m1141.46,146.49h49.76v40.78h-49.76v-40.78Zm1.22,69.33h46.9v203.92h-46.9v-203.92Z"/>
    <path d="m1218.8,215.82h46.9v48.94h4.08c9.38-33.85,31.4-55.06,71.37-55.06,45.68,0,73,34.67,73,88.91v121.13h-46.9v-112.56c0-35.89-18.76-55.06-48.12-55.06-31.81,0-53.43,23.66-53.43,69.33v98.29h-46.9v-203.92Z"/>
    <path d="m1728.88,167.67c.66-1.8-1.24-3.42-2.94-2.54-6.5,3.36-20.84,7.15-51.14,3.43-13.41-1.65-32.15-4.62-53.85,3.4-16.18,5.98-31.61,21.36-41.55,39.57-7.98-1.21-17.76-2.24-30.97-2.24-59.15,0-98.7,37.93-98.7,80.75,0,25.68,14.28,46.9,36.71,60.77v3.66c-22.02,4.09-49.35,22.83-49.35,55.06,0,29.77,24.06,46.5,53.83,46.5,44.46,0,71.79-39.16,100.33-39.16,14.69,0,23.65,9.78,23.65,22.02,0,13.46-11.83,25.7-33.04,25.7h-33.65v36.71h37.73c54.65,0,75.85-31.81,75.85-65.66,0-31.41-20.79-60.36-57.9-60.36-44.46,0-70.15,37.11-100.33,37.11-12.64,0-22.43-6.53-22.43-22.03,0-16.31,11.83-30.18,25.29-30.18,13.05,5.3,26.09,7.75,41.6,7.75,59.54,0,94.62-39.16,94.62-78.3,0-34.18-23.85-52-23.85-52,77.44.26,103.33-51.53,110.09-69.97Zm-180.86,162.33c-28.95,0-51.8-15.9-51.8-40.78s23.26-41.61,52.21-41.61,51.8,16.32,51.8,41.2-24.08,41.19-52.21,41.19Z"/>
  </svg>
)

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

              {/* Exact Seedling Email Template Card */}
              <div className="bg-white border border-[#DFE1E6] rounded-[20px] overflow-hidden shadow-[0_4px_24px_rgba(0,0,0,0.06),0_1px_2px_rgba(0,0,0,0.04)] flex flex-col flex-1 transition-all">
                {/* Email Subject Line Header Bar */}
                <div className="px-4.5 py-2.5 bg-[#F8F9FA] border-b border-[#EBECF0] flex items-center justify-between gap-3 shrink-0">
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

                {/* Lush Green-to-Lime Gradient Banner with Official Seedling Wordmark */}
                <div
                  className="px-6 py-5 sm:px-8 sm:py-6 flex items-center justify-between select-none shrink-0"
                  style={{
                    background:
                      'linear-gradient(90deg, #33634C 0%, #396D54 12%, #458A69 38%, #4B9873 55%, #58A981 70%, #64BA8F 82%, #85C380 92%, #B7D170 100%)',
                  }}
                >
                  <SeedlingLogoWordmark />
                </div>

                {/* Email Body Content */}
                <div className="px-6 py-6 sm:px-8 sm:py-7 bg-white flex flex-col justify-between flex-1">
                  {emailTemplate.boldLead || emailTemplate.remainingBody ? (
                    <p className="text-[14px] sm:text-[14.5px] text-[#1C1C1E] leading-relaxed">
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

                  {/* Left-Aligned Official Pine Green Pill CTA Button */}
                  {emailTemplate.buttonText && (
                    <div className="mt-6 sm:mt-7 flex justify-start">
                      <button
                        type="button"
                        className="bg-[#33634C] hover:bg-[#28523E] text-white font-semibold text-[13.5px] sm:text-[14px] px-7 py-2.5 sm:py-3 rounded-full shadow-xs hover:shadow-sm transition cursor-pointer"
                      >
                        {emailTemplate.buttonText}
                      </button>
                    </div>
                  )}
                </div>

                {/* Exact Brand Gradient Divider Line Ending The Template */}
                <div
                  className="h-[3px] w-full shrink-0"
                  style={{
                    background:
                      'linear-gradient(90deg, #4C9873 0%, #54A57D 20%, #5DB188 40%, #62B88D 50%, #74BE8A 60%, #92C57D 70%, #B1CC70 80%, #CFD363 90%, #EEDB61 100%)',
                  }}
                />
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
