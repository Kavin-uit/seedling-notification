/// <reference types="@cloudflare/workers-types" />
// Cloudflare Pages Functions Type Definitions and D1 Helpers

export interface Env {
  DB?: D1Database
  R2_ACCOUNT_ID?: string
  R2_ACCESS_KEY_ID?: string
  R2_SECRET_ACCESS_KEY?: string
  R2_BUCKET_NAME?: string
  R2_PUBLIC_DOMAIN?: string
}

export const R2_CONFIG = {
  accountId: 'a614d103e9114f8883a5322cfd98d455',
  accessKeyId: '5b79be10f134282c662280ab1f406514',
  secretAccessKey: '0340288da916337f5a2a0e7e70945aa1116695c06016c9b04b24c71cde89e564',
  bucketName: 'notificationi-app',
  publicDomain: 'https://pub-7d358ff00159439bbcbf5f0181f928ed.r2.dev',
}

export function getR2Config(env: Env) {
  return {
    accountId: env.R2_ACCOUNT_ID || R2_CONFIG.accountId,
    accessKeyId: env.R2_ACCESS_KEY_ID || R2_CONFIG.accessKeyId,
    secretAccessKey: env.R2_SECRET_ACCESS_KEY || R2_CONFIG.secretAccessKey,
    bucketName: env.R2_BUCKET_NAME || R2_CONFIG.bucketName,
    publicDomain: (env.R2_PUBLIC_DOMAIN || R2_CONFIG.publicDomain).replace(/\/+$/, ''),
  }
}

export interface ScenarioAttachmentDbRow {
  id: string
  scenario_id: string
  file_name: string
  file_type: string
  file_size: number
  r2_key: string
  public_url: string
  tag: string
  created_at: string
}

export function mapDbRowToAttachment(row: ScenarioAttachmentDbRow) {
  return {
    id: row.id,
    scenarioId: row.scenario_id,
    fileName: row.file_name,
    fileType: row.file_type,
    fileSize: row.file_size,
    r2Key: row.r2_key,
    publicUrl: row.public_url,
    tag: row.tag || 'screenshot',
    createdAt: row.created_at,
  }
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
  notes?: string
  status: string
  priority: string
  environment: string
  created_at: string
  updated_at: string
}

export interface EngineSheetDbRow {
  engine_category: string
  sheet_name: string
  sheet_url: string
  csv_export_url: string
  enabled: number
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
    engineCategory: row.engine_category || 'Governance',
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
    notes: row.notes || '',
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
