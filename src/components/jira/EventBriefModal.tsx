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
  onClose: () => void
  onUpdateScenario: (updated: NotificationScenario) => void
}

export const EventBriefModal: React.FC<EventBriefModalProps> = ({
  scenario,
  onClose,
  onUpdateScenario,
}) => {
  if (!scenario) return null

  const [draftNotes, setDraftNotes] = useState<string>(scenario.notes || '')
  const [isPolishing, setIsPolishing] = useState(false)
  const [polishedSuccess, setPolishedSuccess] = useState(false)
  const [saveToast, setSaveToast] = useState<string | null>(null)

  // Sync draftNotes whenever scenario changes
  useEffect(() => {
    setDraftNotes(scenario.notes || '')
    setPolishedSuccess(false)
  }, [scenario.id, scenario.notes])

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
    }, 600)
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-md animate-in fade-in duration-200 select-text"
      onClick={onClose}
    >
      <div
        className="w-full max-w-lg bg-[#F2F2F7] rounded-[26px] shadow-2xl border border-white/80 flex flex-col overflow-hidden text-[#1C1C1E] font-[-apple-system,BlinkMacSystemFont,'SF_Pro_Text','SF_Pro_Display',system-ui,sans-serif] animate-in zoom-in-95 duration-150"
        onClick={(e) => e.stopPropagation()}
      >
        {/* iOS Drag Handle */}
        <div className="w-10 h-1 rounded-full bg-slate-300/80 mx-auto mt-2.5 mb-1 shrink-0" />

        {/* iOS Header: Event Title and Circular Close Button */}
        <div className="flex items-center justify-between px-6 pt-3 pb-3">
          <div className="min-w-0 pr-3">
            <h2 className="text-base sm:text-lg font-bold text-[#1C1C1E] tracking-tight leading-snug truncate">
              {scenario.governanceEvent}
            </h2>
          </div>

          {/* iOS Circular Close Button */}
          <button
            type="button"
            onClick={onClose}
            className="w-7 h-7 rounded-full bg-slate-200/80 hover:bg-slate-300/90 text-slate-500 hover:text-slate-800 flex items-center justify-center transition cursor-pointer shrink-0"
            title="Close"
          >
            <X className="w-4 h-4 stroke-[2.5]" />
          </button>
        </div>

        {/* Save Confirmation Toast */}
        {saveToast && (
          <div className="mx-6 mb-2 px-3 py-1.5 rounded-xl bg-emerald-500/10 border border-emerald-500/20 text-emerald-700 text-xs font-semibold flex items-center gap-1.5 animate-in fade-in duration-150">
            <Check className="w-3.5 h-3.5 stroke-[2.5] text-emerald-600" />
            <span>{saveToast}</span>
          </div>
        )}

        {/* Modal Body: Clean iOS Inset Grouped Card with Direct Note Field */}
        <div className="px-6 pb-6 pt-1">
          <div className="bg-white rounded-2xl p-4 sm:p-5 border border-black/5 shadow-xs space-y-3">
            {/* Top Toolbar: Pen Icon Indicator & Gemini AI Frame Action */}
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-1.5 text-slate-400 text-xs font-medium">
                <Pencil className="w-3.5 h-3.5" />
              </div>

              {/* Gemini AI Auto-Frame Button */}
              <button
                type="button"
                disabled={isPolishing || !draftNotes.trim()}
                onClick={handleAiPolish}
                className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold text-purple-700 bg-purple-50 hover:bg-purple-100 border border-purple-200 transition cursor-pointer disabled:opacity-40"
                title="Auto-correct spelling & frame into proper English with Gemini AI"
              >
                {isPolishing ? (
                  <Loader2 className="w-3.5 h-3.5 animate-spin text-purple-600" />
                ) : (
                  <GeminiSparkleIcon className="w-3.5 h-3.5 text-purple-600" />
                )}
                <span>Gemini AI</span>
              </button>
            </div>

            {/* Direct Editable Text Area */}
            <div className="relative">
              <textarea
                autoFocus
                rows={5}
                value={draftNotes}
                onChange={(e) => setDraftNotes(e.target.value)}
                onKeyDown={(e) => {
                  if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
                    e.preventDefault()
                    handleSave()
                  }
                }}
                placeholder="Add description or notes for this event..."
                className={`w-full text-sm p-3.5 rounded-xl bg-[#F2F2F7]/70 border ${
                  polishedSuccess
                    ? 'border-emerald-500 ring-2 ring-emerald-200/60 bg-white'
                    : 'border-slate-200/80 focus:bg-white focus:border-[#007AFF] focus:ring-3 focus:ring-[#007AFF]/15'
                } text-[#1C1C1E] placeholder:text-slate-400 resize-none outline-none leading-relaxed transition`}
              />

              {/* Gemini polish indicator banner */}
              {polishedSuccess && (
                <div className="mt-1 flex items-center gap-1 text-[11px] font-medium text-emerald-600 animate-in fade-in">
                  <Sparkles className="w-3 h-3 text-emerald-600" />
                  <span>Framed and spelling corrected with Gemini AI</span>
                </div>
              )}
            </div>

            {/* Bottom Actions */}
            <div className="flex items-center justify-end gap-2 pt-1">
              <button
                type="button"
                onClick={onClose}
                className="px-4 py-1.5 rounded-full text-xs font-medium text-slate-600 hover:bg-slate-100 transition cursor-pointer"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={handleSave}
                className="px-5 py-1.5 rounded-full text-xs font-semibold bg-[#007AFF] hover:bg-[#0062CC] text-white shadow-xs transition cursor-pointer inline-flex items-center gap-1"
              >
                <Check className="w-3.5 h-3.5 stroke-[2.5]" />
                <span>Done</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
