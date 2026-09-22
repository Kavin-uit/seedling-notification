import React, { useState, useEffect, useRef } from 'react'
import type { FieldMismatch } from '../../services/sheetVerificationService'
import { Check, Copy, ExternalLink, X } from 'lucide-react'

interface IosMismatchTooltipProps {
  mismatch: FieldMismatch
  anchorRect: DOMRect | null
  onClose: () => void
  onApplyValue: (field: string, value: string) => void
  sheetUrl?: string
}

export const IosMismatchTooltip: React.FC<IosMismatchTooltipProps> = ({
  mismatch,
  anchorRect,
  onClose,
  onApplyValue,
  sheetUrl,
}) => {
  const [copied, setCopied] = useState(false)
  const [applied, setApplied] = useState(false)
  const tooltipRef = useRef<HTMLDivElement>(null)

  // Auto-reposition within viewport
  const [coords, setCoords] = useState<{ top: number; left: number }>({ top: 0, left: 0 })

  useEffect(() => {
    if (!anchorRect) return

    const tooltipWidth = 320
    const tooltipHeight = 220
    const padding = 12

    let left = anchorRect.left + anchorRect.width / 2 - tooltipWidth / 2
    let top = anchorRect.bottom + 8

    // Screen boundary adjustments
    if (left < padding) {
      left = padding
    } else if (left + tooltipWidth > window.innerWidth - padding) {
      left = window.innerWidth - tooltipWidth - padding
    }

    if (top + tooltipHeight > window.innerHeight - padding) {
      // Flip to above anchor if no room below
      top = Math.max(padding, anchorRect.top - tooltipHeight - 8)
    }

    setCoords({ top, left })
  }, [anchorRect])

  // Close on Escape
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose()
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [onClose])

  if (!anchorRect) return null

  const handleCopyExpected = (e: React.MouseEvent) => {
    e.stopPropagation()
    navigator.clipboard.writeText(mismatch.expected)
    setCopied(true)
    setTimeout(() => setCopied(false), 1800)
  }

  const handleApply = (e: React.MouseEvent) => {
    e.stopPropagation()
    onApplyValue(mismatch.fieldName, mismatch.expected)
    setApplied(true)
    setTimeout(() => {
      onClose()
    }, 400)
  }

  return (
    <div
      ref={tooltipRef}
      style={{ top: `${coords.top}px`, left: `${coords.left}px` }}
      onClick={(e) => e.stopPropagation()}
      className="fixed z-50 w-[320px] bg-[#1C1C1E]/95 backdrop-blur-xl text-white rounded-2xl p-3.5 border border-white/15 shadow-[0_16px_36px_rgba(0,0,0,0.4)] font-sans antialiased text-left animate-in fade-in zoom-in-95 duration-150 select-none"
    >
      {/* iOS Red Header */}
      <div className="flex items-center justify-between gap-2 pb-2.5 mb-2.5 border-b border-white/10">
        <div className="flex items-center gap-2">
          {/* iOS System Red Exclamation Circle */}
          <span className="w-5 h-5 rounded-full bg-[#FF3B30] text-white flex items-center justify-center text-[11px] font-extrabold shadow-xs shrink-0">
            !
          </span>
          <div className="flex flex-col">
            <span className="text-[12px] font-semibold text-white tracking-tight leading-none">
              Sheet Data Mismatch
            </span>
            <span className="text-[10px] text-[#FF453A] font-medium tracking-wide mt-0.5">
              {mismatch.fieldLabel}
            </span>
          </div>
        </div>

        <button
          type="button"
          onClick={onClose}
          className="w-5 h-5 rounded-full bg-white/10 hover:bg-white/20 text-white/70 hover:text-white flex items-center justify-center transition cursor-pointer shrink-0"
        >
          <X className="w-3 h-3 stroke-[2.5]" />
        </button>
      </div>

      {/* Comparison Body */}
      <div className="space-y-2.5 text-xs">
        {/* Expected from Google Sheet */}
        <div className="bg-white/8 rounded-xl p-2.5 border border-white/10 relative group">
          <div className="flex items-center justify-between text-[10px] uppercase font-bold tracking-wider text-[#30D158] mb-1">
            <span className="flex items-center gap-1.5">
              <span className="w-1.5 h-1.5 rounded-full bg-[#30D158]" />
              Expected (Sheet)
            </span>
            <button
              type="button"
              onClick={handleCopyExpected}
              className="text-white/60 hover:text-white flex items-center gap-1 transition cursor-pointer text-[10px] font-normal lowercase"
              title="Copy to clipboard"
            >
              {copied ? (
                <>
                  <Check className="w-3 h-3 text-[#30D158]" />
                  <span className="text-[#30D158]">copied</span>
                </>
              ) : (
                <>
                  <Copy className="w-3 h-3" />
                  <span>copy</span>
                </>
              )}
            </button>
          </div>
          <div className="text-[11.5px] text-white font-mono leading-relaxed select-text break-words max-h-24 overflow-y-auto pr-1">
            {mismatch.expected || <span className="text-white/40 italic">(empty in sheet)</span>}
          </div>
        </div>

        {/* Displayed in UI */}
        <div className="bg-[#FF3B30]/10 rounded-xl p-2.5 border border-[#FF3B30]/20">
          <div className="flex items-center gap-1.5 text-[10px] uppercase font-bold tracking-wider text-[#FF453A] mb-1">
            <span className="w-1.5 h-1.5 rounded-full bg-[#FF3B30]" />
            Displayed (UI)
          </div>
          <div className="text-[11.5px] text-[#FFD2CE] font-mono leading-relaxed select-text break-words max-h-20 overflow-y-auto line-through decoration-[#FF3B30]/60 pr-1">
            {mismatch.actual || <span className="text-white/40 italic">(empty in UI)</span>}
          </div>
        </div>
      </div>

      {/* iOS Action Buttons */}
      <div className="mt-3 flex items-center gap-2 pt-2 border-t border-white/10">
        <button
          type="button"
          onClick={handleApply}
          disabled={applied}
          className={`flex-1 flex items-center justify-center gap-1.5 py-1.5 px-3 rounded-xl font-semibold text-xs transition cursor-pointer shadow-sm active:scale-[0.98] ${
            applied
              ? 'bg-[#30D158] text-white'
              : 'bg-[#0071E3] hover:bg-[#0077ED] text-white'
          }`}
        >
          {applied ? (
            <>
              <Check className="w-3.5 h-3.5" />
              <span>Applied!</span>
            </>
          ) : (
            <>
              <Check className="w-3.5 h-3.5" />
              <span>Apply Sheet Value</span>
            </>
          )}
        </button>

        {sheetUrl && (
          <a
            href={sheetUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="px-2.5 py-1.5 rounded-xl bg-white/10 hover:bg-white/20 text-white/80 hover:text-white text-xs transition flex items-center gap-1 shrink-0"
            title="Open reference Google Sheet"
          >
            <ExternalLink className="w-3.5 h-3.5" />
          </a>
        )}
      </div>
    </div>
  )
}
