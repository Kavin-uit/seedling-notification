import React, { useState } from 'react'
import type { NotificationScenario, ScenarioStatus } from '../../types/notification'
import { parseExcelFile, parseGoogleSheetsClipboard } from '../../utils/excel'
import type { ParsedRow } from '../../utils/excel'
import { X, Upload, Clipboard, FileSpreadsheet, CheckCircle2, AlertCircle, ArrowRight } from 'lucide-react'


interface ExcelImportModalProps {
  onClose: () => void
  onImport: (newScenarios: NotificationScenario[], mode: 'append' | 'replace') => void
  currentMaxKeyNum: number
}

export const ExcelImportModal: React.FC<ExcelImportModalProps> = ({
  onClose,
  onImport,
  currentMaxKeyNum,
}) => {
  const [activeMode, setActiveMode] = useState<'upload' | 'paste'>('paste')
  const [pastedText, setPastedText] = useState('')
  const [parsedRows, setParsedRows] = useState<ParsedRow[]>([])
  const [importMode, setImportMode] = useState<'append' | 'replace'>('append')
  const [errorMsg, setErrorMsg] = useState('')
  const [fileName, setFileName] = useState('')

  // Handle file drop / select
  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    setFileName(file.name)
    setErrorMsg('')

    try {
      const buffer = await file.arrayBuffer()
      const rows = parseExcelFile(buffer)
      if (rows.length === 0) {
        setErrorMsg('No data rows could be extracted from this spreadsheet.')
      } else {
        setParsedRows(rows)
      }
    } catch (err) {
      console.error(err)
      setErrorMsg('Failed to parse Excel file. Please ensure it is a valid .xlsx or .csv.')
    }
  }

  // Handle Google Sheet clipboard text parsing
  const handleParseClipboard = () => {
    setErrorMsg('')
    if (!pastedText.trim()) {
      setErrorMsg('Please paste tab-delimited cells from your Google Sheet or Excel.')
      return
    }

    try {
      const rows = parseGoogleSheetsClipboard(pastedText)
      if (rows.length === 0) {
        setErrorMsg('Could not detect valid columns in pasted text.')
      } else {
        setParsedRows(rows)
      }
    } catch (err) {
      console.error(err)
      setErrorMsg('Failed to parse clipboard contents.')
    }
  }

  // Finalize import
  const handleConfirmImport = () => {
    if (parsedRows.length === 0) return

    let nextNum = importMode === 'replace' ? 1 : currentMaxKeyNum + 1

    const newScenarios: NotificationScenario[] = parsedRows.map((r) => {
      const s: NotificationScenario = {
        id: `sc-${Date.now()}-${Math.random().toString(36).substr(2, 5)}`,
        key: `NOTIF-${nextNum++}`,
        engineCategory: (r.governanceEvent.toLowerCase().includes('seedling') || r.governanceEvent.toLowerCase().includes('comment') ? 'Governance' : 'Contribution') as 'Governance' | 'Contribution',
        governanceEvent: r.governanceEvent,
        trigger: r.trigger,
        audience: r.audience,
        communicationObjective: r.communicationObjective,
        desiredOutcome: r.desiredOutcome,
        pushSubject: r.pushSubject || r.governanceEvent,
        pushBody: r.pushBody || r.governanceEvent,
        emailSubject: r.emailSubject || r.governanceEvent,
        emailBody: r.emailBody || r.pushBody || '',
        inAppExperience: r.inAppExperience || 'Notification toast',
        cta: r.cta || 'View Details',
        status: (r.status || 'TO DO') as ScenarioStatus,
        priority: 'Medium',
        environment: 'STAGING',
        assignee: {
          name: 'Alex Rivera',
          email: 'alex.rivera@atlassian.net',
          avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80',
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      }
      return s
    })

    onImport(newScenarios, importMode)
    onClose()
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-xs p-3 sm:p-4 overflow-y-auto animate-in fade-in duration-150">
      <div
        className="w-full max-w-3xl bg-white rounded-lg shadow-2xl border border-[#DFE1E6] flex flex-col max-h-[88dvh] overflow-hidden"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="px-4 sm:px-6 py-3 sm:py-4 border-b border-[#EBECF0] flex items-center justify-between bg-white">
          <div className="flex items-center gap-2.5 min-w-0">
            <div className="w-7 h-7 rounded bg-emerald-600 flex items-center justify-center text-white shrink-0">
              <FileSpreadsheet className="w-4 h-4" />
            </div>
            <div className="min-w-0">
              <h2 className="text-sm sm:text-base font-bold text-[#172B4D] truncate">
                Import Notification Scenarios from Spreadsheet
              </h2>
              <p className="text-[11px] text-[#6B778C] truncate">
                Upload an Excel/CSV file or copy-paste directly from Google Sheets
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="text-slate-400 hover:text-slate-700 p-1 rounded cursor-pointer shrink-0"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Tab switcher */}
        <div className="flex border-b border-[#EBECF0] px-4 sm:px-6 bg-[#FAFBFC] text-xs font-semibold overflow-x-auto whitespace-nowrap">
          <button
            type="button"
            onClick={() => setActiveMode('paste')}
            className={`py-3 px-4 flex items-center gap-2 border-b-2 cursor-pointer transition ${
              activeMode === 'paste'
                ? 'border-[#0052CC] text-[#0052CC] bg-white'
                : 'border-transparent text-[#6B778C] hover:text-[#172B4D]'
            }`}
          >
            <Clipboard className="w-4 h-4" />
            <span>Copy & Paste from Google Sheets</span>
          </button>
          <button
            type="button"
            onClick={() => setActiveMode('upload')}
            className={`py-3 px-4 flex items-center gap-2 border-b-2 cursor-pointer transition ${
              activeMode === 'upload'
                ? 'border-[#0052CC] text-[#0052CC] bg-white'
                : 'border-transparent text-[#6B778C] hover:text-[#172B4D]'
            }`}
          >
            <Upload className="w-4 h-4" />
            <span>Upload Excel File (.xlsx, .csv)</span>
          </button>
        </div>

        {/* Content */}
        <div className="p-6 overflow-y-auto space-y-4 flex-1 text-xs">
          {errorMsg && (
            <div className="p-3 bg-red-50 text-red-700 border border-red-200 rounded flex items-center gap-2 text-xs">
              <AlertCircle className="w-4 h-4 shrink-0" />
              <span>{errorMsg}</span>
            </div>
          )}

          {activeMode === 'paste' ? (
            <div className="space-y-3">
              <div className="text-[11px] text-[#42526E] bg-blue-50/60 p-3 rounded border border-blue-100 leading-relaxed">
                <strong>How to use:</strong> Select the cells in your Google Sheet or Excel (including header row or without headers), press <kbd className="px-1 py-0.5 bg-white border rounded font-mono text-[10px]">Ctrl+C</kbd> / <kbd className="px-1 py-0.5 bg-white border rounded font-mono text-[10px]">⌘+C</kbd>, and paste here.
              </div>

              <textarea
                value={pastedText}
                onChange={(e) => setPastedText(e.target.value)}
                placeholder={`Governance Event\tTrigger\tAudience\tCommunication Objective\tDesired Outcome\tPush Notification Subject Line\tPush Notification\tEmail Subject Line\tEmail Message\tIn-App Experience\tCall to Action`}
                rows={6}
                className="w-full font-mono text-xs border border-[#DFE1E6] rounded p-3 focus:border-[#0052CC] focus:outline-none bg-[#FAFBFC]"
              />

              <button
                type="button"
                onClick={handleParseClipboard}
                className="cursor-pointer bg-[#0052CC] hover:bg-[#0065FF] text-white px-4 py-2 rounded text-xs font-semibold shadow-xs flex items-center gap-2"
              >
                <span>Parse Pasted Content</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </button>
            </div>
          ) : (
            <div className="space-y-3">
              <label className="border-2 border-dashed border-[#DFE1E6] hover:border-[#0052CC] rounded-xl p-8 flex flex-col items-center justify-center cursor-pointer transition bg-[#FAFBFC] hover:bg-blue-50/20">
                <FileSpreadsheet className="w-10 h-10 text-emerald-600 mb-2" />
                <span className="font-bold text-[#172B4D] text-sm">
                  {fileName || 'Click to browse or drop .xlsx / .csv file here'}
                </span>
                <span className="text-[11px] text-[#6B778C] mt-1">
                  Supports Microsoft Excel (.xlsx, .xls) and Comma-Separated Values (.csv)
                </span>
                <input
                  type="file"
                  accept=".xlsx, .xls, .csv"
                  onChange={handleFileUpload}
                  className="hidden"
                />
              </label>
            </div>
          )}

          {/* Parsed Rows Preview */}
          {parsedRows.length > 0 && (
            <div className="pt-4 border-t border-[#EBECF0] space-y-3">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                  <span className="font-bold text-[#172B4D]">
                    Successfully Parsed {parsedRows.length} Scenario(s)
                  </span>
                </div>

                {/* Append vs Replace Mode */}
                <div className="flex items-center gap-3">
                  <label className="flex items-center gap-1.5 cursor-pointer text-xs text-[#42526E]">
                    <input
                      type="radio"
                      name="importMode"
                      checked={importMode === 'append'}
                      onChange={() => setImportMode('append')}
                      className="text-[#0052CC]"
                    />
                    <span>Append to existing</span>
                  </label>
                  <label className="flex items-center gap-1.5 cursor-pointer text-xs text-[#42526E]">
                    <input
                      type="radio"
                      name="importMode"
                      checked={importMode === 'replace'}
                      onChange={() => setImportMode('replace')}
                      className="text-[#0052CC]"
                    />
                    <span>Replace all</span>
                  </label>
                </div>
              </div>

              {/* Preview table */}
              <div className="border border-[#DFE1E6] rounded-md max-h-48 overflow-y-auto">
                <table className="w-full text-left text-[11px]">
                  <thead className="bg-[#F4F5F7] text-[#42526E] font-bold sticky top-0 border-b border-[#DFE1E6]">
                    <tr>
                      <th className="p-2">Governance Event</th>
                      <th className="p-2">Trigger</th>
                      <th className="p-2">Audience</th>
                      <th className="p-2">Push Subject Line</th>
                      <th className="p-2">Desired Outcome</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-[#EBECF0]">
                    {parsedRows.map((r, i) => (
                      <tr key={i} className="hover:bg-slate-50">
                        <td className="p-2 font-semibold text-[#172B4D]">{r.governanceEvent}</td>
                        <td className="p-2 font-mono text-[#6B778C]">{r.trigger}</td>
                        <td className="p-2">{r.audience}</td>
                        <td className="p-2 text-blue-600">{r.pushSubject}</td>
                        <td className="p-2">{r.desiredOutcome}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>

        {/* Modal Footer */}
        <div className="px-6 py-3.5 border-t border-[#EBECF0] bg-white flex items-center justify-end gap-2 shrink-0">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-xs font-semibold text-[#42526E] hover:bg-[#F4F5F7] rounded cursor-pointer transition"
          >
            Cancel
          </button>
          <button
            type="button"
            disabled={parsedRows.length === 0}
            onClick={handleConfirmImport}
            className={`px-5 py-2 text-xs font-semibold rounded cursor-pointer transition shadow-sm ${
              parsedRows.length > 0
                ? 'bg-[#0052CC] hover:bg-[#0065FF] text-white'
                : 'bg-slate-200 text-slate-400 cursor-not-allowed'
            }`}
          >
            Import {parsedRows.length} Scenarios
          </button>
        </div>
      </div>
    </div>
  )
}
