import React, { useState, useEffect, useRef } from 'react'
import { X, Copy, Check, ExternalLink, Share2, Layers, Filter } from 'lucide-react'
import { copyShareUrlToClipboard } from '../../utils/filterShare'

interface ShareFilterModalProps {
  isOpen: boolean
  onClose: () => void
  shareUrl: string
  selectedEngine?: string
  selectedStatuses?: string[]
  searchQuery?: string
  matchingCount?: number
}

export const ShareFilterModal: React.FC<ShareFilterModalProps> = ({
  isOpen,
  onClose,
  shareUrl,
  selectedEngine = 'ALL',
  selectedStatuses = [],
  searchQuery = '',
  matchingCount = 0,
}) => {
  const [copied, setCopied] = useState(false)
  const inputRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    if (isOpen) {
      setCopied(false)
      setTimeout(() => {
        if (inputRef.current) {
          inputRef.current.select()
        }
      }, 50)
    }
  }, [isOpen])

  if (!isOpen) return null

  const handleCopy = async () => {
    const success = await copyShareUrlToClipboard(shareUrl)
    if (success) {
      setCopied(true)
      setTimeout(() => setCopied(false), 2500)
    }
  }

  return (
    <div
      className="fixed inset-0 z-[10000] flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-150 select-none"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-lg shadow-2xl border border-[#DFE1E6] w-full max-w-lg overflow-hidden animate-in zoom-in-95 duration-150 text-[#172B4D]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="px-5 py-4 border-b border-[#EBECF0] flex items-center justify-between bg-[#FAFBFC]">
          <div className="flex items-center gap-2.5">
            <div className="w-8 h-8 rounded-full bg-blue-100 text-[#0052CC] flex items-center justify-center">
              <Share2 className="w-4 h-4" />
            </div>
            <div>
              <h3 className="font-bold text-sm text-[#172B4D]">Share Filtered View</h3>
              <p className="text-xs text-[#6B778C]">
                Anyone with this link will open this exact filtered records view.
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="p-1.5 rounded hover:bg-[#EBECF0] text-[#6B778C] hover:text-[#172B4D] transition cursor-pointer"
            title="Close (Esc)"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Body */}
        <div className="p-5 space-y-4 text-xs">
          {/* Active Filter Chips */}
          <div>
            <label className="block text-[11px] font-bold text-[#6B778C] uppercase tracking-wider mb-2">
              Active Filters Included ({matchingCount} matching records)
            </label>
            <div className="flex flex-wrap items-center gap-1.5 p-2.5 bg-[#F4F5F7] rounded border border-[#DFE1E6]">
              {/* Engine */}
              {selectedEngine !== 'ALL' ? (
                <span className="inline-flex items-center gap-1 px-2 py-1 rounded bg-blue-100 text-blue-800 font-semibold border border-blue-200">
                  <Layers className="w-3 h-3" />
                  Engine: {selectedEngine}
                </span>
              ) : (
                <span className="inline-flex items-center gap-1 px-2 py-1 rounded bg-slate-200 text-slate-700 font-medium">
                  All Engines
                </span>
              )}

              {/* Statuses */}
              {selectedStatuses.length > 0 ? (
                selectedStatuses.map((st) => (
                  <span
                    key={st}
                    className="inline-flex items-center gap-1 px-2 py-1 rounded bg-emerald-100 text-emerald-800 font-semibold border border-emerald-200"
                  >
                    <Filter className="w-3 h-3" />
                    Status: {st === 'NOT_WORKING_ANY' ? 'All Not Working' : st}
                  </span>
                ))
              ) : (
                <span className="inline-flex items-center gap-1 px-2 py-1 rounded bg-slate-200 text-slate-700 font-medium">
                  All Statuses
                </span>
              )}

              {/* Search query */}
              {searchQuery.trim() && (
                <span className="inline-flex items-center gap-1 px-2 py-1 rounded bg-purple-100 text-purple-800 font-semibold border border-purple-200">
                  Search: "{searchQuery.trim()}"
                </span>
              )}
            </div>
          </div>

          {/* Shareable Link Input with One-Click Copy */}
          <div>
            <label className="block text-[11px] font-bold text-[#6B778C] uppercase tracking-wider mb-1.5">
              Shareable URL
            </label>
            <div className="flex items-center gap-2">
              <input
                ref={inputRef}
                type="text"
                readOnly
                value={shareUrl}
                onFocus={(e) => e.target.select()}
                className="flex-1 bg-white border border-[#C1C7D0] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 rounded px-3 py-2 text-xs text-[#172B4D] font-mono outline-none select-all transition"
              />
              <button
                type="button"
                onClick={handleCopy}
                className={`cursor-pointer px-4 py-2 rounded text-xs font-semibold flex items-center gap-1.5 transition shrink-0 shadow-2xs ${
                  copied
                    ? 'bg-emerald-600 hover:bg-emerald-700 text-white ring-1 ring-emerald-500'
                    : 'bg-[#0052CC] hover:bg-[#0747A6] text-white'
                }`}
              >
                {copied ? (
                  <>
                    <Check className="w-3.5 h-3.5 stroke-[2.5]" />
                    <span>Copied!</span>
                  </>
                ) : (
                  <>
                    <Copy className="w-3.5 h-3.5" />
                    <span>Copy Link</span>
                  </>
                )}
              </button>
            </div>
            {copied && (
              <p className="text-[11px] text-emerald-700 font-semibold mt-1.5 flex items-center gap-1 animate-in fade-in duration-100">
                <Check className="w-3.5 h-3.5" /> Link copied to clipboard! You can now paste and send it to your team.
              </p>
            )}
          </div>
        </div>

        {/* Footer */}
        <div className="px-5 py-3 border-t border-[#EBECF0] bg-[#FAFBFC] flex items-center justify-between">
          <a
            href={shareUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-[#0052CC] hover:underline text-xs font-medium inline-flex items-center gap-1 cursor-pointer"
          >
            <ExternalLink className="w-3 h-3" />
            <span>Open preview in new tab</span>
          </a>
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 rounded text-xs font-medium bg-[#EBECF0] hover:bg-[#DFE1E6] text-[#172B4D] transition cursor-pointer"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}
