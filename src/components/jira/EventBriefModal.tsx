import React, { useState } from 'react'
import type { NotificationScenario } from '../../types/notification'
import { polishTextWithGemini } from '../../services/commentAiService'
import { GeminiSparkleIcon } from './JiraTable'
import {
  X,
  Edit3,
  Check,
  Loader2,
  Bell,
  Mail,
  Smartphone,
  ExternalLink,
  Target,
  Users,
  Zap,
  CheckCircle2,
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

  const [isEditing, setIsEditing] = useState(false)
  const [formData, setFormData] = useState<NotificationScenario>({ ...scenario })
  const [polishingField, setPolishingField] = useState<string | null>(null)
  const [polishedSuccessField, setPolishedSuccessField] = useState<string | null>(null)
  const [saveToast, setSaveToast] = useState<string | null>(null)

  const handleFieldChange = (field: keyof NotificationScenario, value: string) => {
    setFormData((prev) => ({ ...prev, [field]: value }))
  }

  const handleAiPolish = async (field: keyof NotificationScenario, label: string) => {
    const rawValue = String(formData[field] || '')
    if (!rawValue.trim() || polishingField) return

    setPolishingField(field)
    try {
      const polished = await polishTextWithGemini(rawValue, label)
      if (polished) {
        setFormData((prev) => ({ ...prev, [field]: polished }))
        setPolishedSuccessField(field)
        setTimeout(() => setPolishedSuccessField(null), 2200)
      }
    } catch (err) {
      console.error('Error polishing with Gemini AI:', err)
    } finally {
      setPolishingField(null)
    }
  }

  const handleSave = () => {
    const updated: NotificationScenario = {
      ...formData,
      updatedAt: new Date().toISOString(),
    }
    onUpdateScenario(updated)
    setSaveToast('Changes saved successfully to database!')
    setTimeout(() => {
      setSaveToast(null)
      setIsEditing(false)
    }, 900)
  }

  const handleCancel = () => {
    setFormData({ ...scenario })
    setIsEditing(false)
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4 bg-black/45 backdrop-blur-xs animate-in fade-in duration-150 select-text"
      onClick={onClose}
    >
      <div
        className="w-full max-w-2xl bg-white rounded-2xl shadow-2xl border border-slate-200 flex flex-col max-h-[92dvh] overflow-hidden text-[#172B4D] font-sans"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header Bar */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100 bg-[#FAFBFC]">
          <div className="flex items-center gap-2.5 min-w-0">
            <span
              className={`px-2 py-0.5 rounded text-[11px] font-bold uppercase tracking-wider ${
                scenario.engineCategory === 'Governance'
                  ? 'bg-emerald-100 text-emerald-800 border border-emerald-200'
                  : 'bg-blue-100 text-blue-800 border border-blue-200'
              }`}
            >
              {scenario.key}
            </span>
            <span className="text-xs text-slate-400">•</span>
            <span className="text-xs font-semibold text-slate-600">
              {scenario.engineCategory} Engine Brief
            </span>
          </div>

          <div className="flex items-center gap-2">
            {!isEditing ? (
              <button
                type="button"
                onClick={() => setIsEditing(true)}
                className="px-3 py-1.5 rounded-lg bg-[#0052CC] hover:bg-[#0747A6] text-white text-xs font-semibold flex items-center gap-1.5 transition shadow-xs cursor-pointer"
              >
                <Edit3 className="w-3.5 h-3.5" />
                <span>Edit Brief</span>
              </button>
            ) : (
              <button
                type="button"
                onClick={handleSave}
                className="px-3 py-1.5 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-semibold flex items-center gap-1.5 transition shadow-xs cursor-pointer"
              >
                <Check className="w-3.5 h-3.5" />
                <span>Save</span>
              </button>
            )}

            <button
              type="button"
              onClick={onClose}
              className="p-1.5 rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition cursor-pointer"
              title="Close modal"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Save Toast Notification */}
        {saveToast && (
          <div className="bg-emerald-50 border-b border-emerald-200 text-emerald-800 px-5 py-2 text-xs font-medium flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-emerald-600" />
            <span>{saveToast}</span>
          </div>
        )}

        {/* Modal Scrollable Body */}
        <div className="flex-1 overflow-y-auto p-5 sm:p-6 space-y-5">
          {!isEditing ? (
            /* VIEW MODE */
            <div className="space-y-5">
              {/* Event Name & Core Brief */}
              <div className="p-4 rounded-xl bg-slate-50 border border-slate-200/80 space-y-2">
                <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                  Event Name
                </span>
                <h3 className="text-base sm:text-lg font-bold text-[#172B4D] leading-snug">
                  {scenario.governanceEvent}
                </h3>
              </div>

              {/* Grid: Trigger & Audience */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                <div className="p-3.5 rounded-xl border border-slate-200 bg-white space-y-1.5 shadow-2xs">
                  <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                    <Zap className="w-3.5 h-3.5 text-amber-500" />
                    <span>Trigger</span>
                  </div>
                  <p className="text-xs text-slate-800 leading-relaxed">
                    {scenario.trigger || <span className="italic text-slate-400">None specified</span>}
                  </p>
                </div>

                <div className="p-3.5 rounded-xl border border-slate-200 bg-white space-y-1.5 shadow-2xs">
                  <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                    <Users className="w-3.5 h-3.5 text-blue-500" />
                    <span>Target Audience</span>
                  </div>
                  <p className="text-xs text-slate-800 leading-relaxed">
                    {scenario.audience || <span className="italic text-slate-400">None specified</span>}
                  </p>
                </div>
              </div>

              {/* Objectives & Desired Outcome */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                <div className="p-3.5 rounded-xl border border-slate-200 bg-white space-y-1.5 shadow-2xs">
                  <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                    <Target className="w-3.5 h-3.5 text-indigo-500" />
                    <span>Communication Objective</span>
                  </div>
                  <p className="text-xs text-slate-800 leading-relaxed">
                    {scenario.communicationObjective || (
                      <span className="italic text-slate-400">None specified</span>
                    )}
                  </p>
                </div>

                <div className="p-3.5 rounded-xl border border-slate-200 bg-white space-y-1.5 shadow-2xs">
                  <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                    <CheckCircle2 className="w-3.5 h-3.5 text-emerald-500" />
                    <span>Desired Outcome</span>
                  </div>
                  <p className="text-xs text-slate-800 leading-relaxed">
                    {scenario.desiredOutcome || (
                      <span className="italic text-slate-400">None specified</span>
                    )}
                  </p>
                </div>
              </div>

              {/* Notification Channels Preview Card */}
              <div className="rounded-xl border border-slate-200 overflow-hidden shadow-2xs">
                <div className="bg-slate-100/70 px-4 py-2 border-b border-slate-200 text-xs font-bold text-slate-700 uppercase tracking-wider">
                  Configured Notification Channels
                </div>
                <div className="p-4 space-y-3.5 divide-y divide-slate-100 bg-white">
                  {/* Push */}
                  <div className="space-y-1">
                    <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                      <Bell className="w-3.5 h-3.5 text-blue-600" />
                      <span>Mobile Push Notification</span>
                    </div>
                    <p className="text-xs font-medium text-slate-800">
                      {scenario.pushSubject || 'No subject'}
                    </p>
                    <p className="text-xs text-slate-600 leading-relaxed">
                      {scenario.pushBody || 'No message body'}
                    </p>
                  </div>

                  {/* Email */}
                  <div className="pt-3 space-y-1">
                    <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                      <Mail className="w-3.5 h-3.5 text-purple-600" />
                      <span>Email Notification</span>
                    </div>
                    <p className="text-xs font-medium text-slate-800">
                      {scenario.emailSubject || 'No subject'}
                    </p>
                    <p className="text-xs text-slate-600 leading-relaxed">
                      {scenario.emailBody || 'No email body'}
                    </p>
                  </div>

                  {/* In-App & CTA */}
                  <div className="pt-3 grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div>
                      <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                        <Smartphone className="w-3.5 h-3.5 text-emerald-600" />
                        <span>In-App Experience</span>
                      </div>
                      <p className="text-xs text-slate-800 mt-1">
                        {scenario.inAppExperience || 'N/A'}
                      </p>
                    </div>
                    <div>
                      <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-600">
                        <ExternalLink className="w-3.5 h-3.5 text-teal-600" />
                        <span>Call to Action (CTA)</span>
                      </div>
                      <p className="text-xs font-bold text-[#0052CC] mt-1">
                        {scenario.cta || 'View Details'}
                      </p>
                    </div>
                  </div>
                </div>
              </div>

              {/* Comments */}
              {scenario.comments && (
                <div className="p-3.5 rounded-xl border border-slate-200 bg-amber-50/40 space-y-1">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-amber-800">
                    Comments / Notes
                  </span>
                  <p className="text-xs text-slate-800 leading-relaxed">{scenario.comments}</p>
                </div>
              )}
            </div>
          ) : (
            /* EDIT MODE WITH GEMINI AI ON EACH FIELD */
            <div className="space-y-4">
              <div className="bg-blue-50/70 border border-blue-200 rounded-xl p-3 flex items-center justify-between gap-2 text-xs text-blue-900">
                <span>
                  💡 <strong>Gemini AI Active:</strong> Click the sparkle logo (✨) on any field to auto-correct spelling and frame into professional English.
                </span>
              </div>

              {/* Event Name Field */}
              <div className="space-y-1">
                <div className="flex items-center justify-between text-xs font-semibold text-slate-700">
                  <label>Event Name</label>
                  {formData.governanceEvent.trim().length > 0 && (
                    <button
                      type="button"
                      disabled={polishingField === 'governanceEvent'}
                      onClick={() => handleAiPolish('governanceEvent', 'event name')}
                      className="px-2 py-0.5 rounded-full bg-purple-50 hover:bg-purple-100 text-purple-700 border border-purple-200 text-[10px] font-semibold flex items-center gap-1 transition cursor-pointer disabled:opacity-60"
                      title="Gemini AI: Fix spelling & frame event name"
                    >
                      {polishingField === 'governanceEvent' ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <GeminiSparkleIcon className="w-3 h-3" />
                      )}
                      <span>Gemini Frame</span>
                    </button>
                  )}
                </div>
                <input
                  type="text"
                  value={formData.governanceEvent}
                  onChange={(e) => handleFieldChange('governanceEvent', e.target.value)}
                  className={`w-full text-xs px-3 py-2 rounded-lg border ${
                    polishedSuccessField === 'governanceEvent'
                      ? 'border-emerald-500 ring-2 ring-emerald-100'
                      : 'border-slate-300 focus:border-[#0052CC] focus:ring-2 focus:ring-blue-100'
                  } outline-none transition`}
                  placeholder="e.g. Seedling Submitted for Review"
                />
              </div>

              {/* Trigger & Audience */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                {/* Trigger */}
                <div className="space-y-1">
                  <div className="flex items-center justify-between text-xs font-semibold text-slate-700">
                    <label>Trigger</label>
                    {formData.trigger.trim().length > 0 && (
                      <button
                        type="button"
                        disabled={polishingField === 'trigger'}
                        onClick={() => handleAiPolish('trigger', 'trigger description')}
                        className="px-2 py-0.5 rounded-full bg-purple-50 hover:bg-purple-100 text-purple-700 border border-purple-200 text-[10px] font-semibold flex items-center gap-1 transition cursor-pointer disabled:opacity-60"
                        title="Gemini AI: Frame trigger"
                      >
                        {polishingField === 'trigger' ? (
                          <Loader2 className="w-3 h-3 animate-spin" />
                        ) : (
                          <GeminiSparkleIcon className="w-3 h-3" />
                        )}
                        <span>AI</span>
                      </button>
                    )}
                  </div>
                  <input
                    type="text"
                    value={formData.trigger}
                    onChange={(e) => handleFieldChange('trigger', e.target.value)}
                    className={`w-full text-xs px-3 py-2 rounded-lg border ${
                      polishedSuccessField === 'trigger'
                        ? 'border-emerald-500 ring-2 ring-emerald-100'
                        : 'border-slate-300 focus:border-[#0052CC] focus:ring-2 focus:ring-blue-100'
                    } outline-none transition`}
                    placeholder="When user initiates..."
                  />
                </div>

                {/* Audience */}
                <div className="space-y-1">
                  <label className="text-xs font-semibold text-slate-700 block">Target Audience</label>
                  <input
                    type="text"
                    value={formData.audience}
                    onChange={(e) => handleFieldChange('audience', e.target.value)}
                    className="w-full text-xs px-3 py-2 rounded-lg border border-slate-300 focus:border-[#0052CC] focus:ring-2 focus:ring-blue-100 outline-none transition"
                    placeholder="e.g. Donor, Community Member"
                  />
                </div>
              </div>

              {/* Communication Objective & Desired Outcome */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                {/* Objective */}
                <div className="space-y-1">
                  <div className="flex items-center justify-between text-xs font-semibold text-slate-700">
                    <label>Communication Objective</label>
                    {formData.communicationObjective.trim().length > 0 && (
                      <button
                        type="button"
                        disabled={polishingField === 'communicationObjective'}
                        onClick={() => handleAiPolish('communicationObjective', 'objective')}
                        className="px-2 py-0.5 rounded-full bg-purple-50 hover:bg-purple-100 text-purple-700 border border-purple-200 text-[10px] font-semibold flex items-center gap-1 transition cursor-pointer disabled:opacity-60"
                        title="Gemini AI: Frame objective"
                      >
                        {polishingField === 'communicationObjective' ? (
                          <Loader2 className="w-3 h-3 animate-spin" />
                        ) : (
                          <GeminiSparkleIcon className="w-3 h-3" />
                        )}
                        <span>AI</span>
                      </button>
                    )}
                  </div>
                  <textarea
                    rows={2}
                    value={formData.communicationObjective}
                    onChange={(e) => handleFieldChange('communicationObjective', e.target.value)}
                    className={`w-full text-xs px-3 py-2 rounded-lg border ${
                      polishedSuccessField === 'communicationObjective'
                        ? 'border-emerald-500 ring-2 ring-emerald-100'
                        : 'border-slate-300 focus:border-[#0052CC] focus:ring-2 focus:ring-blue-100'
                    } outline-none transition resize-none`}
                    placeholder="Why we send this notification..."
                  />
                </div>

                {/* Desired Outcome */}
                <div className="space-y-1">
                  <div className="flex items-center justify-between text-xs font-semibold text-slate-700">
                    <label>Desired Outcome</label>
                    {formData.desiredOutcome.trim().length > 0 && (
                      <button
                        type="button"
                        disabled={polishingField === 'desiredOutcome'}
                        onClick={() => handleAiPolish('desiredOutcome', 'desired outcome')}
                        className="px-2 py-0.5 rounded-full bg-purple-50 hover:bg-purple-100 text-purple-700 border border-purple-200 text-[10px] font-semibold flex items-center gap-1 transition cursor-pointer disabled:opacity-60"
                        title="Gemini AI: Frame outcome"
                      >
                        {polishingField === 'desiredOutcome' ? (
                          <Loader2 className="w-3 h-3 animate-spin" />
                        ) : (
                          <GeminiSparkleIcon className="w-3 h-3" />
                        )}
                        <span>AI</span>
                      </button>
                    )}
                  </div>
                  <textarea
                    rows={2}
                    value={formData.desiredOutcome}
                    onChange={(e) => handleFieldChange('desiredOutcome', e.target.value)}
                    className={`w-full text-xs px-3 py-2 rounded-lg border ${
                      polishedSuccessField === 'desiredOutcome'
                        ? 'border-emerald-500 ring-2 ring-emerald-100'
                        : 'border-slate-300 focus:border-[#0052CC] focus:ring-2 focus:ring-blue-100'
                    } outline-none transition resize-none`}
                    placeholder="Action user should take..."
                  />
                </div>
              </div>

              {/* Push Notification Subject & Body */}
              <div className="space-y-2 p-3.5 rounded-xl border border-slate-200 bg-slate-50/50">
                <div className="flex items-center justify-between text-xs font-bold text-slate-700">
                  <div className="flex items-center gap-1.5">
                    <Bell className="w-3.5 h-3.5 text-blue-600" />
                    <span>Push Notification Copy</span>
                  </div>
                  {formData.pushBody.trim().length > 0 && (
                    <button
                      type="button"
                      disabled={polishingField === 'pushBody'}
                      onClick={() => handleAiPolish('pushBody', 'push notification message')}
                      className="px-2 py-0.5 rounded-full bg-purple-50 hover:bg-purple-100 text-purple-700 border border-purple-200 text-[10px] font-semibold flex items-center gap-1 transition cursor-pointer disabled:opacity-60"
                      title="Gemini AI: Polish push message"
                    >
                      {polishingField === 'pushBody' ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <GeminiSparkleIcon className="w-3 h-3" />
                      )}
                      <span>Frame Push</span>
                    </button>
                  )}
                </div>

                <input
                  type="text"
                  value={formData.pushSubject}
                  onChange={(e) => handleFieldChange('pushSubject', e.target.value)}
                  className="w-full text-xs px-3 py-1.5 rounded-lg border border-slate-300 bg-white focus:border-[#0052CC] outline-none"
                  placeholder="Push Subject Line"
                />

                <textarea
                  rows={2}
                  value={formData.pushBody}
                  onChange={(e) => handleFieldChange('pushBody', e.target.value)}
                  className={`w-full text-xs px-3 py-1.5 rounded-lg border ${
                    polishedSuccessField === 'pushBody'
                      ? 'border-emerald-500 ring-2 ring-emerald-100'
                      : 'border-slate-300 bg-white focus:border-[#0052CC]'
                  } outline-none resize-none`}
                  placeholder="Push message body..."
                />
              </div>

              {/* Comments Field */}
              <div className="space-y-1">
                <div className="flex items-center justify-between text-xs font-semibold text-slate-700">
                  <label>Comments / Notes</label>
                  {formData.comments && formData.comments.trim().length > 0 && (
                    <button
                      type="button"
                      disabled={polishingField === 'comments'}
                      onClick={() => handleAiPolish('comments', 'QA comment')}
                      className="px-2 py-0.5 rounded-full bg-purple-50 hover:bg-purple-100 text-purple-700 border border-purple-200 text-[10px] font-semibold flex items-center gap-1 transition cursor-pointer disabled:opacity-60"
                      title="Gemini AI: Fix spelling and frame comment"
                    >
                      {polishingField === 'comments' ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <GeminiSparkleIcon className="w-3 h-3" />
                      )}
                      <span>Gemini Frame</span>
                    </button>
                  )}
                </div>
                <textarea
                  rows={2}
                  value={formData.comments || ''}
                  onChange={(e) => handleFieldChange('comments', e.target.value)}
                  className={`w-full text-xs px-3 py-2 rounded-lg border ${
                    polishedSuccessField === 'comments'
                      ? 'border-emerald-500 ring-2 ring-emerald-100'
                      : 'border-slate-300 focus:border-[#0052CC] focus:ring-2 focus:ring-blue-100'
                  } outline-none transition resize-none`}
                  placeholder="Add any QA or verification notes..."
                />
              </div>

              {/* Modal Edit Action Buttons */}
              <div className="flex items-center justify-end gap-2 pt-2 border-t border-slate-100">
                <button
                  type="button"
                  onClick={handleCancel}
                  className="px-3.5 py-1.5 rounded-lg text-xs font-semibold text-slate-600 hover:bg-slate-100 transition cursor-pointer"
                >
                  Cancel
                </button>
                <button
                  type="button"
                  onClick={handleSave}
                  className="px-4 py-1.5 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-semibold flex items-center gap-1.5 transition shadow-xs cursor-pointer"
                >
                  <Check className="w-3.5 h-3.5" />
                  <span>Save Changes</span>
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
