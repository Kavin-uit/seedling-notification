import type {
  NotificationScenario,
  ScenarioStatus,
  PriorityLevel,
  Environment,
} from '../types/notification'

export const VALID_STATUSES: ScenarioStatus[] = [
  'TO DO',
  'TESTED',
  'NOT WORKING',
  'NAVIGATION NOT WORKING',
  'PUSH NOTIFICATION NOT WORKING',
  'EMAIL NOTIFICATION NOT WORKING',
  'SMS NOTIFICATION NOT WORKING',
]

export const VALID_ENGINES = ['Governance', 'Contribution'] as const

export const VALID_PRIORITIES: PriorityLevel[] = ['Highest', 'High', 'Medium', 'Low']

export const VALID_ENVIRONMENTS: Environment[] = ['DEV', 'STAGING', 'PROD']

/**
 * Normalizes priority input into strict PriorityLevel enum
 */
export function normalizePriority(rawPriority?: string): PriorityLevel | null {
  if (!rawPriority) return null
  const clean = rawPriority.trim().toLowerCase()
  if (clean.includes('highest') || clean.includes('critical') || clean.includes('blocker')) return 'Highest'
  if (clean.includes('high') || clean.includes('major')) return 'High'
  if (clean.includes('low') || clean.includes('minor') || clean.includes('trivial')) return 'Low'
  if (clean.includes('med') || clean.includes('normal')) return 'Medium'
  return null
}

/**
 * Normalizes environment input into strict Environment enum
 */
export function normalizeEnvironment(rawEnv?: string): Environment | null {
  if (!rawEnv) return null
  const clean = rawEnv.trim().toUpperCase()
  if (clean.includes('PROD')) return 'PROD'
  if (clean.includes('STAGE') || clean.includes('STAGING')) return 'STAGING'
  if (clean.includes('DEV')) return 'DEV'
  return null
}

/**
 * Normalizes any status input from AI into a strict valid ScenarioStatus
 */
export function normalizeStatus(rawStatus?: string): ScenarioStatus | null {
  if (!rawStatus) return null
  const clean = rawStatus.trim().toUpperCase()

  // Exact match
  if (VALID_STATUSES.includes(clean as ScenarioStatus)) {
    return clean as ScenarioStatus
  }

  // Smart aliases
  if (clean === 'PASSED' || clean === 'PASS' || clean === 'VERIFIED' || clean === 'WORKING' || clean === 'COMPLETED') {
    return 'TESTED'
  }
  if (clean.includes('NAV')) {
    return 'NAVIGATION NOT WORKING'
  }
  if (clean.includes('PUSH') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('ISSUE') || clean.includes('DEFECT') || clean.includes('BUG'))) {
    return 'PUSH NOTIFICATION NOT WORKING'
  }
  if (clean.includes('EMAIL') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('ISSUE') || clean.includes('DEFECT') || clean.includes('BUG'))) {
    return 'EMAIL NOTIFICATION NOT WORKING'
  }
  if (clean.includes('SMS') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('ISSUE') || clean.includes('DEFECT') || clean.includes('BUG'))) {
    return 'SMS NOTIFICATION NOT WORKING'
  }
  if (clean.includes('FAIL') || clean.includes('DEFECT') || clean.includes('BUG') || clean === 'NOT WORKING') {
    return 'NOT WORKING'
  }
  if (clean === 'TODO' || clean === 'TO-DO' || clean === 'OPEN' || clean === 'PENDING') {
    return 'TO DO'
  }

  return null
}

/**
 * Normalizes engine category
 */
export function normalizeEngine(rawEngine?: string): 'Governance' | 'Contribution' {
  if (!rawEngine) return 'Contribution'
  const clean = rawEngine.trim().toLowerCase()
  if (clean.includes('gov')) return 'Governance'
  return 'Contribution'
}

/**
 * Validates and safely extracts only valid changed fields for an UPDATE operation.
 * Guarantees that untouched fields are NEVER overwritten or corrupted.
 */
export function validateAndSanitizeUpdate(
  existing: NotificationScenario,
  changes: Partial<NotificationScenario>
): {
  sanitizedScenario: NotificationScenario
  appliedFieldCount: number
  diffs: { field: string; oldVal: string; newVal: string }[]
} {
  const diffs: { field: string; oldVal: string; newVal: string }[] = []
  const result: NotificationScenario = { ...existing }

  // 1. Status field validation
  if (changes.status !== undefined) {
    const validStatus = normalizeStatus(changes.status)
    if (validStatus && validStatus !== existing.status) {
      diffs.push({ field: 'status', oldVal: existing.status, newVal: validStatus })
      result.status = validStatus
    }
  }

  // 2. Engine category validation
  if (changes.engineCategory !== undefined) {
    const validEngine = normalizeEngine(changes.engineCategory)
    if (validEngine !== existing.engineCategory) {
      diffs.push({ field: 'engineCategory', oldVal: existing.engineCategory, newVal: validEngine })
      result.engineCategory = validEngine
    }
  }

  // 3. Priority validation
  if (changes.priority !== undefined) {
    const validPriority = normalizePriority(changes.priority)
    if (validPriority && validPriority !== existing.priority) {
      diffs.push({ field: 'priority', oldVal: existing.priority, newVal: validPriority })
      result.priority = validPriority
    }
  }

  // 4. Environment validation
  if (changes.environment !== undefined) {
    const validEnv = normalizeEnvironment(changes.environment)
    if (validEnv && validEnv !== existing.environment) {
      diffs.push({ field: 'environment', oldVal: existing.environment, newVal: validEnv })
      result.environment = validEnv
    }
  }

  // 5. String content fields validation: only apply if non-empty and actually different!
  const contentKeys: (keyof NotificationScenario)[] = [
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
  ]

  for (const key of contentKeys) {
    const incomingVal = changes[key]
    if (incomingVal !== undefined && incomingVal !== null) {
      const cleanVal = String(incomingVal).trim()
      // Only update if incoming is non-empty and different from current value
      // (Protects against AI sending blank "" or hallucinated empty fields)
      if (cleanVal.length > 0 && cleanVal !== (existing[key] || '')) {
        diffs.push({
          field: key,
          oldVal: String(existing[key] || ''),
          newVal: cleanVal,
        })
        ;(result as any)[key] = cleanVal
      }
    }
  }

  result.updatedAt = new Date().toISOString()

  return {
    sanitizedScenario: result,
    appliedFieldCount: diffs.length,
    diffs,
  }
}

/**
 * Validates and safely formats a new scenario for INSERT.
 * Guarantees no key collisions, correct sequential numbering, and clean sanitized fields.
 */
export function validateAndSanitizeInsert(
  raw: Partial<NotificationScenario>,
  allScenarios: NotificationScenario[],
  indexOffset: number = 0
): NotificationScenario {
  const engineCategory = normalizeEngine(raw.engineCategory)
  const prefix = engineCategory === 'Governance' ? 'GOV' : 'CONTRIB'

  // Calculate highest existing number for this prefix
  const existingNums = allScenarios
    .filter((s) => s.engineCategory === engineCategory)
    .map((s) => {
      const match = s.key.match(new RegExp(`${prefix}-(\\d+)`))
      return match ? parseInt(match[1], 10) : 0
    })

  const maxNum = existingNums.length > 0 ? Math.max(...existingNums) : 0
  const sequentialNum = maxNum + 1 + indexOffset
  const uniqueKey = `${prefix}-${sequentialNum}`

  const now = new Date().toISOString()
  const validStatus = normalizeStatus(raw.status) || 'TO DO'
  const validPriority = normalizePriority(raw.priority) || 'Medium'
  const validEnvironment = normalizeEnvironment(raw.environment) || 'STAGING'

  return {
    id: `${prefix.toLowerCase()}-${Date.now()}-${Math.floor(Math.random() * 1000) + indexOffset}`,
    key: uniqueKey,
    engineCategory,
    governanceEvent: (raw.governanceEvent || raw.trigger || 'New Notification Scenario').trim(),
    trigger: (raw.trigger || '').trim(),
    audience: (raw.audience || (engineCategory === 'Contribution' ? 'Donor' : 'Community Member')).trim(),
    communicationObjective: (raw.communicationObjective || '').trim(),
    desiredOutcome: (raw.desiredOutcome || '').trim(),
    pushSubject: (raw.pushSubject || '').trim(),
    pushBody: (raw.pushBody || '').trim(),
    emailSubject: (raw.emailSubject || '').trim(),
    emailBody: (raw.emailBody || '').trim(),
    inAppExperience: (raw.inAppExperience || '').trim(),
    cta: (raw.cta || 'View Details').trim(),
    comments: (raw.comments || '').trim(),
    status: validStatus,
    priority: validPriority,
    environment: validEnvironment,
    assignee: {
      name: 'Google Gemini',
      email: 'gemini@google.com',
      avatar: '',
    },
    createdAt: now,
    updatedAt: now,
    versionHistory: [],
    fieldHistory: {},
  }
}
