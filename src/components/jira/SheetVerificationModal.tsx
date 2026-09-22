import React, { useState, useEffect } from 'react'
import {
  X,
  ExternalLink,
  RefreshCw,
  CheckCircle2,
  AlertCircle,
  Plus,
  Trash2,
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

  const hasMismatches = activeSummary && activeSummary.totalMismatches > 0

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-2xs animate-in fade-in duration-100">
      <div className="bg-white rounded-lg shadow-xl border border-slate-200 w-full max-w-lg overflow-hidden flex flex-col text-slate-800 text-xs">
        {/* Header */}
        <div className="px-5 py-3.5 border-b border-slate-200 flex items-center justify-between bg-slate-50/50">
          <div>
            <h2 className="text-sm font-bold text-slate-900">Google Sheet Verification</h2>
            <p className="text-[11px] text-slate-500 mt-0.5">
              Verify live notification copy against official reference Google Sheets
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Close modal"
            className="text-slate-400 hover:text-slate-600 p-1 rounded hover:bg-slate-100 transition cursor-pointer"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Content Body */}
        <div className="p-5 space-y-4 max-h-[75vh] overflow-y-auto">
          {/* Subtle Status Notice */}
          {activeSummary && (
            <div
              className={`px-3 py-2 rounded border flex items-center justify-between gap-3 text-xs ${
                hasMismatches
                  ? 'bg-rose-50 border-rose-200 text-rose-900'
                  : 'bg-emerald-50 border-emerald-200 text-emerald-900'
              }`}
            >
              <div className="flex items-center gap-2 min-w-0">
                {hasMismatches ? (
                  <AlertCircle className="w-4 h-4 text-rose-600 shrink-0" />
                ) : (
                  <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                )}
                <span className="font-medium truncate">
                  {hasMismatches
                    ? `${activeSummary.totalMismatches} content mismatch${
                        activeSummary.totalMismatches > 1 ? 'es' : ''
                      } detected`
                    : `All ${activeSummary.totalScenariosChecked} scenarios match reference sheets`}
                </span>
              </div>

              <button
                type="button"
                onClick={onReverify}
                disabled={isReverifying}
                className="px-2 py-1 rounded bg-white border border-slate-300 text-slate-700 hover:bg-slate-50 font-medium text-[11px] inline-flex items-center gap-1.5 shrink-0 transition cursor-pointer disabled:opacity-50"
              >
                <RefreshCw className={`w-3 h-3 ${isReverifying ? 'animate-spin text-blue-600' : ''}`} />
                <span>Re-verify</span>
              </button>
            </div>
          )}

          {/* Engine Sheet Connections */}
          <div className="space-y-3.5">
            <div className="flex items-center justify-between pb-1 border-b border-slate-100">
              <span className="font-bold text-[11px] uppercase tracking-wider text-slate-500">
                Connected Reference Sheets
              </span>
              {!showAddForm && (
                <button
                  type="button"
                  onClick={() => setShowAddForm(true)}
                  className="text-blue-600 hover:text-blue-800 text-xs font-semibold inline-flex items-center gap-1 cursor-pointer"
                >
                  <Plus className="w-3.5 h-3.5" />
                  <span>Add Engine</span>
                </button>
              )}
            </div>

            {Object.values(configs).map((cfg) => (
              <div key={cfg.engineCategory} className="space-y-1">
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-slate-800 text-xs">
                    {cfg.engineCategory} Engine
                  </span>

                  <div className="flex items-center gap-3 text-[11px]">
                    <label className="flex items-center gap-1 text-slate-500 cursor-pointer hover:text-slate-700">
                      <input
                        type="checkbox"
                        checked={cfg.enabled}
                        onChange={() => handleToggleEnable(cfg.engineCategory)}
                        className="rounded border-slate-300 text-blue-600 focus:ring-0 cursor-pointer"
                      />
                      <span>Auto-verify</span>
                    </label>

                    {cfg.sheetUrl && (
                      <a
                        href={cfg.sheetUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-blue-600 hover:underline inline-flex items-center gap-0.5"
                      >
                        <span>Open sheet</span>
                        <ExternalLink className="w-3 h-3" />
                      </a>
                    )}

                    {cfg.engineCategory !== 'Governance' && (
                      <button
                        type="button"
                        onClick={() => handleDeleteEngineSheet(cfg.engineCategory)}
                        className="text-slate-400 hover:text-rose-600 transition cursor-pointer p-0.5"
                        title="Remove engine sheet"
                      >
                        <Trash2 className="w-3 h-3" />
                      </button>
                    )}
                  </div>
                </div>

                <input
                  type="url"
                  value={cfg.sheetUrl}
                  onChange={(e) => handleUpdateUrl(cfg.engineCategory, e.target.value)}
                  placeholder="https://docs.google.com/spreadsheets/d/..."
                  className="w-full bg-slate-50/70 hover:bg-white focus:bg-white text-slate-800 border border-slate-200 focus:border-blue-500 rounded px-2.5 py-1.5 text-xs outline-none transition"
                />
              </div>
            ))}
          </div>

          {/* Add New Sheet Form */}
          {showAddForm && (
            <form
              onSubmit={handleAddEngineSheet}
              className="p-3 bg-slate-50 border border-slate-200 rounded space-y-2 text-xs animate-in fade-in"
            >
              <div className="font-semibold text-slate-800">Add Engine Reference Sheet</div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                <input
                  type="text"
                  required
                  placeholder="Engine Name (e.g. Identity)"
                  value={newEngineName}
                  onChange={(e) => setNewEngineName(e.target.value)}
                  className="bg-white border border-slate-300 rounded px-2.5 py-1.5 text-xs outline-none focus:border-blue-500"
                />
                <input
                  type="url"
                  required
                  placeholder="Google Sheet URL"
                  value={newSheetUrl}
                  onChange={(e) => setNewSheetUrl(e.target.value)}
                  className="bg-white border border-slate-300 rounded px-2.5 py-1.5 text-xs outline-none focus:border-blue-500"
                />
              </div>
              <div className="flex justify-end gap-2 pt-1">
                <button
                  type="button"
                  onClick={() => setShowAddForm(false)}
                  className="px-2.5 py-1 rounded text-slate-600 hover:bg-slate-200 transition cursor-pointer text-xs"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-3 py-1 rounded bg-blue-600 hover:bg-blue-700 text-white font-semibold transition cursor-pointer text-xs"
                >
                  Add Sheet
                </button>
              </div>
            </form>
          )}
        </div>

        {/* Footer */}
        <div className="px-5 py-3 border-t border-slate-200 bg-slate-50/50 flex items-center justify-between">
          <span className="text-[11px] text-slate-400">
            {activeSummary?.lastCheckedAt && (
              <>
                Last verified at{' '}
                {new Date(activeSummary.lastCheckedAt).toLocaleTimeString([], {
                  hour: '2-digit',
                  minute: '2-digit',
                  second: '2-digit',
                })}
              </>
            )}
          </span>

          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 rounded-[3px] bg-[#0052CC] hover:bg-[#0065FF] text-white font-semibold text-xs transition cursor-pointer shadow-2xs"
          >
            Done
          </button>
        </div>
      </div>
    </div>
  )
}
