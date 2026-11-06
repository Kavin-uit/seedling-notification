import React, { useState, useRef, useEffect } from 'react'
import type { NotificationScenario } from '../../types/notification'
import { getNotificationTiming } from '../../utils/notificationTiming'
import { Clock, Info, X, ShieldCheck } from 'lucide-react'

interface ConditionTimingBadgeProps {
  scenario: NotificationScenario | null
  className?: string
}

export const ConditionTimingBadge: React.FC<ConditionTimingBadgeProps> = ({
  scenario,
  className = '',
}) => {
  const [isOpen, setIsOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)
  const timingInfo = getNotificationTiming(scenario)

  // Close on outside click or Escape
  useEffect(() => {
    if (!isOpen) return
    const handleClickOutside = (e: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setIsOpen(false)
      }
    }
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setIsOpen(false)
    }
    document.addEventListener('mousedown', handleClickOutside)
    document.addEventListener('keydown', handleKeyDown)
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isOpen])

  return (
    <div
      className={`relative inline-block ${className}`}
      ref={containerRef}
      style={{
        fontFamily:
          '-apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Helvetica Neue", sans-serif',
      }}
    >
      {/* iOS-Themed Trigger Pill Button */}
      <button
        type="button"
        onClick={() => setIsOpen((prev) => !prev)}
        className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-[#F2F2F7] hover:bg-[#E5E5EA] active:bg-[#D1D1D6] active:scale-[0.98] border border-black/[0.08] text-[11px] transition-all cursor-pointer select-none shadow-[0_1px_2px_rgba(0,0,0,0.04)]"
        title="Tap to view delivery timing when condition is met"
      >
        <Clock className="w-3.5 h-3.5 text-[#007AFF] shrink-0" />
        <span className="text-[#8E8E93] font-medium">Recv:</span>
        <span className="truncate max-w-[200px] font-semibold text-[#1C1C1E]">
          {timingInfo.badgeShortLabel || timingInfo.badgeLabel}
        </span>
        <Info className="w-3 h-3 text-[#8E8E93] hover:text-[#1C1C1E] opacity-75 shrink-0 ml-0.5" />
      </button>

      {/* iOS-Themed Popover Card */}
      {isOpen && (
        <div
          style={{
            boxShadow:
              '0 24px 60px rgba(0,0,0,0.18), 0 8px 24px rgba(0,0,0,0.08), 0 0 1px rgba(0,0,0,0.12)',
            fontFamily:
              '-apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", "Helvetica Neue", sans-serif',
          }}
          className="absolute left-0 top-full mt-2 w-80 sm:w-[380px] bg-white/95 backdrop-blur-2xl rounded-[20px] border border-black/[0.08] p-4 z-50 animate-in fade-in zoom-in-95 duration-150 text-[#1C1C1E]"
        >
          {/* iOS Header */}
          <div className="flex items-center justify-between pb-3 border-b border-black/[0.06]">
            <div className="flex items-center gap-2.5">
              <div className="w-8 h-8 rounded-[10px] bg-[#007AFF]/10 flex items-center justify-center shrink-0">
                <Clock className="w-4 h-4 text-[#007AFF]" />
              </div>
              <div>
                <h4 className="text-[14px] font-semibold text-[#1C1C1E] tracking-tight leading-tight">
                  Notification Delivery Timing
                </h4>
                <p className="text-[11px] text-[#8E8E93] leading-tight mt-0.5">
                  When recipient receives notification once condition is met
                </p>
              </div>
            </div>
            <button
              type="button"
              onClick={() => setIsOpen(false)}
              className="w-7 h-7 rounded-full bg-[#E5E5EA] text-[#636366] hover:bg-[#D1D1D6] hover:text-[#1C1C1E] flex items-center justify-center cursor-pointer transition-colors active:scale-95"
              title="Close"
            >
              <X className="w-3.5 h-3.5 stroke-[2.5]" />
            </button>
          </div>

          {/* Details Content (iOS Inset Grouped Style) */}
          <div className="py-3 space-y-2.5">
            {/* Primary Schedule Card */}
            <div className="bg-[#F2F2F7] rounded-[14px] p-3.5 border border-black/[0.04]">
              <div className="flex items-center justify-between mb-1.5">
                <span className="text-[10px] font-semibold tracking-wider uppercase text-[#8E8E93]">
                  Receive Schedule
                </span>
                {timingInfo.ruleId && (
                  <span className="font-mono text-[10px] font-semibold text-[#007AFF] bg-white px-2 py-0.5 rounded-full border border-black/[0.06] shadow-[0_1px_2px_rgba(0,0,0,0.03)]">
                    {timingInfo.ruleId}
                  </span>
                )}
              </div>
              <p className="text-[13px] font-semibold text-[#1C1C1E] leading-snug tracking-[-0.1px]">
                {timingInfo.fullSchedule}
              </p>
            </div>

            {/* Inset Metadata List */}
            <div className="bg-[#F2F2F7] rounded-[14px] border border-black/[0.04] divide-y divide-[#E5E5EA]/80 overflow-hidden text-[12px]">
              {/* Condition */}
              <div className="px-3.5 py-2.5 flex items-start justify-between gap-3">
                <span className="text-[#8E8E93] font-normal shrink-0 w-24">Condition</span>
                <span className="text-[#1C1C1E] font-medium text-right leading-snug flex-1">
                  {timingInfo.conditionDescription}
                </span>
              </div>

              {/* Quiet Hours */}
              <div className="px-3.5 py-2.5 flex items-start justify-between gap-3">
                <span className="text-[#8E8E93] font-normal shrink-0 w-24">Quiet Hours</span>
                <span className="text-[#1C1C1E] font-medium text-right leading-snug flex-1">
                  {timingInfo.quietHoursStatus}
                </span>
              </div>

              {/* Time Zone */}
              <div className="px-3.5 py-2.5 flex items-start justify-between gap-3">
                <span className="text-[#8E8E93] font-normal shrink-0 w-24">Time Zone</span>
                <span className="text-[#636366] text-right leading-snug flex-1">
                  Recipient device time zone (fallback: account → Pacific)
                </span>
              </div>
            </div>
          </div>

          {/* iOS Footer */}
          <div className="pt-2 flex items-center justify-between border-t border-black/[0.06]">
            <div className="inline-flex items-center gap-1.5 text-[11px] font-medium text-[#8E8E93]">
              <ShieldCheck className="w-3.5 h-3.5 text-[#34C759]" />
              <span>CI Rulebook Policy</span>
            </div>
            <button
              type="button"
              onClick={() => setIsOpen(false)}
              className="px-3.5 py-1.5 rounded-full bg-[#007AFF] text-white text-[12px] font-semibold hover:bg-[#0062CC] active:scale-95 transition-all shadow-[0_2px_6px_rgba(0,122,255,0.25)] cursor-pointer"
            >
              Done
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
