import React, { useState, useEffect } from 'react'
import type { NotificationScenario } from '../../types/notification'
import { polishTextWithGemini } from '../../services/commentAiService'
import { GeminiSparkleIcon } from './JiraTable'
import {
  X,
  Pencil,
  Check,
  Loader2,
  Sparkles,
} from 'lucide-react'

interface EventBriefModalProps {
  scenario: NotificationScenario | null
  anchorRect?: DOMRect | null
  onClose: () => void
  onUpdateScenario: (updated: NotificationScenario) => void
}

export const EventBriefModal: React.FC<EventBriefModalProps> = ({
  scenario,
  anchorRect,
  onClose,
  onUpdateScenario,
}) => {
  if (!scenario) return null

  const [isEditing, setIsEditing] = useState<boolean>(!scenario.notes?.trim())
  const [draftNotes, setDraftNotes] = useState<string>(scenario.notes || '')
  const [isPolishing, setIsPolishing] = useState(false)
  const [polishedSuccess, setPolishedSuccess] = useState(false)
  const [saveToast, setSaveToast] = useState<string | null>(null)

  // Sync draftNotes whenever scenario changes
  useEffect(() => {
    setDraftNotes(scenario.notes || '')
    setIsEditing(!scenario.notes?.trim())
    setPolishedSuccess(false)
  }, [scenario.id, scenario.notes])

  // Close on Escape key
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose()
      }
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [onClose])

  const handleAiPolish = async () => {
    if (!draftNotes.trim() || isPolishing) return
    setIsPolishing(true)
    try {
      const polished = await polishTextWithGemini(draftNotes, 'event description')
      if (polished) {
        setDraftNotes(polished)
        setPolishedSuccess(true)
        setTimeout(() => setPolishedSuccess(false), 2400)
      }
    } catch (err) {
      console.error('Failed to polish extra info with Gemini:', err)
    } finally {
      setIsPolishing(false)
    }
  }

  const handleSave = () => {
    const trimmed = draftNotes.trim()
    const updated: NotificationScenario = {
      ...scenario,
      notes: trimmed,
      updatedAt: new Date().toISOString(),
    }
    onUpdateScenario(updated)
    setSaveToast(trimmed ? 'Saved' : 'Cleared')
    setTimeout(() => {
      setSaveToast(null)
      onClose()
    }, 350)
  }

  const handleCancel = () => {
    setDraftNotes(scenario.notes || '')
    setPolishedSuccess(false)
    onClose()
  }

  // Calculate popover positioning if anchorRect is provided
  const popoverWidth = 300
  const isNearTop = anchorRect ? anchorRect.top < 240 : false
  const left = anchorRect
    ? Math.max(
        12,
        Math.min(
          window.innerWidth - popoverWidth - 12,
          anchorRect.left + anchorRect.width / 2 - popoverWidth / 2
        )
      )
    : undefined
  const arrowOffset =
    anchorRect && left !== undefined
      ? Math.max(
          14,
          Math.min(popoverWidth - 24, anchorRect.left + anchorRect.width / 2 - left - 5)
        )
      : popoverWidth / 2 - 5

  return (
    <>
      {/* Transparent Click-Outside Overlay (No dark screen takeover) */}
      <div
        className="fixed inset-0 z-40 bg-transparent select-none"
        onClick={onClose}
      />

      {/* Tooltip-Style Popover */}
      <div
        className={`fixed z-50 flex flex-col transition-all duration-150 animate-in fade-in zoom-in-95 ${
          !anchorRect ? 'inset-0 items-center justify-center p-4 pointer-events-none' : ''
        }`}
        style={
          anchorRect
            ? {
                top: isNearTop ? `${anchorRect.bottom + 8}px` : undefined,
                bottom: !isNearTop
                  ? `${window.innerHeight - anchorRect.top + 8}px`
                  : undefined,
                left: `${left}px`,
                width: `${popoverWidth}px`,
              }
            : undefined
        }
      >
        {/* Caret pointing up if near top */}
        {anchorRect && isNearTop && (
          <div
            className="w-2.5 h-2.5 bg-white rotate-45 border-l border-t border-slate-200/80 -mb-1.5 shrink-0 z-10"
            style={{ marginLeft: `${arrowOffset}px` }}
          />
        )}

        <div
          className={`w-full max-w-[320px] bg-white rounded-xl shadow-xl border border-slate-200/90 overflow-hidden text-[#1C1C1E] font-sans ${
            !anchorRect ? 'pointer-events-auto shadow-2xl' : ''
          }`}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Header Bar */}
          <div className="flex items-center justify-between px-3.5 py-2 bg-slate-50/80 border-b border-slate-100">
            <span className="text-xs font-semibold text-slate-800 truncate pr-2">
              {scenario.governanceEvent}
            </span>

            <div className="flex items-center gap-1 shrink-0">
              {/* If viewing, show Edit pencil button */}
              {!isEditing ? (
                <button
                  type="button"
                  onClick={() => setIsEditing(true)}
                  className="p-1 text-slate-500 hover:text-[#007AFF] hover:bg-slate-100 rounded transition cursor-pointer"
                  title="Edit info"
                >
                  <Pencil className="w-3 h-3" />
                </button>
              ) : (
                /* If editing, show Gemini AI sparkle button */
                <button
                  type="button"
                  disabled={isPolishing || !draftNotes.trim()}
                  onClick={handleAiPolish}
                  className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[11px] font-semibold text-purple-700 bg-purple-50 hover:bg-purple-100 border border-purple-200 transition cursor-pointer disabled:opacity-40"
                  title="Fix spelling & frame with Gemini AI"
                >
                  {isPolishing ? (
                    <Loader2 className="w-3 h-3 animate-spin text-purple-600" />
                  ) : (
                    <GeminiSparkleIcon className="w-3 h-3 text-purple-600" />
                  )}
                  <span>AI</span>
                </button>
              )}

              {/* Close Button */}
              <button
                type="button"
                onClick={onClose}
                className="p-1 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded transition cursor-pointer"
                title="Close"
              >
                <X className="w-3.5 h-3.5" />
              </button>
            </div>
          </div>

          {/* Toast Notification */}
          {saveToast && (
            <div className="px-3 py-1 bg-emerald-50 text-emerald-700 text-[11px] font-medium flex items-center gap-1 border-b border-emerald-100">
              <Check className="w-3 h-3 text-emerald-600 stroke-[2.5]" />
              <span>{saveToast}</span>
            </div>
          )}

          {/* Popover Content */}
          <div className="p-3">
            {!isEditing ? (
              /* VIEW MODE: Plain text, simple & lightweight */
              <div className="min-h-[50px]">
                {scenario.notes && scenario.notes.trim().length > 0 ? (
                  <p className="text-xs text-slate-700 leading-relaxed whitespace-pre-wrap select-text">
                    {scenario.notes}
                  </p>
                ) : (
                  <p className="text-xs text-slate-400 italic py-2">
                    No info added yet. Click pencil to add.
                  </p>
                )}
              </div>
            ) : (
              /* EDIT MODE: Simple compact textarea + Save / Cancel */
              <div className="space-y-2">
                <textarea
                  autoFocus
                  rows={4}
                  value={draftNotes}
                  onChange={(e) => setDraftNotes(e.target.value)}
                  onKeyDown={(e) => {
                    if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
                      e.preventDefault()
                      handleSave()
                    }
                  }}
                  placeholder="Add info or details..."
                  className={`w-full text-xs p-2 rounded-lg bg-slate-50 border ${
                    polishedSuccess
                      ? 'border-emerald-500 ring-1 ring-emerald-200 bg-white'
                      : 'border-slate-200 focus:bg-white focus:border-[#007AFF] focus:ring-1 focus:ring-[#007AFF]'
                  } text-[#1C1C1E] placeholder:text-slate-400 resize-none outline-none leading-relaxed transition`}
                />

                {polishedSuccess && (
                  <div className="flex items-center gap-1 text-[10px] font-medium text-emerald-600">
                    <Sparkles className="w-3 h-3 text-emerald-600" />
                    <span>Framed with Gemini AI</span>
                  </div>
                )}

                <div className="flex items-center justify-end gap-1.5 pt-0.5">
                  <button
                    type="button"
                    onClick={handleCancel}
                    className="px-2.5 py-1 rounded text-xs font-medium text-slate-600 hover:bg-slate-100 transition cursor-pointer"
                  >
                    Cancel
                  </button>
                  <button
                    type="button"
                    onClick={handleSave}
                    className="px-3 py-1 rounded text-xs font-semibold bg-[#007AFF] hover:bg-[#0062CC] text-white shadow-xs transition cursor-pointer inline-flex items-center gap-1"
                  >
                    <Check className="w-3 h-3 stroke-[2.5]" />
                    <span>Save</span>
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Caret pointing down if not near top */}
        {anchorRect && !isNearTop && (
          <div
            className="w-2.5 h-2.5 bg-white rotate-45 border-r border-b border-slate-200/80 -mt-1.5 shrink-0 z-10"
            style={{ marginLeft: `${arrowOffset}px` }}
          />
        )}
      </div>
    </>
  )
}
