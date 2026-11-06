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

/**
 * Returns accurate delivery timing details for when a user receives the notification
 * once its condition is met, strictly adhering to the client's CI Rulebook & Attention Policies.
 */
export function getNotificationTiming(
  scenario: Partial<NotificationScenario> | null | undefined
): NotificationTimingDetails {
  if (!scenario) {
    return {
      badgeLabel: 'When Condition Met',
      badgeShortLabel: 'Condition Met',
      badgeVariant: 'immediate',
      badgeBg: 'bg-slate-50',
      badgeText: 'text-slate-700',
      badgeBorder: 'border-slate-200',
      dotColor: 'bg-slate-400',
      fullSchedule: 'Notification is evaluated when the trigger condition is met.',
      conditionDescription: 'When event trigger occurs.',
      quietHoursStatus: 'Standard Quiet Hours apply (9:00 PM – 8:00 AM local).',
    }
  }

  const rule: NotificationRule | undefined = scenario.rule || getRuleForScenario(scenario)
  const engine = scenario.engineCategory || rule?.engine || 'Opportunity'
  const eventName = scenario.governanceEvent || rule?.ruleName || ''
  const timing = rule?.timing || ''
  const trigger = scenario.trigger || rule?.trigger || ''
  const ruleId = rule?.ruleId || scenario.ruleId || ''
  const delivery = rule?.delivery || scenario.pushSubject ? 'Push + In-App' : 'In-App'
  const channelTier = rule?.channelTier || ''

  const normEngine = engine.toLowerCase().trim()
  const normEvent = eventName.toLowerCase().trim()
  const normTiming = timing.toLowerCase().trim()

  // 1. Governance Engine: Always Immediate 24/7 (Exempt from Quiet Hours)
  if (normEngine.includes('governance')) {
    return {
      badgeLabel: 'Immediate 24/7 (Exempt)',
      badgeShortLabel: 'Immediate 24/7',
      badgeVariant: 'immediate',
      badgeBg: 'bg-emerald-50',
      badgeText: 'text-emerald-900',
      badgeBorder: 'border-emerald-200',
      dotColor: 'bg-emerald-600',
      fullSchedule: 'Immediate, 24/7 across Push + In-App. Critical compliance and account status alerts are fully exempt from Quiet Hours.',
      conditionDescription: trigger || 'Triggered immediately when governance event occurs.',
      quietHoursStatus: 'Exempt (Never delayed by time zone or quiet hours).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 2. Guaranteed Creator Reinforcement (Donation Received): CI-PART-057 and CI-PART-058
  if (
    ruleId === 'CI-PART-057' ||
    ruleId === 'CI-PART-058' ||
    normEvent.includes('donation received on your seedling') ||
    normEvent.includes('donation received for your organization')
  ) {
    return {
      badgeLabel: 'Immediate 24/7 (Creator Alert)',
      badgeShortLabel: 'Immediate 24/7',
      badgeVariant: 'immediate',
      badgeBg: 'bg-emerald-50',
      badgeText: 'text-emerald-900',
      badgeBorder: 'border-emerald-200',
      dotColor: 'bg-emerald-600',
      fullSchedule: 'Immediate, 24/7 across Push, In-App, and Email. Guaranteed creator reinforcement is exempt from Quiet Hours so creators receive alerts without delay.',
      conditionDescription: trigger || 'Immediately when donor completes contribution to Seedling/Organization.',
      quietHoursStatus: 'Exempt (Immediate delivery 24/7).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 3. Opportunity Engine: Best Moment Today in user time zone (clamped 8am - 9pm local)
  if (normEngine.includes('opportunity')) {
    const isDeadline =
      normEvent.includes('1 day') ||
      normEvent.includes('7 days') ||
      normEvent.includes('closes') ||
      normEvent.includes('deadline') ||
      normEvent.includes('last chance')

    const isCalendared =
      normTiming.includes('calendar') ||
      normEvent.includes('day') ||
      normEvent.includes('month') ||
      normEvent.includes('week')

    if (isDeadline) {
      return {
        badgeLabel: '8:00 AM local (Deadline)',
        badgeShortLabel: '8:00 AM local',
        badgeVariant: 'deadline',
        badgeBg: 'bg-rose-50',
        badgeText: 'text-rose-900',
        badgeBorder: 'border-rose-200',
        dotColor: 'bg-rose-600',
        fullSchedule: "Delivered at 8:00 AM in recipient's local time zone on the deadline threshold date. Clamped within the 8:00 AM – 9:00 PM local active window; subject to Quiet Hours.",
        conditionDescription: trigger || 'Seedling deadline or expiration threshold met.',
        quietHoursStatus: 'Quiet Hours apply (9:00 PM – 8:00 AM local).',
        ruleId,
        channelTier,
        delivery,
      }
    }

    return {
      badgeLabel: 'Best Moment Today (7:00 PM local)',
      badgeShortLabel: 'Best Moment (7 PM local)',
      badgeVariant: 'opportunity',
      badgeBg: 'bg-amber-50',
      badgeText: 'text-amber-900',
      badgeBorder: 'border-amber-200',
      dotColor: 'bg-amber-600',
      fullSchedule: isCalendared
        ? "Delivered on the approved calendar date at the user's personal usual-open hour (default 7:00 PM recipient local time, clamped 8:00 AM – 9:00 PM local). Sunday 7:00 PM preferred for giving asks."
        : "Delivered at the user's personal usual-open hour (last 14 days, clamped 8:00 AM – 9:00 PM recipient local time). Default is 7:00 PM local (Sunday 7:00 PM preferred; no sends Mon <12 PM or Fri >6 PM).",
      conditionDescription: trigger || 'When behavioral opportunity or social proof condition is met.',
      quietHoursStatus: 'Quiet Hours apply (9:00 PM – 8:00 AM held to 8:00 AM roll-up).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 4. Contribution Engine
  if (normEngine.includes('contribution')) {
    if (
      ruleId === 'CI-CONTR-002' ||
      ruleId === 'CI-CONTR-027' ||
      normEvent.includes('annual giving summary')
    ) {
      return {
        badgeLabel: 'Early Jan (10:00 AM local)',
        badgeShortLabel: 'Early Jan 10 AM',
        badgeVariant: 'scheduled',
        badgeBg: 'bg-blue-50',
        badgeText: 'text-blue-900',
        badgeBorder: 'border-blue-200',
        dotColor: 'bg-blue-600',
        fullSchedule: "Once annually in early January at 10:00 AM recipient local time. Covers all gifts through 11:59 PM Dec 31.",
        conditionDescription: 'Annual tax year closeout.',
        quietHoursStatus: 'Scheduled 10:00 AM local (Outside Quiet Hours).',
        ruleId,
        channelTier,
        delivery,
      }
    }
    if (ruleId === 'CI-CONTR-028' || normEvent.includes('tax season')) {
      return {
        badgeLabel: 'Mid-Feb (10:00 AM local)',
        badgeShortLabel: 'Mid-Feb 10 AM',
        badgeVariant: 'scheduled',
        badgeBg: 'bg-blue-50',
        badgeText: 'text-blue-900',
        badgeBorder: 'border-blue-200',
        dotColor: 'bg-blue-600',
        fullSchedule: 'Once annually in mid-February at 10:00 AM recipient local time.',
        conditionDescription: 'Tax season milestone.',
        quietHoursStatus: 'Scheduled 10:00 AM local.',
        ruleId,
        channelTier,
        delivery,
      }
    }
    if (ruleId === 'CI-CONTR-031' || normEvent.includes('batch gift processed')) {
      return {
        badgeLabel: 'Batch Day (10:00 AM local)',
        badgeShortLabel: 'Batch Day 10 AM',
        badgeVariant: 'scheduled',
        badgeBg: 'bg-blue-50',
        badgeText: 'text-blue-900',
        badgeBorder: 'border-blue-200',
        dotColor: 'bg-blue-600',
        fullSchedule: "Delivered at the member's best engagement time (default 10:00 AM recipient local time) on batch processing day after the collect window closes. Starts 12h quiet period.",
        conditionDescription: 'When monthly Grounds Crew batch gift is processed.',
        quietHoursStatus: 'Scheduled 10:00 AM local (Starts 12h quiet period).',
        ruleId,
        channelTier,
        delivery,
      }
    }
    if (ruleId === 'CI-CONTR-034' || normEvent.includes('year-end giving preview')) {
      return {
        badgeLabel: '2nd Wk Dec (10:00 AM local)',
        badgeShortLabel: 'Dec 10 AM',
        badgeVariant: 'scheduled',
        badgeBg: 'bg-blue-50',
        badgeText: 'text-blue-900',
        badgeBorder: 'border-blue-200',
        dotColor: 'bg-blue-600',
        fullSchedule: "Second week of December at the member's best engagement time (default 10:00 AM recipient local time).",
        conditionDescription: 'December year-end giving campaign window.',
        quietHoursStatus: 'Scheduled 10:00 AM local.',
        ruleId,
        channelTier,
        delivery,
      }
    }
    if (ruleId === 'CI-CONTR-036' || normEvent.includes('contribution upcoming')) {
      return {
        badgeLabel: '48h Before Batch Launch',
        badgeShortLabel: '48h Before Batch',
        badgeVariant: 'scheduled',
        badgeBg: 'bg-blue-50',
        badgeText: 'text-blue-900',
        badgeBorder: 'border-blue-200',
        dotColor: 'bg-blue-600',
        fullSchedule: 'Delivered 48 hours before the Grounds Crew batch launch date at 10:00 AM recipient local time.',
        conditionDescription: '48 hours before scheduled monthly batch launch.',
        quietHoursStatus: 'Scheduled 10:00 AM local.',
        ruleId,
        channelTier,
        delivery,
      }
    }
    if (ruleId === 'CI-CONTR-029' || normEvent.includes('support all 5 gift made')) {
      return {
        badgeLabel: 'After 120s Collect Window',
        badgeShortLabel: 'After 120s Collect',
        badgeVariant: 'immediate',
        badgeBg: 'bg-emerald-50',
        badgeText: 'text-emerald-900',
        badgeBorder: 'border-emerald-200',
        dotColor: 'bg-emerald-600',
        fullSchedule: 'Fires immediately after the 5-gift collect window closes (max 120 seconds). Starts the 12-hour split-gift quiet period.',
        conditionDescription: 'Donor completes Support All 5 contribution.',
        quietHoursStatus: 'Immediate (starts 12h quiet period).',
        ruleId,
        channelTier,
        delivery,
      }
    }

    // Default Contribution: Immediate confirmation or failure (Exempt from Quiet Hours)
    return {
      badgeLabel: 'Immediate (24/7)',
      badgeShortLabel: 'Immediate (24/7)',
      badgeVariant: 'immediate',
      badgeBg: 'bg-emerald-50',
      badgeText: 'text-emerald-900',
      badgeBorder: 'border-emerald-200',
      dotColor: 'bg-emerald-600',
      fullSchedule: 'Immediate delivery. Confirmations of user actions (donations, payment method changes) and actionable failures (ACH/card failed) are exempt from Quiet Hours.',
      conditionDescription: trigger || 'Immediately when transaction completes or payment status changes.',
      quietHoursStatus: 'Exempt (Action confirmation / failure).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 5. Participation Engine
  if (normEngine.includes('participation')) {
    const isLikeWindow = normTiming.includes('15-minute') || normEvent.includes('like')
    return {
      badgeLabel: isLikeWindow ? '15m Batch (8:00 AM Roll-up)' : '5–10m Batch (8:00 AM Roll-up)',
      badgeShortLabel: isLikeWindow ? '15m Batch' : '5–10m Batch',
      badgeVariant: 'participation',
      badgeBg: 'bg-sky-50',
      badgeText: 'text-sky-900',
      badgeBorder: 'border-sky-200',
      dotColor: 'bg-sky-600',
      fullSchedule: isLikeWindow
        ? '15-minute batching window during active daytime hours. During Quiet Hours (9:00 PM – 8:00 AM local), pushes are held and delivered as one 8:00 AM recipient local time roll-up.'
        : '5–10 minute batching window during active daytime hours. During Quiet Hours (9:00 PM – 8:00 AM local), pushes are held and delivered as one 8:00 AM recipient local time roll-up.',
      conditionDescription: trigger || 'Social interaction detected (like, comment, milestone).',
      quietHoursStatus: 'Quiet Hours apply (9:00 PM – 8:00 AM local held to 8:00 AM roll-up).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 6. Campaign Engine
  if (normEngine.includes('campaign')) {
    return {
      badgeLabel: '10:00 AM – 8:00 PM local',
      badgeShortLabel: '10 AM – 8 PM local',
      badgeVariant: 'campaign',
      badgeBg: 'bg-purple-50',
      badgeText: 'text-purple-900',
      badgeBorder: 'border-purple-200',
      dotColor: 'bg-purple-600',
      fullSchedule: 'Delivered in the next 10:00 AM – 8:00 PM recipient local time window following milestone achievement. Quiet Hours apply (9:00 PM – 8:00 AM).',
      conditionDescription: trigger || 'Meaningful campaign milestone reached (e.g. 25%, 50%, 75%, 100%).',
      quietHoursStatus: 'Quiet Hours apply (Held outside 10:00 AM – 8:00 PM window).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 7. Identity Engine
  if (normEngine.includes('identity')) {
    return {
      badgeLabel: 'Weekend 10am–12pm local',
      badgeShortLabel: 'Weekend 10am–12pm',
      badgeVariant: 'identity',
      badgeBg: 'bg-teal-50',
      badgeText: 'text-teal-900',
      badgeBorder: 'border-teal-200',
      dotColor: 'bg-teal-600',
      fullSchedule: "Milestone reflection push delivered on weekend late morning (Saturday or Sunday 10:00 AM – 12:00 PM in recipient's local time zone). Quiet Hours apply.",
      conditionDescription: trigger || 'Account milestone or reflective profile threshold achieved.',
      quietHoursStatus: 'Quiet Hours apply (gated to Sat/Sun 10:00 AM – 12:00 PM local).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 8. Discovery Engine
  if (normEngine.includes('discovery')) {
    return {
      badgeLabel: 'In-App (Browsing Session)',
      badgeShortLabel: 'In-App (Browsing)',
      badgeVariant: 'passive',
      badgeBg: 'bg-slate-50',
      badgeText: 'text-slate-700',
      badgeBorder: 'border-slate-200',
      dotColor: 'bg-slate-400',
      fullSchedule: 'Passive in-app feed during user browsing session. Never initiates an interruption (no Push, no 1:1 Email).',
      conditionDescription: trigger || 'When user is actively browsing feed or discovery content.',
      quietHoursStatus: 'N/A (In-App only).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // 9. Narrative Engine
  if (normEngine.includes('narrative')) {
    return {
      badgeLabel: 'In-App (On Demand)',
      badgeShortLabel: 'In-App (On Demand)',
      badgeVariant: 'passive',
      badgeBg: 'bg-slate-50',
      badgeText: 'text-slate-700',
      badgeBorder: 'border-slate-200',
      dotColor: 'bg-slate-400',
      fullSchedule: 'On demand in-app experience during active drafting or sharing flow.',
      conditionDescription: trigger || 'Triggered on demand by user interaction.',
      quietHoursStatus: 'N/A (In-App only).',
      ruleId,
      channelTier,
      delivery,
    }
  }

  // Fallback
  return {
    badgeLabel: timing || 'Immediate',
    badgeShortLabel: timing || 'Immediate',
    badgeVariant: 'immediate',
    badgeBg: 'bg-slate-50',
    badgeText: 'text-slate-700',
    badgeBorder: 'border-slate-200',
    dotColor: 'bg-slate-500',
    fullSchedule: timing || 'Delivered when condition is met.',
    conditionDescription: trigger || 'When trigger condition is met.',
    quietHoursStatus: 'Standard policy applies.',
    ruleId,
    channelTier,
    delivery,
  }
}
