export type ScenarioStatus =
  | 'TO DO'
  | 'TESTED'
  | 'NOT WORKING'
  | 'IN-APP NAVIGATION NOT WORKING'
  | 'NAVIGATION NOT WORKING'
  | 'PUSH NOTIFICATION NOT WORKING'
  | 'PUSH NOTIFICATION NAVIGATION NOT WORKING'
  | 'EMAIL NOTIFICATION NOT WORKING'
  | 'EMAIL NOTIFICATION NAVIGATION NOT WORKING'
  | 'SMS NOTIFICATION NOT WORKING'
  | 'HIDE'
  | (string & {})

export function parseStatuses(statusStr?: string): ScenarioStatus[] {
  if (!statusStr) return ['TO DO']
  const parts = statusStr
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean)
  return parts.length > 0 ? (parts as ScenarioStatus[]) : ['TO DO']
}

export function serializeStatuses(statuses: ScenarioStatus[]): string {
  if (!statuses || statuses.length === 0) return 'TO DO'
  return Array.from(new Set(statuses)).join(', ')
}

export type PriorityLevel = 'Highest' | 'High' | 'Medium' | 'Low' | 'Medium-Low' | 'User initiated' | (string & {})

export type Environment = 'DEV' | 'STAGING' | 'PROD'

export interface TestLog {
  id: string
  timestamp: string
  status: 'PASSED' | 'FAILED' | 'INFO'
  stage: string
  message: string
  payload?: Record<string, unknown>
}

export interface FieldChange {
  field: string
  label: string
  oldValue: string
  newValue: string
}

export interface ScenarioVersion {
  versionId: string
  timestamp: string // ISO timestamp of the update
  summary: string   // e.g., "Updated Comments", "Status: TESTED -> NOT WORKING"
  changes: FieldChange[]
  snapshot: {
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
    comments?: string
    notes?: string
    status: ScenarioStatus
    engineCategory: string
    priority: PriorityLevel
    environment: Environment
  }
}

export interface FieldVersionRecord {
  versionId: string
  timestamp: string
  value: string
}

export interface NotificationScenario {
  id: string
  key: string // e.g., 'GOV-1' or 'CONTRIB-1'
  engineCategory: string
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
  comments?: string
  status: ScenarioStatus
  priority: PriorityLevel
  environment: Environment
  assignee: {
    name: string
    email: string
    avatar: string
  }
  lastRunDate?: string
  lastRunDurationMs?: number
  testLogs?: TestLog[]
  notes?: string
  createdAt: string
  updatedAt: string
  versionHistory?: ScenarioVersion[]
  fieldHistory?: Record<string, FieldVersionRecord[]>
  attachmentsCount?: number
  ruleId?: string
  rule?: NotificationRule
}

export interface NotificationRule {
  ruleId: string
  engine: string
  ruleName: string
  trigger: string
  audience: string
  communicationObjective: string
  priority: string
  delivery: string
  channelTier: string
  emailDeliveryPolicy: string
  cooldown: string
  suppression: string
  sourceWorkbook: string
  attentionClass: string
  candidateScore: string
  guaranteedExperience: string
  batchEligible: string
  runtimeMemoryDependency: string
  attentionQueueGroup: string
  rotationGroup: string
  timing: string
  mergePolicy: string
  defaultDecisionReason: string
  experienceType: string
  memoryKeys: string
  decisionReasonTemplate: string
  candidateAudiences: string
  candidateExperiences: string
  templateId: string
  changeNotes: string
  scenarioId?: string
  createdAt?: string
  updatedAt?: string
}

export type AttachmentTag = 'screenshot' | 'push' | 'email' | 'in_app' | 'defect' | 'general'

export interface ScenarioAttachment {
  id: string
  scenarioId: string
  fileName: string
  fileType: string
  fileSize: number
  r2Key: string
  publicUrl: string
  tag: AttachmentTag
  createdAt: string
}

export type ActiveView = 'table' | 'board' | 'simulator' | 'metrics'

export type ProductionStatus =
  | 'READY FOR PROD'
  | 'LIVE IN PROD'
  | 'STAGING VERIFIED'
  | 'PENDING REVIEW'
  | 'DEPLOYED'
  | (string & {})

export interface ProductionNotification extends NotificationScenario {
  originalScenarioId?: string
  clonedAt?: string
}
