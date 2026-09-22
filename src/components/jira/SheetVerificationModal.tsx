import React, { useState, useEffect } from 'react'
import {
  X,
  ExternalLink,
  RefreshCw,
  CheckCircle2,
  AlertTriangle,
  Plus,
  Trash2,
  FileSpreadsheet,
} from 'lucide-react'
import {
  getRegisteredEngineSheets,
  saveRegisteredEngineSheets,
  convertToCsvExportUrl,
  type EngineSheetConfig,
  type SheetVerificationSummary,
} from '../../services/sheetVerificationService'
import { engineSheetsApi } from '../../api/engineSheetsApi'

interface SheetVerificationModalProps {
  onClose: () => void
  activeSummary: SheetVerificationSummary | null
  onReverify: () => void
  isReverifying: boolean
}

export const SheetVerificationModal: React.FC<SheetVerificationModalProps> = ({
  onClose,
  activeSummary,
  onReverify,
  isReverifying,
}) => {
  const [configs, setConfigs] = useState<Record<string, EngineSheetConfig>>(
    getRegisteredEngineSheets()
  )
  const [newEngineName, setNewEngineName] = useState('')
  const [newSheetUrl, setNewSheetUrl] = useState('')
  const [showAddForm, setShowAddForm] = useState(false)

  useEffect(() => {
    let isMounted = true
    engineSheetsApi.fetchEngineSheets().then((data) => {
      if (isMounted && data) {
        setConfigs(data)
      }
    })
    return () => {
      isMounted = false
    }
  }, [])

  const handleToggleEnable = (engine: string) => {
    const updatedItem = {
      ...configs[engine],
      enabled: !configs[engine].enabled,
    }
    const updated = {
      ...configs,
      [engine]: updatedItem,
    }
    setConfigs(updated)
    saveRegisteredEngineSheets(updated)
    engineSheetsApi.saveEngineSheet(updatedItem)
    onReverify()
  }

  const handleUpdateUrl = (engine: string, url: string) => {
    const csvUrl = convertToCsvExportUrl(url)
    const updatedItem = {
      ...configs[engine],
      sheetUrl: url,
      csvExportUrl: csvUrl,
    }
    const updated = {
      ...configs,
      [engine]: updatedItem,
    }
    setConfigs(updated)
    saveRegisteredEngineSheets(updated)
    engineSheetsApi.saveEngineSheet(updatedItem)
  }

  const handleAddEngineSheet = (e: React.FormEvent) => {
    e.preventDefault()
    if (!newEngineName.trim() || !newSheetUrl.trim()) return

    const trimmedEngine = newEngineName.trim()
    const csvUrl = convertToCsvExportUrl(newSheetUrl.trim())

    const newItem: EngineSheetConfig = {
      engineCategory: trimmedEngine,
      sheetName: `${trimmedEngine} Content Sheet`,
      sheetUrl: newSheetUrl.trim(),
      csvExportUrl: csvUrl,
      enabled: true,
    }

    const updated = {
      ...configs,
      [trimmedEngine]: newItem,
    }
    setConfigs(updated)
    saveRegisteredEngineSheets(updated)
    engineSheetsApi.saveEngineSheet(newItem)
    setNewEngineName('')
    setNewSheetUrl('')
    setShowAddForm(false)
    onReverify()
  }

  const handleDeleteEngineSheet = (engine: string) => {
    if (engine === 'Governance') {
      alert('Governance Engine sheet cannot be removed, but you can update its URL.')
      return
    }
    const copy = { ...configs }
    delete copy[engine]
    setConfigs(copy)
    saveRegisteredEngineSheets(copy)
    engineSheetsApi.deleteEngineSheet(engine)
    onReverify()
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-xs animate-in fade-in duration-150">
      <div className="bg-white rounded-2xl shadow-2xl border border-slate-200 w-full max-w-xl overflow-hidden flex flex-col max-h-[90vh]">
        {/* Modal Header */}
        <div className="px-5 py-4 bg-slate-50 border-b border-slate-200 flex items-center justify-between">
          <div className="flex items-center gap-2.5">
            <div className="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-700 flex items-center justify-center shadow-xs">
              <FileSpreadsheet className="w-4 h-4" />
            </div>
            <div>
              <h2 className="text-sm font-bold text-slate-900">Google Sheet Verification Engine</h2>
              <p className="text-xs text-slate-500">
                Verifies displayed scenario copy against official Google Sheets on refresh
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="w-7 h-7 rounded-lg hover:bg-slate-200/80 text-slate-400 hover:text-slate-700 flex items-center justify-center transition cursor-pointer"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Modal Body */}
        <div className="p-5 overflow-y-auto space-y-4">
          {/* Active Status Banner */}
          {activeSummary && (
            <div
              className={`p-3.5 rounded-xl border flex items-start justify-between gap-3 ${
                activeSummary.totalMismatches > 0
                  ? 'bg-rose-50 border-rose-200 text-rose-900'
                  : 'bg-emerald-50 border-emerald-200 text-emerald-900'
              }`}
            >
              <div className="flex items-start gap-2.5">
                {activeSummary.totalMismatches > 0 ? (
                  <AlertTriangle className="w-5 h-5 text-[#FF3B30] shrink-0 mt-0.5" />
                ) : (
                  <CheckCircle2 className="w-5 h-5 text-emerald-600 shrink-0 mt-0.5" />
                )}
                <div>
                  <div className="text-xs font-bold">
                    {activeSummary.totalMismatches > 0
                      ? `${activeSummary.totalMismatches} Content Mismatch${
                          activeSummary.totalMismatches > 1 ? 'es' : ''
                        } Detected`
                      : 'All Scenario Data Matches Reference Sheet'}
                  </div>
                  <div className="text-[11px] opacity-80 mt-0.5">
                    Engine: <span className="font-semibold">{activeSummary.engineCategory}</span> •
                    Checked {activeSummary.totalScenariosChecked} scenarios against{' '}
                    {activeSummary.totalSheetRows} sheet rows.
                  </div>
                  {activeSummary.lastCheckedAt && (
                    <div className="text-[10px] opacity-60 mt-1">
                      Last verified:{' '}
                      {new Date(activeSummary.lastCheckedAt).toLocaleTimeString([], {
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit',
                      })}
                    </div>
                  )}
                </div>
              </div>

              <button
                type="button"
                onClick={onReverify}
                disabled={isReverifying}
                className="px-2.5 py-1.5 rounded-lg bg-white border border-slate-200 text-slate-700 hover:bg-slate-50 text-xs font-semibold flex items-center gap-1.5 shadow-2xs transition cursor-pointer shrink-0 disabled:opacity-50"
              >
                <RefreshCw className={`w-3.5 h-3.5 ${isReverifying ? 'animate-spin text-blue-600' : ''}`} />
                <span>Re-verify</span>
              </button>
            </div>
          )}

          {/* Engine Sheets List */}
          <div>
            <div className="flex items-center justify-between mb-2">
              <h3 className="text-xs font-bold uppercase tracking-wider text-slate-500">
                Connected Engine Sheets
              </h3>
              <button
                type="button"
                onClick={() => setShowAddForm(!showAddForm)}
                className="text-xs text-blue-600 hover:text-blue-700 font-semibold flex items-center gap-1 cursor-pointer"
              >
                <Plus className="w-3.5 h-3.5" />
                <span>Add Engine Sheet</span>
              </button>
            </div>

            <div className="space-y-3">
              {Object.values(configs).map((cfg) => (
                <div
                  key={cfg.engineCategory}
                  className="p-3.5 rounded-xl border border-slate-200 bg-white shadow-2xs flex flex-col gap-2"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <span className="text-xs font-bold text-slate-800">
                        {cfg.engineCategory} Engine
                      </span>
                      <label className="flex items-center gap-1.5 text-[11px] text-slate-500 cursor-pointer">
                        <input
                          type="checkbox"
                          checked={cfg.enabled}
                          onChange={() => handleToggleEnable(cfg.engineCategory)}
                          className="rounded text-blue-600 focus:ring-0 cursor-pointer"
                        />
                        <span>Auto-verify on refresh</span>
                      </label>
                    </div>

                    <div className="flex items-center gap-2">
                      {cfg.sheetUrl && (
                        <a
                          href={cfg.sheetUrl}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-xs text-blue-600 hover:text-blue-800 flex items-center gap-1"
                        >
                          <span>Open Sheet</span>
                          <ExternalLink className="w-3 h-3" />
                        </a>
                      )}
                      {cfg.engineCategory !== 'Governance' && (
                        <button
                          type="button"
                          onClick={() => handleDeleteEngineSheet(cfg.engineCategory)}
                          className="text-slate-400 hover:text-rose-600 p-1 transition cursor-pointer"
                          title="Remove sheet"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      )}
                    </div>
                  </div>

                  {/* URL Input */}
                  <div className="flex items-center gap-2">
                    <input
                      type="url"
                      value={cfg.sheetUrl}
                      onChange={(e) => handleUpdateUrl(cfg.engineCategory, e.target.value)}
                      placeholder="Paste Google Sheet URL (with view or edit permission)..."
                      className="flex-1 bg-slate-50 border border-slate-200 text-slate-800 text-xs rounded-lg px-2.5 py-1.5 focus:bg-white focus:ring-1 focus:ring-blue-500 outline-none"
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Add New Engine Sheet Form */}
          {showAddForm && (
            <form
              onSubmit={handleAddEngineSheet}
              className="p-3.5 rounded-xl border border-blue-200 bg-blue-50/50 space-y-2.5 animate-in fade-in"
            >
              <div className="text-xs font-bold text-blue-900">Register New Engine Sheet</div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                <input
                  type="text"
                  required
                  placeholder="Engine Category (e.g., Contribution)"
                  value={newEngineName}
                  onChange={(e) => setNewEngineName(e.target.value)}
                  className="bg-white border border-slate-200 text-xs rounded-lg px-2.5 py-1.5 outline-none focus:ring-1 focus:ring-blue-500"
                />
                <input
                  type="url"
                  required
                  placeholder="Google Sheets URL"
                  value={newSheetUrl}
                  onChange={(e) => setNewSheetUrl(e.target.value)}
                  className="bg-white border border-slate-200 text-xs rounded-lg px-2.5 py-1.5 outline-none focus:ring-1 focus:ring-blue-500"
                />
              </div>
              <div className="flex justify-end gap-2 pt-1">
                <button
                  type="button"
                  onClick={() => setShowAddForm(false)}
                  className="px-3 py-1 rounded-lg text-xs font-medium text-slate-600 hover:bg-slate-200 transition cursor-pointer"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-3 py-1 rounded-lg text-xs font-semibold bg-blue-600 hover:bg-blue-700 text-white shadow-2xs transition cursor-pointer"
                >
                  Save & Connect
                </button>
              </div>
            </form>
          )}
        </div>

        {/* Modal Footer */}
        <div className="px-5 py-3 bg-slate-50 border-t border-slate-200 flex justify-end">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 rounded-xl bg-slate-900 hover:bg-slate-800 text-white text-xs font-semibold shadow-xs transition cursor-pointer"
          >
            Done
          </button>
        </div>
      </div>
    </div>
  )
}
