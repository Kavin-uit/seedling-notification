import type { NotificationScenario, NotificationRule } from '../types/notification'
import { getRuleForScenario } from '../data/notificationRules'

export interface NotificationTimingDetails {
  badgeLabel: string
  badgeShortLabel: string
  badgeVariant: 'immediate' | 'opportunity' | 'deadline' | 'scheduled' | 'participation' | 'campaign' | 'identity' | 'passive'
  badgeBg: string
  badgeText: string
  badgeBorder: string
  dotColor: string
  fullSchedule: string
  conditionDescription: string
  quietHoursStatus: string
  ruleId?: string
  channelTier?: string
  delivery?: string
}

/*
 * Mirrors the backend Compassion Intelligence timing (sggateway ci/CIQuietHours, ci/CISendWindow,
 * ci/CIUsualOpenHourService, CIOrchestrator batching and rolling cooldown). Keep in sync with those files.
 *
 * - Quiet Hours: 9:00 PM - 8:00 AM recipient local time. Only the PUSH is held; in-app and email are not.
 *   Held pushes are released at 8:00 AM, one roll-up per engine.
 * - Exempt from Quiet Hours: Governance, Manual, Narrative, creator donation alerts (CI-PART-057/058),
 *   and every Contribution rule except the scheduled sends below.
 * - Recipient local time = device time zone (X-Time-Zone header), else Pacific.
 */

const QUIET_HOURS_APPLY = 'Quiet Hours apply to Push (9:00 PM – 8:00 AM local, released as one 8:00 AM roll-up).'

/** Contribution scheduled sends: held to the usual open hour (default 10:00 AM) and subject to Quiet Hours. */
const SCHEDULED_CONTRIBUTION_CODES = new Set(['CI-CONTR-002', 'CI-CONTR-028', 'CI-CONTR-031', 'CI-CONTR-034', 'CI-CONTR-036'])

/** Participation rules with batch_window_seconds = 900 (15 minutes) in the backend catalog. */
const BATCHED_PARTICIPATION_CODES = new Set([
  'CI-PART-001', 'CI-PART-003', 'CI-PART-004', 'CI-PART-005', 'CI-PART-007', 'CI-PART-008',
  'CI-PART-009', 'CI-PART-011', 'CI-PART-031', 'CI-PART-032', 'CI-PART-036', 'CI-PART-037',
  'CI-PART-039', 'CI-PART-041', 'CI-PART-042', 'CI-PART-058',
])

/** Guaranteed creator reinforcement: exempt from Quiet Hours. */
const CREATOR_REINFORCEMENT_CODES = new Set(['CI-PART-057', 'CI-PART-058'])

type Variant = NotificationTimingDetails['badgeVariant']

const VARIANT_STYLES: Record<Variant, Pick<NotificationTimingDetails, 'badgeBg' | 'badgeText' | 'badgeBorder' | 'dotColor'>> = {
  immediate: { badgeBg: 'bg-emerald-50', badgeText: 'text-emerald-900', badgeBorder: 'border-emerald-200', dotColor: 'bg-emerald-600' },
  opportunity: { badgeBg: 'bg-amber-50', badgeText: 'text-amber-900', badgeBorder: 'border-amber-200', dotColor: 'bg-amber-600' },
  deadline: { badgeBg: 'bg-rose-50', badgeText: 'text-rose-900', badgeBorder: 'border-rose-200', dotColor: 'bg-rose-600' },
  scheduled: { badgeBg: 'bg-blue-50', badgeText: 'text-blue-900', badgeBorder: 'border-blue-200', dotColor: 'bg-blue-600' },
  participation: { badgeBg: 'bg-sky-50', badgeText: 'text-sky-900', badgeBorder: 'border-sky-200', dotColor: 'bg-sky-600' },
  campaign: { badgeBg: 'bg-purple-50', badgeText: 'text-purple-900', badgeBorder: 'border-purple-200', dotColor: 'bg-purple-600' },
  identity: { badgeBg: 'bg-teal-50', badgeText: 'text-teal-900', badgeBorder: 'border-teal-200', dotColor: 'bg-teal-600' },
  passive: { badgeBg: 'bg-slate-50', badgeText: 'text-slate-700', badgeBorder: 'border-slate-200', dotColor: 'bg-slate-400' },
}

/** Opportunity deadline messages: not held to a best moment or the Monday/Friday blackout - only Quiet Hours. */
function isOpportunityDeadline(eventName: string): boolean {
  return eventName.includes('1 day before') || eventName.includes('last chance') || eventName.includes('one final gift')
}

/**
 * Returns delivery timing details for when a user receives the notification once its condition is met,
 * matching the backend CI engine's actual timing logic.
 */
export function getNotificationTiming(
  scenario: Partial<NotificationScenario> | null | undefined
): NotificationTimingDetails {
  if (!scenario) {
    return {
      badgeLabel: 'When Condition Met',
      badgeShortLabel: 'Condition Met',
      badgeVariant: 'immediate',
      ...VARIANT_STYLES.passive,
      fullSchedule: 'Notification is evaluated when the trigger condition is met.',
      conditionDescription: 'When event trigger occurs.',
      quietHoursStatus: QUIET_HOURS_APPLY,
    }
  }

  const rule: NotificationRule | undefined = scenario.rule || getRuleForScenario(scenario)
  const engine = scenario.engineCategory || rule?.engine || 'Opportunity'
  const eventName = scenario.governanceEvent || rule?.ruleName || ''
  const timing = rule?.timing || ''
  const trigger = scenario.trigger || rule?.trigger || ''
  const ruleId = rule?.ruleId || scenario.ruleId || ''
  const delivery = rule?.delivery || (scenario.pushSubject ? 'Push + In-App' : 'In-App')
  const channelTier = rule?.channelTier || ''

  const normEngine = engine.toLowerCase().trim()
  const normEvent = eventName.toLowerCase().trim()
  const normTiming = timing.toLowerCase().trim()

  const make = (
    variant: Variant,
    badgeLabel: string,
    badgeShortLabel: string,
    fullSchedule: string,
    defaultCondition: string,
    quietHoursStatus: string
  ): NotificationTimingDetails => ({
    badgeLabel,
    badgeShortLabel,
    badgeVariant: variant,
    ...VARIANT_STYLES[variant],
    fullSchedule,
    conditionDescription: trigger || defaultCondition,
    quietHoursStatus,
    ruleId,
    channelTier,
    delivery,
  })

  // 1. Governance: Critical, immediate 24/7, exempt from Quiet Hours.
  if (normEngine.includes('governance')) {
    return make(
      'immediate',
      'Immediate 24/7 (Exempt)',
      'Immediate 24/7',
      'Immediate, 24/7. Critical compliance and account-status alerts are exempt from Quiet Hours.',
      'Triggered immediately when the governance event occurs.',
      'Exempt (never delayed by time zone or Quiet Hours).'
    )
  }

  // 2. Manual: an admin sends it on demand - delivered immediately, exempt from Quiet Hours.
  if (normEngine.includes('manual')) {
    return make(
      'immediate',
      'Immediate when admin sends',
      'Immediate (Admin)',
      'Delivered immediately when an admin triggers it from the CI Rulebook admin page. Exempt from Quiet Hours.',
      'Admin sends the notification on demand.',
      'Exempt (an admin chose to send it now).'
    )
  }

  // 3. Narrative: no engine is registered in the backend yet, so these events are dropped.
  if (normEngine.includes('narrative')) {
    return make(
      'passive',
      'Not active in backend',
      'Not active',
      'No Narrative engine is registered in the backend yet, so this notification is not delivered. Once wired it is exempt from Quiet Hours.',
      'Triggered on demand by user interaction.',
      'Exempt (when wired).'
    )
  }

  // 4. Guaranteed creator reinforcement (donation alerts to creators / organizations): exempt from Quiet Hours.
  if (CREATOR_REINFORCEMENT_CODES.has(ruleId)) {
    if (BATCHED_PARTICIPATION_CODES.has(ruleId)) {
      return make(
        'participation',
        '15m Batch (Exempt)',
        '15m Batch',
        'Collected in a 15-minute batching window, then delivered as one summary. Creator donation alerts are exempt from Quiet Hours.',
        'Donation received for the organization.',
        'Exempt (creator donation alert).'
      )
    }
    return make(
      'immediate',
      'Immediate 24/7 (Creator Alert)',
      'Immediate 24/7',
      'Immediate, 24/7 across Push, In-App and Email. Guaranteed creator reinforcement is exempt from Quiet Hours.',
      'Immediately when a donor completes a contribution to the Seedling.',
      'Exempt (immediate delivery 24/7).'
    )
  }

  // 5. Opportunity: one push per rolling 24h slot, then the per-user best moment and Quiet Hours.
  if (normEngine.includes('opportunity')) {
    const competition =
      'Competes for the recipient’s one Opportunity push per rolling 24 hours (strongest candidate wins, others are suppressed).'

    if (isOpportunityDeadline(normEvent)) {
      const expiresOvernight = normEvent.includes('last chance')
      return make(
        'deadline',
        'Immediate (Deadline)',
        'Immediate (Deadline)',
        `Deadline message: not held to a best moment or the Monday/Friday blackout - only Quiet Hours apply.${
          expiresOvernight ? ' If held overnight by Quiet Hours, the push is dropped at 8:00 AM (no longer relevant).' : ''
        } ${competition}`,
        'Seedling deadline or expiration threshold met.',
        expiresOvernight
          ? 'Quiet Hours apply to Push (9:00 PM – 8:00 AM local); a push held overnight is dropped, not sent.'
          : QUIET_HOURS_APPLY
      )
    }

    const calendared = normTiming.includes('calendar')
    return make(
      'opportunity',
      'Best Moment Today (7:00 PM local)',
      'Best Moment (7 PM local)',
      `${
        calendared
          ? 'Fires on its calendar date (daily scheduler, 1:30 AM Pacific). '
          : ''
      }Push delivered at the user’s usual app-open hour (learned from 5+ sessions in the last 14 days, kept between 8:00 AM and 8:00 PM local); default 7:00 PM local. If that moment has passed but it is before 9:00 PM, it sends now. No sends Monday before 12:00 PM or Friday from 6:00 PM. ${competition}`,
      'When the opportunity condition is met.',
      QUIET_HOURS_APPLY
    )
  }

  // 6. Contribution: scheduled sends wait for the usual open hour; everything else is immediate and exempt.
  if (normEngine.includes('contribution')) {
    if (SCHEDULED_CONTRIBUTION_CODES.has(ruleId)) {
      const scheduledLabels: Record<string, [string, string, string]> = {
        'CI-CONTR-002': ['Early Jan (10:00 AM local)', 'Early Jan 10 AM', 'Once annually in early January. Covers all gifts through 11:59 PM Dec 31.'],
        'CI-CONTR-028': ['Mid-Feb (10:00 AM local)', 'Mid-Feb 10 AM', 'Once annually in mid-February.'],
        'CI-CONTR-031': ['Batch Day (10:00 AM local)', 'Batch Day 10 AM', 'On batch processing day after the collect window closes. Starts the 12-hour split-gift quiet period.'],
        'CI-CONTR-034': ['2nd Wk Dec (10:00 AM local)', 'Dec 10 AM', 'Second week of December.'],
        'CI-CONTR-036': ['48h Before Batch (10:00 AM local)', '48h Before Batch', '48 hours before the Grounds Crew batch launch date.'],
      }
      const [label, short, when] = scheduledLabels[ruleId]
      return make(
        'scheduled',
        label,
        short,
        `${when} Push held to the user’s usual app-open hour (default 10:00 AM local); if that hour has already passed, it sends now. Never dropped.`,
        'Scheduled contribution event.',
        QUIET_HOURS_APPLY
      )
    }

    if (ruleId === 'CI-CONTR-029' || normEvent.includes('support all 5 gift made')) {
      return make(
        'immediate',
        'After 120s Collect Window',
        'After 120s Collect',
        'Fires immediately after the 5-gift collect window closes (max 120 seconds). Starts the 12-hour split-gift quiet period.',
        'Donor completes Support All 5 contribution.',
        'Exempt (action confirmation).'
      )
    }

    return make(
      'immediate',
      'Immediate (24/7)',
      'Immediate (24/7)',
      'Immediate delivery. Confirmations of user actions (donations, payment method changes), failures and required notices are exempt from Quiet Hours.',
      'Immediately when the transaction completes or payment status changes.',
      'Exempt (action confirmation / failure / required notice).'
    )
  }

  // 7. Participation: 15-minute batch for batched rules, otherwise immediate; Quiet Hours apply.
  if (normEngine.includes('participation')) {
    if (BATCHED_PARTICIPATION_CODES.has(ruleId)) {
      return make(
        'participation',
        '15m Batch (8:00 AM Roll-up)',
        '15m Batch',
        'Collected in a 15-minute batching window, then delivered as one summary push. During Quiet Hours (9:00 PM – 8:00 AM local) the push is held and released as one 8:00 AM roll-up.',
        'Social interaction detected.',
        QUIET_HOURS_APPLY
      )
    }
    return make(
      'participation',
      'Immediate (8:00 AM Roll-up)',
      'Immediate',
      'Delivered immediately. During Quiet Hours (9:00 PM – 8:00 AM local) the push is held and released as one 8:00 AM roll-up.',
      'Social interaction detected.',
      QUIET_HOURS_APPLY
    )
  }

  // 8. Campaign: push only between 10:00 AM and 8:00 PM local.
  if (normEngine.includes('campaign')) {
    return make(
      'campaign',
      '10:00 AM – 8:00 PM local',
      '10 AM – 8 PM local',
      'Push delivered in the next 10:00 AM – 8:00 PM recipient local window. Before 10:00 AM it waits until 10:00 AM; from 8:00 PM it waits until 10:00 AM the next day.',
      'Meaningful campaign milestone reached.',
      'Covered by the 10:00 AM – 8:00 PM window (never sent during Quiet Hours).'
    )
  }

  // 9. Identity: immediate; only Quiet Hours hold the push (the weekend milestone window is not built).
  if (normEngine.includes('identity')) {
    return make(
      'identity',
      'Immediate (8:00 AM Roll-up)',
      'Immediate',
      'Delivered immediately. During Quiet Hours (9:00 PM – 8:00 AM local) the push is held and released as one 8:00 AM roll-up.',
      'Account milestone or profile event.',
      QUIET_HOURS_APPLY
    )
  }

  // 10. Discovery: in-app immediately; push only if the user has left the app, held by Quiet Hours.
  if (normEngine.includes('discovery')) {
    return make(
      'passive',
      'Immediate (8:00 AM Roll-up)',
      'Immediate',
      'In-app immediately. Push only if the user has left the app, and held by Quiet Hours (9:00 PM – 8:00 AM local) until one 8:00 AM roll-up.',
      'When a followed user acts (follows, supports).',
      QUIET_HOURS_APPLY
    )
  }

  // Fallback
  return make(
    'immediate',
    timing || 'Immediate',
    timing || 'Immediate',
    timing || 'Delivered when condition is met.',
    'When trigger condition is met.',
    QUIET_HOURS_APPLY
  )
}
