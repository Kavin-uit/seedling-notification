/**
 * Dynamic Sheet Verification Service
 * Verifies live scenario data against reference Google Sheets on every page refresh/load.
 * Designed to support multiple engines (Governance, Contribution, etc.) extensible by configuration.
 */

import type { NotificationScenario } from '../types/notification'

export type EditableField =
  | 'governanceEvent'
  | 'trigger'
  | 'audience'
  | 'communicationObjective'
  | 'desiredOutcome'
  | 'pushSubject'
  | 'pushBody'
  | 'emailSubject'
  | 'emailBody'
  | 'inAppExperience'
  | 'cta'

export interface EngineSheetConfig {
  engineCategory: string
  sheetName: string
  sheetUrl: string
  csvExportUrl: string
  enabled: boolean
}

export interface FieldMismatch {
  fieldName: EditableField
  fieldLabel: string
  expected: string
  actual: string
}

export interface SheetScenarioRow {
  governanceEvent: string
  trigger: string
  audience: string
  communicationObjective: string
  desiredOutcome: string
  pushSubject: string
  pushBody: string
  emailSubject: string
  emailBody: string
  inAppExperience: string
  cta: string
  rowIndex: number
}

export interface SheetVerificationSummary {
  engineCategory: string
  lastCheckedAt: string
  isLoading: boolean
  error?: string | null
  sheetName: string
  sheetUrl: string
  totalSheetRows: number
  totalScenariosChecked: number
  totalMismatches: number
  // scenarioId -> { fieldName -> FieldMismatch }
  mismatchesByScenarioId: Record<string, Record<string, FieldMismatch>>
}

// Field human labels
export const FIELD_LABELS: Record<EditableField, string> = {
  governanceEvent: 'Governance Event',
  trigger: 'Trigger',
  audience: 'Audience',
  communicationObjective: 'Communication Objective',
  desiredOutcome: 'Desired Outcome',
  pushSubject: 'Push Notification Subject Line',
  pushBody: 'Push Notification',
  emailSubject: 'Email Subject Line',
  emailBody: 'Email Message',
  inAppExperience: 'In-App Experience',
  cta: 'Call to Action',
}

// Default Registered Sheets per Engine (Extensible for future engines)
export const DEFAULT_ENGINE_SHEETS: Record<string, EngineSheetConfig> = {
  Governance: {
    engineCategory: 'Governance',
    sheetName: 'Governance Content Sheet',
    sheetUrl:
      'https://docs.google.com/spreadsheets/d/1WQP9fY_pMUqZG28TX8gGSDL2vtb58ZAP/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true',
    csvExportUrl:
      'https://docs.google.com/spreadsheets/d/1WQP9fY_pMUqZG28TX8gGSDL2vtb58ZAP/export?format=csv',
    enabled: true,
  },
  Contribution: {
    engineCategory: 'Contribution',
    sheetName: 'Contribution Content Sheet',
    sheetUrl: '',
    csvExportUrl: '',
    enabled: false,
  },
}

// Helper to convert Google Sheets edit/sharing URL to CSV export URL
export function convertToCsvExportUrl(url: string): string {
  if (!url || !url.trim()) return ''
  const trimmed = url.trim()
  if (trimmed.includes('/export?format=csv')) return trimmed

  const match = trimmed.match(/\/spreadsheets\/d\/([a-zA-Z0-9-_]+)/)
  if (match && match[1]) {
    return `https://docs.google.com/spreadsheets/d/${match[1]}/export?format=csv`
  }
  return trimmed
}

// Load registered sheet configs from localStorage or defaults
export function getRegisteredEngineSheets(): Record<string, EngineSheetConfig> {
  try {
    const saved = localStorage.getItem('seedling_engine_sheets_v1')
    if (saved) {
      const parsed = JSON.parse(saved)
      return { ...DEFAULT_ENGINE_SHEETS, ...parsed }
    }
  } catch {
    // Ignore storage error
  }
  return { ...DEFAULT_ENGINE_SHEETS }
}

export function saveRegisteredEngineSheets(configs: Record<string, EngineSheetConfig>): void {
  try {
    localStorage.setItem('seedling_engine_sheets_v1', JSON.stringify(configs))
  } catch {
    // Ignore storage error
  }
}

/**
 * Standard RFC-4180 compliant CSV parser
 * Correctly handles quotes, escaped quotes (""), embedded newlines and commas
 */
export function parseCsv(text: string): string[][] {
  const rows: string[][] = []
  let currentRow: string[] = []
  let currentField = ''
  let inQuotes = false
  let i = 0
  const len = text.length

  while (i < len) {
    const char = text[i]

    if (inQuotes) {
      if (char === '"') {
        if (i + 1 < len && text[i + 1] === '"') {
          // Escaped quote: ""
          currentField += '"'
          i += 2
          continue
        } else {
          // Closing quote
          inQuotes = false
          i++
          continue
        }
      } else {
        currentField += char
        i++
        continue
      }
    } else {
      if (char === '"') {
        inQuotes = true
        i++
        continue
      } else if (char === ',') {
        currentRow.push(currentField)
        currentField = ''
        i++
        continue
      } else if (char === '\r') {
        if (i + 1 < len && text[i + 1] === '\n') {
          i++
        }
        currentRow.push(currentField)
        currentField = ''
        rows.push(currentRow)
        currentRow = []
        i++
        continue
      } else if (char === '\n') {
        currentRow.push(currentField)
        currentField = ''
        rows.push(currentRow)
        currentRow = []
        i++
        continue
      } else {
        currentField += char
        i++
        continue
      }
    }
  }

  if (currentField.length > 0 || currentRow.length > 0) {
    currentRow.push(currentField)
    rows.push(currentRow)
  }

  return rows
}

// Normalize strings for comparison (collapses spacing and carriage returns)
export function normalizeText(val?: string | null): string {
  if (!val) return ''
  return val
    .replace(/\r\n/g, '\n')
    .replace(/\r/g, '\n')
    .split('\n')
    .map((line) => line.trim().replace(/\s+/g, ' '))
    .join('\n')
    .trim()
}

// Embedded offline fallback snapshot for Governance Sheet
const GOVERNANCE_FALLBACK_SNAPSHOT = `Governance Event,Trigger,Audience,Communication Objective,Desired Outcome,Push Notification Subject Line,Push Notification,Email Subject Line,Email Message,In-App Experience,Call to Action
Seedling Submitted for Review,Seedling Submitted ,"Sponsor, Co-Sponsors",Acknowledge submission,Review Seedling,Your Seedling is in review,Your Seedling is in Review,Your Seedling Is in Review,"Thanks for submitting your Seedling! Our team is reviewing it now, and we'll let you know as soon as it's ready to go live.  BOX: View Status",Thanks! Your Seedling has been submitted for review -- once we have completed our review we'll let you know!,take user to Seedling review status
Seedling Approved,Seedling Approved,"Sponsor, Co-Sponsors",Acknowledge Acceptance,Post Seedling,You're live! 🎉,Congratulations -- your Seedling is Live!,You're Live! 🎉,"Great news -- your Seedling has been approved and is now live on Seedling. Now's the time to start sharing it with your community and inviting support.  BOX: Share Your Seedling",Your Seedling has been approved and is now live on Seedling. Time to start sharing it with your community.  BOX: Share,take user directly to Seedling
Seedling Rejected,Seedling Rejected,"Sponsor, Co-Sponsors",Explain decision,Modify Seedling,Your Seedling needs a change,We couldn't publish your Seedling -- Here's why,Your Seedling Needs a Change,"We weren't able to publish your Seedling because it doesn't currently meet our community guidelines. Review the reason we've provided, make the needed changes, and reach out to support if you have questions.  BOX: Edit Seedling",Your Seedling doesn't meet our community guidelines. Review the reason provided and contact support if you have questions.,take user to Seedling edit screen with rejection reason
Comment Reported,Comment Flagged by user,Reporter,Acknowledge report,Review Comment,Thanks for the report,Thank you for reporting a Seedling comment,Thanks for the Report,"Thanks for helping keep Seedling welcoming. We'll review the comment you reported, and if it merits removal, we'll take care of it.","Thanks for helping keep Seedling welcoming. We'll review the reported comment and if it merits removal we will do so.",confirm in place, no navigation required
Comment Removed,Comment Removed,Commenter,Notify author,Comment removed,A comment was removed,One of your comments has been removed.,A Comment Was Removed,One of your comments has been removed because it violated our Community Guidelines. Take a look at our guidelines if you have questions.  BOX: View Guidelines,We removed one of your comments because it violated our Community Guidelines.,take user to Community Guidelines
Comment Removed,Comment Removed,Reporter,Close the loop on report,Confirm resolution,Update on your report,Thanks for helping keep Seedling welcoming.,Update on Your Report,Thanks for helping keep Seedling welcoming. The comment you reported has been removed for violating our Community Guidelines.,The comment you reported has been removed for violating our Community Guidelines.,confirm in place, no navigation required
Account Warning,Offending activity,Commenter,Policy warning,Warning,A notice about your account,Important notice about your account.,A Notice About Your Account,Your recent activity may violate our Community Guidelines. Please take a moment to review our policies so your account stays in good standing.  BOX: View Guidelines,Your recent activity may violate our Community Guidelines. Please review our policies.,take user to Community Guidelines
Temporary Account Restriction,Offending issue,Commenter,Notify restriction,Restricted use,Your account is temporarily restricted,Your account has been temporarily restricted.,Your Account Is Temporarily Restricted,Your account has been temporarily restricted while we review recent activity. Some features will be unavailable in the meantime.  BOX: View Account Status,Some account features are temporarily unavailable while we review your account.,take user to account status page
Account Restored,Account reinstated,Commenter,Notify restoration,Full use,Welcome back! ✅,Your account has been restored.,Welcome Back! ✅,Thank you for your patience -- your account has been restored and is fully active again. We're glad to have you back.  BOX: View Account,Thank you for your patience. Your account is fully active again.,take user to account settings`

/**
 * Fetch and parse a Google Sheet given an engine configuration
 */
export async function fetchSheetData(config: EngineSheetConfig): Promise<SheetScenarioRow[]> {
  if (!config.csvExportUrl) {
    return []
  }

  let csvText = ''
  try {
    const response = await fetch(config.csvExportUrl, {
      method: 'GET',
      headers: {
        Accept: 'text/csv,text/plain,*/*',
      },
    })
    if (!response.ok) {
      throw new Error(`HTTP ${response.status} when fetching sheet CSV`)
    }
    csvText = await response.text()
  } catch (err) {
    console.warn(`[SheetVerification] Direct fetch failed for ${config.engineCategory}:`, err)
    if (config.engineCategory === 'Governance') {
      csvText = GOVERNANCE_FALLBACK_SNAPSHOT
    } else {
      throw err
    }
  }

  const parsedRows = parseCsv(csvText)
  if (parsedRows.length <= 1) {
    return []
  }

  // Skip header row
  const dataRows = parsedRows.slice(1)
  return dataRows
    .filter((r) => r.some((c) => c.trim().length > 0))
    .map((cols, idx) => ({
      governanceEvent: cols[0]?.trim() || '',
      trigger: cols[1]?.trim() || '',
      audience: cols[2]?.trim() || '',
      communicationObjective: cols[3]?.trim() || '',
      desiredOutcome: cols[4]?.trim() || '',
      pushSubject: cols[5]?.trim() || '',
      pushBody: cols[6]?.trim() || '',
      emailSubject: cols[7]?.trim() || '',
      emailBody: cols[8]?.trim() || '',
      inAppExperience: cols[9]?.trim() || '',
      cta: cols[10]?.trim() || '',
      rowIndex: idx + 1,
    }))
}

const COMPARABLE_FIELDS: EditableField[] = [
  'governanceEvent',
  'trigger',
  'audience',
  'communicationObjective',
  'desiredOutcome',
  'pushSubject',
  'pushBody',
  'emailSubject',
  'emailBody',
  'inAppExperience',
  'cta',
]

/**
 * Verify scenarios of a given engine category against its Google Sheet
 */
export async function verifyEngineScenarios(
  engineCategory: string,
  scenarios: NotificationScenario[],
  configOverride?: EngineSheetConfig
): Promise<SheetVerificationSummary> {
  const configs = getRegisteredEngineSheets()
  const config = configOverride || configs[engineCategory]

  const summary: SheetVerificationSummary = {
    engineCategory,
    lastCheckedAt: new Date().toISOString(),
    isLoading: false,
    error: null,
    sheetName: config?.sheetName || `${engineCategory} Sheet`,
    sheetUrl: config?.sheetUrl || '',
    totalSheetRows: 0,
    totalScenariosChecked: 0,
    totalMismatches: 0,
    mismatchesByScenarioId: {},
  }

  if (!config || !config.enabled || !config.csvExportUrl) {
    return summary
  }

  let sheetRows: SheetScenarioRow[] = []
  try {
    sheetRows = await fetchSheetData(config)
    summary.totalSheetRows = sheetRows.length
  } catch (err: any) {
    summary.error = err.message || 'Failed to load Google Sheet'
    return summary
  }

  // Target scenarios for this engine
  const targetScenarios = scenarios.filter((s) => s.engineCategory === engineCategory)
  summary.totalScenariosChecked = targetScenarios.length

  // Build lookup index from sheet rows
  // 1. By composite key: "event:::audience"
  // 2. By rowIndex: GOV-1 -> sheetRow[0], GOV-2 -> sheetRow[1], etc.
  const compositeMap = new Map<string, SheetScenarioRow>()
  const usedSheetRowIndices = new Set<number>()

  sheetRows.forEach((sr) => {
    const key = `${normalizeText(sr.governanceEvent)}:::${normalizeText(sr.audience)}`
    compositeMap.set(key, sr)
  })

  targetScenarios.forEach((scen) => {
    let matchedSheetRow: SheetScenarioRow | undefined

    // Try composite match first
    const compKey = `${normalizeText(scen.governanceEvent)}:::${normalizeText(scen.audience)}`
    if (compositeMap.has(compKey)) {
      matchedSheetRow = compositeMap.get(compKey)
    }

    // Try key numeric index match if not found (e.g. GOV-1 -> row 0)
    if (!matchedSheetRow) {
      const numMatch = scen.key.match(/\d+/)
      if (numMatch) {
        const idx = parseInt(numMatch[0], 10) - 1
        if (idx >= 0 && idx < sheetRows.length) {
          matchedSheetRow = sheetRows[idx]
        }
      }
    }

    if (!matchedSheetRow) {
      return
    }

    usedSheetRowIndices.add(matchedSheetRow.rowIndex)

    // Compare all fields
    const scenarioMismatches: Record<EditableField, FieldMismatch> = {} as any
    let hasAnyMismatch = false

    for (const field of COMPARABLE_FIELDS) {
      const sheetVal = matchedSheetRow[field]
      const actualVal = (scen as any)[field] || ''

      const normSheet = normalizeText(sheetVal)
      const normActual = normalizeText(actualVal)

      if (normSheet !== normActual) {
        hasAnyMismatch = true
        summary.totalMismatches++
        scenarioMismatches[field] = {
          fieldName: field,
          fieldLabel: FIELD_LABELS[field],
          expected: sheetVal,
          actual: actualVal,
        }
      }
    }

    if (hasAnyMismatch) {
      summary.mismatchesByScenarioId[scen.id] = scenarioMismatches
    }
  })

  return summary
}
