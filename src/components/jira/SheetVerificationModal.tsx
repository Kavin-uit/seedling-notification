import React, { useState, useEffect } from 'react'
import { X, ExternalLink, RefreshCw } from 'lucide-react'
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
    if (engine === 'Governance' || engine === 'Contribution') {
      alert(`${engine} Engine sheet cannot be removed, but you can update its URL.`)
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
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-2xs">
      <div className="bg-white rounded border border-[#DFE1E6] shadow-xl w-full max-w-lg overflow-hidden flex flex-col text-[#172B4D]">
        {/* Modal Header */}
        <div className="px-5 py-4 border-b border-[#EBECF0] flex items-center justify-between">
          <div>
            <h2 className="text-base font-semibold text-[#172B4D]">Google Sheets</h2>
            <p className="text-xs text-[#6B778C] mt-0.5">
              Notification scenario copy is checked against these Google Sheets.
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Close"
            className="text-[#6B778C] hover:text-[#172B4D] hover:bg-[#EBECF0] p-1.5 rounded transition cursor-pointer"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Modal Body */}
        <div className="p-5 space-y-4 max-h-[75vh] overflow-y-auto text-xs">
          {/* Engine Sheet Fields */}
          <div className="space-y-3.5">
            {Object.values(configs).map((cfg) => (
              <div key={cfg.engineCategory} className="space-y-1">
                <div className="flex items-center justify-between">
                  <label className="font-medium text-[#172B4D]">
                    {cfg.engineCategory} Sheet URL
                  </label>

                  <div className="flex items-center gap-2">
                    {cfg.sheetUrl && (
                      <a
                        href={cfg.sheetUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-[#0052CC] hover:underline inline-flex items-center gap-1 text-xs"
                      >
                        <span>Open sheet</span>
                        <ExternalLink className="w-3 h-3" />
                      </a>
                    )}
                    {cfg.engineCategory !== 'Governance' && cfg.engineCategory !== 'Contribution' && (
                      <button
                        type="button"
                        onClick={() => handleDeleteEngineSheet(cfg.engineCategory)}
                        className="text-[#6B778C] hover:text-[#DE350B] text-xs cursor-pointer ml-1"
                      >
                        Remove
                      </button>
                    )}
                  </div>
                </div>

                <input
                  type="url"
                  value={cfg.sheetUrl}
                  onChange={(e) => handleUpdateUrl(cfg.engineCategory, e.target.value)}
                  placeholder="Paste Google Sheet URL..."
                  className="w-full bg-[#FAFBFC] hover:bg-[#EBECF0]/60 focus:bg-white text-[#172B4D] border border-[#DFE1E6] focus:border-[#0052CC] focus:ring-1 focus:ring-[#0052CC] rounded px-3 py-1.5 text-xs outline-none transition"
                />
              </div>
            ))}
          </div>

          {/* Add Sheet Link / Form */}
          {!showAddForm ? (
            <button
              type="button"
              onClick={() => setShowAddForm(true)}
              className="text-[#0052CC] hover:underline font-medium text-xs cursor-pointer pt-1"
            >
              + Add another sheet
            </button>
          ) : (
            <form
              onSubmit={handleAddEngineSheet}
              className="p-3 bg-[#FAFBFC] border border-[#DFE1E6] rounded space-y-2 mt-2"
            >
              <div className="font-medium text-[#172B4D]">Add Engine Sheet</div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                <input
                  type="text"
                  required
                  placeholder="Engine Name (e.g. Identity)"
                  value={newEngineName}
                  onChange={(e) => setNewEngineName(e.target.value)}
                  className="bg-white border border-[#DFE1E6] rounded px-2.5 py-1.5 text-xs outline-none focus:border-[#0052CC]"
                />
                <input
                  type="url"
                  required
                  placeholder="Google Sheet URL"
                  value={newSheetUrl}
                  onChange={(e) => setNewSheetUrl(e.target.value)}
                  className="bg-white border border-[#DFE1E6] rounded px-2.5 py-1.5 text-xs outline-none focus:border-[#0052CC]"
                />
              </div>
              <div className="flex justify-end gap-2 pt-1">
                <button
                  type="button"
                  onClick={() => setShowAddForm(false)}
                  className="px-2.5 py-1 rounded text-[#42526E] hover:bg-[#EBECF0] transition cursor-pointer text-xs"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-3 py-1 rounded bg-[#0052CC] hover:bg-[#0065FF] text-white font-medium transition cursor-pointer text-xs"
                >
                  Add
                </button>
              </div>
            </form>
          )}

          {/* Clean Human Status Summary (No giant colored box) */}
          <div className="pt-2 border-t border-[#EBECF0] flex items-center justify-between text-xs text-[#6B778C]">
            <div>
              {hasMismatches ? (
                <span className="text-[#DE350B] font-medium">
                  {activeSummary.totalMismatches} mismatch{activeSummary.totalMismatches > 1 ? 'es' : ''} detected with sheets.
                </span>
              ) : activeSummary ? (
                <span className="text-[#006644] font-medium">
                  All {activeSummary.totalScenariosChecked} scenarios match sheets.
                </span>
              ) : (
                <span>Verification ready.</span>
              )}
              {activeSummary?.lastCheckedAt && (
                <span className="text-[#6B778C] ml-1">
                  (Checked at {new Date(activeSummary.lastCheckedAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })})
                </span>
              )}
            </div>

            <button
              type="button"
              onClick={onReverify}
              disabled={isReverifying}
              className="text-[#0052CC] hover:underline font-medium inline-flex items-center gap-1 cursor-pointer disabled:opacity-50"
            >
              <RefreshCw className={`w-3 h-3 ${isReverifying ? 'animate-spin' : ''}`} />
              <span>{isReverifying ? 'Checking...' : 'Re-verify'}</span>
            </button>
          </div>
        </div>

        {/* Modal Footer */}
        <div className="px-5 py-3 border-t border-[#EBECF0] bg-[#FAFBFC] flex justify-end">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-1.5 rounded-[3px] bg-[#0052CC] hover:bg-[#0065FF] text-white font-medium text-xs transition cursor-pointer"
          >
            Done
          </button>
        </div>
      </div>
    </div>
  )
}
