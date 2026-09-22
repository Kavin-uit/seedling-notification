export type ScenarioStatus =
  | 'TO DO'
  | 'TESTED'
  | 'NOT WORKING'
  | 'IN-APP NAVIGATION NOT WORKING'
  | 'NAVIGATION NOT WORKING'
  | 'PUSH NOTIFICATION NOT WORKING'
  | 'EMAIL NOTIFICATION NOT WORKING'
  | 'SMS NOTIFICATION NOT WORKING'

export type PriorityLevel = 'Highest' | 'High' | 'Medium' | 'Low'

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
    engineCategory: 'Governance' | 'Contribution'
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
  engineCategory: 'Governance' | 'Contribution'
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
}

export type ActiveView = 'table' | 'board' | 'simulator' | 'metrics'

