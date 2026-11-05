import React, { useState, useEffect, useCallback } from 'react'
import {
  getActivityLog,
  clearActivityLog,
  type ProductionActivityEntry,
} from '../../utils/productionActivityLog'

interface ProductionActivityLogModalProps {
  onClose: () => void
}

/* ─── helpers ─────────────────────────────────────────────────────── */

function formatDate(iso: string): string {
  try {
    return new Date(iso).toLocaleDateString('en-US', {
      month: 'short', day: 'numeric', year: 'numeric',
    })
  } catch { return '—' }
}

function formatTime(iso: string): string {
  try {
    return new Date(iso).toLocaleTimeString('en-US', {
      hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true,
    })
  } catch { return '—' }
}

function timeAgo(iso: string): string {
  try {
    const diff = Date.now() - new Date(iso).getTime()
    const mins  = Math.floor(diff / 60000)
    const hours = Math.floor(diff / 3600000)
    const days  = Math.floor(diff / 86400000)
    if (mins  < 1)   return 'just now'
    if (mins  < 60)  return `${mins}m ago`
    if (hours < 24)  return `${hours}h ago`
    return `${days}d ago`
  } catch { return '' }
}

const ENGINE_COLORS: Record<string, { bg: string; text: string; dot: string }> = {
  Contribution:  { bg: '#dcfce7', text: '#14532d', dot: '#16a34a' },
  Governance:    { bg: '#f3e8ff', text: '#581c87', dot: '#9333ea' },
  Opportunity:   { bg: '#fef9c3', text: '#713f12', dot: '#ca8a04' },
  Participation: { bg: '#dbeafe', text: '#1e3a8a', dot: '#2563eb' },
  Identity:      { bg: '#ccfbf1', text: '#134e4a', dot: '#0d9488' },
  Discovery:     { bg: '#e0e7ff', text: '#1e1b4b', dot: '#6366f1' },
  Campaign:      { bg: '#ffe4e6', text: '#881337', dot: '#e11d48' },
}
function getEngineStyle(engine: string) {
  return ENGINE_COLORS[engine] ?? { bg: '#f1f5f9', text: '#334155', dot: '#94a3b8' }
}

/* ─── component ───────────────────────────────────────────────────── */

export const ProductionActivityLogModal: React.FC<ProductionActivityLogModalProps> = ({
  onClose,
}) => {
  const [entries, setEntries] = useState<ProductionActivityEntry[]>([])
  const [search, setSearch]   = useState('')

  const reload = useCallback(() => setEntries(getActivityLog()), [])

  useEffect(() => { reload() }, [reload])

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [onClose])

  const handleClear = () => {
    if (window.confirm('Clear all activity log entries? This cannot be undone.')) {
      clearActivityLog(); reload()
    }
  }

  const filtered = search.trim()
    ? entries.filter(e =>
        e.prodKey.toLowerCase().includes(search.toLowerCase()) ||
        e.governanceEvent.toLowerCase().includes(search.toLowerCase()) ||
        e.engineCategory.toLowerCase().includes(search.toLowerCase())
      )
    : entries

  return (
    <div
      style={{
        position: 'fixed', inset: 0, zIndex: 9999,
        background: 'rgba(0,0,0,0.5)',
        backdropFilter: 'blur(6px)',
        WebkitBackdropFilter: 'blur(6px)',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        padding: '24px',
      }}
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      {/* ── Sheet / Modal card ── */}
      <div
        style={{
          background: '#ffffff',
          borderRadius: '20px',
          width: '100%',
          maxWidth: '860px',
          maxHeight: '88vh',
          display: 'flex',
          flexDirection: 'column',
          boxShadow: '0 32px 80px rgba(0,0,0,0.28), 0 8px 24px rgba(0,0,0,0.12)',
          overflow: 'hidden',
          fontFamily: '-apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", sans-serif',
        }}
      >

        {/* ── Header ── */}
        <div style={{
          padding: '20px 24px 16px',
          borderBottom: '1px solid #f0f0f0',
          display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: '16px',
          flexShrink: 0,
          background: 'linear-gradient(135deg, #0a4f2a 0%, #1a7a40 100%)',
        }}>
          <div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              {/* Icon */}
              <div style={{
                width: '36px', height: '36px', borderRadius: '10px',
                background: 'rgba(255,255,255,0.18)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: '18px', flexShrink: 0,
              }}>📋</div>
              <div>
                <div style={{ fontSize: '17px', fontWeight: '700', color: '#fff', letterSpacing: '-0.3px' }}>
                  Production Activity Log
                </div>
                <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.7)', marginTop: '1px' }}>
                  {entries.length === 0
                    ? 'No entries yet'
                    : `${entries.length} entr${entries.length === 1 ? 'y' : 'ies'} · newest first`}
                </div>
              </div>
            </div>
          </div>

          {/* Close button — iOS-style pill */}
          <button
            type="button"
            onClick={onClose}
            style={{
              width: '28px', height: '28px', borderRadius: '50%',
              background: 'rgba(255,255,255,0.2)',
              border: 'none', cursor: 'pointer',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              color: '#fff', fontSize: '14px', fontWeight: '600',
              flexShrink: 0, marginTop: '4px',
              transition: 'background 0.15s',
            }}
            onMouseEnter={e => (e.currentTarget.style.background = 'rgba(255,255,255,0.35)')}
            onMouseLeave={e => (e.currentTarget.style.background = 'rgba(255,255,255,0.2)')}
            title="Close (Esc)"
          >
            ✕
          </button>
        </div>

        {/* ── Search bar ── */}
        <div style={{
          padding: '12px 24px',
          borderBottom: '1px solid #f0f0f0',
          flexShrink: 0,
          background: '#fafafa',
        }}>
          <div style={{ position: 'relative' }}>
            <span style={{
              position: 'absolute', left: '11px', top: '50%', transform: 'translateY(-50%)',
              fontSize: '14px', color: '#aaa', pointerEvents: 'none',
            }}>🔍</span>
            <input
              type="text"
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Search by key, event or engine…"
              style={{
                width: '100%', boxSizing: 'border-box',
                padding: '8px 12px 8px 34px',
                background: '#fff',
                border: '1.5px solid #e5e7eb',
                borderRadius: '10px',
                fontSize: '13px',
                color: '#1a1a1a',
                outline: 'none',
                fontFamily: 'inherit',
                transition: 'border-color 0.15s',
              }}
              onFocus={e => (e.currentTarget.style.borderColor = '#16a34a')}
              onBlur={e  => (e.currentTarget.style.borderColor = '#e5e7eb')}
            />
            {search && (
              <button
                onClick={() => setSearch('')}
                style={{
                  position: 'absolute', right: '10px', top: '50%', transform: 'translateY(-50%)',
                  background: '#d1d5db', border: 'none', borderRadius: '50%',
                  width: '16px', height: '16px', cursor: 'pointer',
                  fontSize: '9px', color: '#fff', display: 'flex',
                  alignItems: 'center', justifyContent: 'center', padding: 0,
                }}
              >✕</button>
            )}
          </div>
        </div>

        {/* ── Table ── */}
        <div style={{ overflowY: 'auto', flex: 1 }}>
          {filtered.length === 0 ? (
            <div style={{
              display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center',
              minHeight: '200px', gap: '8px',
              color: '#9ca3af', fontFamily: 'inherit',
            }}>
              <div style={{ fontSize: '36px' }}>📭</div>
              <div style={{ fontSize: '15px', fontWeight: '600', color: '#6b7280' }}>
                {search ? 'No matching entries' : 'No activity yet'}
              </div>
              <div style={{ fontSize: '13px', color: '#9ca3af', textAlign: 'center', maxWidth: '280px' }}>
                {search
                  ? 'Try a different search term'
                  : 'Each time a notification is cloned to Production Ready, it will appear here.'}
              </div>
            </div>
          ) : (
            <table style={{
              width: '100%', borderCollapse: 'collapse',
              fontSize: '13px', fontFamily: 'inherit',
            }}>
              {/* Table head */}
              <thead>
                <tr style={{ background: '#f9fafb', borderBottom: '2px solid #e5e7eb', position: 'sticky', top: 0, zIndex: 2 }}>
                  {[
                    { label: '#',                  w: '44px',   align: 'center' as const },
                    { label: 'Date',               w: '110px',  align: 'left'   as const },
                    { label: 'Time',               w: '104px',  align: 'left'   as const },
                    { label: 'Prod Key',           w: '140px',  align: 'left'   as const },
                    { label: 'Event / Notification', w: 'auto', align: 'left'   as const },
                    { label: 'Engine',             w: '130px',  align: 'left'   as const },
                    { label: 'When',               w: '78px',   align: 'right'  as const },
                  ].map(col => (
                    <th key={col.label} style={{
                      padding: '10px 14px',
                      textAlign: col.align,
                      width: col.w,
                      fontWeight: '600',
                      fontSize: '11px',
                      letterSpacing: '0.04em',
                      textTransform: 'uppercase',
                      color: '#6b7280',
                      whiteSpace: 'nowrap',
                      background: '#f9fafb',
                    }}>
                      {col.label}
                    </th>
                  ))}
                </tr>
              </thead>

              <tbody>
                {filtered.map((entry, idx) => {
                  const eng = getEngineStyle(entry.engineCategory)
                  return (
                    <tr
                      key={entry.id}
                      style={{
                        background: idx % 2 === 0 ? '#ffffff' : '#fafafa',
                        borderBottom: '1px solid #f0f0f0',
                        transition: 'background 0.1s',
                      }}
                      onMouseEnter={e => (e.currentTarget.style.background = '#f0fdf4')}
                      onMouseLeave={e => (e.currentTarget.style.background = idx % 2 === 0 ? '#ffffff' : '#fafafa')}
                    >
                      {/* # */}
                      <td style={{ padding: '12px 14px', textAlign: 'center', color: '#d1d5db', fontSize: '12px', fontWeight: '500' }}>
                        {idx + 1}
                      </td>

                      {/* Date */}
                      <td style={{ padding: '12px 14px', whiteSpace: 'nowrap' }}>
                        <span style={{ fontSize: '13px', color: '#374151', fontWeight: '500' }}>
                          {formatDate(entry.timestamp)}
                        </span>
                      </td>

                      {/* Time */}
                      <td style={{ padding: '12px 14px', whiteSpace: 'nowrap' }}>
                        <span style={{
                          fontSize: '12px', color: '#6b7280',
                          fontFamily: '"SF Mono", "Fira Code", monospace',
                          background: '#f3f4f6', borderRadius: '5px',
                          padding: '2px 6px',
                        }}>
                          {formatTime(entry.timestamp)}
                        </span>
                      </td>

                      {/* Prod Key */}
                      <td style={{ padding: '12px 14px', whiteSpace: 'nowrap' }}>
                        <span style={{
                          fontFamily: '"SF Mono", "Fira Code", monospace',
                          fontSize: '12px', fontWeight: '600',
                          color: '#0a3baa',
                          background: '#eff6ff',
                          borderRadius: '6px',
                          padding: '3px 8px',
                          border: '1px solid #bfdbfe',
                        }}>
                          {entry.prodKey}
                        </span>
                      </td>

                      {/* Event */}
                      <td style={{ padding: '12px 14px', maxWidth: '1px' }}>
                        <div style={{
                          display: 'flex', alignItems: 'center', gap: '8px',
                        }}>
                          <span style={{
                            display: 'inline-block', width: '7px', height: '7px',
                            borderRadius: '50%', background: '#16a34a', flexShrink: 0,
                          }} />
                          <span style={{
                            fontSize: '13px', color: '#111827', fontWeight: '500',
                            overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap',
                          }} title={entry.governanceEvent}>
                            {entry.governanceEvent}
                          </span>
                        </div>
                      </td>

                      {/* Engine */}
                      <td style={{ padding: '12px 14px', whiteSpace: 'nowrap' }}>
                        <span style={{
                          display: 'inline-flex', alignItems: 'center', gap: '5px',
                          background: eng.bg, color: eng.text,
                          borderRadius: '20px', padding: '3px 10px',
                          fontSize: '11px', fontWeight: '600',
                        }}>
                          <span style={{ width: '6px', height: '6px', borderRadius: '50%', background: eng.dot, flexShrink: 0 }} />
                          {entry.engineCategory}
                        </span>
                      </td>

                      {/* When */}
                      <td style={{ padding: '12px 14px', textAlign: 'right', whiteSpace: 'nowrap' }}>
                        <span style={{ fontSize: '11px', color: '#9ca3af' }}>
                          {timeAgo(entry.timestamp)}
                        </span>
                      </td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          )}
        </div>

        {/* ── Footer ── */}
        <div style={{
          padding: '14px 24px',
          borderTop: '1px solid #f0f0f0',
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          background: '#fafafa', flexShrink: 0,
        }}>
          <button
            type="button"
            onClick={handleClear}
            disabled={entries.length === 0}
            style={{
              padding: '8px 16px',
              borderRadius: '10px',
              border: entries.length === 0 ? '1.5px solid #e5e7eb' : '1.5px solid #fecaca',
              background: entries.length === 0 ? '#f9fafb' : '#fff1f2',
              color: entries.length === 0 ? '#d1d5db' : '#dc2626',
              fontSize: '13px', fontWeight: '600', cursor: entries.length === 0 ? 'default' : 'pointer',
              fontFamily: 'inherit', transition: 'all 0.15s',
            }}
            onMouseEnter={e => { if (entries.length > 0) e.currentTarget.style.background = '#fee2e2' }}
            onMouseLeave={e => { if (entries.length > 0) e.currentTarget.style.background = '#fff1f2' }}
          >
            🗑 Clear Log
          </button>

          <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
            {search && filtered.length !== entries.length && (
              <span style={{ fontSize: '12px', color: '#6b7280' }}>
                Showing {filtered.length} of {entries.length}
              </span>
            )}
            <button
              type="button"
              onClick={onClose}
              style={{
                padding: '8px 24px',
                borderRadius: '10px',
                border: 'none',
                background: 'linear-gradient(135deg, #0a4f2a 0%, #1a7a40 100%)',
                color: '#fff',
                fontSize: '13px', fontWeight: '600', cursor: 'pointer',
                fontFamily: 'inherit', transition: 'opacity 0.15s',
                boxShadow: '0 2px 8px rgba(10,79,42,0.3)',
              }}
              onMouseEnter={e => (e.currentTarget.style.opacity = '0.9')}
              onMouseLeave={e => (e.currentTarget.style.opacity = '1')}
            >
              Done
            </button>
          </div>
        </div>

      </div>
    </div>
  )
}
