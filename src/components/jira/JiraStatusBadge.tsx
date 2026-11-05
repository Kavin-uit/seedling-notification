import React, { useState, useRef, useEffect } from 'react'
import { createPortal } from 'react-dom'
import type { ScenarioStatus } from '../../types/notification'
import { parseStatuses, serializeStatuses } from '../../types/notification'
import { ChevronDown, CheckCircle2, AlertCircle, Clock, Check, X, EyeOff } from 'lucide-react'

interface JiraStatusBadgeProps {
  status: ScenarioStatus
  onChange?: (newStatus: ScenarioStatus) => void
  onCreateDefect?: () => void
  onOpenLog?: () => void
  interactive?: boolean
  size?: 'sm' | 'md'
}

const statusConfig: Record<
  ScenarioStatus,
  { bg: string; text: string; border: string; label: string; icon: React.ReactNode }
> = {
  'TO DO': {
    bg: 'bg-[#DFE1E6] hover:bg-[#D0D4DC]',
    text: 'text-[#42526E]',
    border: 'border-transparent',
    label: 'TO DO',
    icon: <Clock className="w-3 h-3 text-[#42526E]" />,
  },
  'TESTED': {
    bg: 'bg-[#E3FCEF] hover:bg-[#ABF5D1]',
    text: 'text-[#006644]',
    border: 'border-transparent',
    label: 'TESTED',
    icon: <CheckCircle2 className="w-3 h-3 text-[#006644]" />,
  },
  'NOT WORKING': {
    bg: 'bg-[#FFEBE6] hover:bg-[#FFBDAD]',
    text: 'text-[#BF2600]',
    border: 'border-transparent',
    label: 'NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#BF2600]" />,
  },
  'IN-APP NAVIGATION NOT WORKING': {
    bg: 'bg-[#FFF0B3] hover:bg-[#FFE380]',
    text: 'text-[#172B4D]',
    border: 'border-transparent',
    label: 'IN-APP NAVIGATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#FFAB00]" />,
  },
  'NAVIGATION NOT WORKING': {
    bg: 'bg-[#FFF0B3] hover:bg-[#FFE380]',
    text: 'text-[#172B4D]',
    border: 'border-transparent',
    label: 'IN-APP NAVIGATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#FFAB00]" />,
  },
  'PUSH NOTIFICATION NOT WORKING': {
    bg: 'bg-[#FFEBE6] hover:bg-[#FFBDAD]',
    text: 'text-[#BF2600]',
    border: 'border-transparent',
    label: 'PUSH NOTIFICATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#BF2600]" />,
  },
  'PUSH NOTIFICATION NAVIGATION NOT WORKING': {
    bg: 'bg-[#FFEBE6] hover:bg-[#FFBDAD]',
    text: 'text-[#BF2600]',
    border: 'border-transparent',
    label: 'PUSH NOTIFICATION NAVIGATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#BF2600]" />,
  },
  'EMAIL NOTIFICATION NOT WORKING': {
    bg: 'bg-[#EAE6FF] hover:bg-[#D8D0FF]',
    text: 'text-[#403294]',
    border: 'border-transparent',
    label: 'EMAIL NOTIFICATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#403294]" />,
  },
  'EMAIL NOTIFICATION NAVIGATION NOT WORKING': {
    bg: 'bg-[#EAE6FF] hover:bg-[#D8D0FF]',
    text: 'text-[#403294]',
    border: 'border-transparent',
    label: 'EMAIL NOTIFICATION NAVIGATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#403294]" />,
  },
  'SMS NOTIFICATION NOT WORKING': {
    bg: 'bg-[#E6FCFF] hover:bg-[#B6F0FF]',
    text: 'text-[#0065FF]',
    border: 'border-transparent',
    label: 'SMS NOTIFICATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#0065FF]" />,
  },
  'HIDE': {
    bg: 'bg-[#F4F5F7] hover:bg-[#EBECF0]',
    text: 'text-[#5E6C84]',
    border: 'border-[#C1C7D0]',
    label: 'HIDE',
    icon: <EyeOff className="w-3 h-3 text-[#5E6C84]" />,
  },
}

export function getStatusBadgeConfig(status?: string): {
  bg: string
  text: string
  border: string
  label: string
  icon: React.ReactNode
} {
  const s = status || 'TO DO'
  if (statusConfig[s as keyof typeof statusConfig]) {
    return statusConfig[s as keyof typeof statusConfig]
  }
  const clean = s.toUpperCase()
  if (clean === 'HIDE' || clean === 'HIDDEN') {
    return {
      bg: 'bg-[#F4F5F7] hover:bg-[#EBECF0]',
      text: 'text-[#5E6C84]',
      border: 'border-[#C1C7D0]',
      label: 'HIDE',
      icon: <EyeOff className="w-3 h-3 text-[#5E6C84]" />,
    }
  }
  if (clean.includes('TEST') || clean.includes('PASS')) {
    return {
      bg: 'bg-[#E3FCEF] hover:bg-[#ABF5D1]',
      text: 'text-[#006644]',
      border: 'border-transparent',
      label: s,
      icon: <CheckCircle2 className="w-3 h-3 text-[#006644]" />,
    }
  }
  if (clean.includes('TODO') || clean.includes('TO DO')) {
    return {
      bg: 'bg-[#DFE1E6] hover:bg-[#D0D4DC]',
      text: 'text-[#42526E]',
      border: 'border-transparent',
      label: s,
      icon: <Clock className="w-3 h-3 text-[#42526E]" />,
    }
  }
  if (clean.includes('EMAIL')) {
    return {
      bg: 'bg-[#EAE6FF] hover:bg-[#D8D0FF]',
      text: 'text-[#403294]',
      border: 'border-transparent',
      label: s,
      icon: <AlertCircle className="w-3 h-3 text-[#403294]" />,
    }
  }
  if (clean.includes('SMS')) {
    return {
      bg: 'bg-[#E6FCFF] hover:bg-[#B6F0FF]',
      text: 'text-[#0065FF]',
      border: 'border-transparent',
      label: s,
      icon: <AlertCircle className="w-3 h-3 text-[#0065FF]" />,
    }
  }
  if (clean.includes('NAV')) {
    return {
      bg: 'bg-[#FFF0B3] hover:bg-[#FFE380]',
      text: 'text-[#172B4D]',
      border: 'border-transparent',
      label: s,
      icon: <AlertCircle className="w-3 h-3 text-[#FFAB00]" />,
    }
  }
  return {
    bg: 'bg-[#FFEBE6] hover:bg-[#FFBDAD]',
    text: 'text-[#BF2600]',
    border: 'border-transparent',
    label: s,
    icon: <AlertCircle className="w-3 h-3 text-[#BF2600]" />,
  }
}

export const JiraStatusBadge: React.FC<JiraStatusBadgeProps & { availableStatuses?: ScenarioStatus[] }> = ({
  status,
  onChange,
  onCreateDefect,
  onOpenLog,
  interactive = true,
  size = 'md',
  availableStatuses,
}) => {
  const [isOpen, setIsOpen] = useState(false)
  const [coords, setCoords] = useState<{
    top?: string
    bottom?: string
    left: string
    maxHeight: string
  } | null>(null)
  const triggerRef = useRef<HTMLButtonElement>(null)

  const activeStatuses = parseStatuses(status)

  const updateCoords = () => {
    if (!triggerRef.current) return
    const rect = triggerRef.current.getBoundingClientRect()
    const spaceBelow = window.innerHeight - rect.bottom
    const spaceAbove = rect.top
    const openUp = spaceBelow < 380 && spaceAbove > spaceBelow
    const width = 320
    const left = Math.max(12, Math.min(window.innerWidth - width - 12, rect.left))

    if (openUp) {
      setCoords({
        bottom: `${window.innerHeight - rect.top + 4}px`,
        top: undefined,
        left: `${left}px`,
        maxHeight: `${Math.min(380, spaceAbove - 16)}px`,
      })
    } else {
      setCoords({
        top: `${rect.bottom + 4}px`,
        bottom: undefined,
        left: `${left}px`,
        maxHeight: `${Math.min(380, spaceBelow - 16)}px`,
      })
    }
  }

  const handleToggle = (e: React.MouseEvent) => {
    e.stopPropagation()
    if (!isOpen) {
      updateCoords()
      setIsOpen(true)
    } else {
      setIsOpen(false)
    }
  }

  useEffect(() => {
    if (!isOpen) return
    const handleClose = () => setIsOpen(false)
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setIsOpen(false)
    }
    window.addEventListener('scroll', handleClose, true)
    window.addEventListener('resize', handleClose)
    document.addEventListener('keydown', handleKeyDown)
    return () => {
      window.removeEventListener('scroll', handleClose, true)
      window.removeEventListener('resize', handleClose)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isOpen])

  if (!interactive || !onChange) {
    return (
      <div className="inline-flex flex-wrap gap-1 items-center max-w-full">
        {activeStatuses.map((st) => {
          const cfg = getStatusBadgeConfig(st)
          return (
            <span
              key={st}
              title={st}
              className={`inline-flex items-center gap-1 font-semibold uppercase rounded max-w-full truncate ${
                size === 'sm' ? 'px-1.5 py-0.5 text-[10px]' : 'px-2 py-0.5 text-[11px]'
              } ${cfg.bg} ${cfg.text}`}
            >
              <span className="truncate">{cfg.label}</span>
            </span>
          )
        })}
      </div>
    )
  }

  const defaultStatuses: ScenarioStatus[] = [
    'TO DO',
    'TESTED',
    'NOT WORKING',
    'IN-APP NAVIGATION NOT WORKING',
    'PUSH NOTIFICATION NOT WORKING',
    'PUSH NOTIFICATION NAVIGATION NOT WORKING',
    'EMAIL NOTIFICATION NOT WORKING',
    'EMAIL NOTIFICATION NAVIGATION NOT WORKING',
    'SMS NOTIFICATION NOT WORKING',
  ]

  const statusList = availableStatuses && availableStatuses.length > 0 ? availableStatuses : defaultStatuses
  const allStatuses = [...new Set([...statusList, ...activeStatuses])]

  const handleSelectStatus = (st: ScenarioStatus, e: React.MouseEvent) => {
    e.stopPropagation()
    let nextStatuses: ScenarioStatus[]

    if (st === 'TESTED' || st === 'TO DO') {
      nextStatuses = [st]
    } else {
      const nonDefault = activeStatuses.filter((s) => s !== 'TESTED' && s !== 'TO DO')
      if (nonDefault.includes(st)) {
        nextStatuses = nonDefault.filter((s) => s !== st)
        if (nextStatuses.length === 0) {
          nextStatuses = ['TO DO']
        }
      } else {
        nextStatuses = [...nonDefault, st]
      }
    }

    onChange(serializeStatuses(nextStatuses))
  }

  return (
    <div className="inline-block text-left max-w-full">
      {/* Trigger Button showing active badge(s) */}
      <button
        ref={triggerRef}
        type="button"
        onClick={handleToggle}
        className="inline-flex items-center gap-1 p-0.5 rounded hover:bg-slate-100/80 transition cursor-pointer max-w-full overflow-hidden"
        title={activeStatuses.join(', ')}
      >
        <div className="inline-flex items-center gap-1 min-w-0 max-w-[calc(100%-14px)] overflow-hidden">
          {activeStatuses.map((st) => {
            const cfg = getStatusBadgeConfig(st)
            return (
              <span
                key={st}
                title={st}
                className={`inline-flex items-center gap-1 font-semibold uppercase rounded border min-w-0 truncate ${
                  size === 'sm' ? 'px-1.5 py-0.5 text-[10px]' : 'px-2 py-0.5 text-[11px]'
                } ${cfg.bg} ${cfg.text} ${cfg.border}`}
              >
                <span className="truncate">{cfg.label}</span>
              </span>
            )
          })}
        </div>
        <ChevronDown className="w-3 h-3 text-slate-400 shrink-0" />
      </button>

      {/* Clean Human Dropdown Popover via Portal */}
      {isOpen && coords && createPortal(
        <>
          <div
            className="fixed inset-0 z-[99990] bg-transparent"
            onClick={(e) => {
              e.stopPropagation()
              setIsOpen(false)
            }}
            onContextMenu={(e) => {
              e.preventDefault()
              setIsOpen(false)
            }}
          />
          <div
            style={{
              position: 'fixed',
              top: coords.top,
              bottom: coords.bottom,
              left: coords.left,
              maxHeight: coords.maxHeight,
              zIndex: 99999,
            }}
            className="w-80 rounded-xl bg-white shadow-2xl border border-slate-200 overflow-hidden animate-in fade-in zoom-in-95 duration-100 flex flex-col"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Simple Human Header */}
            <div className="px-3.5 py-2.5 border-b border-slate-100 flex items-center justify-between bg-slate-50/60 shrink-0">
              <div className="flex items-center gap-1.5">
                <span className="text-xs font-semibold text-slate-800">Select Status</span>
                {activeStatuses.length > 1 && (
                  <span className="text-[10px] font-semibold bg-blue-100 text-[#0052CC] px-1.5 py-0.2 rounded-full">
                    {activeStatuses.length} selected
                  </span>
                )}
              </div>
              <button
                type="button"
                onClick={(e) => {
                  e.stopPropagation()
                  setIsOpen(false)
                }}
                className="text-slate-400 hover:text-slate-600 p-0.5 rounded transition cursor-pointer"
                title="Close"
              >
                <X className="w-3.5 h-3.5" />
              </button>
            </div>

            {/* Checklist items */}
            <div className="py-1 flex-1 overflow-y-auto divide-y divide-slate-50 overscroll-contain">
              {allStatuses.map((st) => {
                const cfg = getStatusBadgeConfig(st)
                const isChecked = activeStatuses.includes(st)
                return (
                  <button
                    key={st}
                    type="button"
                    onClick={(e) => handleSelectStatus(st, e)}
                    className={`w-full flex items-center gap-2.5 px-3 py-1.5 text-xs text-left transition hover:bg-slate-50 cursor-pointer ${
                      isChecked ? 'bg-blue-50/40' : ''
                    }`}
                  >
                    {/* Clean Checkbox */}
                    <div
                      className={`w-4 h-4 rounded flex items-center justify-center border transition shrink-0 ${
                        isChecked
                          ? 'bg-[#0052CC] border-[#0052CC] text-white shadow-2xs'
                          : 'border-slate-300 bg-white hover:border-slate-400'
                      }`}
                    >
                      {isChecked && <Check className="w-2.5 h-2.5 stroke-[3]" />}
                    </div>

                    {/* Status Badge Tag */}
                    <span
                      className={`inline-flex items-center px-2 py-0.5 rounded text-[10px] font-semibold uppercase ${cfg.bg} ${cfg.text}`}
                    >
                      {cfg.label}
                    </span>
                  </button>
                )
              })}
            </div>

            {/* Simple Understated Footer */}
            <div className="px-3 py-2 bg-slate-50 border-t border-slate-100 flex items-center justify-between shrink-0">
              <div className="flex items-center gap-3">
                {onOpenLog && (
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation()
                      setIsOpen(false)
                      onOpenLog()
                    }}
                    className="text-[11px] font-medium text-slate-600 hover:text-[#0052CC] transition cursor-pointer"
                  >
                    Change Log
                  </button>
                )}
                {onCreateDefect && (
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation()
                      setIsOpen(false)
                      onCreateDefect()
                    }}
                    className="text-[11px] font-medium text-rose-600 hover:text-rose-700 transition cursor-pointer"
                  >
                    Create Defect
                  </button>
                )}
              </div>
              <button
                type="button"
                onClick={(e) => {
                  e.stopPropagation()
                  setIsOpen(false)
                }}
                className="px-2.5 py-1 text-xs font-semibold text-slate-700 bg-white border border-slate-200 hover:bg-slate-100 rounded transition shadow-2xs cursor-pointer"
              >
                Done
              </button>
            </div>
          </div>
        </>,
        document.body
      )}
    </div>
  )
}
