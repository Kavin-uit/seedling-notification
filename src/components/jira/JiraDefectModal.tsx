import React, { useState, useEffect } from 'react'
import type { NotificationScenario } from '../../types/notification'
import { X, Check, Copy } from 'lucide-react'

export type DefectFailureType = 'PUSH' | 'NAVIGATION' | 'EMAIL' | 'SMS' | 'GENERAL'

interface JiraDefectModalProps {
  scenario: NotificationScenario | null
  isOpen: boolean
  onClose: () => void
  onMarkNotWorking?: (id: string) => void
}

interface DefectContent {
  title: string
  description: string
  steps: string
  expected: string
  actual: string
}

function getInitialFailureType(status: string): DefectFailureType {
  if (status === 'NAVIGATION NOT WORKING') return 'NAVIGATION'
  if (status === 'EMAIL NOTIFICATION NOT WORKING') return 'EMAIL'
  if (status === 'SMS NOTIFICATION NOT WORKING') return 'SMS'
  if (status === 'PUSH NOTIFICATION NOT WORKING') return 'PUSH'
  return 'PUSH'
}

function buildDefectData(scenario: NotificationScenario, type: DefectFailureType): DefectContent {
  const cleanSubject = scenario.pushSubject
    ? scenario.pushSubject.replace(/[💚🚀📦🗳️👥]/g, '').trim()
    : scenario.governanceEvent

  if (type === 'NAVIGATION') {
    return {
      title: `[Navigation] CTA "${scenario.cta || 'View Details'}" fails to navigate after ${scenario.trigger}`,
      description: `Event: ${scenario.governanceEvent}
Trigger: ${scenario.trigger}
Audience: ${scenario.audience}
Engine: ${scenario.engineCategory}

Issue Summary:
When the ${scenario.audience} receives the "${cleanSubject}" notification and taps "${scenario.cta || 'View Details'}", the application does not navigate to the target screen (${scenario.inAppExperience || 'intended view'}).

Navigation Parameters:
• CTA Label: ${scenario.cta || 'N/A'}
• Target Destination: ${scenario.inAppExperience || 'N/A'}
• Push Subject: ${scenario.pushSubject || 'N/A'}
• Expected Outcome: ${scenario.desiredOutcome || 'N/A'}

Observed Behavior:
Tapping the notification or CTA either opens the generic home screen or fails to resolve the deep link route.`,
      steps: `1. Log in as ${scenario.audience}.
2. Complete "${scenario.trigger}" in the ${scenario.engineCategory} flow.
3. Tap on the notification or in-app alert for "${cleanSubject}".
4. Click the CTA button: "${scenario.cta || 'View Details'}".`,
      expected: `App navigates directly to "${scenario.inAppExperience || scenario.cta}" with correct context loaded for ${scenario.audience}.`,
      actual: `Navigation fails. App stays on current screen or opens generic landing page without deep link payload.`,
    }
  }

  if (type === 'EMAIL') {
    return {
      title: `[Email] Email "${scenario.emailSubject || scenario.governanceEvent}" not delivered for ${scenario.trigger}`,
      description: `Event: ${scenario.governanceEvent}
Trigger: ${scenario.trigger}
Audience: ${scenario.audience}
Engine: ${scenario.engineCategory}

Issue Summary:
Transactional email was not received by ${scenario.audience} after "${scenario.trigger}".

Email Specification:
• Subject Line: ${scenario.emailSubject || 'N/A'}
• Email Body Template: ${scenario.emailBody || 'N/A'}
• CTA: ${scenario.cta || 'N/A'}
• Objective: ${scenario.communicationObjective || 'N/A'}`,
      steps: `1. Log in as ${scenario.audience} with a verified email.
2. Complete action: "${scenario.trigger}".
3. Confirm transaction completes successfully on screen.
4. Check recipient inbox, promotions, and spam folders.`,
      expected: `Email delivered promptly with subject "${scenario.emailSubject || scenario.governanceEvent}" and functional CTA link "${scenario.cta || 'View Details'}".`,
      actual: `No email received. Mail server logs show dispatch failure or missing email template.`,
    }
  }

  if (type === 'SMS') {
    return {
      title: `[SMS] SMS alert not received for ${scenario.trigger}`,
      description: `Event: ${scenario.governanceEvent}
Trigger: ${scenario.trigger}
Audience: ${scenario.audience}
Engine: ${scenario.engineCategory}

Issue Summary:
SMS alert failed to deliver to ${scenario.audience} phone number upon "${scenario.trigger}".

Specification:
• Event: ${scenario.governanceEvent}
• Notification Subject: ${scenario.pushSubject || 'N/A'}
• CTA: ${scenario.cta || 'N/A'}`,
      steps: `1. Use a user account with verified phone number and role: ${scenario.audience}.
2. Trigger: "${scenario.trigger}".
3. Monitor SMS inbox on test device.`,
      expected: `SMS alert received within 15 seconds containing notification text and CTA link.`,
      actual: `No SMS delivered. SMS gateway provider returned error or webhook did not trigger.`,
    }
  }

  if (type === 'GENERAL') {
    return {
      title: `[Notification Failure] Notification not working for "${scenario.governanceEvent}" (${scenario.trigger})`,
      description: `Event: ${scenario.governanceEvent}
Trigger: ${scenario.trigger}
Audience: ${scenario.audience}
Engine: ${scenario.engineCategory}

Issue Summary:
Notification workflow failed for ${scenario.audience} when "${scenario.trigger}" was triggered. No alert was delivered across configured channels.

Configured Data:
• Push Subject: ${scenario.pushSubject || 'N/A'}
• Push Body: ${scenario.pushBody || 'N/A'}
• Email Subject: ${scenario.emailSubject || 'N/A'}
• CTA: ${scenario.cta || 'N/A'}
• Objective: ${scenario.communicationObjective || 'N/A'}`,
      steps: `1. Log in as ${scenario.audience}.
2. Trigger action: "${scenario.trigger}" under ${scenario.governanceEvent}.
3. Verify notification center, push tray, and email inbox.`,
      expected: `Notification arrives across active channels with correct subject and working CTA "${scenario.cta || 'View'}".`,
      actual: `Notification fails to trigger or display. Pipeline did not enqueue or dispatch alert.`,
    }
  }

  // Default: PUSH
  return {
    title: `[Push] "${cleanSubject}" push notification not received after ${scenario.trigger}`,
    description: `Event: ${scenario.governanceEvent}
Trigger: ${scenario.trigger}
Audience: ${scenario.audience}
Engine: ${scenario.engineCategory}

Issue Summary:
When ${scenario.audience} completes "${scenario.trigger}", the mobile push notification is not delivered to the user device.

Push Specifications:
• Subject: ${scenario.pushSubject || 'N/A'}
• Body: ${scenario.pushBody || 'N/A'}
• CTA: ${scenario.cta || 'N/A'}
• In-App Target: ${scenario.inAppExperience || 'N/A'}
• Objective: ${scenario.communicationObjective || 'N/A'}`,
    steps: `1. Open native app and log in as ${scenario.audience}.
2. Complete the action: "${scenario.trigger}" (${scenario.governanceEvent}).
3. Put the application in background or lock device screen.
4. Check for incoming push banner and notification tray.`,
    expected: `Push banner arrives with title "${scenario.pushSubject || scenario.governanceEvent}" and body "${scenario.pushBody || 'N/A'}".`,
    actual: `No push alert received on device. APNS / FCM dispatch log indicates notification was not sent.`,
  }
}

export const JiraDefectModal: React.FC<JiraDefectModalProps> = ({
  scenario,
  isOpen,
  onClose,
  onMarkNotWorking,
}) => {
  if (!isOpen || !scenario) return null

  const [failureType, setFailureType] = useState<DefectFailureType>(() =>
    getInitialFailureType(scenario.status)
  )
  const [viewMode, setViewMode] = useState<'form' | 'preview'>('form')

  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [steps, setSteps] = useState('')
  const [expected, setExpected] = useState('')
  const [actual, setActual] = useState('')
  const [copied, setCopied] = useState(false)

  // Initialize or recompute when scenario or failureType changes
  useEffect(() => {
    const initial = getInitialFailureType(scenario.status)
    setFailureType(initial)
    const data = buildDefectData(scenario, initial)
    setTitle(data.title)
    setDescription(data.description)
    setSteps(data.steps)
    setExpected(data.expected)
    setActual(data.actual)
  }, [scenario.id, scenario.status])

  const handleFailureTypeChange = (newType: DefectFailureType) => {
    setFailureType(newType)
    const data = buildDefectData(scenario, newType)
    setTitle(data.title)
    setDescription(data.description)
    setSteps(data.steps)
    setExpected(data.expected)
    setActual(data.actual)
  }

  const getFullJiraMarkdown = () => {
    return `h2. ${title}

*Key Details*
* Engine: ${scenario.engineCategory}
* Audience: ${scenario.audience}
* Event: ${scenario.governanceEvent}
* Trigger: ${scenario.trigger}

h3. Description
${description}

h3. Steps to Reproduce
${steps}

h3. Expected Result
${expected}

h3. Actual Result
${actual}
`
  }

  const handleCopy = () => {
    navigator.clipboard.writeText(getFullJiraMarkdown()).then(() => {
      setCopied(true)
      setTimeout(() => setCopied(false), 2200)
    })
  }

  const failureOptions: { key: DefectFailureType; label: string }[] = [
    { key: 'PUSH', label: 'Push Notification' },
    { key: 'NAVIGATION', label: 'Navigation / CTA' },
    { key: 'EMAIL', label: 'Email' },
    { key: 'SMS', label: 'SMS' },
    { key: 'GENERAL', label: 'General Failure' },
  ]

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50"
      onClick={onClose}
    >
      <div
        className="w-full max-w-2xl bg-white rounded-md border border-slate-300 shadow-xl flex flex-col max-h-[92dvh] overflow-hidden text-slate-800 font-sans"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Simple Header */}
        <div className="px-4 sm:px-5 py-3 border-b border-slate-200 flex items-center justify-between bg-slate-50">
          <div>
            <div className="flex items-center gap-2">
              <span className="font-mono text-xs font-semibold text-slate-500">{scenario.key}</span>
              <span className="text-slate-300">&bull;</span>
              <h2 className="text-sm font-semibold text-slate-900">Create Jira Defect</h2>
            </div>
            <p className="text-xs text-slate-500 mt-0.5 truncate max-w-md">
              {scenario.engineCategory} Engine &bull; {scenario.audience} &bull; {scenario.governanceEvent}
            </p>
          </div>

          <button
            type="button"
            onClick={onClose}
            className="p-1 rounded text-slate-400 hover:text-slate-700 hover:bg-slate-200 transition cursor-pointer"
            title="Close"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Failure Type Selector & View Toggle */}
        <div className="px-4 sm:px-5 py-2 bg-white border-b border-slate-200 flex items-center justify-between gap-2 sm:gap-3 flex-wrap text-xs">
          <div className="flex items-center gap-1.5 flex-wrap">
            <span className="text-slate-500 font-medium mr-1 text-xs">Issue:</span>
            {failureOptions.map((opt) => {
              const active = failureType === opt.key
              return (
                <button
                  key={opt.key}
                  type="button"
                  onClick={() => handleFailureTypeChange(opt.key)}
                  className={`px-2 py-0.5 sm:px-2.5 sm:py-1 rounded text-[11px] sm:text-xs transition cursor-pointer border ${
                    active
                      ? 'bg-slate-800 text-white font-medium border-slate-800'
                      : 'bg-white text-slate-600 hover:bg-slate-100 border-slate-300'
                  }`}
                >
                  {opt.label}
                </button>
              )
            })}
          </div>

          <div className="flex items-center rounded border border-slate-300 overflow-hidden text-[11px]">
            <button
              type="button"
              onClick={() => setViewMode('form')}
              className={`px-2.5 py-0.5 font-medium cursor-pointer ${
                viewMode === 'form' ? 'bg-slate-200 text-slate-900' : 'bg-white text-slate-600 hover:bg-slate-50'
              }`}
            >
              Form
            </button>
            <button
              type="button"
              onClick={() => setViewMode('preview')}
              className={`px-2.5 py-0.5 font-medium cursor-pointer border-l border-slate-300 ${
                viewMode === 'preview' ? 'bg-slate-200 text-slate-900' : 'bg-white text-slate-600 hover:bg-slate-50'
              }`}
            >
              Jira Text
            </button>
          </div>
        </div>

        {/* Body Content */}
        <div className="flex-1 overflow-y-auto p-4 sm:p-5 space-y-3 sm:space-y-3.5">
          {viewMode === 'preview' ? (
            <div>
              <div className="flex items-center justify-between mb-1.5">
                <span className="text-xs font-medium text-slate-600">Formatted Jira Ticket Text:</span>
                <span className="text-[11px] text-slate-400">Ready to paste into Jira</span>
              </div>
              <pre className="p-3 bg-slate-50 border border-slate-300 rounded text-xs font-mono text-slate-800 whitespace-pre-wrap leading-relaxed select-all">
                {getFullJiraMarkdown()}
              </pre>
            </div>
          ) : (
            <>
              {/* Summary */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  Summary
                </label>
                <input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  className="w-full text-xs text-slate-900 px-3 py-1.5 rounded border border-slate-300 focus:border-blue-600 focus:outline-none bg-white"
                />
              </div>

              {/* Description */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  Description
                </label>
                <textarea
                  rows={4}
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  className="w-full text-xs text-slate-900 p-2.5 rounded border border-slate-300 focus:border-blue-600 focus:outline-none bg-white leading-relaxed resize-y"
                />
              </div>

              {/* Steps to Reproduce */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">
                  Steps to Reproduce
                </label>
                <textarea
                  rows={3}
                  value={steps}
                  onChange={(e) => setSteps(e.target.value)}
                  className="w-full text-xs text-slate-900 p-2.5 rounded border border-slate-300 focus:border-blue-600 focus:outline-none bg-white leading-relaxed resize-y"
                />
              </div>

              {/* Expected and Actual */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">
                    Expected Result
                  </label>
                  <textarea
                    rows={2}
                    value={expected}
                    onChange={(e) => setExpected(e.target.value)}
                    className="w-full text-xs text-slate-900 p-2 rounded border border-slate-300 focus:border-blue-600 focus:outline-none bg-white resize-none"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">
                    Actual Result
                  </label>
                  <textarea
                    rows={2}
                    value={actual}
                    onChange={(e) => setActual(e.target.value)}
                    className="w-full text-xs text-slate-900 p-2 rounded border border-slate-300 focus:border-blue-600 focus:outline-none bg-white resize-none"
                  />
                </div>
              </div>
            </>
          )}
        </div>

        {/* Simple Footer */}
        <div className="px-5 py-3 border-t border-slate-200 bg-slate-50 flex items-center justify-between gap-3">
          <div>
            {!scenario.status.includes('NOT WORKING') && onMarkNotWorking && (
              <button
                type="button"
                onClick={() => onMarkNotWorking(scenario.id)}
                className="text-xs text-red-700 hover:text-red-900 hover:underline cursor-pointer"
              >
                Mark row as NOT WORKING
              </button>
            )}
          </div>

          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={onClose}
              className="px-3 py-1.5 rounded text-xs text-slate-600 hover:bg-slate-200 cursor-pointer transition font-medium"
            >
              Cancel
            </button>
            <button
              type="button"
              onClick={handleCopy}
              className={`px-4 py-1.5 rounded text-xs font-medium transition cursor-pointer flex items-center gap-1.5 ${
                copied
                  ? 'bg-emerald-700 text-white'
                  : 'bg-[#0052CC] hover:bg-[#0747A6] text-white'
              }`}
            >
              {copied ? (
                <>
                  <Check className="w-3.5 h-3.5" />
                  <span>Copied to Clipboard</span>
                </>
              ) : (
                <>
                  <Copy className="w-3.5 h-3.5" />
                  <span>Copy for Jira</span>
                </>
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
