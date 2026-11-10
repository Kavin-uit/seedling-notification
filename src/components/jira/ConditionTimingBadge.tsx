import React, { useState, useRef, useEffect, useLayoutEffect, useCallback } from 'react'
import { createPortal } from 'react-dom'
import type { NotificationScenario } from '../../types/notification'
import { getNotificationTiming } from '../../utils/notificationTiming'
import { Clock, Info, X, ShieldCheck, Moon, Globe, Zap } from 'lucide-react'

interface ConditionTimingBadgeProps {
  scenario: NotificationScenario | null
  className?: string
}

interface PopoverCoords {
  top?: number
  bottom?: number
  left: number
  width: number
  maxHeight: number
}

const POPOVER_MAX_WIDTH = 400
const POPOVER_MAX_HEIGHT = 560
const VIEWPORT_MARGIN = 12
const GAP = 8

const FONT_STACK = '-apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Helvetica Neue", sans-serif'

export const ConditionTimingBadge: React.FC<ConditionTimingBadgeProps> = ({ scenario, className = '' }) => {
  const [isOpen, setIsOpen] = useState(false)
  const [coords, setCoords] = useState<PopoverCoords | null>(null)
  const triggerRef = useRef<HTMLButtonElement>(null)
  const popoverRef = useRef<HTMLDivElement>(null)
  const timingInfo = getNotificationTiming(scenario)

  const close = useCallback(() => setIsOpen(false), [])

  /** Place the popover under the trigger, or above it when there is more room there; never off-screen. */
  const updateCoords = useCallback(() => {
    const trigger = triggerRef.current
    if (!trigger) return
    const rect = trigger.getBoundingClientRect()
    const vw = window.innerWidth
    const vh = window.innerHeight
    const width = Math.min(POPOVER_MAX_WIDTH, vw - VIEWPORT_MARGIN * 2)
    const left = Math.max(VIEWPORT_MARGIN, Math.min(vw - width - VIEWPORT_MARGIN, rect.left))
    const spaceBelow = vh - rect.bottom - GAP - VIEWPORT_MARGIN
    const spaceAbove = rect.top - GAP - VIEWPORT_MARGIN
    const openUp = spaceBelow < 320 && spaceAbove > spaceBelow

    setCoords(
      openUp
        ? { bottom: vh - rect.top + GAP, left, width, maxHeight: Math.min(POPOVER_MAX_HEIGHT, spaceAbove) }
        : { top: rect.bottom + GAP, left, width, maxHeight: Math.min(POPOVER_MAX_HEIGHT, spaceBelow) }
    )
  }, [])

  useLayoutEffect(() => {
    if (isOpen) updateCoords()
  }, [isOpen, updateCoords])

  // Close on outside click, Escape, resize, or scrolling anything other than the popover itself.
  useEffect(() => {
    if (!isOpen) return
    const handlePointerDown = (e: MouseEvent) => {
      const target = e.target as Node
      if (popoverRef.current?.contains(target) || triggerRef.current?.contains(target)) return
      close()
    }
    // Capture phase on window, so Escape closes only the popover and never reaches the modal's own Escape handler.
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        e.stopPropagation()
        close()
        triggerRef.current?.focus()
      }
    }
    const handleScroll = (e: Event) => {
      if (popoverRef.current && e.target instanceof Node && popoverRef.current.contains(e.target)) return
      close()
    }
    document.addEventListener('mousedown', handlePointerDown)
    window.addEventListener('keydown', handleKeyDown, true)
    window.addEventListener('scroll', handleScroll, true)
    window.addEventListener('resize', close)
    return () => {
      document.removeEventListener('mousedown', handlePointerDown)
      window.removeEventListener('keydown', handleKeyDown, true)
      window.removeEventListener('scroll', handleScroll, true)
      window.removeEventListener('resize', close)
    }
  }, [isOpen, close])

  const quietExempt = /^exempt/i.test(timingInfo.quietHoursStatus)

  return (
    <div className={`relative inline-block ${className}`} style={{ fontFamily: FONT_STACK }}>
      <button
        ref={triggerRef}
        type="button"
        onClick={(e) => {
          e.stopPropagation()
          setIsOpen((prev) => !prev)
        }}
        aria-haspopup="dialog"
        aria-expanded={isOpen}
        className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full border text-[11px] transition-colors cursor-pointer select-none focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#007AFF]/40 ${
          isOpen
            ? 'bg-[#E8F1FF] border-[#007AFF]/30'
            : 'bg-[#F2F2F7] border-black/[0.08] hover:bg-[#E5E5EA] active:bg-[#D1D1D6]'
        }`}
        title="View when the recipient receives this notification"
      >
        <Clock className="w-3.5 h-3.5 text-[#007AFF] shrink-0" />
        <span className="text-[#8E8E93] font-medium">Recv:</span>
        <span className="truncate max-w-[200px] font-semibold text-[#1C1C1E]">
          {timingInfo.badgeShortLabel || timingInfo.badgeLabel}
        </span>
        <Info className="w-3 h-3 text-[#8E8E93] shrink-0 ml-0.5" />
      </button>

      {isOpen &&
        coords &&
        createPortal(
          <div
            ref={popoverRef}
            role="dialog"
            aria-label="Notification delivery timing"
            onMouseDown={(e) => e.stopPropagation()}
            style={{
              position: 'fixed',
              top: coords.top,
              bottom: coords.bottom,
              left: coords.left,
              width: coords.width,
              maxHeight: coords.maxHeight,
              zIndex: 99999,
              fontFamily: FONT_STACK,
            }}
            className="flex flex-col bg-white rounded-2xl border border-black/[0.08] shadow-[0_12px_32px_rgba(15,23,42,0.16),0_2px_6px_rgba(15,23,42,0.06)] text-[#1C1C1E] overflow-hidden motion-safe:animate-in motion-safe:fade-in motion-safe:zoom-in-95 motion-safe:duration-100"
          >
            {/* Header (fixed) */}
            <div className="flex items-start gap-3 px-4 pt-4 pb-3 border-b border-black/[0.06] shrink-0">
              <div className="w-8 h-8 rounded-[10px] bg-[#007AFF]/10 flex items-center justify-center shrink-0">
                <Clock className="w-4 h-4 text-[#007AFF]" />
              </div>
              <div className="min-w-0 flex-1">
                <h4 className="text-[14px] font-semibold leading-tight tracking-tight">Notification Delivery Timing</h4>
                <p className="text-[11.5px] text-[#8E8E93] leading-snug mt-0.5">
                  When the recipient gets it once the condition is met
                </p>
              </div>
              <button
                type="button"
                onClick={close}
                className="w-7 h-7 rounded-full bg-[#F2F2F7] text-[#636366] hover:bg-[#E5E5EA] hover:text-[#1C1C1E] flex items-center justify-center cursor-pointer transition-colors shrink-0 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#007AFF]/40"
                aria-label="Close"
              >
                <X className="w-3.5 h-3.5 stroke-[2.5]" />
              </button>
            </div>

            {/* Body (scrolls on its own) */}
            <div className="flex-1 min-h-0 overflow-y-auto overscroll-contain px-4 py-3.5 space-y-3" style={{ contain: 'content' }}>
              {/* Summary */}
              <div className="flex items-center justify-between gap-3">
                <div className="flex items-center gap-2 min-w-0">
                  <span className={`w-2 h-2 rounded-full shrink-0 ${timingInfo.dotColor}`} />
                  <span className="text-[15px] font-semibold tracking-tight truncate">{timingInfo.badgeLabel}</span>
                </div>
                {timingInfo.ruleId && (
                  <span className="font-mono text-[10.5px] font-semibold text-[#007AFF] bg-[#007AFF]/[0.08] px-2 py-0.5 rounded-full shrink-0">
                    {timingInfo.ruleId}
                  </span>
                )}
              </div>

              {/* Schedule */}
              <div className="rounded-xl bg-[#F7F7F9] border border-black/[0.04] px-3.5 py-3">
                <span className="block text-[10px] font-semibold tracking-[0.08em] uppercase text-[#8E8E93] mb-1">
                  Receive schedule
                </span>
                <p className="text-[13px] leading-relaxed text-[#2C2C2E]">{timingInfo.fullSchedule}</p>
              </div>

              {/* Details */}
              <dl className="rounded-xl border border-black/[0.06] divide-y divide-black/[0.06] text-[12.5px]">
                <div className="flex items-start gap-3 px-3.5 py-2.5">
                  <dt className="flex items-center gap-1.5 w-[104px] shrink-0 text-[#8E8E93]">
                    <Zap className="w-3.5 h-3.5" />
                    Condition
                  </dt>
                  <dd className="flex-1 min-w-0 font-medium leading-snug">{timingInfo.conditionDescription}</dd>
                </div>
                <div className="flex items-start gap-3 px-3.5 py-2.5">
                  <dt className="flex items-center gap-1.5 w-[104px] shrink-0 text-[#8E8E93]">
                    <Moon className="w-3.5 h-3.5" />
                    Quiet Hours
                  </dt>
                  <dd className="flex-1 min-w-0 leading-snug">
                    <span
                      className={`inline-block text-[10px] font-semibold uppercase tracking-wide px-1.5 py-px rounded mb-1 ${
                        quietExempt ? 'bg-emerald-50 text-emerald-700' : 'bg-indigo-50 text-indigo-700'
                      }`}
                    >
                      {quietExempt ? 'Exempt' : 'Applies'}
                    </span>
                    <span className="block font-medium">{timingInfo.quietHoursStatus}</span>
                  </dd>
                </div>
                <div className="flex items-start gap-3 px-3.5 py-2.5">
                  <dt className="flex items-center gap-1.5 w-[104px] shrink-0 text-[#8E8E93]">
                    <Globe className="w-3.5 h-3.5" />
                    Time Zone
                  </dt>
                  <dd className="flex-1 min-w-0 leading-snug text-[#3A3A3C]">
                    Recipient device time zone (fallback: account → Pacific)
                  </dd>
                </div>
              </dl>
            </div>

            {/* Footer (fixed) */}
            <div className="flex items-center justify-between gap-3 px-4 py-3 border-t border-black/[0.06] shrink-0 bg-white">
              <span className="inline-flex items-center gap-1.5 text-[11px] font-medium text-[#8E8E93]">
                <ShieldCheck className="w-3.5 h-3.5 text-[#34C759]" />
                CI Rulebook Policy
              </span>
              <button
                type="button"
                onClick={close}
                className="px-4 py-1.5 rounded-full bg-[#007AFF] text-white text-[12px] font-semibold hover:bg-[#0062CC] transition-colors cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#007AFF]/40 focus-visible:ring-offset-1"
              >
                Done
              </button>
            </div>
          </div>,
          document.body
        )}
    </div>
  )
}
