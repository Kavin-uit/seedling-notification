import React, { useState, useRef, useEffect } from 'react'
import { createPortal } from 'react-dom'
import type { ScenarioStatus } from '../../types/notification'
import { ChevronDown, Check, Bug, Info, X } from 'lucide-react'

interface EngineBadgeProps {
  category: string
  currentStatus: ScenarioStatus
  onUpdateStatus: (newStatus: ScenarioStatus) => void
  onSwitchEngine?: (newCategory: string) => void
  onCreateDefect?: () => void
  onOpenLog?: () => void
  interactive?: boolean
}

const statusOptions: { status: ScenarioStatus; bg: string; text: string }[] = [
  { status: 'TO DO', bg: 'bg-[#DFE1E6]', text: 'text-[#42526E]' },
  { status: 'TESTED', bg: 'bg-[#E3FCEF]', text: 'text-[#006644]' },
  { status: 'NOT WORKING', bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]' },
  { status: 'IN-APP NAVIGATION NOT WORKING', bg: 'bg-[#FFF0B3]', text: 'text-[#172B4D]' },
  { status: 'PUSH NOTIFICATION NOT WORKING', bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]' },
  { status: 'PUSH NOTIFICATION NAVIGATION NOT WORKING', bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]' },
  { status: 'EMAIL NOTIFICATION NOT WORKING', bg: 'bg-[#EAE6FF]', text: 'text-[#403294]' },
  { status: 'EMAIL NOTIFICATION NAVIGATION NOT WORKING', bg: 'bg-[#EAE6FF]', text: 'text-[#403294]' },
  { status: 'SMS NOTIFICATION NOT WORKING', bg: 'bg-[#E6FCFF]', text: 'text-[#0065FF]' },
  { status: 'HIDE', bg: 'bg-[#F4F5F7]', text: 'text-[#5E6C84]' },
]

export const EngineBadge: React.FC<EngineBadgeProps> = ({
  category,
  currentStatus,
  onUpdateStatus,
  onCreateDefect,
  onOpenLog,
  interactive = true,
}) => {
  const [isOpen, setIsOpen] = useState(false)
  const [coords, setCoords] = useState<{
    top?: string
    bottom?: string
    left: string
    maxHeight: string
  } | null>(null)
  const buttonRef = useRef<HTMLButtonElement>(null)
  const popoverRef = useRef<HTMLDivElement>(null)

  const updatePosition = () => {
    if (!buttonRef.current) return
    const rect = buttonRef.current.getBoundingClientRect()
    const spaceBelow = window.innerHeight - rect.bottom
    const spaceAbove = rect.top
    const openUp = spaceBelow < 340 && spaceAbove > spaceBelow
    const width = 288 // 72 = 18rem = 288px
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
      updatePosition()
      setIsOpen(true)
    } else {
      setIsOpen(false)
    }
  }

  useEffect(() => {
    if (!isOpen) return
    const handleScroll = (e: Event) => {
      // Do not close if the scroll occurred inside the popover itself
      if (popoverRef.current && e.target && popoverRef.current.contains(e.target as Node)) {
        return
      }
      setIsOpen(false)
    }
    const handleResize = () => setIsOpen(false)
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setIsOpen(false)
    }
    window.addEventListener('scroll', handleScroll, true)
    window.addEventListener('resize', handleResize)
    document.addEventListener('keydown', handleKeyDown)
    return () => {
      window.removeEventListener('scroll', handleScroll, true)
      window.removeEventListener('resize', handleResize)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isOpen])

  if (!interactive) {
    return (
      <span className="text-xs text-[#172B4D] font-normal">
        {category}
      </span>
    )
  }

  return (
    <div className="inline-block text-left">
      <button
        ref={buttonRef}
        type="button"
        onClick={handleToggle}
        className="inline-flex items-center gap-1.5 text-xs text-[#172B4D] hover:text-[#0052CC] font-normal px-1.5 py-0.5 rounded hover:bg-slate-100 transition cursor-pointer border border-transparent hover:border-slate-300"
        title={`Engine: ${category} • Click to change status or view log`}
      >
        <span>{category}</span>
        <ChevronDown className="w-3.5 h-3.5 text-slate-400" />
      </button>

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
            ref={popoverRef}
            style={{
              position: 'fixed',
              top: coords.top,
              bottom: coords.bottom,
              left: coords.left,
              maxHeight: coords.maxHeight,
              zIndex: 99999,
            }}
            className="w-72 rounded-xl bg-white shadow-2xl ring-1 ring-black/10 py-1 divide-y divide-slate-100 animate-in fade-in zoom-in-95 duration-100 overflow-y-auto"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="px-3 py-1.5 text-xs font-semibold text-[#6B778C] flex items-center justify-between bg-slate-50/70 border-b border-slate-100 rounded-t-xl">
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
              {statusOptions.map((opt) => {
                const isSelected = opt.status === currentStatus
                return (
                  <button
                    key={opt.status}
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation()
                      onUpdateStatus(opt.status)
                      setIsOpen(false)
                    }}
                    className={`w-full flex items-center justify-between px-3 py-1.5 text-xs text-left transition hover:bg-slate-50 cursor-pointer ${
                      isSelected ? 'font-bold bg-slate-50' : 'text-slate-700'
                    }`}
                  >
                    <span
                      className={`inline-flex items-center gap-1.5 px-2 py-0.5 rounded text-[10px] font-bold ${opt.bg} ${opt.text}`}
                    >
                      {opt.status}
                    </span>
                    {isSelected && <Check className="w-3.5 h-3.5 text-blue-600 font-bold" />}
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
        </>,
        document.body
      )}
    </div>
  )
}
