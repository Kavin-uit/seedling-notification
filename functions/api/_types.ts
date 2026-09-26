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
  rule_id?: string
  created_at: string
  updated_at: string
}

export interface NotificationRuleDbRow {
  rule_id: string
  engine: string
  rule_name: string
  trigger?: string
  audience?: string
  communication_objective?: string
  priority?: string
  delivery?: string
  channel_tier?: string
  email_delivery_policy?: string
  cooldown?: string
  suppression?: string
  source_workbook?: string
  attention_class?: string
  candidate_score?: string
  guaranteed_experience?: string
  batch_eligible?: string
  runtime_memory_dependency?: string
  attention_queue_group?: string
  rotation_group?: string
  timing?: string
  merge_policy?: string
  default_decision_reason?: string
  experience_type?: string
  memory_keys?: string
  decision_reason_template?: string
  candidate_audiences?: string
  candidate_experiences?: string
  template_id?: string
  change_notes?: string
  scenario_id?: string
  created_at?: string
  updated_at?: string
}

export function mapDbRowToRule(row: NotificationRuleDbRow) {
  return {
    ruleId: row.rule_id,
    engine: row.engine,
    ruleName: row.rule_name,
    trigger: row.trigger || '',
    audience: row.audience || '',
    communicationObjective: row.communication_objective || '',
    priority: row.priority || 'Medium',
    delivery: row.delivery || '',
    channelTier: row.channel_tier || '',
    emailDeliveryPolicy: row.email_delivery_policy || '',
    cooldown: row.cooldown || '',
    suppression: row.suppression || '',
    sourceWorkbook: row.source_workbook || '',
    attentionClass: row.attention_class || '',
    candidateScore: row.candidate_score || '',
    guaranteedExperience: row.guaranteed_experience || '',
    batchEligible: row.batch_eligible || '',
    runtimeMemoryDependency: row.runtime_memory_dependency || '',
    attentionQueueGroup: row.attention_queue_group || '',
    rotationGroup: row.rotation_group || '',
    timing: row.timing || '',
    mergePolicy: row.merge_policy || '',
    defaultDecisionReason: row.default_decision_reason || '',
    experienceType: row.experience_type || '',
    memoryKeys: row.memory_keys || '',
    decisionReasonTemplate: row.decision_reason_template || '',
    candidateAudiences: row.candidate_audiences || '',
    candidateExperiences: row.candidate_experiences || '',
    templateId: row.template_id || '',
    changeNotes: row.change_notes || '',
    scenarioId: row.scenario_id || '',
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  }
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

export function mapDbRowToScenario(row: ScenarioDbRow, rule?: any) {
  const validRule = rule && typeof rule === 'object' && 'ruleId' in rule ? rule : undefined
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
    ruleId: row.rule_id || '',
    rule: validRule,
    assignee: {
      name: 'QA Tester',
      email: 'tester@seedling.org',
      avatar: '',
    },
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  }
}
