import React, { useState } from 'react'
import type { NotificationScenario } from '../../types/notification'
import {
  callGeminiApi,
  type GeminiParsedResponse,
} from '../../services/geminiService'
import {
  validateAndSanitizeInsert,
  validateAndSanitizeUpdate,
} from '../../utils/aiValidation'
import {
  X,
  Send,
  Loader2,
  CheckCircle2,
  AlertCircle,
  Database,
  Layers,
  ShieldCheck,
} from 'lucide-react'

interface GeminiAssistantModalProps {
  isOpen: boolean
  onClose: () => void
  scenarios: NotificationScenario[]
  onAddScenarios: (newScenarios: NotificationScenario[]) => void
  onUpdateScenario: (updated: NotificationScenario) => void
}

// Authentic Multi-Color Google "G" Logo
export const GoogleGLogo: React.FC<{ className?: string }> = ({ className = 'w-5 h-5' }) => (
  <svg viewBox="0 0 24 24" className={className} xmlns="http://www.w3.org/2000/svg">
    <path
      fill="#4285F4"
      d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.66-5.17 3.66-9.17z"
    />
    <path
      fill="#34A853"
      d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.25v3.15C3.26 21.36 7.33 24 12 24z"
    />
    <path
      fill="#FBBC05"
      d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.25C.45 8.18 0 9.98 0 12s.45 3.82 1.25 5.42l4.03-3.15z"
    />
    <path
      fill="#EA4335"
      d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.25 6.58l4.03 3.15c.95-2.83 3.6-4.98 6.72-4.98z"
    />
  </svg>
)

// Authentic Google Gemini 4-point star gradient logo
export const GeminiSparkleLogo: React.FC<{ className?: string }> = ({ className = 'w-6 h-6' }) => (
  <svg viewBox="0 0 28 28" fill="none" className={className} xmlns="http://www.w3.org/2000/svg">
    <path
      d="M14 0C14 7.732 7.732 14 0 14C7.732 14 14 20.268 14 28C14 20.268 20.268 14 28 14C20.268 14 14 7.732 14 0Z"
      fill="url(#gemini_sparkle_grad_modal)"
    />
    <defs>
      <linearGradient
        id="gemini_sparkle_grad_modal"
        x1="0"
        y1="0"
        x2="28"
        y2="28"
        gradientUnits="userSpaceOnUse"
      >
        <stop stopColor="#1BA1E3" />
        <stop offset="0.34" stopColor="#5B7BF5" />
        <stop offset="0.68" stopColor="#9B66FF" />
        <stop offset="1" stopColor="#E26BD5" />
      </linearGradient>
    </defs>
  </svg>
)

export const GeminiAssistantModal: React.FC<GeminiAssistantModalProps> = ({
  isOpen,
  onClose,
  scenarios,
  onAddScenarios,
  onUpdateScenario,
}) => {
  const [userPrompt, setUserPrompt] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [errorMsg, setErrorMsg] = useState('')
  const [aiResult, setAiResult] = useState<GeminiParsedResponse | null>(null)
  const [appliedSuccess, setAppliedSuccess] = useState<string | null>(null)

  if (!isOpen) return null

  const handleSendPrompt = async () => {
    if (!userPrompt.trim()) return
    setErrorMsg('')
    setIsLoading(true)
    setAiResult(null)
    setAppliedSuccess(null)

    try {
      const response = await callGeminiApi(userPrompt, scenarios)
      setAiResult(response)
    } catch (err: any) {
      console.error(err)
      setErrorMsg(err.message || 'Error executing Gemini request.')
    } finally {
      setIsLoading(false)
    }
  }

  // Finalize and save changes directly to Cloudflare D1 database with strict validation
  const handleApplyChanges = () => {
    if (!aiResult) return

    if (aiResult.action === 'INSERT' && aiResult.insertedRows && aiResult.insertedRows.length > 0) {
      // Validate and sanitize each inserted row (sequential keys, valid enums, clean text)
      const fullRows: NotificationScenario[] = aiResult.insertedRows.map((r, i) =>
        validateAndSanitizeInsert(r, scenarios, i)
      )

      onAddScenarios(fullRows)
      setAppliedSuccess(`Successfully validated & inserted ${fullRows.length} new scenario(s) into database!`)
      setAiResult(null)
      setUserPrompt('')
    } else if (aiResult.action === 'UPDATE' && aiResult.updatedRows && aiResult.updatedRows.length > 0) {
      let count = 0
      let totalFields = 0

      aiResult.updatedRows.forEach((item) => {
        const target = scenarios.find((s) => s.id === item.id || (item.key && s.key === item.key))
        if (target) {
          // Strict field isolation: only update validated fields, preserve all untouched fields
          const { sanitizedScenario, appliedFieldCount } = validateAndSanitizeUpdate(target, item.changes)
          if (appliedFieldCount > 0) {
            onUpdateScenario(sanitizedScenario)
            count++
            totalFields += appliedFieldCount
          }
        }
      })

      if (count > 0) {
        setAppliedSuccess(
          `Successfully updated ${count} scenario(s) (${totalFields} field(s) changed). All untouched fields preserved 100% intact.`
        )
      } else {
        setErrorMsg('No valid field changes were detected for this scenario. Existing fields remain unchanged.')
      }

      setAiResult(null)
      setUserPrompt('')
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4 bg-black/40 backdrop-blur-xs animate-in fade-in duration-150 select-text"
      onClick={onClose}
    >
      {/* Google Material 3 / Gemini Container */}
      <div
        className="w-full max-w-3xl bg-white rounded-[24px] shadow-2xl border border-[#E0E2EC] flex flex-col max-h-[90dvh] overflow-hidden text-[#1F1F1F] font-sans"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Google Header: Authentic Google Logo & Gemini Gradient Wordmark */}
        <div className="px-6 py-4 border-b border-[#F0F4F9] bg-[#FAFBFC] flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-white border border-[#E0E2EC] flex items-center justify-center shadow-xs">
              <GeminiSparkleLogo className="w-6 h-6" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <div className="flex items-center gap-1.5">
                  <GoogleGLogo className="w-4 h-4" />
                  <span className="text-[17px] font-normal text-[#444746] tracking-tight">Google</span>
                  <span className="text-[17px] font-semibold bg-gradient-to-r from-[#1BA1E3] via-[#5B7BF5] to-[#9B66FF] bg-clip-text text-transparent">
                    Gemini
                  </span>
                </div>
              </div>
              <p className="text-xs text-[#747775] mt-0.5">
                Seedling Notification Scenario Copilot powered by Google AI
              </p>
            </div>
          </div>

          <button
            type="button"
            onClick={onClose}
            className="w-8 h-8 rounded-full hover:bg-[#F0F4F9] text-[#747775] hover:text-[#1F1F1F] flex items-center justify-center transition cursor-pointer"
            title="Close"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Scrollable Body */}
        <div className="flex-1 overflow-y-auto p-5 sm:p-6 space-y-4">
          {errorMsg && (
            <div className="p-3.5 rounded-2xl bg-[#FDE8E8] border border-[#F8B4B4] text-[#9B1C1C] flex items-center gap-2.5 text-xs leading-relaxed">
              <AlertCircle className="w-4 h-4 shrink-0 text-[#E02424]" />
              <span>{errorMsg}</span>
            </div>
          )}

          {appliedSuccess && (
            <div className="p-3.5 rounded-2xl bg-[#DEF7EC] border border-[#BCF0DA] text-[#03543F] flex items-center gap-2.5 text-xs font-medium">
              <CheckCircle2 className="w-4 h-4 shrink-0 text-[#0E9F6E]" />
              <span>{appliedSuccess}</span>
            </div>
          )}

          {/* Google Gemini Prompt Pill Box (like gemini.google.com) */}
          <div className="rounded-[24px] bg-[#F0F4F9] border border-[#E0E2EC] p-3.5 sm:p-4 focus-within:bg-white focus-within:ring-2 focus-within:ring-[#1A73E8] focus-within:border-transparent transition-all shadow-xs space-y-2">
            <textarea
              rows={4}
              value={userPrompt}
              onChange={(e) => setUserPrompt(e.target.value)}
              placeholder="Ask Gemini to add notification scenarios, paste raw spreadsheet text, or update rows (e.g. 'Add 2 new Contribution scenarios for Round-up and Tax Receipts')..."
              className="w-full text-[13px] text-[#1F1F1F] placeholder:text-[#747775] bg-transparent outline-none leading-relaxed resize-y"
            />

            {/* Bottom Bar inside Google Gemini Prompt Box */}
            <div className="flex items-center justify-between pt-1 border-t border-[#E0E2EC]/50">
              <div className="flex items-center gap-1.5 text-xs text-[#747775]">
                <GeminiSparkleLogo className="w-4 h-4" />
                <span className="font-medium text-[11px]">Gemini 3.6 Flash</span>
              </div>

              <button
                type="button"
                disabled={isLoading || !userPrompt.trim()}
                onClick={handleSendPrompt}
                className="w-9 h-9 rounded-full bg-[#1A73E8] hover:bg-[#1557B0] disabled:bg-[#E0E2EC] disabled:text-[#8E918F] text-white flex items-center justify-center transition shadow-xs cursor-pointer disabled:cursor-not-allowed"
                title="Send to Google Gemini"
              >
                {isLoading ? (
                  <Loader2 className="w-4 h-4 animate-spin" />
                ) : (
                  <Send className="w-4 h-4" />
                )}
              </button>
            </div>
          </div>

          {/* Google Suggestion Chips */}
          <div className="flex items-center gap-2 flex-wrap pt-0.5">
            <span className="text-[11px] font-semibold text-[#747775] flex items-center gap-1">
              <GoogleGLogo className="w-3.5 h-3.5" />
              <span>Try:</span>
            </span>
            <button
              type="button"
              onClick={() =>
                setUserPrompt(
                  'Add a new Contribution Engine scenario for "Round-up Spare Change Enabled" with push, email, and CTA to View Settings.'
                )
              }
              className="text-xs px-3 py-1 rounded-full bg-[#F0F4F9] hover:bg-[#E3E8EF] text-[#1F1F1F] border border-[#C4C7C5]/40 transition cursor-pointer flex items-center gap-1.5"
            >
              <GeminiSparkleLogo className="w-3 h-3" />
              <span>+ Add Round-up Scenario</span>
            </button>
            <button
              type="button"
              onClick={() =>
                setUserPrompt(
                  'Update status of CONTRIB-7 to "TESTED" with comment "All navigation flows verified on iOS 18".'
                )
              }
              className="text-xs px-3 py-1 rounded-full bg-[#F0F4F9] hover:bg-[#E3E8EF] text-[#1F1F1F] border border-[#C4C7C5]/40 transition cursor-pointer flex items-center gap-1.5"
            >
              <GeminiSparkleLogo className="w-3 h-3" />
              <span>Update CONTRIB-7 Status</span>
            </button>
            <button
              type="button"
              onClick={() =>
                setUserPrompt(
                  'Summarize all scenarios currently marked as NAVIGATION NOT WORKING.'
                )
              }
              className="text-xs px-3 py-1 rounded-full bg-[#F0F4F9] hover:bg-[#E3E8EF] text-[#1F1F1F] border border-[#C4C7C5]/40 transition cursor-pointer flex items-center gap-1.5"
            >
              <GeminiSparkleLogo className="w-3 h-3" />
              <span>Review Navigation Defects</span>
            </button>
          </div>

          {/* AI Result Section (Google Material Design Card) */}
          {aiResult && (
            <div className="space-y-3 pt-3 border-t border-[#E0E2EC] animate-in fade-in duration-200">
              {/* Google AI Response Header */}
              <div className="p-4 bg-[#F8FAFD] rounded-2xl border border-[#D2E3FC] flex items-start gap-3">
                <div className="w-7 h-7 rounded-full bg-white border border-[#D2E3FC] flex items-center justify-center shrink-0 shadow-2xs mt-0.5">
                  <GeminiSparkleLogo className="w-4 h-4" />
                </div>
                <div className="flex-1 text-xs">
                  <div className="flex items-center gap-2">
                    <span className="font-semibold text-[#1F1F1F]">Gemini</span>
                    <span className="text-[10px] text-[#747775]">Structured Analysis</span>
                  </div>
                  <p className="text-[#3C4043] mt-1 leading-relaxed text-[13px]">{aiResult.summary}</p>
                  {aiResult.answer && (
                    <div className="mt-2.5 p-3 bg-white rounded-xl border border-[#E0E2EC] text-[#1F1F1F] whitespace-pre-wrap leading-relaxed">
                      {aiResult.answer}
                    </div>
                  )}
                </div>
              </div>

              {/* Inserted Rows Preview Table */}
              {aiResult.action === 'INSERT' &&
                aiResult.insertedRows &&
                aiResult.insertedRows.length > 0 && (
                  <div className="border border-[#E0E2EC] rounded-2xl overflow-hidden shadow-xs">
                    <div className="bg-[#F8FAFD] px-4 py-2.5 border-b border-[#E0E2EC] text-xs font-semibold text-[#1F1F1F] flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <Layers className="w-4 h-4 text-[#1A73E8]" />
                        <span>Ready to Insert: {aiResult.insertedRows.length} Row(s)</span>
                        <span className="text-[10px] text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full font-medium border border-emerald-200">
                          ✓ Sequential Keys Assigned
                        </span>
                      </div>
                      <span className="text-[11px] text-[#747775] font-normal">
                        Persists directly to Cloudflare D1
                      </span>
                    </div>

                    <div className="max-h-56 overflow-auto">
                      <table className="w-full text-left text-xs">
                        <thead className="bg-[#F0F4F9] text-[#444746] text-[11px] uppercase tracking-wider sticky top-0 border-b border-[#E0E2EC]">
                          <tr>
                            <th className="px-3 py-2">Key</th>
                            <th className="px-3 py-2">Engine</th>
                            <th className="px-3 py-2">Event</th>
                            <th className="px-3 py-2">Trigger</th>
                            <th className="px-3 py-2">Push Subject</th>
                            <th className="px-3 py-2">Status</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-[#E0E2EC] bg-white">
                          {aiResult.insertedRows.map((row, idx) => {
                            const validated = validateAndSanitizeInsert(row, scenarios, idx)
                            return (
                              <tr key={idx} className="hover:bg-[#F8FAFD]">
                                <td className="px-3 py-2 font-mono font-bold text-[#1A73E8]">
                                  {validated.key}
                                </td>
                                <td className="px-3 py-2">
                                  <span
                                    className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${
                                      validated.engineCategory === 'Governance'
                                        ? 'bg-[#E6F4EA] text-[#137333]'
                                        : 'bg-[#E8F0FE] text-[#1A73E8]'
                                    }`}
                                  >
                                    {validated.engineCategory}
                                  </span>
                                </td>
                                <td className="px-3 py-2 font-medium max-w-[180px] truncate text-[#1F1F1F]">
                                  {validated.governanceEvent}
                                </td>
                                <td className="px-3 py-2 text-[#747775] max-w-[150px] truncate">
                                  {validated.trigger || '-'}
                                </td>
                                <td className="px-3 py-2 max-w-[180px] truncate text-[#1F1F1F]">
                                  {validated.pushSubject || '-'}
                                </td>
                                <td className="px-3 py-2">
                                  <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-[#F1F3F4] text-[#3C4043]">
                                    {validated.status}
                                  </span>
                                </td>
                              </tr>
                            )
                          })}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}

              {/* Updated Rows Preview with Field Isolation Diff */}
              {aiResult.action === 'UPDATE' &&
                aiResult.updatedRows &&
                aiResult.updatedRows.length > 0 && (
                  <div className="border border-[#E0E2EC] rounded-2xl overflow-hidden shadow-xs">
                    <div className="bg-[#F8FAFD] px-4 py-2.5 border-b border-[#E0E2EC] text-xs font-semibold text-[#1F1F1F] flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <ShieldCheck className="w-4 h-4 text-emerald-600" />
                        <span>Ready to Update: {aiResult.updatedRows.length} Scenario(s)</span>
                      </div>
                      <span className="text-[11px] text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full font-medium border border-emerald-200">
                        Strict Field Isolation Active
                      </span>
                    </div>
                    <div className="p-3 space-y-2.5 text-xs bg-white">
                      {aiResult.updatedRows.map((u, i) => {
                        const target = scenarios.find((s) => s.id === u.id || (u.key && s.key === u.key))
                        if (!target) {
                          return (
                            <div key={i} className="p-2.5 bg-rose-50 rounded-xl border border-rose-200 text-rose-700">
                              Row "{u.key || u.id}" not found in database.
                            </div>
                          )
                        }

                        const { diffs } = validateAndSanitizeUpdate(target, u.changes)

                        return (
                          <div
                            key={i}
                            className="p-3 bg-[#F8FAFD] rounded-xl border border-[#E0E2EC] space-y-2"
                          >
                            <div className="flex items-center justify-between border-b border-[#E0E2EC]/60 pb-1.5">
                              <div className="flex items-center gap-2">
                                <span className="font-mono font-bold text-[#1A73E8] bg-blue-50 px-2 py-0.5 rounded border border-blue-200">
                                  {target.key}
                                </span>
                                <span className="font-semibold text-[#1F1F1F] truncate max-w-sm">
                                  {target.governanceEvent}
                                </span>
                              </div>
                              <span className="text-[11px] text-emerald-700 font-medium bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">
                                {diffs.length} field(s) modified &bull; {16 - diffs.length} preserved
                              </span>
                            </div>

                            {/* Diff List */}
                            <div className="space-y-1.5 pt-0.5">
                              {diffs.length === 0 ? (
                                <p className="text-slate-400 italic text-[11px]">
                                  No fields changed. Existing data is 100% identical.
                                </p>
                              ) : (
                                diffs.map((d, dIdx) => (
                                  <div key={dIdx} className="flex items-center gap-2 text-xs flex-wrap">
                                    <span className="font-mono text-[11px] font-semibold text-slate-500 uppercase bg-slate-100 px-1.5 py-0.5 rounded">
                                      {d.field}:
                                    </span>
                                    <span className="line-through text-slate-400 bg-slate-50 px-1 rounded">
                                      {d.oldVal || <span className="italic">Empty</span>}
                                    </span>
                                    <span className="text-slate-400 font-bold">&rarr;</span>
                                    <span className="font-semibold text-emerald-700 bg-emerald-50 px-1.5 py-0.5 rounded border border-emerald-200">
                                      {d.newVal}
                                    </span>
                                  </div>
                                ))
                              )}
                            </div>
                          </div>
                        )
                      })}
                    </div>
                  </div>
                )}
            </div>
          )}
        </div>

        {/* Google Style Footer */}
        <div className="px-6 py-3.5 border-t border-[#E0E2EC] bg-[#FAFBFC] flex items-center justify-between gap-3">
          <div className="text-xs text-[#747775] flex items-center gap-1.5">
            <GoogleGLogo className="w-3.5 h-3.5" />
            <span className="text-[11px]">Powered by Google Gemini 3.6 & Cloudflare D1</span>
          </div>

          <div className="flex items-center gap-2.5">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 rounded-full text-xs font-semibold text-[#444746] hover:bg-[#F0F4F9] cursor-pointer transition"
            >
              Cancel
            </button>

            {aiResult && (aiResult.action === 'INSERT' || aiResult.action === 'UPDATE') ? (
              <button
                type="button"
                onClick={handleApplyChanges}
                className="px-5 py-2 rounded-full text-xs font-semibold bg-[#1A73E8] hover:bg-[#1557B0] text-white cursor-pointer transition shadow-xs flex items-center gap-1.5"
              >
                <Database className="w-3.5 h-3.5" />
                <span>Apply to Database (D1)</span>
              </button>
            ) : (
              <button
                type="button"
                disabled={isLoading || !userPrompt.trim()}
                onClick={handleSendPrompt}
                className="px-5 py-2 rounded-full text-xs font-semibold bg-[#1A73E8] hover:bg-[#1557B0] disabled:bg-[#E0E2EC] disabled:text-[#8E918F] text-white cursor-pointer transition shadow-xs flex items-center gap-1.5 disabled:cursor-not-allowed"
              >
                {isLoading ? (
                  <>
                    <Loader2 className="w-3.5 h-3.5 animate-spin" />
                    <span>Thinking with Gemini...</span>
                  </>
                ) : (
                  <>
                    <Send className="w-3.5 h-3.5" />
                    <span>Generate with Gemini</span>
                  </>
                )}
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
