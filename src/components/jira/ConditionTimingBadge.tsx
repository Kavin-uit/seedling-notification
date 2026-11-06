import React, { useState, useRef, useEffect } from 'react'
import type { NotificationScenario } from '../../types/notification'
import { getNotificationTiming } from '../../utils/notificationTiming'
import { Clock, Zap, Calendar, Eye, Info, X, ShieldCheck } from 'lucide-react'

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

  const renderIcon = () => {
    switch (timingInfo.badgeVariant) {
      case 'immediate':
        return <Zap className="w-3 h-3 text-emerald-600 shrink-0" />
      case 'scheduled':
        return <Calendar className="w-3 h-3 text-blue-600 shrink-0" />
      case 'passive':
        return <Eye className="w-3 h-3 text-slate-500 shrink-0" />
      case 'deadline':
        return <Clock className="w-3 h-3 text-rose-600 shrink-0" />
      case 'opportunity':
        return <Clock className="w-3 h-3 text-amber-600 shrink-0" />
      case 'participation':
        return <Clock className="w-3 h-3 text-sky-600 shrink-0" />
      case 'campaign':
        return <Clock className="w-3 h-3 text-purple-600 shrink-0" />
      case 'identity':
        return <Clock className="w-3 h-3 text-teal-600 shrink-0" />
      default:
        return <Clock className="w-3 h-3 text-slate-500 shrink-0" />
    }
  }

  return (
    <div className={`relative inline-block ${className}`} ref={containerRef}>
      {/* Interactive Badge Button */}
      <button
        type="button"
        onClick={() => setIsOpen((prev) => !prev)}
        className={`inline-flex items-center gap-1.5 px-2 py-0.5 rounded-[4px] border text-[11px] font-medium transition cursor-pointer select-none shadow-2xs hover:brightness-95 ${timingInfo.badgeBg} ${timingInfo.badgeText} ${timingInfo.badgeBorder}`}
        title="Click to view delivery schedule when condition is met"
      >
        {renderIcon()}
        <span className="font-semibold text-slate-500">Recv:</span>
        <span className="truncate max-w-[210px] font-semibold">{timingInfo.badgeLabel}</span>
        <Info className="w-3 h-3 opacity-60 hover:opacity-100 shrink-0 ml-0.5" />
      </button>

      {/* Flyout Details Card when clicked */}
      {isOpen && (
        <div className="absolute left-0 top-full mt-1.5 w-80 sm:w-96 bg-white rounded-xl shadow-[0_12px_36px_-6px_rgba(9,30,66,0.3),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] p-3.5 z-50 animate-in fade-in zoom-in-95 duration-100 text-[#172B4D]">
          {/* Header */}
          <div className="flex items-start justify-between pb-2 border-b border-[#EBECF0] gap-2">
            <div className="flex items-center gap-1.5">
              <div className={`w-5 h-5 rounded flex items-center justify-center ${timingInfo.badgeBg} ${timingInfo.badgeBorder} border`}>
                {renderIcon()}
              </div>
              <div>
                <h4 className="text-xs font-bold text-[#172B4D] leading-tight">
                  Notification Delivery Timing
                </h4>
                <p className="text-[10px] text-[#6B778C]">
                  When recipient receives notification once condition is met
                </p>
              </div>
            </div>
            <button
              type="button"
              onClick={() => setIsOpen(false)}
              className="text-slate-400 hover:text-slate-600 p-0.5 rounded transition cursor-pointer"
              title="Close"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          </div>

          {/* Details Content */}
          <div className="py-2.5 space-y-2 text-xs">
            {/* 1. Primary Schedule */}
            <div className="bg-[#F4F5F7] rounded-lg p-2.5 border border-[#EBECF0]">
              <div className="text-[10px] font-bold text-[#6B778C] uppercase tracking-wider mb-1 flex items-center justify-between">
                <span>Receive Schedule</span>
                {timingInfo.ruleId && (
                  <span className="font-mono text-[#0052CC] bg-blue-50 px-1 rounded border border-blue-200">
                    {timingInfo.ruleId}
                  </span>
                )}
              </div>
              <p className="text-xs font-semibold text-[#172B4D] leading-relaxed">
                {timingInfo.fullSchedule}
              </p>
            </div>

            {/* 2. Condition Met (Trigger) */}
            <div className="flex items-start gap-2 pt-0.5">
              <span className="text-[10px] font-bold text-[#6B778C] uppercase shrink-0 w-24">
                Condition:
              </span>
              <span className="text-xs text-[#172B4D] font-medium leading-tight">
                {timingInfo.conditionDescription}
              </span>
            </div>

            {/* 3. Quiet Hours Policy */}
            <div className="flex items-start gap-2 pt-0.5">
              <span className="text-[10px] font-bold text-[#6B778C] uppercase shrink-0 w-24">
                Quiet Hours:
              </span>
              <span className="text-xs text-[#172B4D] leading-tight">
                {timingInfo.quietHoursStatus}
              </span>
            </div>

            {/* 4. Time Zone Resolution */}
            <div className="flex items-start gap-2 pt-0.5">
              <span className="text-[10px] font-bold text-[#6B778C] uppercase shrink-0 w-24">
                Time Zone:
              </span>
              <span className="text-[11px] text-[#5E6C84] leading-tight">
                Recipient device time zone (fallback: account time zone → Pacific)
              </span>
            </div>
          </div>

          {/* Footer note */}
          <div className="pt-2 border-t border-[#EBECF0] flex items-center justify-between text-[10px] text-[#6B778C]">
            <span className="inline-flex items-center gap-1 text-emerald-700 font-medium">
              <ShieldCheck className="w-3 h-3 text-emerald-600" />
              <span>CI Rulebook Timing Policy</span>
            </span>
            <button
              type="button"
              onClick={() => setIsOpen(false)}
              className="px-2 py-0.5 text-[11px] font-semibold text-[#0052CC] hover:bg-blue-50 rounded transition cursor-pointer"
            >
              Done
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
