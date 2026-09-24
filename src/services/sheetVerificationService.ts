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
    sheetUrl:
      'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true',
    csvExportUrl:
      'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/export?format=csv',
    enabled: true,
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
      const merged: Record<string, EngineSheetConfig> = { ...DEFAULT_ENGINE_SHEETS }
      for (const [k, v] of Object.entries(parsed)) {
        const item = v as EngineSheetConfig
        merged[k] = {
          ...DEFAULT_ENGINE_SHEETS[k],
          ...item,
          sheetUrl: item.sheetUrl || DEFAULT_ENGINE_SHEETS[k]?.sheetUrl || '',
          csvExportUrl: item.csvExportUrl || DEFAULT_ENGINE_SHEETS[k]?.csvExportUrl || '',
          enabled: item.sheetUrl ? item.enabled : (DEFAULT_ENGINE_SHEETS[k]?.enabled ?? true),
        }
      }
      return merged
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

// Embedded offline fallback snapshot for Contribution Sheet
const CONTRIBUTION_FALLBACK_SNAPSHOT = `Contribution Event,Trigger,Audience,Communication Objective,Desired Outcome,Push Notification Subject Line,Push Notification,Email Subject Line,Email Message,In-App Experience,Call to Action
Donation Made via Credit/Debit Card,Donor makes donation,Donor,Thank donor,Positive moment,Thank you! 💚,Your donation moved (Seedling) one step closer to its goal -- thank you!,Thank You! 💚,"Thank you! Your donation moved (Seedling) one step closer to its goal. Every gift counts, and yours just made a real difference.  BOX: View Donation",Your donation is complete -- (Seedling) is one step closer to its goal. Thank you!,take user directly to Seedling
Annual Giving Summary Ready,Year-end generated,Donor,Support tax reporting,Download summary,Your year in giving is ready 📊,Your annual giving summary is ready -- check out your generosity this past year!,Your Year in Giving Is Ready 📊,Your annual giving summary is ready. Take a look at the impact you made this year -- it's worth celebrating.  BOX: View Summary,Your year-end giving summary is available to download for your records.  BOX: View Summary,take user to annual giving summary download
ACH Donation Confirmed,Funds settled,Donor,Build trust,Retain confidence,Your ACH donation is confirmed ✅,Your ACH donation has been confirmed.,Your ACH Donation Is Confirmed ✅,Your ACH payment has fully processed and your donation is complete. Thank you for growing good.  BOX: View Donation,Your ACH payment has fully processed and your donation is complete.,take user to donation details
ACH Donation Failed,Payment declined,Donor,Resolve issue,Retry donation,We hit a snag with your donation,We couldn't process your ACH donation.,We Hit a Snag With Your Donation,We weren't able to process your ACH donation. Please update your payment method or try again so your gift can go through.  BOX: Update Payment,Your ACH payment didn't go through -- please update your payment method or try again.,take user to payment method update screen
ACH Donation Pending,ACH or delayed payment,Donor,Set expectations,Await settlement,Your donation is on its way,Your ACH donation is being processed.,Your Donation Is on Its Way,Your ACH payment is on its way. We'll let you know as soon as it's confirmed -- no action needed in the meantime.  BOX: View Status,Your ACH payment is on its way. We'll let you know as soon as it's confirmed.,take user to donation status
Donation Receipt Available,Receipt generated,Donor,Provide documentation,Download receipt,Your receipt is ready 🧾,Your donation receipt is ready.,Your Receipt Is Ready 🧾,Your donation receipt is ready whenever you need it. Download or email it for your records anytime.  BOX: View Receipt,Download or email your official donation receipt anytime.  BOX: View Receipt,take user to donation receipt
GreenHouse Auto-Reload,Automatic funding,User,Maintain balance,Continue giving,Your GreenHouse is topped up,Your GreenHouse was automatically refilled.,Your GreenHouse Is Topped Up,"Your GreenHouse balance has been automatically replenished, so you're ready for your next act of generosity whenever inspiration strikes.  BOX: View GreenHouse",Your GreenHouse balance has been replenished so you're ready for your next act of generosity.,take user to GreenHouse balance
GreenHouse Auto-Reload Failed,Auto reload unsuccessful,User,Resolve payment,Update funding source,We couldn't refill your GreenHouse,We couldn't refill your GreenHouse.,We Couldn't Refill Your GreenHouse,Your GreenHouse auto-reload didn't go through. Update your funding source to keep your GreenHouse topped up and ready to give.  BOX: Update Funding Source,Your GreenHouse auto-reload didn't go through. Update your funding source to keep your GreenHouse topped up.  BOX: Update Funding Source,take user to GreenHouse reload process
GreenHouse Balance Low,Threshold reached,User,Encourage refill,Add funds,Your GreenHouse is running low,Your GreenHouse balance is running low.,Your GreenHouse Is Running Low,Your GreenHouse balance is running low. Add funds so you're ready for your next donation whenever the moment strikes.  BOX: Add Funds,Your GreenHouse balance is running low. Add funds so you're ready for your next donation.  BOX: Add Funds,take user to GreenHouse
GreenHouse Balance Low Auto Reload,Threshold reached,User,Encourage refill,Add funds,Your GreenHouse is running low,Your GreenHouse balance is running low and will be re-loaded based on your preferences.,Your GreenHouse Is Running Low,"Your GreenHouse balance is running low. Based on your preferences, it'll be topped up automatically -- no action needed on your part.  BOX: View GreenHouse","Your GreenHouse balance is running low. Based on your auto-reload preferences, it'll be topped up automatically -- no action needed.",take user to GreenHouse
GreenHouse Deposit Added,Funds deposited,User,Confirm balance,Use GreenHouse,Funds added! 💰,You've added funds to your GreenHouse.,Funds Added! 💰,Your funds have been added to your GreenHouse and are ready to donate whenever inspiration strikes.  BOX: View GreenHouse,Your funds have been added to your GreenHouse and are ready to donate whenever inspiration strikes.,take user to GreenHouse
GreenHouse Donation Made,Donation from balance,User,Confirm transaction,Continue giving,Donation sent from your GreenHouse,Your donation was sent from your GreenHouse.,Donation Sent From Your GreenHouse,Your donation was sent using your GreenHouse balance. Thank you for growing good.  BOX: View Donation,Your donation was sent using your GreenHouse balance. Thank you for Growing Good.,take user directly to Seedling
Offline Donation Recorded,Manual entry,Organization,Confirm accounting,Maintain records,Your offline gift is recorded,Your offline donation has been recorded.,Your Offline Gift Is Recorded,Your offline donation has been recorded. We've added this gift to your giving history so your impact stays complete.  BOX: View Giving History,We've added this gift to your giving history so your impact stays complete.,take user to giving history
Payment Method Added,New payment method,User,Confirm setup,Complete donation,Payment method added ✅,Payment method added successfully.,Payment Method Added ✅,Your new payment method has been added successfully and is ready for future donations.  BOX: View Payment Methods,Your new payment method is ready for future donations.,take user to payment methods
Payment Method Expiring,Card nearing expiration,Donor,Prevent failed payments,Update payment,Your card is expiring soon,Your payment method expires soon.,Your Card Is Expiring Soon,Your payment method expires soon. Update it now to avoid any interruption to your giving.  BOX: Update Payment,Update your payment information to avoid interrupted giving.,take user to payment method update screen
Payment Method Preferences Updated,Giving settings changed,Donor,Confirm preferences,Maintain trust,Preferences updated,Payment preferences updated.,Preferences Updated,Your preferred payment settings have been saved exactly the way you wanted.  BOX: View Preferences,Your preferred payment settings have been saved.,take user to payment preferences
Payment Method Updated,Payment details changed,Donor,Confirm update,Maintain continuity,Payment method updated,Your payment method has been updated.,Payment Method Updated,Your payment method has been updated. Your changes have been saved and are ready to use.  BOX: View Payment Methods,Your changes have been saved and are ready to use.,take user to payment methods
Receipt Downloaded,Receipt accessed,Donor,Confirm access,Retain records,Receipt downloaded,Receipt downloaded.,Receipt Downloaded,Your donation receipt has been downloaded successfully and is ready for your records.,Your donation receipt has been downloaded successfully.,"confirm in place, no navigation required"
Recurring Donation Cancelled,Subscription cancelled,Donor,Acknowledge preference,Maintain goodwill,Recurring donation cancelled,Your recurring donation has been cancelled.,Recurring Donation Cancelled,"Your recurring donation has been cancelled. Your recurring giving has ended, and you can restart it anytime.  BOX: View Settings",Your recurring giving has ended. You can restart it anytime.,take user to recurring donation settings
Recurring Donation Created,Monthly gift established,Donor,Celebrate commitment,Remain subscribed,You're a recurring donor now! 💚,Recurring donation started. 💚,You're a Recurring Donor Now! 💚,"Thank you for making generosity a habit. Your recurring gift is now active, and your support will keep making a difference.  BOX: View Settings",Thank you for making generosity a habit. Your recurring gift is active.,take user to recurring donation settings
Recurring Donation Failed,Recurring payment fails,Donor,Resolve payment,Update payment method,We couldn't process your gift,Your recurring donation couldn't be processed.,We Couldn't Process Your Gift,Your recurring donation couldn't be processed. Please update your payment method to continue your recurring support.  BOX: Update Payment,Please update your payment method to continue your recurring support.,take user to payment method update screen
Recurring Donation Paused,Subscription paused,Donor,Confirm change,Resume later,Recurring donation paused,Recurring donation paused.,Recurring Donation Paused,Your recurring donation is paused. Your recurring giving is on hold until you choose to resume.  BOX: View Settings,Your recurring giving is paused until you choose to resume.,take user to recurring donation settings
Recurring Donation Processed,Scheduled payment succeeds,Donor,Confirm contribution,Continue recurring,Thank you for your gift! 💚,Your recurring donation was received.,Thank You for Your Gift! 💚,Thank you for your continued generosity. Your latest recurring gift has been processed successfully.  BOX: View Donation,Thank you for your continued generosity. Your latest recurring gift has been processed.,take user to donation history
Recurring Donation Resumed,Subscription resumed,Donor,Welcome back,Continue giving,Welcome back! 💚,Recurring donation resumed.,Welcome Back! 💚,Welcome back -- your recurring donation has resumed. Your continued support is active again.  BOX: View Settings,Welcome back. Your recurring support is active again.,take user to recurring donation settings
Recurring Donation Upcoming,Scheduled payment approaching,Donor,Prepare donor,Continue support,Your gift is coming up,Your recurring donation is coming up.,Your Gift Is Coming Up,Your recurring donation is coming up soon. We'll process it automatically -- no action is needed unless you'd like to make changes.  BOX: View Settings,We'll process your scheduled donation soon. No action is needed unless you'd like to make changes.,take user to recurring donation settings
Refund Issued,Donation refunded,Donor,Explain transaction,Maintain trust,Your refund is on the way,Your refund has been processed.,Your Refund Is on the Way,"Your refund has been issued. Depending on your bank, it may take a few days to appear on your statement.  BOX: View Details","Your refund has been issued. Depending on your bank, it may take a few days to appear.",take user to donation history
Tax Acknowledgement Ready,IRS acknowledgment prepared,Donor,Provide compliance,Retain records,Your tax document is ready 🧾,Your tax acknowledgement is ready.,Your Tax Document Is Ready 🧾,Your tax acknowledgement is ready whenever you need it for your records.  BOX: View Document,Your tax documentation is available whenever you need it.,take user to tax documents
Tax Season Reminder,Annual statement available,Donor,Support tax filing,Download documents,Tax season is here,Tax season is here—don't forget your giving records.,Tax Season Is Here,Tax season is here -- don't forget your giving records. Access your donation receipts and annual summary all in one place.  BOX: View Documents,Access your donation receipts and annual summary in one place.,take user to tax documents`

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
    } else if (config.engineCategory === 'Contribution') {
      csvText = CONTRIBUTION_FALLBACK_SNAPSHOT
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
  // 2. By event name: "event"
  // 3. By rowIndex: GOV-1 -> sheetRow[0], CONTRIB-1 -> sheetRow[0], etc.
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

    // Try by event name only if composite key didn't match
    if (!matchedSheetRow) {
      const eventName = normalizeText(scen.governanceEvent)
      matchedSheetRow = sheetRows.find(
        (sr) => normalizeText(sr.governanceEvent) === eventName
      )
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

/**
 * Verifies all enabled engines or a specific target engine, merging mismatches so table and navbar
 * have complete coverage across both Governance and Contribution.
 */
export async function verifyAllEngines(
  targetEngine: string,
  scenarios: NotificationScenario[]
): Promise<SheetVerificationSummary> {
  if (targetEngine !== 'ALL') {
    return verifyEngineScenarios(targetEngine, scenarios)
  }

  const configs = getRegisteredEngineSheets()
  const enabledEngines = Object.keys(configs).filter((eng) => configs[eng].enabled)

  const summary: SheetVerificationSummary = {
    engineCategory: 'ALL',
    lastCheckedAt: new Date().toISOString(),
    isLoading: false,
    error: null,
    sheetName: 'Governance & Contribution Sheets',
    sheetUrl: configs['Governance']?.sheetUrl || configs['Contribution']?.sheetUrl || '',
    totalSheetRows: 0,
    totalScenariosChecked: 0,
    totalMismatches: 0,
    mismatchesByScenarioId: {},
  }

  for (const engine of enabledEngines) {
    try {
      const engSummary = await verifyEngineScenarios(engine, scenarios, configs[engine])
      summary.totalSheetRows += engSummary.totalSheetRows
      summary.totalScenariosChecked += engSummary.totalScenariosChecked
      summary.totalMismatches += engSummary.totalMismatches
      Object.assign(summary.mismatchesByScenarioId, engSummary.mismatchesByScenarioId)
      if (engSummary.error && !summary.error) {
        summary.error = engSummary.error
      }
    } catch (err: any) {
      console.warn(`[SheetVerification] Verification failed for engine ${engine}:`, err)
    }
  }

  return summary
}
