import React, { useState, useRef, useEffect } from 'react'
import type { ScenarioStatus } from '../../types/notification'
import { ChevronDown, CheckCircle2, AlertCircle, Clock, Bug, Info, X } from 'lucide-react'

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
  'EMAIL NOTIFICATION NOT WORKING': {
    bg: 'bg-[#EAE6FF] hover:bg-[#D8D0FF]',
    text: 'text-[#403294]',
    border: 'border-transparent',
    label: 'EMAIL NOTIFICATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#403294]" />,
  },
  'SMS NOTIFICATION NOT WORKING': {
    bg: 'bg-[#E6FCFF] hover:bg-[#B6F0FF]',
    text: 'text-[#0065FF]',
    border: 'border-transparent',
    label: 'SMS NOTIFICATION NOT WORKING',
    icon: <AlertCircle className="w-3 h-3 text-[#0065FF]" />,
  },
}

export const JiraStatusBadge: React.FC<JiraStatusBadgeProps> = ({
  status,
  onChange,
  onCreateDefect,
  onOpenLog,
  interactive = true,
  size = 'md',
}) => {
  const [isOpen, setIsOpen] = useState(false)
  const [openUpward, setOpenUpward] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)

  const current = statusConfig[status] || statusConfig['TO DO']

  useEffect(() => {
    function handleClickOutside(e: MouseEvent | PointerEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) {
        setIsOpen(false)
      }
    }
    function handleKeyDown(e: KeyboardEvent) {
      if (e.key === 'Escape') {
        setIsOpen(false)
      }
    }
    if (isOpen) {
      document.addEventListener('pointerdown', handleClickOutside, true)
      document.addEventListener('keydown', handleKeyDown)
    }
    return () => {
      document.removeEventListener('pointerdown', handleClickOutside, true)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isOpen])

  if (!interactive || !onChange) {
    return (
      <span
        className={`inline-flex items-center gap-1.5 font-bold uppercase tracking-wide rounded ${
          size === 'sm' ? 'px-1.5 py-0.5 text-[10px]' : 'px-2 py-0.5 text-[11px]'
        } ${current.bg} ${current.text}`}
      >
        {current.label}
      </span>
    )
  }

  const allStatuses: ScenarioStatus[] = [
    'TO DO',
    'TESTED',
    'NOT WORKING',
    'IN-APP NAVIGATION NOT WORKING',
    'PUSH NOTIFICATION NOT WORKING',
    'EMAIL NOTIFICATION NOT WORKING',
    'SMS NOTIFICATION NOT WORKING',
  ]

  const handleToggle = (e: React.MouseEvent) => {
    e.stopPropagation()
    if (!isOpen && dropdownRef.current) {
      const rect = dropdownRef.current.getBoundingClientRect()
      const spaceBelow = window.innerHeight - rect.bottom
      setOpenUpward(spaceBelow < 330 && rect.top > spaceBelow)
    }
    setIsOpen(!isOpen)
  }

  return (
    <div className="relative inline-block text-left" ref={dropdownRef}>
      <button
        type="button"
        onClick={handleToggle}
        className={`inline-flex items-center gap-1 font-bold uppercase tracking-wider rounded transition-colors cursor-pointer border ${
          size === 'sm' ? 'px-2 py-0.5 text-[10px]' : 'px-2.5 py-1 text-[11px]'
        } ${current.bg} ${current.text} ${current.border}`}
      >
        <span>{current.label}</span>
        <ChevronDown className="w-3 h-3 opacity-70 ml-0.5" />
      </button>

      {isOpen && (
        <>
          <div
            className="fixed inset-0 z-40 bg-transparent"
            onClick={(e) => {
              e.stopPropagation()
              setIsOpen(false)
            }}
          />
          <div className={`absolute left-0 w-72 rounded-md bg-white shadow-xl ring-1 ring-black/10 z-50 py-1 divide-y divide-slate-100 animate-in fade-in zoom-in-95 duration-100 max-h-[min(380px,80vh)] overflow-y-auto ${
            openUpward ? 'bottom-full mb-1' : 'top-full mt-1'
          }`}>
            <div className="px-3 py-1.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider flex items-center justify-between">
              <span>Transition Status</span>
              <div className="flex items-center gap-1">
                {onOpenLog && (
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation()
                      setIsOpen(false)
                      onOpenLog()
                    }}
                    className="inline-flex items-center gap-1 text-[10px] font-bold text-[#0052CC] bg-blue-50 hover:bg-blue-100 border border-blue-200 px-1.5 py-0.5 rounded transition cursor-pointer shadow-2xs"
                    title="View Jira + GitHub Log Page"
                  >
                    <Info className="w-3 h-3" />
                    <span>Log</span>
                  </button>
                )}
                <button
                  type="button"
                  onClick={(e) => {
                    e.stopPropagation()
                    setIsOpen(false)
                  }}
                  className="p-1 rounded text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition cursor-pointer"
                  title="Close (Esc)"
                  aria-label="Close"
                >
                  <X className="w-3.5 h-3.5" />
                </button>
              </div>
            </div>
          <div className="py-1">
            {allStatuses.map((st) => {
              const cfg = statusConfig[st]
              const isSelected = st === status
              return (
                <button
                  key={st}
                  type="button"
                  onClick={(e) => {
                    e.stopPropagation()
                    onChange(st)
                    setIsOpen(false)
                  }}
                  className={`w-full flex items-center justify-between px-3 py-1.5 text-xs text-left transition hover:bg-slate-50 cursor-pointer ${
                    isSelected ? 'font-bold bg-slate-50' : 'text-slate-700'
                  }`}
                >
                  <span className={`inline-flex items-center gap-1.5 px-2 py-0.5 rounded text-[10px] font-bold ${cfg.bg} ${cfg.text}`}>
                    {cfg.label}
                  </span>
                  {isSelected && <span className="text-blue-600 text-xs font-bold">✓</span>}
                </button>
              )
            })}
          </div>

          {/* Quick Actions Footer with Info Log and Defect button */}
          <div className="pt-1 border-t border-slate-100 space-y-0.5">
            {onOpenLog && (
              <button
                type="button"
                onClick={(e) => {
                  e.stopPropagation()
                  setIsOpen(false)
                  onOpenLog()
                }}
                className="w-full flex items-center gap-2 px-3 py-1.5 text-xs text-left text-[#0052CC] hover:bg-blue-50 font-bold transition cursor-pointer"
              >
                <Info className="w-3.5 h-3.5 text-[#0052CC]" />
                <span>View Change Log & Diffs (Jira + GitHub)</span>
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
                className="w-full flex items-center gap-2 px-3 py-1.5 text-xs text-left text-[#BF2600] hover:bg-rose-50 font-bold transition cursor-pointer"
              >
                <Bug className="w-3.5 h-3.5 text-[#BF2600]" />
                <span>Create Defect</span>
              </button>
            )}
          </div>
        </div>
      </>
      )}
    </div>
  )
}
