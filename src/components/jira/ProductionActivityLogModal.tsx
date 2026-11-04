import React, { useState, useEffect, useCallback } from 'react'
import {
  getActivityLog,
  clearActivityLog,
  type ProductionActivityEntry,
} from '../../utils/productionActivityLog'

interface ProductionActivityLogModalProps {
  onClose: () => void
}

function formatTimestamp(iso: string): string {
  try {
    const d = new Date(iso)
    const pad = (n: number) => String(n).padStart(2, '0')
    const yyyy = d.getFullYear()
    const mm = pad(d.getMonth() + 1)
    const dd = pad(d.getDate())
    const hh = pad(d.getHours())
    const min = pad(d.getMinutes())
    const ss = pad(d.getSeconds())
    return `${yyyy}-${mm}-${dd}  ${hh}:${min}:${ss}`
  } catch {
    return iso
  }
}

export const ProductionActivityLogModal: React.FC<ProductionActivityLogModalProps> = ({
  onClose,
}) => {
  const [entries, setEntries] = useState<ProductionActivityEntry[]>([])

  const reload = useCallback(() => {
    setEntries(getActivityLog())
  }, [])

  useEffect(() => {
    reload()
  }, [reload])

  const handleClear = () => {
    if (window.confirm('Clear all activity log entries? This cannot be undone.')) {
      clearActivityLog()
      reload()
    }
  }

  // Close on Escape
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [onClose])

  return (
    /* Backdrop */
    <div
      style={{
        position: 'fixed',
        inset: 0,
        zIndex: 9000,
        background: 'rgba(0,0,0,0.35)',
        display: 'flex',
        alignItems: 'flex-start',
        justifyContent: 'center',
        paddingTop: '60px',
      }}
      onClick={(e) => { if (e.target === e.currentTarget) onClose() }}
    >
      {/* Modal panel */}
      <div
        style={{
          background: '#fff',
          border: '1px solid #aaa',
          width: '820px',
          maxWidth: '96vw',
          maxHeight: '78vh',
          display: 'flex',
          flexDirection: 'column',
          fontFamily: 'Courier New, Courier, monospace',
          fontSize: '12px',
          boxShadow: '2px 3px 10px rgba(0,0,0,0.25)',
        }}
      >
        {/* Title bar */}
        <div
          style={{
            background: '#1e4d2b',
            color: '#fff',
            padding: '5px 10px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            fontFamily: 'Arial, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            flexShrink: 0,
          }}
        >
          <span>Production Activity Log</span>
          <button
            type="button"
            onClick={onClose}
            style={{
              background: 'transparent',
              border: '1px solid #aaa',
              color: '#fff',
              cursor: 'pointer',
              fontSize: '11px',
              padding: '1px 7px',
              lineHeight: '1.4',
            }}
            title="Close"
          >
            ✕
          </button>
        </div>

        {/* Meta row */}
        <div
          style={{
            borderBottom: '1px solid #ccc',
            padding: '4px 10px',
            fontFamily: 'Arial, sans-serif',
            fontSize: '11px',
            color: '#555',
            background: '#f5f5f5',
            flexShrink: 0,
          }}
        >
          {entries.length === 0
            ? 'No entries yet. Log is recorded each time a notification is added to Production Ready.'
            : `${entries.length} entr${entries.length === 1 ? 'y' : 'ies'} — newest first`}
        </div>

        {/* Table scroll area */}
        <div style={{ overflowY: 'auto', flex: 1 }}>
          <table
            style={{
              width: '100%',
              borderCollapse: 'collapse',
              tableLayout: 'fixed',
              fontSize: '11px',
              fontFamily: 'Courier New, Courier, monospace',
            }}
          >
            <colgroup>
              <col style={{ width: '34px' }} />
              <col style={{ width: '155px' }} />
              <col style={{ width: '52px' }} />
              <col style={{ width: '140px' }} />
              <col style={{ width: '220px' }} />
              <col style={{ width: '110px' }} />
            </colgroup>
            <thead>
              <tr style={{ background: '#d9d9d9', borderBottom: '2px solid #999' }}>
                {['#', 'Date & Time', 'Action', 'Prod Key', 'Event / Notification', 'Engine'].map(
                  (col) => (
                    <th
                      key={col}
                      style={{
                        padding: '3px 6px',
                        textAlign: 'left',
                        fontFamily: 'Arial, sans-serif',
                        fontWeight: 'bold',
                        fontSize: '11px',
                        borderRight: '1px solid #bbb',
                        whiteSpace: 'nowrap',
                        overflow: 'hidden',
                      }}
                    >
                      {col}
                    </th>
                  )
                )}
              </tr>
            </thead>
            <tbody>
              {entries.length === 0 ? (
                <tr>
                  <td
                    colSpan={6}
                    style={{
                      padding: '20px',
                      textAlign: 'center',
                      color: '#888',
                      fontFamily: 'Arial, sans-serif',
                      fontStyle: 'italic',
                    }}
                  >
                    — no log entries —
                  </td>
                </tr>
              ) : (
                entries.map((entry, idx) => (
                  <tr
                    key={entry.id}
                    style={{
                      background: idx % 2 === 0 ? '#fff' : '#f2f2f2',
                      borderBottom: '1px solid #ddd',
                    }}
                  >
                    {/* # */}
                    <td
                      style={{
                        padding: '2px 6px',
                        color: '#888',
                        borderRight: '1px solid #ddd',
                        textAlign: 'right',
                        whiteSpace: 'nowrap',
                      }}
                    >
                      {idx + 1}
                    </td>

                    {/* Date & Time */}
                    <td
                      style={{
                        padding: '2px 6px',
                        borderRight: '1px solid #ddd',
                        whiteSpace: 'nowrap',
                        color: '#333',
                      }}
                    >
                      {formatTimestamp(entry.timestamp)}
                    </td>

                    {/* Action */}
                    <td
                      style={{
                        padding: '2px 6px',
                        borderRight: '1px solid #ddd',
                        color: '#1a6b35',
                        fontWeight: 'bold',
                        whiteSpace: 'nowrap',
                      }}
                    >
                      {entry.action}
                    </td>

                    {/* Prod Key */}
                    <td
                      style={{
                        padding: '2px 6px',
                        borderRight: '1px solid #ddd',
                        color: '#0a3baa',
                        whiteSpace: 'nowrap',
                        overflow: 'hidden',
                        textOverflow: 'ellipsis',
                      }}
                      title={entry.prodKey}
                    >
                      {entry.prodKey}
                    </td>

                    {/* Event */}
                    <td
                      style={{
                        padding: '2px 6px',
                        borderRight: '1px solid #ddd',
                        overflow: 'hidden',
                        textOverflow: 'ellipsis',
                        whiteSpace: 'nowrap',
                        color: '#222',
                      }}
                      title={entry.governanceEvent}
                    >
                      {entry.governanceEvent}
                    </td>

                    {/* Engine */}
                    <td
                      style={{
                        padding: '2px 6px',
                        color: '#555',
                        overflow: 'hidden',
                        textOverflow: 'ellipsis',
                        whiteSpace: 'nowrap',
                      }}
                      title={entry.engineCategory}
                    >
                      {entry.engineCategory}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>

        {/* Footer buttons */}
        <div
          style={{
            borderTop: '1px solid #ccc',
            padding: '5px 10px',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            background: '#f5f5f5',
            flexShrink: 0,
            fontFamily: 'Arial, sans-serif',
            fontSize: '11px',
          }}
        >
          <button
            type="button"
            onClick={handleClear}
            disabled={entries.length === 0}
            style={{
              background: '#fff',
              border: '1px solid #aaa',
              cursor: entries.length === 0 ? 'default' : 'pointer',
              fontSize: '11px',
              padding: '2px 10px',
              color: entries.length === 0 ? '#bbb' : '#c00',
            }}
            title="Clear all log entries"
          >
            Clear Log
          </button>

          <button
            type="button"
            onClick={onClose}
            style={{
              background: '#fff',
              border: '1px solid #aaa',
              cursor: 'pointer',
              fontSize: '11px',
              padding: '2px 14px',
              color: '#333',
            }}
          >
            Close
          </button>
        </div>
      </div>
    </div>
  )
}

