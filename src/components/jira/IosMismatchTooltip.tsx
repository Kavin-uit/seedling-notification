import React, { useState, useEffect, useRef } from 'react'
import type { FieldMismatch } from '../../services/sheetVerificationService'
import { Check, Copy, ExternalLink, X, AlertTriangle } from 'lucide-react'

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
  const [coords, setCoords] = useState<{ top: number; left: number; isAbove: boolean }>({
    top: 0,
    left: 0,
    isAbove: false,
  })

  useEffect(() => {
    if (!anchorRect) return

    const tooltipWidth = 330
    const tooltipHeight = 260
    const padding = 12

    let left = anchorRect.left + anchorRect.width / 2 - tooltipWidth / 2
    let top = anchorRect.bottom + 8
    let isAbove = false

    // Screen boundary adjustments
    if (left < padding) {
      left = padding
    } else if (left + tooltipWidth > window.innerWidth - padding) {
      left = window.innerWidth - tooltipWidth - padding
    }

    if (top + tooltipHeight > window.innerHeight - padding) {
      // Flip to above anchor if no room below
      top = Math.max(padding, anchorRect.top - tooltipHeight - 8)
      isAbove = true
    }

    setCoords({ top, left, isAbove })
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

  const arrowOffset = Math.max(
    16,
    Math.min(330 - 24, anchorRect.left + anchorRect.width / 2 - coords.left - 5)
  )

  return (
    <>
      {/* Transparent Click-Outside Overlay */}
      <div
        className="fixed inset-0 z-40 bg-transparent select-none"
        onClick={onClose}
      />

      {/* Clean Human UI Popover */}
      <div
        ref={tooltipRef}
        style={{ top: `${coords.top}px`, left: `${coords.left}px` }}
        onClick={(e) => e.stopPropagation()}
        className="fixed z-50 w-[330px] flex flex-col font-sans text-left animate-in fade-in zoom-in-95 duration-150"
      >
        {/* Caret pointing up if below anchor */}
        {!coords.isAbove && (
          <div
            className="w-2.5 h-2.5 bg-white rotate-45 border-l border-t border-slate-200 -mb-1.5 shrink-0 z-10"
            style={{ marginLeft: `${arrowOffset}px` }}
          />
        )}

        <div className="w-full bg-white text-slate-800 rounded-xl p-3.5 border border-slate-200 shadow-xl overflow-hidden">
          {/* Clean Header */}
          <div className="flex items-center justify-between gap-2 pb-2.5 mb-2.5 border-b border-slate-100">
            <div className="flex items-center gap-2 min-w-0">
              <span className="w-5 h-5 rounded-full bg-amber-50 text-amber-600 border border-amber-200 flex items-center justify-center shrink-0">
                <AlertTriangle className="w-3 h-3" />
              </span>
              <div className="flex flex-col min-w-0">
                <span className="text-xs font-semibold text-slate-900 truncate">
                  Sheet Data Mismatch
                </span>
                <span className="text-[11px] text-slate-500 truncate">
                  {mismatch.fieldLabel}
                </span>
                {mismatch.expected.trim().toLowerCase() === mismatch.actual.trim().toLowerCase() &&
                  mismatch.expected.trim() !== mismatch.actual.trim() && (
                    <span className="inline-flex items-center gap-1 text-[10px] font-semibold text-amber-800 bg-amber-100/90 border border-amber-300 px-1.5 py-0.2 rounded w-fit mt-0.5">
                      Capitalization / casing mismatch
                    </span>
                  )}
              </div>
            </div>

            <button
              type="button"
              onClick={onClose}
              className="p-1 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-md transition cursor-pointer shrink-0"
              title="Close"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          </div>

          {/* Simple Human Comparison Body */}
          <div className="space-y-2 text-xs">
            {/* Expected in Google Sheet */}
            <div className="bg-emerald-50/60 rounded-lg p-2.5 border border-emerald-200/80">
              <div className="flex items-center justify-between text-[11px] font-medium text-emerald-800 mb-1">
                <span>Expected in Sheet</span>
                <button
                  type="button"
                  onClick={handleCopyExpected}
                  className="text-emerald-700 hover:text-emerald-900 flex items-center gap-1 transition cursor-pointer text-[11px] font-normal"
                  title="Copy to clipboard"
                >
                  {copied ? (
                    <>
                      <Check className="w-3 h-3 text-emerald-600" />
                      <span className="text-emerald-600 font-medium">Copied</span>
                    </>
                  ) : (
                    <>
                      <Copy className="w-3 h-3" />
                      <span>Copy</span>
                    </>
                  )}
                </button>
              </div>
              <div className="text-xs text-slate-800 leading-relaxed select-text break-words max-h-24 overflow-y-auto font-normal">
                {mismatch.expected ? (
                  mismatch.expected.trim().toLowerCase() === mismatch.actual.trim().toLowerCase() &&
                  mismatch.expected.trim() !== mismatch.actual.trim() ? (
                    <span>
                      {mismatch.expected.split('').map((char, i) => {
                        const isDiff = char !== mismatch.actual[i]
                        return isDiff ? (
                          <span
                            key={i}
                            className="bg-emerald-200 text-emerald-900 font-bold px-0.5 rounded underline decoration-emerald-600"
                            title={`Expected lowercase '${char}' in sheet`}
                          >
                            {char}
                          </span>
                        ) : (
                          char
                        )
                      })}
                    </span>
                  ) : (
                    mismatch.expected
                  )
                ) : (
                  <span className="text-slate-400 italic">(Empty in Sheet)</span>
                )}
              </div>
            </div>

            {/* Current in Table */}
            <div className="bg-slate-50 rounded-lg p-2.5 border border-slate-200">
              <div className="text-[11px] font-medium text-slate-600 mb-1">
                Current in Table
              </div>
              <div className="text-xs text-slate-700 leading-relaxed select-text break-words max-h-20 overflow-y-auto font-normal">
                {mismatch.actual ? (
                  mismatch.expected.trim().toLowerCase() === mismatch.actual.trim().toLowerCase() &&
                  mismatch.expected.trim() !== mismatch.actual.trim() ? (
                    <span>
                      {mismatch.actual.split('').map((char, i) => {
                        const isDiff = char !== mismatch.expected[i]
                        return isDiff ? (
                          <span
                            key={i}
                            className="bg-rose-100 text-rose-800 font-bold px-0.5 rounded underline decoration-rose-500"
                            title={`Current uppercase '${char}' in table`}
                          >
                            {char}
                          </span>
                        ) : (
                          char
                        )
                      })}
                    </span>
                  ) : (
                    mismatch.actual
                  )
                ) : (
                  <span className="text-slate-400 italic">(Empty in Table)</span>
                )}
              </div>
            </div>
          </div>

          {/* Action Buttons */}
          <div className="mt-3 flex items-center gap-2 pt-2 border-t border-slate-100">
            <button
              type="button"
              onClick={handleApply}
              disabled={applied}
              className={`flex-1 flex items-center justify-center gap-1.5 py-1.5 px-3 rounded-lg font-medium text-xs transition cursor-pointer shadow-xs ${
                applied
                  ? 'bg-emerald-600 text-white'
                  : 'bg-[#007AFF] hover:bg-[#0062CC] text-white active:scale-[0.99]'
              }`}
            >
              <Check className="w-3.5 h-3.5 stroke-[2.5]" />
              <span>{applied ? 'Applied!' : 'Apply Sheet Value'}</span>
            </button>

            {sheetUrl && (
              <a
                href={sheetUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="px-2.5 py-1.5 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-600 hover:text-slate-900 text-xs transition flex items-center gap-1 shrink-0 border border-slate-200/80"
                title="Open Google Sheet"
              >
                <ExternalLink className="w-3.5 h-3.5" />
              </a>
            )}
          </div>
        </div>

        {/* Caret pointing down if above anchor */}
        {coords.isAbove && (
          <div
            className="w-2.5 h-2.5 bg-white rotate-45 border-r border-b border-slate-200 -mt-1.5 shrink-0 z-10"
            style={{ marginLeft: `${arrowOffset}px` }}
          />
        )}
      </div>
    </>
  )
}
