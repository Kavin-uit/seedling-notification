import React, { useState, useEffect, useMemo, useRef } from 'react'
import type { NotificationScenario, ScenarioStatus, PriorityLevel, Environment } from '../../types/notification'
import {
  X,
  Plus,
  Bell,
  Mail,
  Smartphone,
  ChevronDown,
  Sparkles,
  Info,
  Check,
  FileText,
  Target,
} from 'lucide-react'

interface JiraCreateModalProps {
  isOpen: boolean
  onClose: () => void
  availableEngines: string[]
  currentEngine?: string
  scenarios: NotificationScenario[]
  onCreateScenario: (scenario: NotificationScenario) => void
}

function getEnginePrefix(engineCategory: string): string {
  const norm = (engineCategory || '').trim().toLowerCase()
  if (norm === 'governance') return 'GOV'
  if (norm === 'contribution') return 'CONTRIB'
  if (norm === 'participation') return 'PART'
  if (norm === 'identity') return 'ID'
  if (norm === 'opportunity') return 'OPP'
  if (norm === 'discovery') return 'DISC'
  if (norm === 'campaign') return 'CAMP'
  if (norm === 'narrative') return 'NARR'
  const clean = engineCategory.toUpperCase().replace(/[^A-Z0-9]/g, '')
  return clean.length > 5 ? clean.slice(0, 5) : clean || 'SCEN'
}

function computeNextKey(engineCategory: string, scenarios: NotificationScenario[]) {
  const prefix = getEnginePrefix(engineCategory)
  const existingNums = scenarios
    .filter((s) => (s.engineCategory || '').toLowerCase() === engineCategory.toLowerCase())
    .map((s) => {
      const match = s.key.match(new RegExp(`${prefix}-(\\d+)`, 'i'))
      return match ? parseInt(match[1], 10) : 0
    })
  const maxNum = existingNums.length > 0 ? Math.max(...existingNums) : 0
  const nextNum = maxNum + 1
  const existingIds = new Set(scenarios.map((s) => (s.id || '').toLowerCase()))
  let id = `${prefix.toLowerCase()}-${nextNum}`
  if (existingIds.has(id.toLowerCase())) {
    id = `${prefix.toLowerCase()}-${nextNum}-${Date.now().toString().slice(-4)}`
  }
  return {
    prefix,
    nextNum,
    key: `${prefix}-${nextNum}`,
    id,
  }
}

const ALL_STATUS_OPTIONS: ScenarioStatus[] = [
  'TO DO',
  'IN PROGRESS',
  'TESTED',
  'NOT WORKING',
  'IN-APP NAVIGATION NOT WORKING',
  'NAVIGATION NOT WORKING',
  'PUSH NOTIFICATION NOT WORKING',
  'PUSH NOTIFICATION NAVIGATION NOT WORKING',
  'EMAIL NOTIFICATION NOT WORKING',
  'EMAIL NOTIFICATION NAVIGATION NOT WORKING',
  'SMS NOTIFICATION NOT WORKING',
]

const ALL_PRIORITIES: PriorityLevel[] = ['Highest', 'High', 'Medium', 'Low', 'Lowest']

export const JiraCreateModal: React.FC<JiraCreateModalProps> = ({
  isOpen,
  onClose,
  availableEngines,
  currentEngine = 'Campaign',
  scenarios,
  onCreateScenario,
}) => {
  // Ensure default engine matches current filter or first available engine
  const initialEngine = useMemo(() => {
    if (currentEngine && currentEngine !== 'ALL' && availableEngines.includes(currentEngine)) {
      return currentEngine
    }
    if (availableEngines.includes('Campaign')) return 'Campaign'
    if (availableEngines.includes('Governance')) return 'Governance'
    return availableEngines[0] || 'Governance'
  }, [currentEngine, availableEngines])

  const [selectedEngine, setSelectedEngine] = useState<string>(initialEngine)
  const [governanceEvent, setGovernanceEvent] = useState('')
  const [trigger, setTrigger] = useState('')
  const [audience, setAudience] = useState('')
  const [communicationObjective, setCommunicationObjective] = useState('')
  const [desiredOutcome, setDesiredOutcome] = useState('')
  const [cta, setCta] = useState('')
  const [priority, setPriority] = useState<PriorityLevel>('Medium')
  const [status, setStatus] = useState<ScenarioStatus>('TO DO')
  const [environment, setEnvironment] = useState<Environment>('STAGING')
  const [ruleId, setRuleId] = useState('')
  const [pushSubject, setPushSubject] = useState('')
  const [pushBody, setPushBody] = useState('')
  const [emailSubject, setEmailSubject] = useState('')
  const [emailBody, setEmailBody] = useState('')
  const [inAppExperience, setInAppExperience] = useState('')
  const [comments, setComments] = useState('')
  const [createAnother, setCreateAnother] = useState(false)
  const [errorMessage, setErrorMessage] = useState('')

  const eventInputRef = useRef<HTMLInputElement>(null)

  // Reset form when modal opens
  useEffect(() => {
    if (isOpen) {
      setSelectedEngine(initialEngine)
      setGovernanceEvent('')
      setTrigger('')
      setAudience(initialEngine === 'Contribution' ? 'Donor' : initialEngine === 'Campaign' ? 'Followers' : 'Community Member')
      setCommunicationObjective('')
      setDesiredOutcome('')
      setCta('')
      setPriority('Medium')
      setStatus('TO DO')
      setEnvironment('STAGING')
      setRuleId('')
      setPushSubject('')
      setPushBody('')
      setEmailSubject('')
      setEmailBody('')
      setInAppExperience('')
      setComments('')
      setErrorMessage('')
      setTimeout(() => eventInputRef.current?.focus(), 80)
    }
  }, [isOpen, initialEngine])

  // Handle engine change in dropdown
  const handleEngineChange = (newEngine: string) => {
    setSelectedEngine(newEngine)
    // Adjust default audience if not customized
    if (!audience || audience === 'Donor' || audience === 'Followers' || audience === 'Community Member') {
      if (newEngine === 'Contribution') setAudience('Donor')
      else if (newEngine === 'Campaign') setAudience('Followers')
      else setAudience('Community Member')
    }
  }

  // Prevent background scrolling
  useEffect(() => {
    if (!isOpen) return
    const origOverflow = document.body.style.overflow
    document.body.style.overflow = 'hidden'
    return () => {
      document.body.style.overflow = origOverflow
    }
  }, [isOpen])

  // Compute live key preview
  const keyInfo = useMemo(() => {
    return computeNextKey(selectedEngine, scenarios)
  }, [selectedEngine, scenarios])

  // Keyboard shortcut: Cmd/Ctrl+Enter to submit, Escape to close
  useEffect(() => {
    if (!isOpen) return
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose()
      } else if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
        e.preventDefault()
        handleSubmit()
      }
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  })

  if (!isOpen) return null

  const handleSubmit = (e?: React.FormEvent) => {
    if (e) e.preventDefault()
    setErrorMessage('')

    const cleanEvent = governanceEvent.trim()
    if (!cleanEvent) {
      setErrorMessage('Notification Event / Summary is required.')
      eventInputRef.current?.focus()
      return
    }

    const { key, id } = computeNextKey(selectedEngine, scenarios)
    const nowIso = new Date().toISOString()

    const newScenario: NotificationScenario = {
      id,
      key,
      engineCategory: selectedEngine,
      governanceEvent: cleanEvent,
      trigger: trigger.trim(),
      audience: audience.trim() || 'User',
      communicationObjective: communicationObjective.trim(),
      desiredOutcome: desiredOutcome.trim(),
      pushSubject: pushSubject.trim(),
      pushBody: pushBody.trim(),
      emailSubject: emailSubject.trim(),
      emailBody: emailBody.trim(),
      inAppExperience: inAppExperience.trim(),
      cta: cta.trim(),
      comments: comments.trim(),
      status,
      priority,
      environment,
      ruleId: ruleId.trim() || undefined,
      createdAt: nowIso,
      updatedAt: nowIso,
      assignee: {
        name: 'QA Tester',
        email: 'tester@seedling.org',
        avatar: '',
      },
      versionHistory: [],
      fieldHistory: {},
    }

    onCreateScenario(newScenario)

    if (createAnother) {
      // Reset only content fields, keep engine and audience
      setGovernanceEvent('')
      setTrigger('')
      setCommunicationObjective('')
      setDesiredOutcome('')
      setCta('')
      setPushSubject('')
      setPushBody('')
      setEmailSubject('')
      setEmailBody('')
      setInAppExperience('')
      setComments('')
      setRuleId('')
      setErrorMessage('')
      eventInputRef.current?.focus()
    } else {
      onClose()
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4 bg-slate-900/50 backdrop-blur-xs animate-in fade-in duration-150"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-xl shadow-[0_20px_60px_-15px_rgba(9,30,66,0.3),0_0_1px_rgba(9,30,66,0.31)] border border-[#DFE1E6] w-full max-w-[940px] max-h-[92vh] flex flex-col overflow-hidden text-[#172B4D] select-none"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Modal Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-[#EBECF0] bg-slate-50/70 shrink-0">
          <div className="flex items-center gap-2.5">
            <div className="w-8 h-8 rounded bg-[#0052CC] text-white flex items-center justify-center shadow-xs">
              <Plus className="w-4 h-4 stroke-[3]" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h2 className="text-base font-bold text-[#172B4D]">Create Notification Scenario</h2>
                <span className="text-[11px] font-mono font-semibold px-2 py-0.5 rounded bg-blue-50 text-[#0052CC] border border-blue-200">
                  {keyInfo.key}
                </span>
              </div>
              <p className="text-xs text-[#5E6C84]">
                Select the target engine below. The new notification data will be automatically added to that engine.
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="p-1.5 text-slate-400 hover:text-slate-700 hover:bg-slate-200/60 rounded-md transition cursor-pointer"
            title="Close (Esc)"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Modal Body Form with all Jira field values displayed */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto px-6 py-5 space-y-6">
          {errorMessage && (
            <div className="p-3 bg-red-50 border border-red-200 rounded-md text-red-700 text-xs flex items-center gap-2">
              <Info className="w-4 h-4 shrink-0 text-red-600" />
              <span>{errorMessage}</span>
            </div>
          )}

          {/* 1. Target Engine Selector Dropdown & Live Issue Key Preview */}
          <div className="bg-[#F4F5F7] border border-[#DFE1E6] rounded-lg p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="flex-1">
              <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1.5">
                Target Engine <span className="text-red-500">*</span>
              </label>
              <div className="relative">
                <select
                  value={selectedEngine}
                  onChange={(e) => handleEngineChange(e.target.value)}
                  className="w-full h-10 pl-3.5 pr-9 rounded border border-[#DFE1E6] bg-white text-xs font-semibold text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none cursor-pointer appearance-none shadow-2xs"
                >
                  {availableEngines.map((eng) => (
                    <option key={eng} value={eng}>
                      {eng} Engine
                    </option>
                  ))}
                </select>
                <ChevronDown className="w-4 h-4 text-slate-500 absolute right-3 top-3 pointer-events-none" />
              </div>
              <p className="text-[11px] text-[#6B778C] mt-1">
                Data will be placed into <span className="font-semibold text-[#0052CC]">{selectedEngine}</span> engine sheet
              </p>
            </div>

            <div className="flex items-center gap-4 shrink-0 pt-1 sm:pt-4">
              <div className="text-right">
                <span className="text-[10px] uppercase font-bold text-[#6B778C] block">Generated Key</span>
                <span className="text-base font-mono font-bold text-[#0052CC]">{keyInfo.key}</span>
              </div>
              <div className="w-px h-10 bg-slate-300 hidden sm:block" />
              <div className="text-xs text-slate-600 max-w-[210px] leading-tight">
                Prefix: <span className="font-mono font-bold text-slate-800">{keyInfo.prefix}</span> (#{keyInfo.nextNum})
              </div>
            </div>
          </div>

          {/* 2. General Scenario Information */}
          <div className="space-y-3.5">
            <div className="flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#42526E] pb-1 border-b border-[#EBECF0]">
              <FileText className="w-3.5 h-3.5 text-[#0052CC]" />
              <span>General Scenario Information</span>
            </div>

            {/* Event Name / Summary */}
            <div>
              <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                Notification Event Name (Summary) <span className="text-red-500">*</span>
              </label>
              <input
                ref={eventInputRef}
                type="text"
                value={governanceEvent}
                onChange={(e) => setGovernanceEvent(e.target.value)}
                placeholder="e.g. Campaign Goal 100% Reached, Donation Receipt Available"
                className="w-full h-9.5 px-3 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none placeholder:text-slate-400 font-medium"
                required
              />
            </div>

            {/* 3-Column: Trigger, Audience, CTA */}
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Trigger
                </label>
                <input
                  type="text"
                  value={trigger}
                  onChange={(e) => setTrigger(e.target.value)}
                  placeholder="e.g. Campaign goes live, Settlement complete"
                  className="w-full h-8.5 px-3 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none placeholder:text-slate-400"
                />
              </div>
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Audience
                </label>
                <input
                  type="text"
                  value={audience}
                  onChange={(e) => setAudience(e.target.value)}
                  placeholder="e.g. Followers, Supporters, Donor"
                  className="w-full h-8.5 px-3 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none placeholder:text-slate-400"
                />
              </div>
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Call to Action (CTA)
                </label>
                <input
                  type="text"
                  value={cta}
                  onChange={(e) => setCta(e.target.value)}
                  placeholder="e.g. take user to campaign for seedling"
                  className="w-full h-8.5 px-3 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none placeholder:text-slate-400"
                />
              </div>
            </div>

            {/* 4-Column: Priority, Status, Environment, Rule ID */}
            <div className="grid grid-cols-1 sm:grid-cols-4 gap-3">
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Priority
                </label>
                <select
                  value={priority}
                  onChange={(e) => setPriority(e.target.value as PriorityLevel)}
                  className="w-full h-8.5 px-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none cursor-pointer"
                >
                  {ALL_PRIORITIES.map((p) => (
                    <option key={p} value={p}>
                      {p}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Status
                </label>
                <select
                  value={status}
                  onChange={(e) => setStatus(e.target.value as ScenarioStatus)}
                  className="w-full h-8.5 px-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none cursor-pointer"
                >
                  {ALL_STATUS_OPTIONS.map((st) => (
                    <option key={st} value={st}>
                      {st}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Environment
                </label>
                <select
                  value={environment}
                  onChange={(e) => setEnvironment(e.target.value as Environment)}
                  className="w-full h-8.5 px-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] focus:ring-2 focus:ring-[#0052CC]/20 outline-none cursor-pointer"
                >
                  <option value="STAGING">STAGING</option>
                  <option value="PROD">PRODUCTION</option>
                  <option value="DEV">DEV</option>
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Rule ID (Optional)
                </label>
                <input
                  type="text"
                  value={ruleId}
                  onChange={(e) => setRuleId(e.target.value)}
                  placeholder={`e.g. CI-${getEnginePrefix(selectedEngine)}-001`}
                  className="w-full h-8.5 px-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none font-mono placeholder:font-sans placeholder:text-slate-400"
                />
              </div>
            </div>
          </div>

          {/* 3. Multi-Channel Notification Content (Push, Email, In-App) */}
          <div className="space-y-3.5">
            <div className="flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#42526E] pb-1 border-b border-[#EBECF0]">
              <Sparkles className="w-3.5 h-3.5 text-[#0052CC]" />
              <span>Notification Channels & Content</span>
            </div>

            {/* Push Notification */}
            <div className="border border-[#DFE1E6] rounded-lg p-3.5 bg-slate-50/60 space-y-2.5">
              <div className="flex items-center gap-1.5 text-xs font-bold text-[#172B4D]">
                <Bell className="w-3.5 h-3.5 text-[#0052CC]" />
                <span>Push Notification</span>
              </div>
              <div>
                <label className="block text-[11px] font-semibold text-[#5E6C84] mb-0.5">Subject Line</label>
                <input
                  type="text"
                  value={pushSubject}
                  onChange={(e) => setPushSubject(e.target.value)}
                  placeholder="e.g. (Campaign) is live! 🌱"
                  className="w-full h-8 px-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none"
                />
              </div>
              <div>
                <label className="block text-[11px] font-semibold text-[#5E6C84] mb-0.5">Notification Body</label>
                <textarea
                  rows={2}
                  value={pushBody}
                  onChange={(e) => setPushBody(e.target.value)}
                  placeholder="e.g. (Campaign) just launched. See how Seedlings totals are added up to the Campaign goal."
                  className="w-full p-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none resize-y"
                />
              </div>
            </div>

            {/* Email Notification */}
            <div className="border border-[#DFE1E6] rounded-lg p-3.5 bg-slate-50/60 space-y-2.5">
              <div className="flex items-center gap-1.5 text-xs font-bold text-[#172B4D]">
                <Mail className="w-3.5 h-3.5 text-emerald-600" />
                <span>Email Notification</span>
              </div>
              <div>
                <label className="block text-[11px] font-semibold text-[#5E6C84] mb-0.5">Email Subject</label>
                <input
                  type="text"
                  value={emailSubject}
                  onChange={(e) => setEmailSubject(e.target.value)}
                  placeholder="e.g. (Campaign) Is Live! 🌱"
                  className="w-full h-8 px-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none"
                />
              </div>
              <div>
                <div className="flex items-center justify-between mb-0.5">
                  <label className="text-[11px] font-semibold text-[#5E6C84]">Email Message Body</label>
                  <span className="text-[10px] text-slate-400">Use "BOX: Button Name" for CTA button</span>
                </div>
                <textarea
                  rows={2}
                  value={emailBody}
                  onChange={(e) => setEmailBody(e.target.value)}
                  placeholder="e.g. (Campaign) is officially live. Every Seedling adds to a shared goal.  BOX: View Campaign"
                  className="w-full p-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none resize-y"
                />
              </div>
            </div>

            {/* In-App Experience */}
            <div className="border border-[#DFE1E6] rounded-lg p-3.5 bg-slate-50/60 space-y-2.5">
              <div className="flex items-center gap-1.5 text-xs font-bold text-[#172B4D]">
                <Smartphone className="w-3.5 h-3.5 text-purple-600" />
                <span>In-App Experience</span>
              </div>
              <div>
                <label className="block text-[11px] font-semibold text-[#5E6C84] mb-0.5">In-App Banner / Dialog Copy</label>
                <textarea
                  rows={2}
                  value={inAppExperience}
                  onChange={(e) => setInAppExperience(e.target.value)}
                  placeholder="e.g. (Campaign) is live. Every Seedling adds to a shared goal -- see the full picture.  BOX: View Campaign"
                  className="w-full p-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none resize-y"
                />
              </div>
            </div>
          </div>

          {/* 4. Strategy, Objectives & QA Notes */}
          <div className="space-y-3.5">
            <div className="flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-[#42526E] pb-1 border-b border-[#EBECF0]">
              <Target className="w-3.5 h-3.5 text-[#0052CC]" />
              <span>Communication Strategy & QA Notes</span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Communication Objective
                </label>
                <textarea
                  rows={2}
                  value={communicationObjective}
                  onChange={(e) => setCommunicationObjective(e.target.value)}
                  placeholder="Explain why this notification should be sent and what it communicates"
                  className="w-full p-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none resize-y"
                />
              </div>

              <div>
                <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                  Desired Outcome
                </label>
                <textarea
                  rows={2}
                  value={desiredOutcome}
                  onChange={(e) => setDesiredOutcome(e.target.value)}
                  placeholder="What action or emotion should the recipient experience?"
                  className="w-full p-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none resize-y"
                />
              </div>
            </div>

            <div>
              <label className="block text-[11px] font-bold uppercase tracking-wider text-[#5E6C84] mb-1">
                Comments / QA Defect Notes
              </label>
              <textarea
                rows={2}
                value={comments}
                onChange={(e) => setComments(e.target.value)}
                placeholder="Optional QA defect observations or test execution notes"
                className="w-full p-2.5 rounded border border-[#DFE1E6] bg-white text-xs text-[#172B4D] focus:border-[#0052CC] outline-none resize-y"
              />
            </div>
          </div>
        </form>

        {/* Modal Footer */}
        <div className="flex items-center justify-between px-6 py-3.5 border-t border-[#EBECF0] bg-slate-50 shrink-0">
          <label className="flex items-center gap-2 cursor-pointer select-none text-xs text-[#5E6C84] hover:text-[#172B4D]">
            <input
              type="checkbox"
              checked={createAnother}
              onChange={(e) => setCreateAnother(e.target.checked)}
              className="rounded border-[#DFE1E6] text-[#0052CC] focus:ring-[#0052CC] cursor-pointer"
            />
            <span>Create another</span>
          </label>

          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={onClose}
              className="px-3.5 h-8.5 rounded text-xs font-semibold text-[#42526E] hover:bg-[#EBECF0] transition cursor-pointer"
            >
              Cancel
            </button>
            <button
              type="button"
              onClick={() => handleSubmit()}
              className="px-4 h-8.5 rounded bg-[#0052CC] hover:bg-[#0065FF] active:bg-[#0747A6] text-white text-xs font-semibold flex items-center gap-1.5 transition shadow-xs cursor-pointer"
            >
              <Check className="w-3.5 h-3.5 stroke-[2.5]" />
              <span>Create Scenario</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
