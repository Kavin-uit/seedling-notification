import React, { useState, useEffect } from 'react'
import { createPortal } from 'react-dom'
import type { NotificationScenario } from '../../types/notification'
import { polishCommentWithGemini, prefetchPolish } from '../../services/commentAiService'
import { GeminiSparkleIcon } from './JiraTable'
import {
  X,
  Pencil,
  Check,
  Loader2,
  Sparkles,
  MessageSquare,
  Copy,
  Eye,
} from 'lucide-react'

interface CommentBriefModalProps {
  scenario: NotificationScenario | null
  anchorRect?: DOMRect | null
  initialEditing?: boolean
  onClose: () => void
  onUpdateScenario: (updated: NotificationScenario) => void
}

export const CommentBriefModal: React.FC<CommentBriefModalProps> = ({
  scenario,
  anchorRect,
  initialEditing = true,
  onClose,
  onUpdateScenario,
}) => {
  const [isEditing, setIsEditing] = useState<boolean>(
    initialEditing ?? !scenario?.comments?.trim()
  )
  const [draftComment, setDraftComment] = useState<string>(scenario?.comments || '')
  const [isPolishing, setIsPolishing] = useState(false)
  const [polishedSuccess, setPolishedSuccess] = useState(false)
  const [saveToast, setSaveToast] = useState<string | null>(null)
  const [copied, setCopied] = useState(false)

  // Sync draft whenever scenario or initialEditing changes
  useEffect(() => {
    if (!scenario) return
    const comment = scenario.comments || ''
    setDraftComment(comment)
    setIsEditing(initialEditing ?? !comment.trim())
    setPolishedSuccess(false)
    if (comment.trim().length >= 5) {
      prefetchPolish(comment, 'comment')
    }
  }, [scenario, initialEditing])

  // Smart background pre-fetch while typing (debounced) so clicking AI is instant (0ms)
  useEffect(() => {
    if (!isEditing || !draftComment.trim() || draftComment.trim().length < 5) return
    const timer = setTimeout(() => {
      prefetchPolish(draftComment, 'comment')
    }, 900)
    return () => clearTimeout(timer)
  }, [draftComment, isEditing])

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

  if (!scenario) return null

  const isChanged = draftComment.trim() !== (scenario.comments || '').trim()

  const handleAiPolish = async () => {
    if (!draftComment.trim() || isPolishing) return
    setIsPolishing(true)
    try {
      const polished = await polishCommentWithGemini(draftComment)
      if (polished) {
        setDraftComment(polished)
        setPolishedSuccess(true)
        setTimeout(() => setPolishedSuccess(false), 2400)
      }
    } catch (err) {
      console.error('Failed to polish comment with Gemini AI:', err)
    } finally {
      setIsPolishing(false)
    }
  }

  const handleSave = () => {
    const trimmed = draftComment.trim()
    const updated: NotificationScenario = {
      ...scenario,
      comments: trimmed,
      updatedAt: new Date().toISOString(),
    }
    onUpdateScenario(updated)
    setSaveToast(trimmed ? 'Saved comment' : 'Cleared comment')
    setTimeout(() => {
      setSaveToast(null)
      onClose()
    }, 350)
  }

  const handleCancel = () => {
    setDraftComment(scenario.comments || '')
    setPolishedSuccess(false)
    if (scenario.comments?.trim()) {
      setIsEditing(false)
    } else {
      onClose()
    }
  }

  const handleCopy = async () => {
    if (!scenario.comments?.trim()) return
    try {
      await navigator.clipboard.writeText(scenario.comments.trim())
      setCopied(true)
      setTimeout(() => setCopied(false), 1800)
    } catch {
      // ignore
    }
  }

  // Calculate tooltip-style popover positioning
  const popoverWidth = 340
  const estimatedHeight = 220
  const padding = 12

  const isBelow = anchorRect
    ? anchorRect.bottom + estimatedHeight + 16 <= window.innerHeight
    : true

  const top = anchorRect
    ? isBelow
      ? anchorRect.bottom + 8
      : Math.max(padding, anchorRect.top - estimatedHeight - 8)
    : undefined

  const left = anchorRect
    ? Math.max(
        padding,
        Math.min(
          window.innerWidth - popoverWidth - padding,
          anchorRect.left + anchorRect.width / 2 - popoverWidth / 2
        )
      )
    : undefined

  const arrowOffset =
    anchorRect && left !== undefined
      ? Math.max(
          16,
          Math.min(popoverWidth - 24, anchorRect.left + anchorRect.width / 2 - left - 5)
        )
      : popoverWidth / 2 - 5

  return createPortal(
    <>
      {/* Transparent Click-Outside Overlay */}
      <div
        className="fixed inset-0 z-[99998] bg-transparent select-none"
        onClick={onClose}
      />

      {/* Tooltip-Style Popover */}
      <div
        className={`fixed z-[99999] flex flex-col transition-all duration-150 animate-in fade-in zoom-in-95 ease-out ${
          !anchorRect ? 'inset-0 items-center justify-center p-4 pointer-events-none' : ''
        }`}
        style={
          anchorRect
            ? {
                top: `${top}px`,
                left: `${left}px`,
                width: `${popoverWidth}px`,
              }
            : undefined
        }
      >
        {/* Caret pointing up if placed below anchor */}
        {anchorRect && isBelow && (
          <div
            className="w-2.5 h-2.5 bg-white rotate-45 border-l border-t border-slate-200/90 -mb-1.5 shrink-0 z-10"
            style={{ marginLeft: `${arrowOffset}px` }}
          />
        )}

        <div
          className={`w-full bg-white rounded-xl shadow-2xl border border-slate-200/90 overflow-hidden text-[#1C1C1E] font-sans ${
            !anchorRect ? 'pointer-events-auto max-w-[340px]' : ''
          }`}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Header Bar */}
          <div className="flex items-center justify-between px-3.5 py-2.5 bg-white border-b border-slate-100">
            <div className="flex items-center gap-1.5 min-w-0 pr-2">
              <MessageSquare className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
              <span className="text-xs font-semibold text-slate-800 truncate">
                {isEditing ? 'Enter Comment' : 'Comment'} • {scenario.key}
              </span>
            </div>

            <div className="flex items-center gap-1 shrink-0">
              {/* If viewing, show Copy & Edit buttons */}
              {!isEditing ? (
                <>
                  {scenario.comments?.trim() && (
                    <button
                      type="button"
                      onClick={handleCopy}
                      className="p-1 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded transition cursor-pointer"
                      title={copied ? 'Copied!' : 'Copy comment'}
                    >
                      {copied ? (
                        <Check className="w-3 h-3 text-emerald-600 stroke-[2.5]" />
                      ) : (
                        <Copy className="w-3 h-3" />
                      )}
                    </button>
                  )}
                  <button
                    type="button"
                    onClick={() => setIsEditing(true)}
                    className="inline-flex items-center gap-1 px-2 py-0.5 rounded text-[11px] font-semibold text-[#0052CC] hover:bg-blue-50 transition cursor-pointer"
                    title="Edit comment"
                  >
                    <Pencil className="w-3 h-3" />
                    <span>Edit</span>
                  </button>
                </>
              ) : (
                <>
                  {/* If editing and already has existing text, show View button */}
                  {scenario.comments?.trim() && (
                    <button
                      type="button"
                      onClick={() => setIsEditing(false)}
                      className="p-1 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded transition cursor-pointer"
                      title="View formatted text"
                    >
                      <Eye className="w-3 h-3" />
                    </button>
                  )}

                  {/* Gemini AI sparkle button */}
                  <button
                    type="button"
                    disabled={isPolishing || !draftComment.trim()}
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
                </>
              )}

              {/* Close Button */}
              <button
                type="button"
                onClick={onClose}
                className="p-1 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded transition cursor-pointer"
                title="Close (Esc)"
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
              /* VIEW MODE: Clean readable text, click to edit */
              <div
                className="min-h-[50px] cursor-pointer group"
                onClick={() => setIsEditing(true)}
                title="Click to edit comment"
              >
                {scenario.comments && scenario.comments.trim().length > 0 ? (
                  <p className="text-xs text-slate-700 leading-relaxed whitespace-pre-wrap select-text group-hover:text-slate-900 transition font-normal">
                    {scenario.comments}
                  </p>
                ) : (
                  <p className="text-xs text-slate-400 italic py-2">
                    No comment added yet. Click to enter comment.
                  </p>
                )}
                <div className="pt-2 flex justify-end">
                  <span className="text-[10px] text-slate-400 group-hover:text-[#007AFF] transition flex items-center gap-1">
                    <Pencil className="w-2.5 h-2.5" />
                    <span>Click to edit</span>
                  </span>
                </div>
              </div>
            ) : (
              /* EDIT MODE: Tooltip-like multi-line text input with AI + Save */
              <div className="space-y-2">
                <textarea
                  autoFocus
                  rows={4}
                  value={draftComment}
                  onChange={(e) => setDraftComment(e.target.value)}
                  onKeyDown={(e) => {
                    if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
                      e.preventDefault()
                      handleSave()
                    }
                  }}
                  placeholder="Type comment, observation, or QA note..."
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

                <div className="flex items-center justify-between pt-0.5">
                  <span className="text-[10px] text-slate-400">
                    ⌘+Enter to save
                  </span>
                  <div className="flex items-center gap-1.5">
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
                      className={`px-3 py-1 rounded text-xs font-semibold text-white shadow-xs transition cursor-pointer inline-flex items-center gap-1 ${
                        isChanged
                          ? 'bg-[#007AFF] hover:bg-[#0062CC]'
                          : 'bg-[#007AFF]/80 hover:bg-[#007AFF]'
                      }`}
                    >
                      <Check className="w-3 h-3 stroke-[2.5]" />
                      <span>Save</span>
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Caret pointing down if placed above anchor */}
        {anchorRect && !isBelow && (
          <div
            className="w-2.5 h-2.5 bg-white rotate-45 border-r border-b border-slate-200/90 -mt-1.5 shrink-0 z-10"
            style={{ marginLeft: `${arrowOffset}px` }}
          />
        )}
      </div>
    </>,
    document.body
  )
}
