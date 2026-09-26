import type { NotificationScenario } from '../types/notification'

// Common English stop words to ignore in AI mode when longer query is given
const STOP_WORDS = new Set([
  'a', 'an', 'the', 'and', 'or', 'in', 'on', 'at', 'to', 'for', 'with', 'by', 'from', 'of', 'is', 'it', 'as', 'be', 'this', 'that'
])

// Semantic synonym map for financial / notification / governance domain
const SYNONYM_MAP: Record<string, string[]> = {
  donate: ['donation', 'donations', 'donor', 'giving', 'contribute', 'contribution'],
  donation: ['donate', 'donations', 'donor', 'giving', 'contribute', 'contribution', 'funds'],
  donor: ['donation', 'contributor', 'sponsor', 'user'],
  contribute: ['contribution', 'giving', 'donation', 'donate', 'greenhouse'],
  contribution: ['contribute', 'donation', 'giving', 'greenhouse', 'fund', 'deposit'],
  fail: ['failed', 'failure', 'declined', 'decline', 'unsuccessful', 'snag', 'error'],
  failed: ['fail', 'failure', 'declined', 'decline', 'unsuccessful', 'snag', 'error'],
  decline: ['declined', 'failed', 'fail', 'rejected', 'unsuccessful'],
  reject: ['rejected', 'rejection', 'declined', 'disapproved', 'denied'],
  rejected: ['reject', 'rejection', 'declined', 'disapproved', 'denied'],
  approve: ['approved', 'approval', 'accepted', 'live', 'passed', 'confirmed'],
  approved: ['approve', 'approval', 'accepted', 'live', 'passed', 'confirmed'],
  pass: ['passed', 'approved', 'success', 'confirmed', 'settled'],
  passed: ['pass', 'approved', 'success', 'confirmed', 'settled'],
  comment: ['commenter', 'comments', 'flag', 'flagged', 'report', 'reported', 'removed'],
  reported: ['report', 'flagged', 'flag', 'comment', 'review'],
  remove: ['removed', 'deleted', 'take down', 'moderated'],
  removed: ['remove', 'deleted', 'take down', 'moderated'],
  review: ['reviewed', 'submission', 'submitted', 'proposal', 'inspect'],
  submitted: ['submission', 'submit', 'review', 'proposal', 'seedling'],
  seedling: ['seedlings', 'proposal', 'submission', 'project', 'governance'],
  pay: ['payment', 'paying', 'card', 'credit', 'debit', 'ach', 'transaction'],
  payment: ['pay', 'card', 'credit', 'debit', 'ach', 'transaction', 'settled'],
  card: ['credit', 'debit', 'payment', 'card nearing expiration', 'visa', 'mastercard'],
  ach: ['bank', 'wire', 'settled', 'funds settled', 'transfer'],
  reload: ['auto-reload', 'reload', 'deposit', 'funding', 'refill', 'balance'],
  balance: ['funds', 'greenhouse', 'reload', 'deposit', 'money'],
  push: ['notification', 'alert', 'message', 'prompt'],
  email: ['mail', 'inbox', 'subject', 'message'],
  tested: ['test', 'testing', 'verified', 'passed'],
  todo: ['to do', 'pending', 'open'],
}

// Levenshtein distance for typo tolerance with early threshold cutoff & memory reuse
function levenshteinDistance(s1: string, s2: string, maxAllowed = 2): number {
  if (s1 === s2) return 0
  const l1 = s1.length
  const l2 = s2.length
  if (Math.abs(l1 - l2) > maxAllowed) return maxAllowed + 1
  if (l1 === 0) return l2
  if (l2 === 0) return l1

  let prev = new Int32Array(l2 + 1)
  let curr = new Int32Array(l2 + 1)

  for (let j = 0; j <= l2; j++) prev[j] = j

  for (let i = 1; i <= l1; i++) {
    curr[0] = i
    let minInRow = i
    const ch1 = s1.charCodeAt(i - 1)
    for (let j = 1; j <= l2; j++) {
      const cost = ch1 === s2.charCodeAt(j - 1) ? 0 : 1
      const val = Math.min(
        prev[j] + 1,
        curr[j - 1] + 1,
        prev[j - 1] + cost
      )
      curr[j] = val
      if (val < minInRow) minInRow = val
    }
    if (minInRow > maxAllowed) return maxAllowed + 1
    const tmp = prev
    prev = curr
    curr = tmp
  }
  return prev[l2]
}

// Check if two words are fuzzy match (typo tolerant within 1-2 edits depending on word length)
function isFuzzyMatch(w1: string, w2: string): boolean {
  if (w1 === w2) return true
  if (w1.includes(w2) || w2.includes(w1)) return true
  const maxLen = Math.max(w1.length, w2.length)
  if (maxLen <= 3) return false
  const allowedDist = maxLen >= 7 ? 2 : 1
  if (Math.abs(w1.length - w2.length) > allowedDist) return false
  return levenshteinDistance(w1, w2, allowedDist) <= allowedDist
}

// WeakMap cache for structured scenario text representations
interface ScenarioTextData {
  map: Record<string, string>
  fullText: string
  words: string[]
}

const scenarioTextCache = new WeakMap<NotificationScenario, ScenarioTextData>()

function getScenarioTextData(s: NotificationScenario): ScenarioTextData {
  let cached = scenarioTextCache.get(s)
  if (!cached) {
    const map = {
      key: s.key.toLowerCase(),
      engine: (s.engineCategory || '').toLowerCase(),
      event: (s.governanceEvent || '').toLowerCase(),
      trigger: (s.trigger || '').toLowerCase(),
      audience: (s.audience || '').toLowerCase(),
      objective: (s.communicationObjective || '').toLowerCase(),
      outcome: (s.desiredOutcome || '').toLowerCase(),
      pushSubject: (s.pushSubject || '').toLowerCase(),
      pushBody: (s.pushBody || '').toLowerCase(),
      emailSubject: (s.emailSubject || '').toLowerCase(),
      emailBody: (s.emailBody || '').toLowerCase(),
      inApp: (s.inAppExperience || '').toLowerCase(),
      cta: (s.cta || '').toLowerCase(),
      comments: (s.comments || '').toLowerCase(),
      status: (s.status || '').toLowerCase(),
    }
    const fullText = Object.values(map).join(' ')
    const words = fullText.split(/\W+/).filter(Boolean)
    cached = { map, fullText, words }
    scenarioTextCache.set(s, cached)
  }
  return cached
}

export interface AiSearchResult {
  scenario: NotificationScenario
  score: number
  matchedTerms: Set<string>
}

/**
 * Advanced AI Search & Normal Search Engine:
 * - Normal: case-insensitive multi-word substring match
 * - AI: tokenized multi-word search, stop-word reduction, semantic synonym expansions, typo-tolerant fuzzy matching, and relevance ranking.
 */
export function executeSearch(
  scenarios: NotificationScenario[],
  query: string,
  isAiMode: boolean
): { results: NotificationScenario[]; matchedTerms: Set<string> } {
  const trimmed = query.trim()
  if (!trimmed) {
    return { results: scenarios, matchedTerms: new Set() }
  }

  // --- 1. NORMAL SEARCH ---
  if (!isAiMode) {
    const rawTokens = trimmed
      .toLowerCase()
      .split(/\s+/)
      .filter((t) => t.length > 0)

    const matchedTerms = new Set(rawTokens)
    matchedTerms.add(trimmed.toLowerCase())

    const filtered = scenarios.filter((s) => {
      const { fullText } = getScenarioTextData(s)
      // Match if exact query phrase is found or every typed token is found across fields
      return (
        fullText.includes(trimmed.toLowerCase()) ||
        rawTokens.every((token) => fullText.includes(token))
      )
    })

    return { results: filtered, matchedTerms }
  }

  // --- 2. ADVANCED AI SEARCH ---
  const rawTokens = trimmed
    .toLowerCase()
    .replace(/[^\w\s-]/g, ' ')
    .split(/\s+/)
    .filter((t) => t.length > 0)

  // Keep meaningful tokens; if all were stop words, keep all
  const tokens =
    rawTokens.filter((t) => !STOP_WORDS.has(t)).length > 0
      ? rawTokens.filter((t) => !STOP_WORDS.has(t))
      : rawTokens

  // Expand tokens with semantic synonyms
  const expandedTerms = new Map<string, string[]>()
  tokens.forEach((tok) => {
    const expansions: string[] = [tok]
    // Check direct synonyms
    if (SYNONYM_MAP[tok]) {
      expansions.push(...SYNONYM_MAP[tok])
    }
    // Check partial key matches in synonym map
    for (const [key, syns] of Object.entries(SYNONYM_MAP)) {
      if (tok.startsWith(key) || key.startsWith(tok)) {
        expansions.push(key, ...syns)
      }
    }
    expandedTerms.set(tok, Array.from(new Set(expansions)))
  })

  const allHighlightTerms = new Set<string>()
  allHighlightTerms.add(trimmed.toLowerCase())
  tokens.forEach((t) => {
    if (t.length >= 3 && !STOP_WORDS.has(t)) allHighlightTerms.add(t)
  })
  expandedTerms.forEach((syns) => {
    syns.forEach((s) => {
      if (s.length >= 3 && !STOP_WORDS.has(s)) allHighlightTerms.add(s)
    })
  })

  const scored: AiSearchResult[] = []

  for (const scenario of scenarios) {
    const { map: textMap, fullText, words: wordsInRow } = getScenarioTextData(scenario)

    let score = 0
    const matchedForThisRow = new Set<string>()

    // Full phrase exact match gets huge boost
    if (fullText.includes(trimmed.toLowerCase())) {
      score += 150
    }

    // Check each search token & its synonym cluster against the row
    for (const [token, synonyms] of expandedTerms.entries()) {
      let tokenMatched = false

      // 1. Direct field match (high weight for key, event, trigger, outcome)
      if (textMap.event.includes(token)) {
        score += 40
        tokenMatched = true
        matchedForThisRow.add(token)
      }
      if (textMap.trigger.includes(token)) {
        score += 30
        tokenMatched = true
        matchedForThisRow.add(token)
      }
      if (textMap.pushSubject.includes(token) || textMap.emailSubject.includes(token)) {
        score += 25
        tokenMatched = true
        matchedForThisRow.add(token)
      }
      if (textMap.pushBody.includes(token) || textMap.emailBody.includes(token)) {
        score += 20
        tokenMatched = true
        matchedForThisRow.add(token)
      }
      if (textMap.audience.includes(token) || textMap.engine.includes(token) || textMap.cta.includes(token)) {
        score += 15
        tokenMatched = true
        matchedForThisRow.add(token)
      }

      // 2. Semantic Synonyms match
      for (const syn of synonyms) {
        if (syn !== token && fullText.includes(syn)) {
          score += 18
          tokenMatched = true
          matchedForThisRow.add(syn)
        }
      }

      // 3. Typo-tolerant fuzzy match across words in row
      if (!tokenMatched) {
        for (const rowWord of wordsInRow) {
          if (isFuzzyMatch(token, rowWord)) {
            score += 14
            tokenMatched = true
            matchedForThisRow.add(rowWord)
            break
          }
        }
      }
    }

    // If at least one concept/token matched, include it
    if (score > 0) {
      scored.push({
        scenario,
        score,
        matchedTerms: matchedForThisRow,
      })
    }
  }

  // Sort descending by relevance score (best matches first)
  scored.sort((a, b) => b.score - a.score)

  return {
    results: scored.map((s) => s.scenario),
    matchedTerms: allHighlightTerms,
  }
}
