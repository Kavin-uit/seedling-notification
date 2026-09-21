import type {
  NotificationScenario,
  ScenarioVersion,
  FieldChange,
  FieldVersionRecord,
} from '../types/notification'

export const FIELD_LABELS: Record<string, string> = {
  governanceEvent: 'Event Name',
  trigger: 'Trigger',
  audience: 'Audience',
  communicationObjective: 'Communication Objective',
  desiredOutcome: 'Desired Outcome',
  pushSubject: 'Push Subject Line',
  pushBody: 'Push Notification',
  emailSubject: 'Email Subject Line',
  emailBody: 'Email Message',
  inAppExperience: 'In-App Experience',
  cta: 'Call to Action',
  comments: 'Comments',
  notes: 'Extra Info',
  status: 'Status',
  engineCategory: 'Engine Category',
  priority: 'Priority',
  environment: 'Environment',
}

export const TRACKED_FIELDS = [
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
  'comments',
  'notes',
  'status',
  'engineCategory',
  'priority',
  'environment',
] as const

export function createSnapshot(scenario: NotificationScenario): ScenarioVersion['snapshot'] {
  return {
    governanceEvent: scenario.governanceEvent || '',
    trigger: scenario.trigger || '',
    audience: scenario.audience || '',
    communicationObjective: scenario.communicationObjective || '',
    desiredOutcome: scenario.desiredOutcome || '',
    pushSubject: scenario.pushSubject || '',
    pushBody: scenario.pushBody || '',
    emailSubject: scenario.emailSubject || '',
    emailBody: scenario.emailBody || '',
    inAppExperience: scenario.inAppExperience || '',
    cta: scenario.cta || '',
    comments: scenario.comments || '',
    notes: scenario.notes || '',
    status: scenario.status || 'TO DO',
    engineCategory: scenario.engineCategory || 'Governance',
    priority: scenario.priority || 'Medium',
    environment: scenario.environment || 'STAGING',
  }
}

/**
 * Record an update to a scenario, appending to version history (capped at 10 items)
 * and updating per-field history (each capped at 10 items).
 */
export function recordScenarioUpdate(
  current: NotificationScenario,
  updated: NotificationScenario,
  customSummary?: string
): NotificationScenario {
  const now = new Date().toISOString()
  const changes: FieldChange[] = []

  // Check each tracked field
  TRACKED_FIELDS.forEach((field) => {
    const oldVal = (current[field as keyof NotificationScenario] ?? '') as string
    const newVal = (updated[field as keyof NotificationScenario] ?? '') as string
    if (oldVal !== newVal) {
      changes.push({
        field,
        label: FIELD_LABELS[field] || field,
        oldValue: oldVal,
        newValue: newVal,
      })
    }
  })

  // If nothing changed, return current unchanged
  if (changes.length === 0 && !customSummary) {
    return current
  }

  // Generate a human-readable summary
  const summary =
    customSummary ||
    (changes.length === 1
      ? `Updated ${changes[0].label}`
      : changes.length > 1
      ? `Updated ${changes.map((c) => c.label).slice(0, 3).join(', ')}${changes.length > 3 ? '...' : ''}`
      : 'Updated scenario')

  // Build new version entry representing previous snapshot before this update
  const newVersion: ScenarioVersion = {
    versionId: `v-${Date.now()}-${Math.random().toString(36).slice(2, 6)}`,
    timestamp: current.updatedAt || now,
    summary,
    changes,
    snapshot: createSnapshot(current),
  }

  // Prepend to version history, cap at last 10 versions
  const existingHistory = current.versionHistory || []
  const updatedVersionHistory = [newVersion, ...existingHistory].slice(0, 10)

  // Update per-field history (last 10 values for each field)
  const existingFieldHistory: Record<string, FieldVersionRecord[]> = {
    ...(current.fieldHistory || {}),
  }

  changes.forEach((c) => {
    const fieldRecords = existingFieldHistory[c.field] || []
    const newRecord: FieldVersionRecord = {
      versionId: newVersion.versionId,
      timestamp: current.updatedAt || now,
      value: c.oldValue,
    }
    existingFieldHistory[c.field] = [newRecord, ...fieldRecords].slice(0, 10)
  })

  return {
    ...updated,
    updatedAt: now,
    versionHistory: updatedVersionHistory,
    fieldHistory: existingFieldHistory,
  }
}

/**
 * Rollback full row to target version's snapshot
 */
export function rollbackToVersion(
  current: NotificationScenario,
  targetVersion: ScenarioVersion
): NotificationScenario {
  const now = new Date().toISOString()
  const snapshot = targetVersion.snapshot

  const rolledBack: NotificationScenario = {
    ...current,
    governanceEvent: snapshot.governanceEvent,
    trigger: snapshot.trigger,
    audience: snapshot.audience,
    communicationObjective: snapshot.communicationObjective,
    desiredOutcome: snapshot.desiredOutcome,
    pushSubject: snapshot.pushSubject,
    pushBody: snapshot.pushBody,
    emailSubject: snapshot.emailSubject,
    emailBody: snapshot.emailBody,
    inAppExperience: snapshot.inAppExperience,
    cta: snapshot.cta,
    comments: snapshot.comments,
    status: snapshot.status,
    engineCategory: snapshot.engineCategory,
    priority: snapshot.priority,
    environment: snapshot.environment,
    updatedAt: now,
  }

  return recordScenarioUpdate(
    current,
    rolledBack,
    `Rolled back to version from ${formatRelativeTime(targetVersion.timestamp)}`
  )
}

/**
 * Rollback a specific field to previous value from field history
 */
export function rollbackFieldToVersion(
  current: NotificationScenario,
  fieldKey: string,
  targetValue: string,
  targetTimestamp: string
): NotificationScenario {
  const label = FIELD_LABELS[fieldKey] || fieldKey
  const rolledBack: NotificationScenario = {
    ...current,
    [fieldKey]: targetValue,
    updatedAt: new Date().toISOString(),
  }

  return recordScenarioUpdate(
    current,
    rolledBack,
    `Restored ${label} from ${formatRelativeTime(targetTimestamp)}`
  )
}

/**
 * Format ISO timestamp into clean human-readable date & time
 */
export function formatDateTime(isoString?: string): string {
  if (!isoString) return 'Never'
  try {
    const d = new Date(isoString)
    if (isNaN(d.getTime())) return isoString
    return d.toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: true,
    })
  } catch {
    return isoString
  }
}

/**
 * Format relative time ("Just now", "2m ago", "1h ago", etc.)
 */
export function formatRelativeTime(isoString?: string): string {
  if (!isoString) return 'Just now'
  try {
    const diffMs = Date.now() - new Date(isoString).getTime()
    if (diffMs < 0) return 'Just now'
    const secs = Math.floor(diffMs / 1000)
    if (secs < 30) return 'Just now'
    if (secs < 60) return `${secs}s ago`
    const mins = Math.floor(secs / 60)
    if (mins < 60) return `${mins}m ago`
    const hours = Math.floor(mins / 60)
    if (hours < 24) return `${hours}h ago`
    const days = Math.floor(hours / 24)
    if (days < 30) return `${days}d ago`
    return formatDateTime(isoString)
  } catch {
    return 'Recently'
  }
}
