import type { NotificationRule, NotificationScenario } from '../types/notification'
import {
  ALL_NOTIFICATION_RULES,
  RULES_BY_ID,
  RULE_BOOK_SHEET_URL,
  getRuleForScenario as lookupRuleForScenario,
} from '../data/notificationRules'

export { RULE_BOOK_SHEET_URL }

class RulesApi {
  private rulesCache: NotificationRule[] = ALL_NOTIFICATION_RULES
  private rulesByIdCache: Map<string, NotificationRule> = new Map(
    ALL_NOTIFICATION_RULES.map((r) => [r.ruleId, r])
  )

  public getCachedRules(): NotificationRule[] {
    return this.rulesCache
  }

  public getRuleById(ruleId: string): NotificationRule | undefined {
    return this.rulesByIdCache.get(ruleId) || RULES_BY_ID[ruleId]
  }

  public getRuleForScenario(scenario: Partial<NotificationScenario>): NotificationRule | undefined {
    return lookupRuleForScenario(scenario)
  }

  // Fetch rules from Cloudflare D1 endpoint, fallback to built-in cache
  async fetchRules(params?: { engine?: string; q?: string; scenarioId?: string }): Promise<NotificationRule[]> {
    try {
      const url = new URL('/api/rules', window.location.origin)
      if (params?.engine && params.engine !== 'ALL') url.searchParams.set('engine', params.engine)
      if (params?.q) url.searchParams.set('q', params.q)
      if (params?.scenarioId) url.searchParams.set('scenarioId', params.scenarioId)

      const res = await fetch(url.toString(), {
        headers: { Accept: 'application/json' },
      })

      if (res.ok) {
        const data = await res.json()
        if (data && Array.isArray(data.rules) && data.rules.length > 0) {
          if (!params || Object.keys(params).length === 0) {
            this.rulesCache = data.rules
            this.rulesByIdCache = new Map(data.rules.map((r: NotificationRule) => [r.ruleId, r]))
          }
          return data.rules
        }
      }
    } catch {
      // offline or local dev fallback
    }

    // Filter fallback cache locally
    let results = this.rulesCache
    if (params?.engine && params.engine !== 'ALL') {
      const eLower = params.engine.toLowerCase()
      results = results.filter((r) => r.engine.toLowerCase() === eLower)
    }
    if (params?.scenarioId) {
      results = results.filter((r) => r.scenarioId === params.scenarioId)
    }
    if (params?.q) {
      const qLower = params.q.toLowerCase()
      results = results.filter(
        (r) =>
          r.ruleId.toLowerCase().includes(qLower) ||
          r.ruleName.toLowerCase().includes(qLower) ||
          r.trigger.toLowerCase().includes(qLower) ||
          r.audience.toLowerCase().includes(qLower) ||
          r.communicationObjective.toLowerCase().includes(qLower)
      )
    }

    return results
  }
}

export const rulesApi = new RulesApi()
