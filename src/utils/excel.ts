import * as XLSX from 'xlsx'
import type { NotificationScenario, ScenarioStatus } from '../types/notification'

export interface ParsedRow {
  governanceEvent: string
  trigger: string
  audience: string
  communicationObjective: string
  desiredOutcome: string
  pushSubject: string
  pushBody: string
  emailSubject?: string
  emailBody?: string
  inAppExperience?: string
  cta?: string
  status?: ScenarioStatus
}

// Convert scenarios to Excel workbook and trigger download
export function exportScenariosToExcel(scenarios: NotificationScenario[], format: 'xlsx' | 'csv' = 'xlsx') {
  const data = scenarios.map((s) => ({
    'Key': s.key,
    'Engine': s.engineCategory || 'Governance',
    'Status': s.status || 'TO DO',
    'Comments': s.comments || '',
    'Event': s.governanceEvent || '',
    'Trigger': s.trigger || '',
    'Audience': s.audience || '',
    'Communication Objective': s.communicationObjective || '',
    'Desired Outcome': s.desiredOutcome || '',
    'Push Notification Subject Line': s.pushSubject || '',
    'Push Notification': s.pushBody || '',
    'Email Subject Line': s.emailSubject || '',
    'Email Message': s.emailBody || '',
    'In-App Experience': s.inAppExperience || '',
    'Call to Action': s.cta || '',
    'Environment': s.environment || 'STAGING',
    'Assignee': s.assignee?.name || 'QA Tester',
    'Last Run': s.lastRunDate || 'Never',
  }))

  const worksheet = XLSX.utils.json_to_sheet(data)

  // Auto-fit column widths
  const colWidths = Object.keys(data[0] || {}).map((key) => ({
    wch: Math.max(key.length + 4, 18),
  }))
  worksheet['!cols'] = colWidths

  const workbook = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(workbook, worksheet, 'Notification Scenarios')

  const fileName = `notification_test_scenarios_${new Date().toISOString().slice(0, 10)}.${format}`
  XLSX.writeFile(workbook, fileName, { bookType: format })
}

// Parse an uploaded file (ArrayBuffer)
export function parseExcelFile(buffer: ArrayBuffer): ParsedRow[] {
  const workbook = XLSX.read(buffer, { type: 'array' })
  const firstSheetName = workbook.SheetNames[0]
  const worksheet = workbook.Sheets[firstSheetName]
  const rawData: Record<string, unknown>[] = XLSX.utils.sheet_to_json(worksheet, { defval: '' })

  return normalizeRawRows(rawData)
}

// Parse clipboard tab-separated text (from copying Google Sheets)
export function parseGoogleSheetsClipboard(text: string): ParsedRow[] {
  const lines = text.trim().split('\n').filter(Boolean)
  if (lines.length === 0) return []

  const headerLine = lines[0]
  const headers = headerLine.split('\t').map((h) => h.trim().toLowerCase())

  // Check if first line has headers or is direct data
  const hasHeaders = headers.some((h) =>
    h.includes('governance') || h.includes('trigger') || h.includes('audience') || h.includes('push')
  )

  const dataLines = hasHeaders ? lines.slice(1) : lines

  return dataLines.map((line) => {
    const cols = line.split('\t').map((c) => c.trim())
    return {
      governanceEvent: cols[0] || 'Untitled Governance Event',
      trigger: cols[1] || 'Default Trigger',
      audience: cols[2] || 'All Users',
      communicationObjective: cols[3] || 'Acknowledge event',
      desiredOutcome: cols[4] || 'User action',
      pushSubject: cols[5] || '',
      pushBody: cols[6] || '',
      emailSubject: cols[7] || '',
      emailBody: cols[8] || '',
      inAppExperience: cols[9] || '',
      cta: cols[10] || 'View Details',
    }
  })
}

// Map raw flexible keys to standardized ParsedRow
function normalizeRawRows(rows: Record<string, unknown>[]): ParsedRow[] {
  return rows.map((row) => {
    const getVal = (possibleKeys: string[]): string => {
      for (const k of Object.keys(row)) {
        const cleaned = k.trim().toLowerCase().replace(/[^a-z0-9]/g, '')
        for (const pk of possibleKeys) {
          if (cleaned.includes(pk)) {
            return String(row[k] ?? '').trim()
          }
        }
      }
      return ''
    }

    return {
      governanceEvent: getVal(['contributionevent', 'contribution', 'governanceevent', 'governance', 'event']) || 'Untitled Event',
      trigger: getVal(['trigger', 'eventtrigger']) || 'Manual Trigger',
      audience: getVal(['audience', 'targetaudience', 'recipient', 'recipients']) || 'All Users',
      communicationObjective: getVal(['communicationobjective', 'objective']) || 'Information',
      desiredOutcome: getVal(['desiredoutcome', 'outcome']) || 'Notification Delivery',
      pushSubject: getVal(['pushnotificationsubjectline', 'pushsubject', 'subjectline']) || '',
      pushBody: getVal(['pushnotification', 'pushbody', 'pushmessage', 'push']) || '',
      emailSubject: getVal(['emailsubjectline', 'emailsubject']) || '',
      emailBody: getVal(['emailmessage', 'emailbody', 'email']) || '',
      inAppExperience: getVal(['inappexperience', 'inapp', 'toast', 'experience']) || '',
      cta: getVal(['calltoaction', 'cta', 'action']) || 'Open App',
    }
  })
}
