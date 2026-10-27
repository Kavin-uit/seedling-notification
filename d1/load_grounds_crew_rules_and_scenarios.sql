-- 1. Update engine_sheets with latest Contribution Engine Sheet URL

UPDATE engine_sheets 
SET sheet_url = 'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true',
    csv_export_url = 'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/export?format=csv',
    updated_at = datetime('now')
WHERE engine_category = 'Contribution';


-- 2. Insert missing notification rules (including CI-CONTR-029, 030, 031)

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-OPP-171', 'Opportunity', 'Follower Supported All 5', 'Follower completes Support all 5', 'Connected users', 'Leverage social proof; promote Support all 5',
  'Medium', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours', 'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.',
  'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70', 'No',
  'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '',
  'Best moment today', 'Yes -- one per recipient per parent gift / enrollment', 'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '', 'TPL-CI-OPP-171',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-091.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-OPP-175', 'Opportunity', 'Grounds Crew Anniversary', '3, 6 and 12 months after Grounds Crew enrollment, then every 12 months', 'Grounds Crew member', 'Celebrate commitment',
  'Medium', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours', 'Suppress competing opportunity pushes. Support all 5: one anniversary per parent gift. Grounds Crew contributions: replaced by CI-OPP-175 Grounds Crew Anniversary. One per milestone. Respects the split-gift quiet period (delay, not drop).',
  'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70', 'No',
  'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '',
  'Best moment today', 'Yes', 'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Grounds Crew member', 'Donation confirmation / reinforcement', 'TPL-CI-OPP-175',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Now at 3, 6 and 12 months, then yearly; adds an invite to join The Grounds Crew (referral credit via CI-ID-037/038/039).', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-OPP-176', 'Opportunity', 'Grounds Crew Field Note', 'Owner-approved field note published for one of the current batch''s Picks (partway through a batch)', 'Grounds Crew member', 'Show one human moment from a Seedling the member is supporting; no ask',
  'Medium', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours', 'Suppress competing opportunity pushes. One per batch; not within 3 days of batch day; respects the split-gift quiet period (delay, not drop). CALENDAR APPROVAL GATE: sends only if the field note is approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD); unreviewed on the send date = held; rejected = suppressed.',
  'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70', 'No',
  'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '',
  'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes', 'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Grounds Crew member', 'Impact story / reinforcement', 'TPL-CI-OPP-176',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-029', 'Contribution', 'Support All 5 Gift Made', 'Donor completes a Support all 5 gift (all 5 recommendations recorded under one parent_gift_id)', 'Donor (parent/guardian for family accounts)', 'Thank donor once for the whole gift and show five-fold impact',
  'High', 'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- financial confirmation. Card/ACH-funded: confirms the donation to Seedling Social Giving; the acknowledgment is saved to giving history (not attached) and included in the year-end summary. GreenHouse-funded: grant-recommendation confirmation only; no acknowledgment (ToS 4.3).', 'None', 'Never suppressed. SUPPRESSES the child messages it replaces (CI-CONTR-001/012/006 for the same parent_gift_id) -- Split Gift Policy POL-SPLIT-03.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '96', 'Yes',
  'No', 'ParentGiftID, status of all 5 recommendations, current session', 'Split Gift Confirmation', '',
  'After the collect window closes (all 5 recorded, max 120 seconds), then Immediate. Starts the 12-hour split-gift quiet period.', 'Yes -- merges 5 donation confirmations into one message; also shows any badges/goals the gift unlocked', 'One gift, one thank-you: confirm the whole split gift once instead of five times.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate, SplitGiftQuietUntil, AccountGuardian',
  'Deliver one Support all 5 thank-you; choose card/ACH or GreenHouse closing from FundingSource.', 'Donor (parent/guardian for family accounts)', '', 'TPL-CI-CONTR-029',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-030', 'Contribution', 'Grounds Crew Enrollment Confirmed', 'Donor enrolls in The Grounds Crew (if the first contribution processes the same day, it is included in this message)', 'Donor (parent/guardian for family accounts)', 'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (contribution amount, first charge at enrollment, charged each time a new batch of Picks launches -- no more than once per calendar month -- until cancelled, how to cancel)',
  'High', 'In-App always; Push if user left app; Email always (required)', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push. Must include the enrollment terms and cancellation instructions (ToS 4.4).', 'None', 'NEVER -- required enrollment confirmation (POL-SPLIT-11). Suppresses CI-CONTR-020 (x5). If the first contribution processes the same day, it absorbs that month''s CI-CONTR-031 and CI-CONTR-001/012 (x5).',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '97', 'Yes',
  'No', 'SubscriptionID, first charge date, funding source, current session', 'Split Gift Confirmation', '',
  'Immediate at enrollment (collect window applies only if the first contribution processes at once). Starts the quiet period.', 'Yes -- merges recurring-created + optional first gift into one message', 'Welcome the member once, state the terms clearly, and promise a calm once-a-month cadence.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate, SplitGiftQuietUntil, AccountGuardian, SubscriptionID, FirstChargeDate',
  'Deliver the enrollment confirmation with required terms; include first gift if processed today.', 'Donor (parent/guardian for family accounts)', '', 'TPL-CI-CONTR-030',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Enrollment terms describe batch-based charging (no more than once per calendar month).', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-031', 'Contribution', 'Grounds Crew Batch Gift Processed', 'New Picks batch released AND the member''s Grounds Crew charge for that batch processed (card charge succeeds or GreenHouse balance applied)', 'Donor (Grounds Crew member)', 'Confirm the gift once, celebrate what the last batch grew (when results were entered), and introduce the new Picks (replaces the Picks to Click digest for members)',
  'High', 'Push + In-App + Email (one per month)', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- financial confirmation. Card/ACH-funded: confirms the donation to Seedling Social Giving; the acknowledgment is saved to giving history (not attached) and included in the year-end summary. GreenHouse-funded: grant-recommendation confirmation only; no acknowledgment (ToS 4.3). When the contribution triggers Auto-Replenish, this message carries the required Auto-Replenish charge notice as a labeled section (Email + Push), replacing a separate CI-CONTR-007.', 'One per batch per enrollment (at most one batch per calendar month)', 'Never suppressed. Suppresses CI-CONTR-023 (x5) and CI-CONTR-001/012 (x5) for the month, absorbs CI-CONTR-007 when Auto-Replenish was triggered, and replaces the monthly Picks to Click digest (CI-OPP-150) for this member.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '96', 'Yes',
  'No', 'SubscriptionID, month, recommendation status, lifetime Seedlings supported, Auto-Replenish triggered, batch ID, last-batch results (manually entered; optional), Crew total for last batch, Crew gift count, first-batch-day flag, Crew milestone flag', 'Split Gift Confirmation', '',
  'After the collect window closes; delivered at the member''s best engagement time on processing day. If it carries an Auto-Replenish notice, delivered the same day. Starts the quiet period.', 'Yes -- merges the month''s 5 recurring confirmations + Picks reveal (+ Auto-Replenish notice) into one message', 'Each batch earns exactly one touch: confirm the gift, celebrate the last batch, and introduce the new Picks together.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate, SplitGiftQuietUntil, AccountGuardian, SubscriptionID, LifetimeSeedlingsSupported, AutoReplenishTriggered, BatchID, LastBatchResults, CrewTotalLastBatch, CrewGiftCount, FirstBatchDay, CrewMilestone',
  'Deliver one Grounds Crew batch confirmation + Picks reveal; include last-batch results when entered; add Auto-Replenish section when triggered.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-031',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Renamed from Monthly Gift Processed; fires per batch; opens with last-batch results when entered.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-032', 'Contribution', 'Grounds Crew Contribution Skipped', 'GreenHouse-funded Grounds Crew batch launch date arrives and the GreenHouse balance is insufficient (after any Auto-Replenish attempt)', 'Donor (Grounds Crew member)', 'Required notice (ToS 4.4): this month''s contribution was not made',
  'High', 'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push.', 'One per batch', 'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event. Merges with CI-CONTR-008 when an Auto-Replenish attempt also failed.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'SubscriptionID, GreenHouse balance, Auto-Replenish state', 'Donation Confirmation', '',
  'Immediate on the scheduled date, after any Auto-Replenish attempt resolves', 'Yes -- with CI-CONTR-008 when both apply', 'Required and actionable: tell the member once and nudge Auto-Replenish so it does not recur.', 'Resolution', 'DonorState, SubscriptionID, GreenHouseBalance, AutoReplenishState, AccountGuardian',
  'Deliver the required skipped-month notice with an Auto-Replenish nudge.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-032',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Trigger is the batch launch date.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-033', 'Contribution', 'Auto-Replenish Turned On', 'User turns on GreenHouse Auto-Replenish', 'User (parent/guardian for family accounts)', 'Required confirmation (ToS 4.3): minimum balance, replenishment amount, payment method, continuing charges, how to turn off',
  'High', 'In-App always; Push if user left app; Email always (required)', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push. Must include minimum balance, replenishment amount, payment method, continuing-charge statement and how to turn off (ToS 4.3).', 'None', 'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'Auto-Replenish settings, current session', 'Donation Confirmation', '',
  'Immediate when Auto-Replenish is turned on', 'No', 'Required confirmation of a standing charge authorization.', 'Confirmation', 'DonorState, AutoReplenishSettings, AccountGuardian',
  'Deliver the Auto-Replenish confirmation with all required terms.', 'User (parent/guardian for family accounts)', '', 'TPL-CI-CONTR-033',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-034', 'Contribution', 'Year-End Giving Preview', 'Second week of December -- users with at least one donation in the current calendar year', 'Donor', 'Year-to-date giving recap; promote a GreenHouse Contribution before Dec 31; Grounds Crew members also see batches and Seedlings supported this year',
  'High', 'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, once per year (December). Doubles as the GreenHouse year-end promotion.', 'Once per calendar year', 'Skipped for users with no donations this year (they receive Opportunity One Final Gift instead). Respects the split-gift quiet period (delay, not drop).',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '90', 'Yes',
  'No', 'Year-to-date donations, Seedlings supported', 'Donation Confirmation', '',
  'Second week of December, best engagement time', 'No', 'One year-to-date recap replaces per-gift acknowledgment emails and promotes a GreenHouse Contribution before Dec 31.', 'Recognition', 'DonorState, YTDDonations, LifetimeSeedlingsSupported, CrewBatchCountYTD, CrewSeedlingCountYTD',
  'Deliver the December giving recap with the GreenHouse year-end prompt.', 'Donor', '', 'TPL-CI-CONTR-034',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Adds a Grounds Crew section for members.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-035', 'Contribution', 'Recommendation Redirected', 'Seedling redirects funds because a recommended Seedling/nonprofit is ineligible, inactive, or cannot receive funds (ToS 4.1, 4.4)', 'Donor', 'Keep trust: explain where the support went',
  'High', 'In-App + Email (no Push)', 'Tier 2 - Event-Driven', 'In-App + Email always (trust notice); no Push.', 'One per parent gift or month', 'Never suppressed; consolidated to one per parent gift / Grounds Crew month when several recommendations are redirected.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '80', 'Yes',
  'No', 'Redirect events per gift', 'Donation Confirmation', '',
  'When the redirect is decided (often after the Seedling closes); held until any quiet period ends', 'Yes -- one per parent gift', 'Recommendations are nonbinding (ToS 4.1); telling donors where support went protects trust.', 'Resolution', 'DonorState, ParentGiftID, SubscriptionID',
  'Deliver one redirect explanation per gift.', 'Donor', '', 'TPL-CI-CONTR-035',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-036', 'Contribution', 'Grounds Crew Contribution Upcoming', '48 hours before a scheduled Grounds Crew batch launch date (batch dates are always set at least 48 hours ahead)', 'Donor (Grounds Crew member)', 'One light reminder; prevent skipped months for GreenHouse-funded members',
  'High', 'In-App + Email (no Push)', 'Tier 1 - Guaranteed', 'In-App + Email, once per month; no Push.', 'One per batch', 'Replaces CI-CONTR-025 (x5) for Grounds Crew. Respects the quiet period (delay, not drop).',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '85', 'Yes',
  'No', 'SubscriptionID, next contribution date, GreenHouse balance, Auto-Replenish state', 'Donation Confirmation', '',
  '48 hours before the batch launch date', 'Yes -- replaces 5 Recurring Donation Upcoming messages', 'One light reminder; warns GreenHouse-funded members who are short and nudges Auto-Replenish.', 'Reminder', 'DonorState, SubscriptionID, GreenHouseBalance, AutoReplenishState, NextBatchDate',
  'Deliver one Grounds Crew reminder; add short-balance + Auto-Replenish nudge when applicable.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-036',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Fires 48 hours before each scheduled batch launch; batch dates are always set 48+ hours ahead.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-037', 'Contribution', 'Grounds Crew Payment Failed', 'Card-funded Grounds Crew batch charge fails', 'Donor (Grounds Crew member)', 'Required notice (ToS 4.4): resolve payment',
  'High', 'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push.', 'One per attempt', 'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event. Replaces CI-CONTR-021 (x5) for Grounds Crew.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'SubscriptionID, retry schedule', 'Donation Confirmation', '',
  'Immediate', 'Yes -- replaces 5 Recurring Donation Failed messages', 'Required and actionable; once per failed attempt.', 'Resolution', 'DonorState, SubscriptionID, AccountGuardian',
  'Deliver one Grounds Crew payment failure notice.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-037',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Charge is per batch.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-038', 'Contribution', 'Grounds Crew Paused', 'Member pauses The Grounds Crew, or enrollment is paused after repeated failed payments (ToS 4.4)', 'Donor (Grounds Crew member)', 'Confirm the pause and how to resume',
  'High', 'In-App always; Push if user left app; Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always.', 'None', 'Never; replaces CI-CONTR-022 (x5) for Grounds Crew. Paused-after-failures variant is a required notice (POL-SPLIT-11).',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'SubscriptionID, pause reason', 'Donation Confirmation', '',
  'Immediate', 'Yes -- replaces 5 Recurring Donation Paused messages', 'One action, one confirmation.', 'Confirmation', 'DonorState, SubscriptionID',
  'Deliver one Grounds Crew paused confirmation (member or failure variant).', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-038',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-039', 'Contribution', 'Grounds Crew Cancelled', 'Member cancels The Grounds Crew', 'Donor (Grounds Crew member)', 'Confirm cancellation (ToS 4.4, 7); maintain goodwill',
  'High', 'In-App always; Push if user left app; Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always.', 'None', 'Never; replaces CI-CONTR-019 (x5) for Grounds Crew.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'SubscriptionID', 'Donation Confirmation', '',
  'Immediate', 'Yes -- replaces 5 Recurring Donation Cancelled messages', 'One action, one confirmation; states contributions already processed are final.', 'Confirmation', 'DonorState, SubscriptionID',
  'Deliver one Grounds Crew cancellation confirmation.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-039',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-040', 'Contribution', 'Grounds Crew Resumed', 'Member resumes The Grounds Crew', 'Donor (Grounds Crew member)', 'Welcome back; confirm next contribution',
  'High', 'In-App always; Push if user left app; Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always.', 'None', 'Never; replaces CI-CONTR-024 (x5) for Grounds Crew.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'SubscriptionID, next contribution date', 'Donation Confirmation', '',
  'Immediate', 'Yes -- replaces 5 Recurring Donation Resumed messages', 'One action, one confirmation.', 'Confirmation', 'DonorState, SubscriptionID',
  'Deliver one Grounds Crew resumed confirmation.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-040',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-041', 'Contribution', 'Grounds Crew Program Change Notice', 'Material change to The Grounds Crew program (advance notice required, ToS 4.4)', 'Donor (Grounds Crew member)', 'Required advance notice of material program changes',
  'High', 'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push.', 'None', 'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event. Batch-timing notice (Dec 2026): sent manually by the owner by push and email.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95', 'Yes',
  'No', 'Program change record', 'Donation Confirmation', '',
  'In advance of the effective date (lead time set by policy/counsel)', 'No', 'Required advance notice of material program changes (ToS 4.4).', 'Notice', 'DonorState, SubscriptionID',
  'Deliver the required program change notice.', 'Donor (Grounds Crew member)', '', 'TPL-CI-CONTR-041',
  '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): The batch-timing change notice is a manual owner send by push and email after the updated Terms are published (not automated).', datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  'CI-CONTR-042', 'Contribution', 'GreenHouse Inactive Balance Notice', 'GreenHouse balance has had no grant recommendations for 22 months (60 days before the 24-month mark, ToS 4.3)', 'User', 'Required notice where practicable before an inactive balance is regranted',
  'High', 'In-App + Email; Push', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push. (notice where practicable before regranting an inactive balance, ToS 4.3).', 'Once per inactivity period', 'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event.',
  'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '90', 'Yes',
  'No', 'Last recommendation date, GreenHouse balance', 'Donation Confirmation', '',
  'Once, 60 days before the 24-month inactivity mark', 'No', 'Required notice and a strong prompt to recommend Seedlings or join The Grounds Crew.', 'Notice', 'DonorState, GreenHouseBalance, LastRecommendationDate',
  'Deliver the inactive-balance notice with Choose Seedlings / Grounds Crew options.', 'User', '', 'TPL-CI-CONTR-042',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', datetime('now'), datetime('now')
);


-- 3. Insert or Replace the 3 Target Scenarios in scenarios table

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'ce-17',
  'CONTRIB-17',
  'Contribution',
  'Grounds Crew Enrollment Confirmed',
  'Donor enrolls in The Grounds Crew (if the first contribution processes the same day, it is included in this message)',
  'Donor (parent/guardian for family accounts)',
  'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (contribution amount, first charge at enrollment, charged each time a new batch launches -- no more than once per calendar month -- until cancelled, how to cancel)',
  'Stay enrolled; meet the Picks',
  'Welcome to The Grounds Crew! 🌱',
  'You''re on The Grounds Crew! Your first gift is already supporting this batch''s 5 Picks to Click.',
  'Welcome to The Grounds Crew! 🌱',
  'Welcome to The Grounds Crew! You''ve made generosity a habit, and your first gift is already at work. Your (Amount) gift today is supporting (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5).

Each time a new set of 5 Picks to Click launches, your donation to Seedling Social Giving goes out and is regranted among those 5 Picks -- hand-picked Seedlings that deserve a boost -- no more than once per calendar month, and we''ll send you one note each time so you always know what you''re growing. [IF NEXT BATCH DATE ANNOUNCED] The next Picks launch on (Next Batch Date), so your next gift goes out then.

YOUR ENROLLMENT: Gift amount: (Amount). Funding source: (Card ending #### | GreenHouse balance). First contribution: today. Your contribution is charged when each new set of 5 Picks to Click launches. New Picks launch no more than once per calendar month, so you''ll never be charged more than once in a calendar month. If no new Picks launch in a month, you won''t be charged that month. You can change your amount or funding source, pause, or cancel anytime in the app under The Grounds Crew, or email support@seedlingsocial.org.  BOX: Meet Your Picks

Add the card/ACH or GreenHouse closing from Support All 5 Gift Made.',
  'Welcome to The Grounds Crew! Your first gift is supporting this batch''s 5 Picks. You''ll be charged (Amount) each time new Picks launch, no more than once per calendar month. Manage or cancel anytime in the app under The Grounds Crew.  BOX: Meet Your Picks',
  'take user to Grounds Crew hub (current 5 Picks, amounts, membership settings incl. cancel)',
  '',
  'TO DO',
  'High',
  'STAGING',
  'CI-CONTR-030',
  datetime('now'),
  datetime('now')
);

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'ce-18',
  'CONTRIB-18',
  'Contribution',
  'Grounds Crew Batch Gift Processed',
  'New Picks batch released AND the member''s Grounds Crew charge for that batch processed (card charge succeeds or GreenHouse balance applied)',
  'Donor (Grounds Crew member)',
  'Confirm the gift once, celebrate what the last batch grew, and introduce the new Picks',
  'Open app to meet new Picks; stay enrolled; share',
  'Your Grounds Crew gift is out 💚',
  'Your Grounds Crew gift is out! The Crew grew 5 Seedlings last batch. Come meet your 5 new Picks.   [IF AUTO-REPLENISH CHARGED] Your Grounds Crew gift is out, and Auto-Replenish added (Replenish Amount) to your GreenHouse.',
  'Your Grounds Crew Gift Is Out: Meet Your New Picks 💚',
  'New Picks are here, and your (Amount) Grounds Crew gift just went out to support them.

[IF LAST BATCH RESULTS ENTERED] WHAT THE LAST BATCH GREW: Together the Crew gave (Crew Total Last Batch) to (Last Seedling 1), (Last Seedling 2), (Last Seedling 3), (Last Seedling 4), and (Last Seedling 5). [One result line per Seedling, e.g. (Last Seedling 1) reached (Percent) of its goal.]

MEET YOUR 5 NEW PICKS: (Seedling 1) for (Nonprofit 1) -- (One-line description). [Repeat for Seedlings 2-5.]

Since joining, you''ve helped (Count) Seedlings grow across (Crew Gift Count) Grounds Crew gifts. Your next gift goes out when the next set of Picks launches, no more than once per calendar month.  BOX: Meet the Picks   BOX: Share This Batch

[IF CREW MILESTONE] Opening line: The Grounds Crew just passed (Milestone) given, all time. You''re part of every dollar.
[IF NO LAST BATCH RESULTS ENTERED, OR FIRST BATCH DAY SINCE ENROLLMENT] Skip WHAT THE LAST BATCH GREW; open with: Your second Grounds Crew gift just went out to 5 brand-new Picks.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds to your GreenHouse, so no new acknowledgment is issued. GreenHouse balance remaining: (Balance).

[IF THIS GIFT TRIGGERED AUTO-REPLENISH -- required notice, ToS 4.3] AUTO-REPLENISH CHARGE: (Replenish Amount) was charged to (Card ending ####) on (Date) to refill your GreenHouse. This is a new donation to Seedling Social Giving; your acknowledgment is saved in your giving history. Change or turn off Auto-Replenish anytime in GreenHouse settings.  BOX: Meet the New Picks',
  'Your Grounds Crew gift is now supporting the 5 new Picks to Click. Last batch the Crew grew 5 Seedlings, and you''ve helped (Count) Seedlings grow.  BOX: Meet the Picks',
  'take user to video intro of the new Picks first, then the Grounds Crew hub listing the 5 Picks; Share opens the share card with the member''s personal tracked link',
  '',
  'TO DO',
  'High',
  'STAGING',
  'CI-CONTR-031',
  datetime('now'),
  datetime('now')
);

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'ce-19',
  'CONTRIB-19',
  'Contribution',
  'Support All 5 Gift Made',
  'Donor completes a Support all 5 gift (all 5 recommendations recorded under one parent_gift_id)',
  'Donor (parent/guardian for family accounts)',
  'Thank donor once for the whole gift and show five-fold impact',
  'Positive moment; explore The Grounds Crew',
  'You just supported all 5! 💚',
  'Your gift is supporting all 5 Picks to Click -- five Seedlings just moved closer to their goals. Thank you!',
  'You Just Supported All 5! 💚',
  'Thank you! Your gift of (Amount) is supporting all 5 of (this week''s / this month''s) Picks to Click: (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5). Five causes, one generous act -- and every one of them is closer to its goal because of you.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds on (Deposit Date), so no new acknowledgment is issued.  BOX: See Your Impact',
  'Thank you! Your gift is supporting all 5 Picks to Click -- five Seedlings are closer to their goals, and that''s 5 donations toward your next badge! [GREENHOUSE] Sent from your GreenHouse.  BOX: See Your Impact   |   Secondary line (non-members only): Want to do this every month automatically? Join The Grounds Crew.  BOX: Join The Grounds Crew',
  'take user to Support all 5 impact summary (all 5 Seedlings with amounts, progress bars, and any badges/goals this gift unlocked)',
  '',
  'TO DO',
  'High',
  'STAGING',
  'CI-CONTR-029',
  datetime('now'),
  datetime('now')
);


-- 4. Insert or Replace into production_notifications table

INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-029', 'ce-19', 'PROD-CONTRIB-19', 'Contribution', 'Support All 5 Gift Made',
  'Donor completes a Support all 5 gift (all 5 recommendations recorded under one parent_gift_id)', 'Donor (parent/guardian for family accounts)',
  'Thank donor once for the whole gift and show five-fold impact', 'Positive moment; explore The Grounds Crew',
  'You just supported all 5! 💚', 'Your gift is supporting all 5 Picks to Click -- five Seedlings just moved closer to their goals. Thank you!',
  'You Just Supported All 5! 💚', 'Thank you! Your gift of (Amount) is supporting all 5 of (this week''s / this month''s) Picks to Click: (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5). Five causes, one generous act -- and every one of them is closer to its goal because of you.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds on (Deposit Date), so no new acknowledgment is issued.  BOX: See Your Impact', 'Thank you! Your gift is supporting all 5 Picks to Click -- five Seedlings are closer to their goals, and that''s 5 donations toward your next badge! [GREENHOUSE] Sent from your GreenHouse.  BOX: See Your Impact   |   Secondary line (non-members only): Want to do this every month automatically? Join The Grounds Crew.  BOX: Join The Grounds Crew',
  'take user to Support all 5 impact summary (all 5 Seedlings with amounts, progress bars, and any badges/goals this gift unlocked)',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-029',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-029', datetime('now'), datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-030', 'ce-17', 'PROD-CONTRIB-17', 'Contribution', 'Grounds Crew Enrollment Confirmed',
  'Donor enrolls in The Grounds Crew (if the first contribution processes the same day, it is included in this message)', 'Donor (parent/guardian for family accounts)',
  'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (contribution amount, first charge at enrollment, charged each time a new batch launches -- no more than once per calendar month -- until cancelled, how to cancel)', 'Stay enrolled; meet the Picks',
  'Welcome to The Grounds Crew! 🌱', 'You''re on The Grounds Crew! Your first gift is already supporting this batch''s 5 Picks to Click.',
  'Welcome to The Grounds Crew! 🌱', 'Welcome to The Grounds Crew! You''ve made generosity a habit, and your first gift is already at work. Your (Amount) gift today is supporting (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5).

Each time a new set of 5 Picks to Click launches, your donation to Seedling Social Giving goes out and is regranted among those 5 Picks -- hand-picked Seedlings that deserve a boost -- no more than once per calendar month, and we''ll send you one note each time so you always know what you''re growing. [IF NEXT BATCH DATE ANNOUNCED] The next Picks launch on (Next Batch Date), so your next gift goes out then.

YOUR ENROLLMENT: Gift amount: (Amount). Funding source: (Card ending #### | GreenHouse balance). First contribution: today. Your contribution is charged when each new set of 5 Picks to Click launches. New Picks launch no more than once per calendar month, so you''ll never be charged more than once in a calendar month. If no new Picks launch in a month, you won''t be charged that month. You can change your amount or funding source, pause, or cancel anytime in the app under The Grounds Crew, or email support@seedlingsocial.org.  BOX: Meet Your Picks

Add the card/ACH or GreenHouse closing from Support All 5 Gift Made.',
  'Welcome to The Grounds Crew! Your first gift is supporting this batch''s 5 Picks. You''ll be charged (Amount) each time new Picks launch, no more than once per calendar month. Manage or cancel anytime in the app under The Grounds Crew.  BOX: Meet Your Picks',
  'take user to Grounds Crew hub (current 5 Picks, amounts, membership settings incl. cancel)',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-030',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-030', datetime('now'), datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-031', 'ce-18', 'PROD-CONTRIB-18', 'Contribution', 'Grounds Crew Batch Gift Processed',
  'New Picks batch released AND the member''s Grounds Crew charge for that batch processed (card charge succeeds or GreenHouse balance applied)', 'Donor (Grounds Crew member)',
  'Confirm the gift once, celebrate what the last batch grew, and introduce the new Picks', 'Open app to meet new Picks; stay enrolled; share',
  'Your Grounds Crew gift is out 💚', 'Your Grounds Crew gift is out! The Crew grew 5 Seedlings last batch. Come meet your 5 new Picks.   [IF AUTO-REPLENISH CHARGED] Your Grounds Crew gift is out, and Auto-Replenish added (Replenish Amount) to your GreenHouse.',
  'Your Grounds Crew Gift Is Out: Meet Your New Picks 💚', 'New Picks are here, and your (Amount) Grounds Crew gift just went out to support them.

[IF LAST BATCH RESULTS ENTERED] WHAT THE LAST BATCH GREW: Together the Crew gave (Crew Total Last Batch) to (Last Seedling 1), (Last Seedling 2), (Last Seedling 3), (Last Seedling 4), and (Last Seedling 5). [One result line per Seedling, e.g. (Last Seedling 1) reached (Percent) of its goal.]

MEET YOUR 5 NEW PICKS: (Seedling 1) for (Nonprofit 1) -- (One-line description). [Repeat for Seedlings 2-5.]

Since joining, you''ve helped (Count) Seedlings grow across (Crew Gift Count) Grounds Crew gifts. Your next gift goes out when the next set of Picks launches, no more than once per calendar month.  BOX: Meet the Picks   BOX: Share This Batch

[IF CREW MILESTONE] Opening line: The Grounds Crew just passed (Milestone) given, all time. You''re part of every dollar.
[IF NO LAST BATCH RESULTS ENTERED, OR FIRST BATCH DAY SINCE ENROLLMENT] Skip WHAT THE LAST BATCH GREW; open with: Your second Grounds Crew gift just went out to 5 brand-new Picks.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds to your GreenHouse, so no new acknowledgment is issued. GreenHouse balance remaining: (Balance).

[IF THIS GIFT TRIGGERED AUTO-REPLENISH -- required notice, ToS 4.3] AUTO-REPLENISH CHARGE: (Replenish Amount) was charged to (Card ending ####) on (Date) to refill your GreenHouse. This is a new donation to Seedling Social Giving; your acknowledgment is saved in your giving history. Change or turn off Auto-Replenish anytime in GreenHouse settings.  BOX: Meet the New Picks',
  'Your Grounds Crew gift is now supporting the 5 new Picks to Click. Last batch the Crew grew 5 Seedlings, and you''ve helped (Count) Seedlings grow.  BOX: Meet the Picks',
  'take user to video intro of the new Picks first, then the Grounds Crew hub listing the 5 Picks; Share opens the share card with the member''s personal tracked link',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-031',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-031', datetime('now'), datetime('now'), datetime('now')
);
