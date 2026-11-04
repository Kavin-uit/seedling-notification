-- 1. Ensure Opportunity Engine Sheet is properly registered in engine_sheets

INSERT OR REPLACE INTO engine_sheets (
  engine_category, sheet_name, sheet_url, csv_export_url, enabled, created_at, updated_at
) VALUES (
  'Opportunity',
  'Opportunity Content Sheet',
  'https://docs.google.com/spreadsheets/d/1jD0q7YXiHRo6BAp64F36n6kE48xWonvZ/edit?gid=659053223#gid=659053223',
  'https://docs.google.com/spreadsheets/d/1jD0q7YXiHRo6BAp64F36n6kE48xWonvZ/export?format=csv&gid=659053223',
  1,
  datetime('now'),
  datetime('now')
);


-- 2. Insert or Replace the 4 Target Notification Rules into notification_rules

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
  'CI-OPP-172', 'Opportunity', 'Followed Supported All 5', 'Followed user completes Support all 5', 'Connected users', 'Leverage social proof; promote Support all 5',
  'Medium', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours', 'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.',
  'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70', 'No',
  'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '',
  'Best moment today', 'Yes -- one per recipient per parent gift / enrollment', 'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '', 'TPL-CI-OPP-172',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-092.', datetime('now'), datetime('now')
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
  'CI-OPP-173', 'Opportunity', 'Follower Joined The Grounds Crew', 'Follower enrolls in The Grounds Crew', 'Connected users', 'Leverage social proof; promote The Grounds Crew',
  'Medium', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours', 'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.',
  'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70', 'No',
  'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '',
  'Best moment today', 'Yes -- one per recipient per parent gift / enrollment', 'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '', 'TPL-CI-OPP-173',
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
  'CI-OPP-174', 'Opportunity', 'Followed Joined The Grounds Crew', 'Followed user enrolls in The Grounds Crew', 'Connected users', 'Leverage social proof; promote The Grounds Crew',
  'Medium', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours', 'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.',
  'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70', 'No',
  'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '',
  'Best moment today', 'Yes -- one per recipient per parent gift / enrollment', 'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '', 'TPL-CI-OPP-174',
  '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-092.', datetime('now'), datetime('now')
);


-- 3. Insert or Replace the 4 Target Scenarios in scenarios table

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'opp-171',
  'OPP-171',
  'Opportunity',
  'Follower Supported All 5',
  'Follower completes Support all 5',
  'Connected users',
  'Leverage social proof; promote Support all 5',
  'Support all 5',
  '(Name) supported all 5! 💚',
  '(Name), who follows you, just supported all 5 Picks to Click -- check them out.',
  '(Name) Supported All 5 Picks 💚',
  '(Name), who follows you, just supported all 5 of (this week''s / this month''s) Picks to Click. Take a look at the five Seedlings they helped grow -- you can support all 5 with one tap, too.  BOX: View the Picks',
  '',
  'take user to Picks to Click list with Support all 5 button',
  '',
  'TO DO',
  'Medium',
  'STAGING',
  'CI-OPP-171',
  datetime('now'),
  datetime('now')
);

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'opp-172',
  'OPP-172',
  'Opportunity',
  'Followed Supported All 5',
  'Followed user completes Support all 5',
  'Connected users',
  'Leverage social proof; promote Support all 5',
  'Support all 5',
  '(Name) supported all 5! 💚',
  '(Name), whom you follow, just supported all 5 Picks to Click -- check them out.',
  '(Name) Supported All 5 Picks 💚',
  '(Name), whom you follow, just supported all 5 of (this week''s / this month''s) Picks to Click. Take a look at the five Seedlings they helped grow -- you can support all 5 with one tap, too.  BOX: View the Picks',
  '',
  'take user to Picks to Click list with Support all 5 button',
  '',
  'TO DO',
  'Medium',
  'STAGING',
  'CI-OPP-172',
  datetime('now'),
  datetime('now')
);

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'opp-173',
  'OPP-173',
  'Opportunity',
  'Follower Joined The Grounds Crew',
  'Follower enrolls in The Grounds Crew',
  'Connected users',
  'Leverage social proof; promote The Grounds Crew',
  'Join The Grounds Crew',
  '(Name) joined The Grounds Crew 🌱',
  '(Name), who follows you, just joined The Grounds Crew -- supporting 5 Picks to Click every month.',
  '(Name) Joined The Grounds Crew 🌱',
  '(Name), who follows you, just joined The Grounds Crew, supporting this month''s 5 Picks to Click -- and next month''s, and the month after. Join them and make generosity a monthly habit.  BOX: Learn About The Grounds Crew',
  '',
  'take user to The Grounds Crew page',
  '',
  'TO DO',
  'Medium',
  'STAGING',
  'CI-OPP-173',
  datetime('now'),
  datetime('now')
);

INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  'opp-174',
  'OPP-174',
  'Opportunity',
  'Followed Joined The Grounds Crew',
  'Followed user enrolls in The Grounds Crew',
  'Connected users',
  'Leverage social proof; promote The Grounds Crew',
  'Join The Grounds Crew',
  '(Name) joined The Grounds Crew 🌱',
  '(Name), whom you follow, just joined The Grounds Crew -- supporting 5 Picks to Click every month.',
  '(Name) Joined The Grounds Crew 🌱',
  '(Name), whom you follow, just joined The Grounds Crew, supporting this month''s 5 Picks to Click -- and next month''s, and the month after. Join them and make generosity a monthly habit.  BOX: Learn About The Grounds Crew',
  '',
  'take user to The Grounds Crew page',
  '',
  'TO DO',
  'Medium',
  'STAGING',
  'CI-OPP-174',
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
  'prod-ci-opp-171', 'opp-171', 'PROD-OPP-171', 'Opportunity', 'Follower Supported All 5',
  'Follower completes Support all 5', 'Connected users',
  'Leverage social proof; promote Support all 5', 'Support all 5',
  '(Name) supported all 5! 💚', '(Name), who follows you, just supported all 5 Picks to Click -- check them out.',
  '(Name) Supported All 5 Picks 💚', '(Name), who follows you, just supported all 5 of (this week''s / this month''s) Picks to Click. Take a look at the five Seedlings they helped grow -- you can support all 5 with one tap, too.  BOX: View the Picks', '',
  'take user to Picks to Click list with Support all 5 button',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-171',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-OPP-171', datetime('now'), datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-172', 'opp-172', 'PROD-OPP-172', 'Opportunity', 'Followed Supported All 5',
  'Followed user completes Support all 5', 'Connected users',
  'Leverage social proof; promote Support all 5', 'Support all 5',
  '(Name) supported all 5! 💚', '(Name), whom you follow, just supported all 5 Picks to Click -- check them out.',
  '(Name) Supported All 5 Picks 💚', '(Name), whom you follow, just supported all 5 of (this week''s / this month''s) Picks to Click. Take a look at the five Seedlings they helped grow -- you can support all 5 with one tap, too.  BOX: View the Picks', '',
  'take user to Picks to Click list with Support all 5 button',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-172',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-OPP-172', datetime('now'), datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-173', 'opp-173', 'PROD-OPP-173', 'Opportunity', 'Follower Joined The Grounds Crew',
  'Follower enrolls in The Grounds Crew', 'Connected users',
  'Leverage social proof; promote The Grounds Crew', 'Join The Grounds Crew',
  '(Name) joined The Grounds Crew 🌱', '(Name), who follows you, just joined The Grounds Crew -- supporting 5 Picks to Click every month.',
  '(Name) Joined The Grounds Crew 🌱', '(Name), who follows you, just joined The Grounds Crew, supporting this month''s 5 Picks to Click -- and next month''s, and the month after. Join them and make generosity a monthly habit.  BOX: Learn About The Grounds Crew', '',
  'take user to The Grounds Crew page',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-173',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-OPP-173', datetime('now'), datetime('now'), datetime('now')
);

INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-174', 'opp-174', 'PROD-OPP-174', 'Opportunity', 'Followed Joined The Grounds Crew',
  'Followed user enrolls in The Grounds Crew', 'Connected users',
  'Leverage social proof; promote The Grounds Crew', 'Join The Grounds Crew',
  '(Name) joined The Grounds Crew 🌱', '(Name), whom you follow, just joined The Grounds Crew -- supporting 5 Picks to Click every month.',
  '(Name) Joined The Grounds Crew 🌱', '(Name), whom you follow, just joined The Grounds Crew, supporting this month''s 5 Picks to Click -- and next month''s, and the month after. Join them and make generosity a monthly habit.  BOX: Learn About The Grounds Crew', '',
  'take user to The Grounds Crew page',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-174',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-OPP-174', datetime('now'), datetime('now'), datetime('now')
);
