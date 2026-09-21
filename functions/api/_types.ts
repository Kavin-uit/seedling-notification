// Cloudflare Pages Functions Type Definitions and D1 Helpers

export interface Env {
  DB?: D1Database
}

export interface ScenarioDbRow {
  id: string
  key: string
  engine_category: string
  governance_event: string
  trigger: string
  audience: string
  communication_objective: string
  desired_outcome: string
  push_subject: string
  push_body: string
  email_subject: string
  email_body: string
  in_app_experience: string
  cta: string
  comments?: string
  status: string
  priority: string
  environment: string
  created_at: string
  updated_at: string
}

export function jsonResponse(data: unknown, status = 200, headers: HeadersInit = {}): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
      ...headers,
    },
  })
}

export function mapDbRowToScenario(row: ScenarioDbRow) {
  return {
    id: row.id,
    key: row.key,
    engineCategory: (row.engine_category || 'Governance') as 'Governance' | 'Contribution',
    governanceEvent: row.governance_event,
    trigger: row.trigger || '',
    audience: row.audience || '',
    communicationObjective: row.communication_objective || '',
    desiredOutcome: row.desired_outcome || '',
    pushSubject: row.push_subject || '',
    pushBody: row.push_body || '',
    emailSubject: row.email_subject || '',
    emailBody: row.email_body || '',
    inAppExperience: row.in_app_experience || '',
    cta: row.cta || '',
    comments: row.comments || '',
    status: row.status || 'TO DO',
    priority: row.priority || 'Medium',
    environment: row.environment || 'STAGING',
    assignee: {
      name: 'QA Tester',
      email: 'tester@seedling.org',
      avatar: '',
    },
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  }
}
