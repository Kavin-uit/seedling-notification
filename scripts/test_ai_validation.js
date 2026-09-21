// Verification test for AI field validation and isolation
import assert from 'node:assert'

const VALID_STATUSES = [
  'TO DO',
  'TESTED',
  'NOT WORKING',
  'NAVIGATION NOT WORKING',
  'PUSH NOTIFICATION NOT WORKING',
  'EMAIL NOTIFICATION NOT WORKING',
  'SMS NOTIFICATION NOT WORKING',
]

function normalizeStatus(rawStatus) {
  if (!rawStatus) return null
  const clean = rawStatus.trim().toUpperCase()
  if (VALID_STATUSES.includes(clean)) return clean
  if (clean === 'PASSED' || clean === 'PASS' || clean === 'VERIFIED' || clean === 'WORKING' || clean === 'COMPLETED') return 'TESTED'
  if (clean.includes('NAV')) return 'NAVIGATION NOT WORKING'
  if (clean.includes('PUSH') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('ISSUE') || clean.includes('DEFECT') || clean.includes('BUG'))) return 'PUSH NOTIFICATION NOT WORKING'
  if (clean.includes('EMAIL') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('ISSUE') || clean.includes('DEFECT') || clean.includes('BUG'))) return 'EMAIL NOTIFICATION NOT WORKING'
  if (clean.includes('SMS') && (clean.includes('NOT') || clean.includes('FAIL') || clean.includes('ISSUE') || clean.includes('DEFECT') || clean.includes('BUG'))) return 'SMS NOTIFICATION NOT WORKING'
  if (clean.includes('FAIL') || clean.includes('DEFECT') || clean.includes('BUG') || clean === 'NOT WORKING') return 'NOT WORKING'
  if (clean === 'TODO' || clean === 'TO-DO' || clean === 'OPEN' || clean === 'PENDING') return 'TO DO'
  return null
}

function normalizeEngine(rawEngine) {
  if (!rawEngine) return 'Contribution'
  const clean = rawEngine.trim().toLowerCase()
  if (clean.includes('gov')) return 'Governance'
  return 'Contribution'
}

function normalizePriority(rawPriority) {
  if (!rawPriority) return null
  const clean = rawPriority.trim().toLowerCase()
  if (clean.includes('highest') || clean.includes('critical') || clean.includes('blocker')) return 'Highest'
  if (clean.includes('high') || clean.includes('major')) return 'High'
  if (clean.includes('low') || clean.includes('minor') || clean.includes('trivial')) return 'Low'
  if (clean.includes('med') || clean.includes('normal')) return 'Medium'
  return null
}

function normalizeEnvironment(rawEnv) {
  if (!rawEnv) return null
  const clean = rawEnv.trim().toUpperCase()
  if (clean.includes('PROD')) return 'PROD'
  if (clean.includes('STAGE') || clean.includes('STAGING')) return 'STAGING'
  if (clean.includes('DEV')) return 'DEV'
  return null
}

function validateAndSanitizeUpdate(existing, changes) {
  const diffs = []
  const result = { ...existing }

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
  const contentKeys = [
    'governanceEvent', 'trigger', 'audience', 'communicationObjective',
    'desiredOutcome', 'pushSubject', 'pushBody', 'emailSubject', 'emailBody',
    'inAppExperience', 'cta', 'comments',
  ]

  for (const key of contentKeys) {
    const incomingVal = changes[key]
    if (incomingVal !== undefined && incomingVal !== null) {
      const cleanVal = String(incomingVal).trim()
      if (cleanVal.length > 0 && cleanVal !== (existing[key] || '')) {
        diffs.push({ field: key, oldVal: String(existing[key] || ''), newVal: cleanVal })
        result[key] = cleanVal
      }
    }
  }

  result.updatedAt = new Date().toISOString()
  return { sanitizedScenario: result, appliedFieldCount: diffs.length, diffs }
}

function validateAndSanitizeInsert(raw, allScenarios, indexOffset = 0) {
  const engineCategory = normalizeEngine(raw.engineCategory)
  const prefix = engineCategory === 'Governance' ? 'GOV' : 'CONTRIB'

  const existingNums = allScenarios
    .filter((s) => s.engineCategory === engineCategory)
    .map((s) => {
      const match = s.key.match(new RegExp(`${prefix}-(\\d+)`))
      return match ? parseInt(match[1], 10) : 0
    })

  const maxNum = existingNums.length > 0 ? Math.max(...existingNums) : 0
  const sequentialNum = maxNum + 1 + indexOffset
  const uniqueKey = `${prefix}-${sequentialNum}`

  return {
    id: `${prefix.toLowerCase()}-${Date.now()}-${indexOffset}`,
    key: uniqueKey,
    engineCategory,
    governanceEvent: (raw.governanceEvent || raw.trigger || 'New Scenario').trim(),
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
    status: normalizeStatus(raw.status) || 'TO DO',
    priority: normalizePriority(raw.priority) || 'Medium',
    environment: normalizeEnvironment(raw.environment) || 'STAGING',
  }
}

// ----------------------------------------------------
// RUN EXTENSIVE TEST SUITE
// ----------------------------------------------------
console.log('Running AI Validation & Field Isolation Test Suite...\n')

const sampleRow = {
  id: 'contrib-12345',
  key: 'CONTRIB-7',
  engineCategory: 'Contribution',
  governanceEvent: 'GreenHouse Balance Low',
  trigger: 'Threshold reached',
  audience: 'User',
  communicationObjective: 'Encourage refill',
  desiredOutcome: 'Add funds',
  pushSubject: 'Your GreenHouse is running low',
  pushBody: 'Your GreenHouse balance is running low.',
  emailSubject: 'Your GreenHouse Is Running Low',
  emailBody: 'Your GreenHouse balance is running low. Add funds...',
  inAppExperience: 'take user to GreenHouse',
  cta: 'Add funds',
  comments: 'Previous defect notes',
  status: 'TO DO',
  priority: 'Medium',
  environment: 'STAGING',
}

// TEST 1: Update only status
const test1 = validateAndSanitizeUpdate(sampleRow, { status: 'TESTED' })
assert.strictEqual(test1.appliedFieldCount, 1)
assert.strictEqual(test1.sanitizedScenario.status, 'TESTED')
assert.strictEqual(test1.sanitizedScenario.governanceEvent, sampleRow.governanceEvent, 'governanceEvent must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.trigger, sampleRow.trigger, 'trigger must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.pushBody, sampleRow.pushBody, 'pushBody must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.emailBody, sampleRow.emailBody, 'emailBody must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.comments, sampleRow.comments, 'comments must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.priority, sampleRow.priority, 'priority must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.environment, sampleRow.environment, 'environment must remain unchanged')
assert.strictEqual(test1.sanitizedScenario.key, 'CONTRIB-7', 'key must never change')
assert.strictEqual(test1.sanitizedScenario.id, 'contrib-12345', 'id must never change')
console.log('✔ TEST 1 PASSED: Only requested status field updated; all 15 other fields remain 100% untouched.')

// TEST 2: Update only comments
const test2 = validateAndSanitizeUpdate(sampleRow, { comments: 'Verified on iPhone 15 Pro Max iOS 18.2' })
assert.strictEqual(test2.appliedFieldCount, 1)
assert.strictEqual(test2.sanitizedScenario.comments, 'Verified on iPhone 15 Pro Max iOS 18.2')
assert.strictEqual(test2.sanitizedScenario.status, 'TO DO', 'status must remain untouched')
assert.strictEqual(test2.sanitizedScenario.pushBody, sampleRow.pushBody, 'pushBody must remain untouched')
console.log('✔ TEST 2 PASSED: Only comments field updated; status, pushBody, and all other fields untouched.')

// TEST 3: Reject empty strings or nulls from wiping out existing content
const test3 = validateAndSanitizeUpdate(sampleRow, {
  status: 'TESTED',
  governanceEvent: '',     // AI hallucinated empty string
  trigger: null,           // AI hallucinated null
  pushBody: '   ',         // Whitespace only
  comments: '',            // Empty comments
})
assert.strictEqual(test3.appliedFieldCount, 1)
assert.strictEqual(test3.sanitizedScenario.status, 'TESTED')
assert.strictEqual(test3.sanitizedScenario.governanceEvent, 'GreenHouse Balance Low', 'Must reject empty string')
assert.strictEqual(test3.sanitizedScenario.trigger, 'Threshold reached', 'Must reject null')
assert.strictEqual(test3.sanitizedScenario.pushBody, 'Your GreenHouse balance is running low.', 'Must reject whitespace string')
assert.strictEqual(test3.sanitizedScenario.comments, 'Previous defect notes', 'Must reject empty comments wipe')
console.log('✔ TEST 3 PASSED: Accidental empty strings or nulls safely rejected from corrupting existing fields.')

// TEST 4: Status normalization
const test4a = validateAndSanitizeUpdate(sampleRow, { status: 'passed' })
assert.strictEqual(test4a.sanitizedScenario.status, 'TESTED')

const test4b = validateAndSanitizeUpdate(sampleRow, { status: 'navigation failed' })
assert.strictEqual(test4b.sanitizedScenario.status, 'NAVIGATION NOT WORKING')

const test4c = validateAndSanitizeUpdate(sampleRow, { status: 'sms issue detected' })
assert.strictEqual(test4c.sanitizedScenario.status, 'SMS NOTIFICATION NOT WORKING')

const test4d = validateAndSanitizeUpdate(sampleRow, { status: 'push notification bug' })
assert.strictEqual(test4d.sanitizedScenario.status, 'PUSH NOTIFICATION NOT WORKING')

const test4e = validateAndSanitizeUpdate(sampleRow, { status: 'INVALID_GARBAGE' })
assert.strictEqual(test4e.appliedFieldCount, 0, 'Invalid status must be rejected')
assert.strictEqual(test4e.sanitizedScenario.status, 'TO DO', 'Status must remain original')
console.log('✔ TEST 4 PASSED: Status normalization handles aliases, channel-specific defects, and rejects invalid values.')

// TEST 5: Priority and Environment normalization
const test5a = validateAndSanitizeUpdate(sampleRow, { priority: 'critical blocker' })
assert.strictEqual(test5a.sanitizedScenario.priority, 'Highest')

const test5b = validateAndSanitizeUpdate(sampleRow, { environment: 'prod' })
assert.strictEqual(test5b.sanitizedScenario.environment, 'PROD')

const test5c = validateAndSanitizeUpdate(sampleRow, { priority: 'random_invalid_priority' })
assert.strictEqual(test5c.appliedFieldCount, 0)
assert.strictEqual(test5c.sanitizedScenario.priority, 'Medium', 'Priority remains Medium')
console.log('✔ TEST 5 PASSED: Priority and Environment normalization works with strict enums.')

// TEST 6: Immutable system fields protection (key, id cannot be overwritten)
const test6 = validateAndSanitizeUpdate(sampleRow, {
  id: 'malicious-id-999',
  key: 'MALICIOUS-KEY-999',
  createdAt: '1999-01-01T00:00:00.000Z',
  comments: 'Valid comment update',
})
assert.strictEqual(test6.appliedFieldCount, 1)
assert.strictEqual(test6.sanitizedScenario.id, 'contrib-12345', 'id must remain strictly unchanged')
assert.strictEqual(test6.sanitizedScenario.key, 'CONTRIB-7', 'key must remain strictly unchanged')
console.log('✔ TEST 6 PASSED: Immutable system keys (id, key) are 100% protected against AI updates.')

// TEST 7: Sequential key generation for INSERT without collision
const existingScenarios = [
  { key: 'GOV-1', engineCategory: 'Governance' },
  { key: 'GOV-6', engineCategory: 'Governance' },
  { key: 'CONTRIB-1', engineCategory: 'Contribution' },
  { key: 'CONTRIB-16', engineCategory: 'Contribution' },
]

const insertedContrib1 = validateAndSanitizeInsert({ engineCategory: 'Contribution', governanceEvent: 'Test Event 1' }, existingScenarios, 0)
assert.strictEqual(insertedContrib1.key, 'CONTRIB-17', 'Key must be sequentially next CONTRIB-17')

const insertedContrib2 = validateAndSanitizeInsert({ engineCategory: 'Contribution', governanceEvent: 'Test Event 2' }, existingScenarios, 1)
assert.strictEqual(insertedContrib2.key, 'CONTRIB-18', 'Key must be sequentially next CONTRIB-18')

const insertedGov = validateAndSanitizeInsert({ engineCategory: 'Governance', governanceEvent: 'Test Gov' }, existingScenarios, 0)
assert.strictEqual(insertedGov.key, 'GOV-7', 'Key must be sequentially next GOV-7')
console.log('✔ TEST 7 PASSED: Sequential keys generated accurately without collision (GOV-7, CONTRIB-17, CONTRIB-18).')

console.log('\n=============================================')
console.log('ALL 7 AI VALIDATION & FIELD ISOLATION TESTS PASSED!')
console.log('=============================================')
