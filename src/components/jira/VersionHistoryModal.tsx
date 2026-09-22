import React, { useState } from 'react'
import type { NotificationScenario, ScenarioVersion } from '../../types/notification'
import { formatDateTime, formatRelativeTime } from '../../utils/versionHistory'
import { X, RotateCcw } from 'lucide-react'

interface VersionHistoryModalProps {
  scenario: NotificationScenario
  onClose: () => void
  onRollbackRow?: (version: ScenarioVersion) => void
  onRollbackField: (fieldKey: string, targetValue: string, timestamp: string) => void
}

// Authentic Atlassian Design System Status Lozenges
const statusLozenges: Record<
  string,
  { bg: string; text: string; label: string }
> = {
  'TO DO': { bg: 'bg-[#DFE1E6]', text: 'text-[#42526E]', label: 'TO DO' },
  'TESTED': { bg: 'bg-[#E3FCEF]', text: 'text-[#006644]', label: 'TESTED' },
  'NOT WORKING': { bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]', label: 'NOT WORKING' },
  'IN-APP NAVIGATION NOT WORKING': { bg: 'bg-[#FFF0B3]', text: 'text-[#172B4D]', label: 'IN-APP NAVIGATION NOT WORKING' },
  'NAVIGATION NOT WORKING': { bg: 'bg-[#FFF0B3]', text: 'text-[#172B4D]', label: 'IN-APP NAVIGATION NOT WORKING' },
  'PUSH NOTIFICATION NOT WORKING': { bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]', label: 'PUSH NOTIFICATION NOT WORKING' },
  'PUSH NOTIFICATION NAVIGATION NOT WORKING': { bg: 'bg-[#FFEBE6]', text: 'text-[#BF2600]', label: 'PUSH NOTIFICATION NAVIGATION NOT WORKING' },
  'EMAIL NOTIFICATION NOT WORKING': { bg: 'bg-[#EAE6FF]', text: 'text-[#403294]', label: 'EMAIL NOTIFICATION NOT WORKING' },
  'EMAIL NOTIFICATION NAVIGATION NOT WORKING': { bg: 'bg-[#EAE6FF]', text: 'text-[#403294]', label: 'EMAIL NOTIFICATION NAVIGATION NOT WORKING' },
  'SMS NOTIFICATION NOT WORKING': { bg: 'bg-[#E6FCFF]', text: 'text-[#0065FF]', label: 'SMS NOTIFICATION NOT WORKING' },
}

const renderJiraLozenge = (status: string) => {
  if (!status) return null
  const statuses = status.split(',').map((s) => s.trim()).filter(Boolean)
  return (
    <span className="inline-flex flex-wrap gap-1 items-center">
      {statuses.map((st) => {
        const cfg = statusLozenges[st] || {
          bg: 'bg-[#FFEBE6]',
          text: 'text-[#BF2600]',
          label: st,
        }
        return (
          <span
            key={st}
            className={`inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold uppercase tracking-wider ${cfg.bg} ${cfg.text}`}
          >
            {cfg.label}
          </span>
        )
      })}
    </span>
  )
}

export const VersionHistoryModal: React.FC<VersionHistoryModalProps> = ({
  scenario,
  onClose,
  onRollbackField,
}) => {
  const [activeTab, setActiveTab] = useState<'all' | 'status' | 'fields'>('all')
  const [confirmingFieldId, setConfirmingFieldId] = useState<string | null>(null)

  const versions = scenario.versionHistory || []

  // Flatten version history into a clean Jira Activity list
  const historyEntries: {
    versionId: string
    timestamp: string
    field: string
    label: string
    oldValue: string
    newValue: string
  }[] = []

  versions.forEach((ver) => {
    if (ver.changes && ver.changes.length > 0) {
      ver.changes.forEach((c) => {
        historyEntries.push({
          versionId: ver.versionId,
          timestamp: ver.timestamp,
          field: c.field,
          label: c.label || (c.field === 'status' ? 'Status' : c.field),
          oldValue: c.oldValue,
          newValue: c.newValue,
        })
      })
    }
  })

  // Filter based on active Atlassian tab
  const displayedEntries = historyEntries.filter((e) => {
    if (activeTab === 'status') return e.field === 'status'
    if (activeTab === 'fields') return e.field !== 'status'
    return true
  })

  const statusCount = historyEntries.filter((e) => e.field === 'status').length
  const fieldCount = historyEntries.filter((e) => e.field !== 'status').length

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-md shadow-2xl border border-[#DFE1E6] w-full max-w-4xl max-h-[88dvh] flex flex-col font-sans text-[#172B4D] overflow-hidden"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Jira Dialog Header */}
        <div className="px-4 sm:px-6 py-3 sm:py-4 border-b border-[#DFE1E6] flex items-start justify-between bg-white">
          <div>
            <div className="flex items-center gap-2 text-xs text-[#5E6C84]">
              <span className="font-semibold text-[#0052CC] hover:underline cursor-pointer">
                {scenario.key}
              </span>
              <span>/</span>
              <span>{scenario.engineCategory} Engine</span>
            </div>
            <h2 className="text-sm sm:text-base font-semibold text-[#172B4D] mt-0.5 sm:mt-1 truncate max-w-lg">
              History: {scenario.governanceEvent || 'Scenario'}
            </h2>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="text-[#6B778C] hover:text-[#172B4D] p-1.5 rounded hover:bg-slate-100 transition cursor-pointer"
            title="Close dialog"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Jira Tabs (Clean Underline Style, No Pills) */}
        <div className="flex gap-4 sm:gap-6 border-b border-[#DFE1E6] px-4 sm:px-6 text-xs select-none">
          <button
            type="button"
            onClick={() => setActiveTab('all')}
            className={`py-3 font-semibold border-b-2 transition cursor-pointer ${
              activeTab === 'all'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#6B778C] hover:text-[#172B4D]'
            }`}
          >
            All Activity ({historyEntries.length})
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('status')}
            className={`py-3 font-semibold border-b-2 transition cursor-pointer ${
              activeTab === 'status'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#6B778C] hover:text-[#172B4D]'
            }`}
          >
            Status Transitions ({statusCount})
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('fields')}
            className={`py-3 font-semibold border-b-2 transition cursor-pointer ${
              activeTab === 'fields'
                ? 'border-[#0052CC] text-[#0052CC]'
                : 'border-transparent text-[#6B778C] hover:text-[#172B4D]'
            }`}
          >
            Field Changes ({fieldCount})
          </button>
        </div>

        {/* Body: Jira History List */}
        <div className="flex-1 overflow-y-auto p-6 bg-white">
          {displayedEntries.length === 0 ? (
            <div className="py-12 text-center text-xs text-[#6B778C]">
              <p className="font-semibold text-sm text-[#172B4D]">No history logged yet</p>
              <p className="mt-1">
                Any status transitions or updates to this scenario will be recorded here with author and timestamp details.
              </p>
            </div>
          ) : (
            <div className="border border-[#DFE1E6] rounded">
              <table className="w-full text-left text-xs border-collapse">
                <thead>
                  <tr className="border-b border-[#DFE1E6] bg-[#FAFBFC] text-[#6B778C] font-semibold text-[11px] uppercase tracking-wider">
                    <th className="px-4 py-2.5 w-44">Date & Time</th>
                    <th className="px-4 py-2.5 w-28">Field</th>
                    <th className="px-4 py-2.5">Original Value</th>
                    <th className="px-4 py-2.5">New Value</th>
                    <th className="px-4 py-2.5 text-right w-28">Action</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-[#DFE1E6]">
                  {displayedEntries.map((entry, idx) => {
                    const isConfirming =
                      confirmingFieldId === `${entry.versionId}-${entry.field}`
                    const isStatus = entry.field === 'status'

                    return (
                      <tr key={idx} className="hover:bg-[#FAFBFC] transition-colors">
                        {/* Timestamp */}
                        <td className="px-4 py-3 whitespace-nowrap text-[#172B4D]">
                          <div className="font-medium text-xs">
                            {formatDateTime(entry.timestamp)}
                          </div>
                          <div className="text-[11px] text-[#6B778C]">
                            {formatRelativeTime(entry.timestamp)}
                          </div>
                        </td>

                        {/* Field Name */}
                        <td className="px-4 py-3 whitespace-nowrap font-semibold text-[#172B4D]">
                          {entry.label}
                        </td>

                        {/* Original Value */}
                        <td className="px-4 py-3">
                          {isStatus ? (
                            renderJiraLozenge(entry.oldValue)
                          ) : (
                            <span className="text-slate-600 line-through">
                              {entry.oldValue || <span className="italic text-slate-400 font-normal">None</span>}
                            </span>
                          )}
                        </td>

                        {/* New Value */}
                        <td className="px-4 py-3">
                          {isStatus ? (
                            renderJiraLozenge(entry.newValue)
                          ) : (
                            <span className="text-[#172B4D] font-medium">
                              {entry.newValue || <span className="italic text-slate-400 font-normal">None</span>}
                            </span>
                          )}
                        </td>

                        {/* Revert Action */}
                        <td className="px-4 py-3 text-right whitespace-nowrap">
                          {isStatus || entry.field === 'comments' ? (
                            isConfirming ? (
                              <div className="inline-flex items-center gap-1.5 justify-end">
                                <button
                                  type="button"
                                  onClick={() => {
                                    onRollbackField(entry.field, entry.oldValue, entry.timestamp)
                                    setConfirmingFieldId(null)
                                  }}
                                  className="px-2 py-1 bg-[#DE350B] hover:bg-[#BF2600] text-white rounded text-[11px] font-semibold cursor-pointer transition shadow-2xs"
                                >
                                  Confirm
                                </button>
                                <button
                                  type="button"
                                  onClick={() => setConfirmingFieldId(null)}
                                  className="px-1.5 py-1 text-[#42526E] hover:bg-slate-100 rounded text-[11px] cursor-pointer transition"
                                >
                                  Cancel
                                </button>
                              </div>
                            ) : (
                              <button
                                type="button"
                                onClick={() =>
                                  setConfirmingFieldId(`${entry.versionId}-${entry.field}`)
                                }
                                className="inline-flex items-center gap-1 text-[#0052CC] hover:underline font-semibold text-xs cursor-pointer"
                                title={`Revert ${entry.label.toLowerCase()} back to "${entry.oldValue}"`}
                              >
                                <RotateCcw className="w-3 h-3 stroke-[2.5]" />
                                <span>Revert</span>
                              </button>
                            )
                          ) : (
                            <span className="text-[11px] text-[#6B778C]">
                              Locked
                            </span>
                          )}
                        </td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>

        {/* Jira Dialog Footer */}
        <div className="px-6 py-3 border-t border-[#DFE1E6] bg-[#FAFBFC] flex items-center justify-between text-xs">
          <div className="flex items-center gap-2">
            <span className="text-[#5E6C84]">Current status:</span>
            {renderJiraLozenge(scenario.status)}
          </div>
          <button
            type="button"
            onClick={onClose}
            className="px-3.5 py-1.5 bg-[#F4F5F7] hover:bg-[#EBECF0] text-[#172B4D] border border-[#DFE1E6] rounded text-xs font-semibold transition cursor-pointer"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}
