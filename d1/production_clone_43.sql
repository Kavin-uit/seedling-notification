-- 1. Ensure all missing notification rules exist in notification_rules table
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-GOV-010', 'Governance', 'Seedling Update Submitted for Review', 'Sponsor submits a Seedling update that includes a new video', 'Sponsor, Co-Sponsors', 'Acknowledge update submission', 'High', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None', 'Exact duplicates only', 'Hand-authored - Seedling update flow, 2026-09-02', 'Critical', '100', 'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience', 'Governance Action', '', 'Immediate', 'No', 'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents', 'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '', 'TPL-CI-GOV-010', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-GOV-011', 'Governance', 'Seedling Update Completed', 'Sponsor submits a Seedling update with no new video - merges automatically', 'Sponsor, Co-Sponsors', 'Confirm update completed', 'High', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None', 'Exact duplicates only', 'Hand-authored - Seedling update flow, 2026-09-02', 'Critical', '100', 'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience', 'Governance Action', '', 'Immediate', 'No', 'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents', 'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '', 'TPL-CI-GOV-011', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-GOV-012', 'Governance', 'Seedling Update Approved', 'Admin approves a Seedling update that included a new video', 'Sponsor, Co-Sponsors', 'Acknowledge update approval', 'Highest', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None', 'Exact duplicates only', 'Hand-authored - Seedling update flow, 2026-09-02', 'Critical', '100', 'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience', 'Governance Action', '', 'Immediate', 'No', 'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents', 'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '', 'TPL-CI-GOV-012', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-GOV-013', 'Governance', 'Seedling Approved - Scheduled Go-Live', 'Admin approves a new Seedling whose start date is in the future', 'Sponsor, Co-Sponsors', 'Acknowledge acceptance and confirm the go-live date', 'High', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None', 'Exact duplicates only', 'Hand-authored - Seedling scheduled go-live approval, 2026-10-08', 'Critical', '100', 'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience', 'Governance Action', '', 'Immediate', 'No', 'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents', 'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '', 'TPL-CI-GOV-013', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-001', 'Manual', '5 Picks to Click', 'Admin triggers manual broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Showcase 5 hand-picked Seedlings to drive engagement and donations', 'Medium', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - 5 Picks to Click admin broadcast, 2026-09-30', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent 5 Picks to Click.', 'Opportunity', 'LastPush', 'Deliver because an admin sent 5 Picks to Click.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-001', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-002', 'Manual', 'Introducing The Grounds Crew', 'Admin sends Grounds Crew intro broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Introduce The Grounds Crew subscription program', 'High', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - Grounds Crew intro admin broadcast, 2026-10-05', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent Introducing The Grounds Crew.', 'Opportunity', 'LastPush', 'Deliver because an admin sent Introducing The Grounds Crew.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-002', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-003', 'Manual', 'Welcome to Seedling', 'Admin sends Welcome to Seedling broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Re-engage users with Seedling mission and video', 'Medium', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - Welcome to Seedling admin broadcast, 2026-10-06', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent Welcome to Seedling.', 'Opportunity', 'LastPush', 'Deliver because an admin sent Welcome to Seedling.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-003', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-004', 'Manual', 'How Your GreenHouse Works', 'Admin sends How Your GreenHouse Works broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Educate users on GreenHouse giving wallet', 'Medium', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - How Your GreenHouse Works admin broadcast, 2026-10-06', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent How Your GreenHouse Works.', 'Opportunity', 'LastPush', 'Deliver because an admin sent How Your GreenHouse Works.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-004', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-005', 'Manual', 'Seedling Birthday Challenge', 'Admin sends Birthday Challenge broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Encourage users to dedicate upcoming birthday to a cause', 'Medium', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - Seedling Birthday Challenge admin broadcast, 2026-10-06', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent the Seedling Birthday Challenge.', 'Opportunity', 'LastPush', 'Deliver because an admin sent the Seedling Birthday Challenge.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-005', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-006', 'Manual', 'What''s New on Seedling', 'Admin sends What''s New on Seedling broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Tell users what''s new on Seedling', 'Medium', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - What''s New on Seedling admin broadcast, 2026-10-09', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent What''s New on Seedling.', 'Opportunity', 'LastPush', 'Deliver because an admin sent What''s New on Seedling.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-006', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-MANU-007', 'Manual', 'Seedling Spotlight Broadcast', 'Admin triggers spotlight broadcast linking directly to a specific Seedling campaign', 'All Users (excluding Admins), or targeted segment', 'Spotlight a critical or urgent Seedling campaign', 'High', 'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours', 'Suppress competing manual pushes', 'Hand-authored - Seedling Spotlight admin broadcast', 'Interruptive', '80', 'Yes', 'No', 'LastPush', 'Manual Broadcast', '', 'Immediate', 'No', 'Deliver because an admin sent Seedling Spotlight Broadcast.', 'Opportunity', 'LastPush', 'Deliver because an admin sent Seedling Spotlight Broadcast.', 'All Users (excluding Admins)', '', 'TPL-CI-MANU-007', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-OPP-172', 'Opportunity', 'Year-End Giving Celebration', 'Year-End Season (Late December)', 'All Users', 'Inspire year-end generosity and celebration', 'High', 'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine''s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only.', '24 hours', 'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '75', 'No', 'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '', 'Best moment today', 'Yes', 'Deliver only if strongest opportunity available today.', 'Opportunity', 'OpportunityToday, LastPush', 'Deliver only if strongest opportunity available today.', 'All Users', '', 'TPL-CI-OPP-172', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-OPP-173', 'Opportunity', 'Year-End Tax Giving Reminder', 'December 28-30 Tax Giving Deadlines', 'All Users', 'Maximize charitable deductions before year-end', 'High', 'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine''s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only.', '24 hours', 'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '75', 'No', 'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '', 'Best moment today', 'Yes', 'Deliver only if strongest opportunity available today.', 'Opportunity', 'OpportunityToday, LastPush', 'Deliver only if strongest opportunity available today.', 'All Users', '', 'TPL-CI-OPP-173', '', datetime('now'), datetime('now'));
INSERT OR REPLACE INTO notification_rules (rule_id, engine, rule_name, trigger, audience, communication_objective, priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook, attention_class, candidate_score, guaranteed_experience, batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group, timing, merge_policy, default_decision_reason, experience_type, memory_keys, decision_reason_template, candidate_audiences, candidate_experiences, template_id, change_notes, created_at, updated_at) VALUES ('CI-OPP-174', 'Opportunity', 'One Final Gift - Final Hours', 'December 31st final countdown to midnight', 'All Users', 'Final push for year-end giving before midnight', 'Highest', 'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as reach channel for users without app.', '24 hours', 'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '80', 'No', 'Yes', 'Opportunity push already used today; last push timestamp', 'Return Opportunity', '', 'Best moment today', 'Yes', 'Deliver only if strongest opportunity available today.', 'Opportunity', 'OpportunityToday, LastPush', 'Deliver only if strongest opportunity available today.', 'All Users', '', 'TPL-CI-OPP-174', '', datetime('now'), datetime('now'));

-- 2. Clone the 43 target rules into production_notifications table
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-001', 'contrib-1', 'PROD-CONTRIB-1', 'Contribution', 'Donation Made via Credit/Debit Card', 'User successfully makes a donation using a credit or debit card', 'Donors',
  'Acknowledge donation and express gratitude', 'View Seedling receipt and share impact', 'Thank you for your donation!', 'Your donation to Seedling has been processed. Thank you for your support!',
  'Donation Receipt', 'Thank you for donating via credit/debit card. Your donation receipt is attached.', 'Your donation has been processed successfully. View your receipt and track campaign progress.', 'View Receipt', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-001',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-CONTR-001', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-004', 'contrib-3', 'PROD-CONTRIB-3', 'Contribution', 'ACH Donation Failed', 'ACH transfer fails due to insufficient funds or incorrect account details', 'Donors',
  'Alert user of failed payment and request updated payment details', 'Retry payment with updated payment method', 'ACH Donation Failed', 'Your recent bank transfer donation failed. Please check your payment details.',
  'Important: ACH Donation Failed', 'We could not process your bank transfer donation. Please update your payment information to retry.', 'Your ACH donation could not be processed. Please verify your bank details.', 'Update Payment Method', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-004',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-CONTR-004', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-005', 'contrib-4', 'PROD-CONTRIB-4', 'Contribution', 'ACH Donation Pending', 'ACH donation initiated and waiting for bank clearance', 'Donors',
  'Inform donor that ACH transfer is processing', 'Wait for bank clearance confirmation', 'ACH Donation Processing', 'Your bank transfer donation is pending. We will notify you once cleared.',
  'ACH Donation Pending Confirmation', 'Your ACH donation has been initiated and is currently clearing with your bank.', 'Your ACH donation is in process. It typically takes 2-3 business days to clear.', 'View Donation Status', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-005',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-CONTR-005', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-007', 'contrib-6', 'PROD-CONTRIB-6', 'Contribution', 'GreenHouse Auto-Reload', 'Balance falls below threshold and auto-reload is successfully triggered', 'Account holders',
  'Confirm GreenHouse wallet reload', 'Review updated GreenHouse balance', 'GreenHouse Auto-Reloaded', 'Your GreenHouse balance was auto-reloaded successfully.',
  'GreenHouse Auto-Reload Receipt', 'Your GreenHouse balance has been automatically reloaded per your settings.', 'GreenHouse reloaded successfully. Your giving balance is up to date.', 'View GreenHouse', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-007',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-CONTR-007', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-008', 'contrib-7', 'PROD-CONTRIB-7', 'Contribution', 'GreenHouse Auto-Reload Failed', 'Auto-reload charge fails on configured payment source', 'Account holders',
  'Prompt user to fix payment method for auto-reload', 'Update payment card to resume automated giving', 'Auto-Reload Failed', 'We could not reload your GreenHouse balance. Please update your card.',
  'Urgent: GreenHouse Auto-Reload Failed', 'Your auto-reload did not go through. Please update your billing details to maintain uninterrupted giving.', 'Auto-reload failed. Tap to update your payment source.', 'Update Payment Source', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-008',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-CONTR-008', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-009', 'contrib-8', 'PROD-CONTRIB-8', 'Contribution', 'GreenHouse Balance Low', 'Balance drops below threshold without auto-reload enabled', 'Account holders',
  'Remind donor to reload GreenHouse wallet', 'Top up giving balance', 'GreenHouse Balance Low', 'Your GreenHouse balance is running low. Top up now to keep supporting causes.',
  'Your GreenHouse Balance Is Low', 'Your giving balance is running low. Add funds to continue supporting your favorite Seedlings.', 'Your balance is low. Tap to add funds to your GreenHouse.', 'Add Funds', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-009',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-CONTR-009', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-010', 'contrib-9', 'PROD-CONTRIB-9', 'Contribution', 'GreenHouse Balance Low Auto Reload', 'Balance low alert before automated reload executes', 'Account holders',
  'Advance notice of upcoming reload', 'Review scheduled reload charge', 'Upcoming GreenHouse Reload', 'Your GreenHouse balance is low; an auto-reload will be processed soon.',
  'Upcoming GreenHouse Auto-Reload Notice', 'Heads up: your GreenHouse balance reached your reload threshold. An automatic deposit is scheduled.', 'Your balance reached threshold. Auto-reload is scheduled.', 'Manage Settings', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-010',
  'READY FOR PROD', 'Low', 'PROD', 'CI-CONTR-010', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-011', 'contrib-10', 'PROD-CONTRIB-10', 'Contribution', 'GreenHouse Deposit Added', 'Manual deposit added to GreenHouse wallet', 'Account holders',
  'Confirm manual deposit to wallet', 'View new available balance', 'Deposit Added to GreenHouse', 'Funds have been added to your GreenHouse wallet.',
  'Deposit Confirmation', 'Your deposit into GreenHouse is complete and ready to deploy to causes.', 'Deposit complete! Your GreenHouse balance has increased.', 'View GreenHouse', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-011',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-CONTR-011', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-012', 'contrib-11', 'PROD-CONTRIB-11', 'Contribution', 'GreenHouse Donation Made', 'Donation completed using GreenHouse wallet balance', 'Donors',
  'Acknowledge donation made from wallet', 'View campaign impact and updated balance', 'Donation Made from GreenHouse', 'You donated to Seedling using your GreenHouse balance.',
  'GreenHouse Donation Confirmation', 'Your donation using GreenHouse funds was successful. Thank you for making a difference!', 'Donation successful from GreenHouse balance.', 'View Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-012',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-CONTR-012', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-014', 'contrib-12', 'PROD-CONTRIB-12', 'Contribution', 'Payment Method Added', 'New credit card or bank account saved', 'Users',
  'Confirm payment method setup for security', 'Review wallet and verify authorization', 'New Payment Method Added', 'A new payment method was added to your account.',
  'Security Notice: Payment Method Added', 'A new payment method was registered on your Seedling account. If this wasn''t you, contact support immediately.', 'New payment method saved successfully.', 'View Payment Methods', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-014',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-014', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-015', 'contrib-13', 'PROD-CONTRIB-13', 'Contribution', 'Payment Method Expiring', 'Card expiration date approaching within 30 days', 'Users',
  'Encourage updating card before expiration', 'Update card expiration details', 'Payment Method Expiring Soon', 'Your credit card on file is expiring soon. Update it to keep giving active.',
  'Action Required: Card Expiring Soon', 'Your credit card is set to expire soon. Please update your card details to prevent payment disruptions.', 'Your payment card will expire soon. Tap to update.', 'Update Card', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-015',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-CONTR-015', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-016', 'contrib-14', 'PROD-CONTRIB-14', 'Contribution', 'Payment Method Preferences Updated', 'Default payment method or billing settings altered', 'Users',
  'Confirm payment preferences changes', 'Review updated billing configuration', 'Payment Preferences Updated', 'Your default payment method has been updated.',
  'Payment Preferences Changed', 'We updated your payment preferences as requested.', 'Default payment method preferences saved.', 'View Settings', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-016',
  'READY FOR PROD', 'Low', 'PROD', 'CI-CONTR-016', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-018', 'contrib-16', 'PROD-CONTRIB-16', 'Contribution', 'Receipt Downloaded', 'User downloads tax receipt / transaction receipt', 'Donors',
  'Confirm receipt retrieval', 'Store or review tax document', 'Receipt Downloaded', 'Your donation receipt has been downloaded successfully.',
  'Your Donation Receipt', 'Here is a copy of your requested donation receipt for tax records.', 'Receipt downloaded successfully.', 'View Receipts', 'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-018',
  'READY FOR PROD', 'Low', 'PROD', 'CI-CONTR-018', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-001', 'gov-1', 'PROD-GOV-1', 'Governance', 'Seedling Submitted for Review', 'Creator submits seedling for compliance/admin approval', 'Sponsor, Co-Sponsors',
  'Acknowledge submission and set expectations', 'Track approval status in dashboard', 'Seedling Submitted for Review', 'Your Seedling was submitted for review. We will notify you once approved!',
  'Seedling Under Review', 'Thanks for creating a Seedling! Our team is reviewing it to ensure compliance.', 'Your Seedling is currently in review. We will notify you once approved.', 'Track Status', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-001',
  'READY FOR PROD', 'High', 'PROD', 'CI-GOV-001', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-002', 'gov-2', 'PROD-GOV-2', 'Governance', 'Seedling Approved', 'Admin approves seedling to go live immediately', 'Sponsor, Co-Sponsors',
  'Congratulate creator and encourage immediate sharing', 'Share Seedling with community', 'Congratulations -- your Seedling is Live!', 'Your Seedling has been approved and is now live! Start sharing it with your community.',
  'Your Seedling Is Live!', 'Congratulations! Your Seedling has been approved and is now accepting donations.', 'Your Seedling has been approved and is now live! Time to start sharing it with your community.  BOX: Share', 'Share Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-002',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-GOV-002', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-003', 'gov-3', 'PROD-GOV-3', 'Governance', 'Seedling Rejected', 'Admin declines seedling submission with reason notes', 'Sponsor, Co-Sponsors',
  'Explain rejection clearly and provide actionable revision steps', 'Edit Seedling and resubmit for review', 'Action Needed on Your Seedling', 'Your Seedling needs changes before it can go live. Tap to see reviewer feedback.',
  'Update Required for Your Seedling', 'Our team reviewed your Seedling and noted adjustments needed before launch.', 'Your Seedling requires revisions before approval. Please review feedback and resubmit.', 'Review Feedback', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-003',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-GOV-003', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-004', 'gov-4', 'PROD-GOV-4', 'Governance', 'Comment Reported', 'User flags a comment for community guidelines violation', 'Reporter',
  'Acknowledge moderation report and reassure user', 'Awaiting moderation team review', 'Report Received', 'Thank you for helping keep Seedling safe. We are reviewing the reported comment.',
  'Comment Report Received', 'We received your report regarding a comment. Our moderation team is investigating.', 'Thanks for reporting. We review flagged comments promptly to ensure a welcoming community.', 'Close', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-004',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-GOV-004', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-005', 'gov-5', 'PROD-GOV-5', 'Governance', 'Comment Removed', 'Admin deletes comment following violation confirmation', 'Commenter',
  'Notify commenter of removal and reinforce guidelines', 'Review Community Guidelines', 'Comment Removed', 'A comment you posted was removed for violating Community Guidelines.',
  'Notice: Comment Removed', 'Your comment has been removed because it violated our Community Guidelines.', 'Your comment has been removed for violating Community Guidelines.', 'Community Guidelines', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-005',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-GOV-005', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-007', 'rule-ci-gov-007', 'PROD-GOV-7', 'Governance', 'Temporary Account Restriction', 'Offending activity triggers temporary account limitation', 'Commenter',
  'Notify restriction clearly and specify limitation scope', 'Review account standing and contact support if needed', 'Your account is temporarily restricted', 'Your account has been temporarily restricted while we review recent activity.',
  'Your Account Is Temporarily Restricted', 'Your account has been temporarily restricted while we review recent activity. Some features will be unavailable in the meantime.  BOX: View Account Status', 'Some account features are temporarily unavailable while we review your account. BOX: Account', 'View Account Status', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-007',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-GOV-007', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-008', 'rule-ci-gov-008', 'PROD-GOV-8', 'Governance', 'Account Restored', 'Account reinstatement approved after review', 'Commenter',
  'Notify full account restoration warmly', 'Resume regular platform activity', 'Welcome back!', 'Your account has been restored. Thank you for your patience.',
  'Welcome Back!', 'Thank you for your patience -- your account has been restored and is fully active again. We''re glad to have you back.  BOX: View Account', 'Thank you for your patience. Your account is fully active again. BOX: Settings', 'View Account', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-008',
  'READY FOR PROD', 'High', 'PROD', 'CI-GOV-008', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-009', 'rule-ci-gov-009', 'PROD-GOV-9', 'Governance', 'Comment Removed (Reporter Notification)', 'Resolution of flagged comment report', 'Reporter',
  'Close loop on report with resolution outcome', 'Confirm community safety action', 'Update on your report', 'Thanks for helping keep Seedling welcoming.',
  'Update on Your Report', 'Thanks for helping keep Seedling welcoming. The comment you reported has been removed for violating our Community Guidelines.', 'The comment you reported has been removed for violating our Community Guidelines.', 'Dismiss', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-009',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-GOV-009', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-010', 'rule-ci-gov-010', 'PROD-GOV-10', 'Governance', 'Seedling Update Submitted for Review', 'Sponsor submits a Seedling update that includes a new video', 'Sponsor, Co-Sponsors',
  'Acknowledge update submission', 'Review Seedling Update status', 'Your Seedling Update is in Review', 'Your Seedling Update is in Review. Once we have completed our review we''ll let you know!',
  'Seedling Update Under Review', 'Thanks! Your Seedling update has been submitted for review -- once we have completed our review we''ll let you know!  BOX: Review Status', 'Thanks! Your Seedling update has been submitted for review -- once we have completed our review we''ll let you know!  BOX: Review Status', 'Review Status', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-010',
  'READY FOR PROD', 'High', 'PROD', 'CI-GOV-010', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-011', 'rule-ci-gov-011', 'PROD-GOV-11', 'Governance', 'Seedling Update Completed', 'Sponsor submits a Seedling update with no new video - merges automatically', 'Sponsor, Co-Sponsors',
  'Confirm update completed instantly', 'View Updated Seedling', 'Your Seedling Update is Live', 'Your Seedling update has been saved and is now live -- no review was needed since no new video was added.',
  'Your Seedling Update Is Live', 'Your Seedling update has been saved and is now live -- no review was needed since no new video was added.', 'Your Seedling update has been saved and is now live -- no review was needed since no new video was added.', 'View Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-011',
  'READY FOR PROD', 'High', 'PROD', 'CI-GOV-011', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-012', 'rule-ci-gov-012', 'PROD-GOV-12', 'Governance', 'Seedling Update Approved', 'Admin approves a Seedling update that included a new video', 'Sponsor, Co-Sponsors',
  'Acknowledge update approval and encourage sharing', 'Share Updated Seedling', 'Congratulations -- your Seedling Update is Live!', 'Your Seedling update has been approved and is now live. Time to start sharing it with your community.  BOX: Share',
  'Your Seedling Update Is Approved', 'Your Seedling update has been approved and is now live. Time to start sharing it with your community.  BOX: Share', 'Your Seedling update has been approved and is now live. Time to start sharing it with your community.  BOX: Share', 'Share Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-012',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-GOV-012', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-gov-013', 'rule-ci-gov-013', 'PROD-GOV-13', 'Governance', 'Seedling Approved - Scheduled Go-Live', 'Admin approves a new Seedling whose start date is in the future', 'Sponsor, Co-Sponsors',
  'Acknowledge acceptance and confirm future launch date', 'Prepare to share the Seedling when it goes live', 'You''re approved!', 'Your Seedling has been approved -- it''ll go live on your scheduled start date!',
  'Your Seedling Is Approved', 'Great news -- your Seedling has been approved and will go live on Seedling on your scheduled start date. Use the time before launch to line up the friends, family, and community you''ll invite to support it.  BOX: View Seedling', 'Your Seedling has been approved and will go live on Seedling on your scheduled start date. Get ready to share it with your community when it launches.  BOX: View Seedling', 'View Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-GOV-013',
  'READY FOR PROD', 'High', 'PROD', 'CI-GOV-013', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-001', 'rule-ci-manu-001', 'PROD-MANU-1', 'Manual', '5 Picks to Click', 'Admin triggers manual broadcast from CI Rulebook page', 'All Users (excluding Admins), or selected users',
  'Showcase 5 hand-picked Seedlings to drive engagement and donations', 'Browse and donate to featured Seedlings', '5 Picks to Click are here 🌱', 'Check out 5 incredible Seedlings chosen just for you. Tap to explore and support!',
  'Your 5 Picks to Click', 'Here are 5 inspiring Seedlings making a real difference right now. Take a look and support the ones that move you.  BOX: View 5 Picks', '5 Picks to Click! Discover 5 inspiring Seedlings hand-picked for our community today.  BOX: View 5 Picks', 'View 5 Picks', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-001',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-MANU-001', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-002', 'rule-ci-manu-002', 'PROD-MANU-2', 'Manual', 'Introducing The Grounds Crew', 'Admin sends Grounds Crew intro broadcast from CI Rulebook page', 'All Users (excluding Admins), or selected users',
  'Introduce The Grounds Crew subscription program', 'Join The Grounds Crew recurring support community', 'Meet The Grounds Crew 🌿', 'Join a passionate community making sustained monthly impact across active Seedlings.',
  'Introducing The Grounds Crew', 'Become part of something bigger. The Grounds Crew is our dedicated recurring support community.  BOX: Join The Grounds Crew', 'Welcome to The Grounds Crew! Learn how monthly recurring support transforms community causes.  BOX: Join The Grounds Crew', 'Join The Grounds Crew', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-002',
  'READY FOR PROD', 'High', 'PROD', 'CI-MANU-002', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-003', 'rule-ci-manu-003', 'PROD-MANU-3', 'Manual', 'Welcome to Seedling', 'Admin sends Welcome broadcast to community', 'All Users (excluding Admins)',
  'Re-engage users with Seedling mission and video', 'Watch welcome video and explore active causes', 'Welcome to Seedling 👋🌱', 'Discover how simple it is to grow compassion and support causes together.',
  'Welcome to Seedling -- How We Grow Good Together', 'Whether you''re here to start a cause or support one, we''re glad you''re part of Seedling. Watch our quick story.  BOX: Watch Video', 'Welcome to Seedling! Watch how our community comes together to fund meaningful change.  BOX: Watch Video', 'Watch Video', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-003',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-MANU-003', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-004', 'rule-ci-manu-004', 'PROD-MANU-4', 'Manual', 'How Your GreenHouse Works', 'Admin sends GreenHouse intro broadcast', 'All Users (excluding Admins)',
  'Educate users on GreenHouse giving wallet', 'Fund GreenHouse wallet balance', 'How Your GreenHouse Works 🏡🌱', 'Set aside funds on your terms and deploy donations whenever inspiration strikes.',
  'Maximize Your Giving with GreenHouse', 'Your GreenHouse makes giving effortless. Deposit funds anytime and donate with zero checkout friction.  BOX: Learn About GreenHouse', 'How Your GreenHouse Works: Learn how having a dedicated giving balance empowers your impact.  BOX: Learn About GreenHouse', 'Learn About GreenHouse', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-004',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-MANU-004', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-005', 'rule-ci-manu-005', 'PROD-MANU-5', 'Manual', 'Seedling Birthday Challenge', 'Admin sends Birthday Challenge broadcast', 'All Users (excluding Admins)',
  'Encourage users to dedicate upcoming birthday to a cause', 'Create a Birthday Seedling', 'Take the Seedling Birthday Challenge 🎂', 'Make your next birthday mean even more -- create a Birthday Seedling and invite friends to give with you. Tap to watch how.',
  'Take the Seedling Birthday Challenge', 'What if your birthday could help a cause you love grow? Take the Seedling Birthday Challenge: create a Birthday Seedling for a cause that matters to you, share it with friends and family, and invite them to celebrate you by giving. Watch the short video to see how it works, then start your Birthday Seedling.  BOX: Watch the Birthday Video', 'Take the Seedling Birthday Challenge! Turn your birthday into something meaningful by creating a Birthday Seedling and inviting friends to join you. Watch the short video to see how.  BOX: Watch the Birthday Video', 'Watch the Birthday Video', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-005',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-MANU-005', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-006', 'rule-ci-manu-006', 'PROD-MANU-6', 'Manual', 'What''s New on Seedling', 'Admin sends What''s New on Seedling broadcast', 'All Users (excluding Admins), or users picked by the admin',
  'Tell users what''s new on Seedling', 'Watch the What''s New video and try the latest features', 'See what''s new on Seedling ✨', 'We''ve been growing! Tap to watch a quick video on what''s new on Seedling.',
  'What''s new on Seedling', 'Seedling keeps growing, and we''ve added new features to make giving with your community even easier. Watch the short video to see what''s new and how to get the most out of it.  BOX: Watch What''s New', 'There''s something new on Seedling! Watch the short video to see the latest features and updates.  BOX: Watch What''s New', 'Watch What''s New', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-006',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-MANU-006', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-manu-007', 'rule-ci-manu-007', 'PROD-MANU-7', 'Manual', 'Seedling Spotlight Broadcast', 'Admin triggers spotlight broadcast linking directly to a specific Seedling campaign', 'All Users (excluding Admins), or targeted segment',
  'Spotlight a critical or urgent Seedling campaign', 'Support featured Seedling', 'Seedling Spotlight 🌱', 'Take a look at a special Seedling making an urgent difference right now.',
  'Special Seedling Spotlight', 'An inspiring cause needs our community''s support today. Explore this featured Seedling and help it reach its goal.  BOX: View Seedling', 'Special Spotlight: Support this featured Seedling today and help bring its mission to life.  BOX: View Seedling', 'View Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-MANU-007',
  'READY FOR PROD', 'High', 'PROD', 'CI-MANU-007', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-109', 'rule-ci-opp-109', 'PROD-OPP-109', 'Opportunity', 'National Dog Day', 'National Dog Day (August 26)', 'Dog rescue and adoption',
  'Celebrate and support animal welfare causes', 'Support animal rescue Seedlings', 'National Dog Day is here! 🐾', 'National Dog Day is here -- here are some Seedlings to support your canine friends.',
  'National Dog Day Is Here!', 'National Dog Day is here. Take a look at some Seedlings you might like to support the cause.  BOX: View Seedlings', 'National Dog Day is here! Celebrate by helping dogs in need find homes, care, and love.  BOX: View Seedlings', 'View Seedlings', 'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-109',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-OPP-109', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-163', 'rule-ci-opp-163', 'PROD-OPP-163', 'Opportunity', 'World Food Day', 'October 16', 'Food insecurity supporters',
  'UN observance - drive food donations', 'Support food relief Seedlings', 'World Food Day is here 🍞🌱', 'World Food Day is here. Help put food on more tables by supporting a Seedling today. 🍞🌱',
  'World Food Day Is Here', 'World Food Day is here. Take a look at some Seedlings you might like to support the cause.  BOX: View Seedlings', 'World Food Day is here. Take a look at some Seedlings fighting food insecurity that you can support.  BOX: View Seedlings', 'View Seedlings', 'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-163',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-OPP-163', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-172', 'rule-ci-opp-172', 'PROD-OPP-172', 'Opportunity', 'Year-End Giving Celebration', 'Year-End Season (Late December)', 'All Users',
  'Inspire year-end generosity and celebration', 'Donate or fund GreenHouse', 'Year-End Giving Season is here 🌱', 'Finish the year strong by growing something that lasts. Help a cause reach its year-end goal!',
  'Celebrate the Season of Giving', 'As the year comes to a close, your generosity can create lasting impact for causes that matter.  BOX: Explore Seedlings', 'Year-End Giving is here! Finish the year by helping causes close out their goals.  BOX: Explore Seedlings', 'Explore Seedlings', 'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-172',
  'READY FOR PROD', 'High', 'PROD', 'CI-OPP-172', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-173', 'rule-ci-opp-173', 'PROD-OPP-173', 'Opportunity', 'Year-End Tax Giving Reminder', 'December 28-30 Tax Giving Deadlines', 'All Users',
  'Maximize charitable deductions before year-end', 'Complete tax-deductible contributions', 'Year-End Tax Giving Reminder ⏰', 'Only days left to claim your 2026 charitable tax deductions! Give before midnight Dec 31.',
  'Make Your Year-End Tax-Deductible Gift', 'Make your charitable gifts count for this tax year. Donate directly to Seedlings or fund your GreenHouse today.  BOX: Fund Your GreenHouse', 'Time is running out for 2026 tax deductions. Make a final gift or fund your GreenHouse.  BOX: Fund Your GreenHouse', 'Fund Your GreenHouse', 'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-173',
  'READY FOR PROD', 'High', 'PROD', 'CI-OPP-173', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-opp-174', 'rule-ci-opp-174', 'PROD-OPP-174', 'Opportunity', 'One Final Gift - Final Hours', 'December 31st final countdown to midnight', 'All Users',
  'Final push for year-end giving before the clock strikes midnight', 'Make final donation of the year', 'Final Hours: One Last Gift for 2026 ⏳', 'There''s still time to do good before the year ends. Make one final gift tonight!',
  'Final Hours to Give This Year', 'Today is the final day of the year. Every gift today helps our communities grow good.  BOX: Make a Final Gift', 'Final hours of the year! Close out 2026 with an act of generosity.  BOX: Make a Final Gift', 'Make a Final Gift', 'Production Ready clone verified for production release.', 'Cloned from rule CI-OPP-174',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-OPP-174', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-part-001', 'part-1', 'PROD-PART-1', 'Participation', 'First App Session', 'First app session', 'User',
  'Welcome and establish participation habits', 'Explore Seedlings', 'Welcome to Seedling!', 'Welcome to Seedling! Explore active causes and find what speaks to you.',
  'Welcome to the Seedling Community', 'We''re so excited to have you join our community of growers and supporters!', 'Welcome to Seedling! Take a moment to explore active causes.  BOX: Explore Seedlings', 'Explore Seedlings', 'Production Ready clone verified for production release.', 'Cloned from rule CI-PART-001',
  'READY FOR PROD', 'Medium', 'PROD', 'CI-PART-001', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-part-014', 'part-14', 'PROD-PART-14', 'Participation', 'Organization Followed', 'User follows a nonprofit organization', 'Follower',
  'Confirm follow and suggest related causes', 'View organization profile', 'You are following a new organization', 'You are now following this organization. You will receive updates about their Seedlings!',
  'Organization Follow Confirmed', 'You are now following this organization. Stay tuned for new updates and campaigns.', 'You followed this organization! We''ll keep you updated on their latest Seedlings.  BOX: View Profile', 'View Profile', 'Production Ready clone verified for production release.', 'Cloned from rule CI-PART-014',
  'READY FOR PROD', 'Low', 'PROD', 'CI-PART-014', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-part-015', 'part-15', 'PROD-PART-15', 'Participation', 'Grower Followed', 'User follows an individual Grower / Campaigner', 'Follower',
  'Confirm follow of grower', 'View grower profile and active campaigns', 'You are following a Grower', 'You are now following this grower. See their latest stories and campaigns!',
  'Grower Follow Confirmed', 'You''re now following this grower on Seedling.', 'You''re now following this grower. Tap to view their profile and active Seedlings.  BOX: View Grower', 'View Grower', 'Production Ready clone verified for production release.', 'Cloned from rule CI-PART-015',
  'READY FOR PROD', 'Low', 'PROD', 'CI-PART-015', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-part-041', 'part-41', 'PROD-PART-41', 'Participation', 'Co-Sponsor Invited', 'Grower sends co-sponsor invitation to a contact', 'Invited co-sponsor',
  'Invite user to co-sponsor a Seedling', 'Accept co-sponsorship', 'You''ve been invited to co-sponsor a Seedling!', 'Join as a co-sponsor and help grow this Seedling together.',
  'Invitation: Co-Sponsor a Seedling', 'You''ve been invited to co-sponsor a Seedling! Review the campaign and accept the invitation.  BOX: Review Invitation', 'You have a pending co-sponsor invitation. Tap to view and accept.  BOX: Review Invitation', 'Review Invitation', 'Production Ready clone verified for production release.', 'Cloned from rule CI-PART-041',
  'READY FOR PROD', 'High', 'PROD', 'CI-PART-041', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-part-042', 'part-42', 'PROD-PART-42', 'Participation', 'Co-Sponsor Invitation Responded to', 'Invited contact accepts or declines co-sponsorship', 'Seedling Creator / Sponsor',
  'Notify creator of co-sponsor response', 'View Seedling team', 'Co-Sponsor Invitation Update', 'An invited co-sponsor has responded to your invitation!',
  'Co-Sponsor Response Received', 'Your co-sponsor invitation was answered. Check your Seedling team.', 'An invitation to co-sponsor your Seedling was accepted!  BOX: View Team', 'View Team', 'Production Ready clone verified for production release.', 'Cloned from rule CI-PART-042',
  'READY FOR PROD', 'High', 'PROD', 'CI-PART-042', datetime('now'), datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-part-057', 'part-57', 'PROD-PART-57', 'Participation', 'Donation Received on Your Seedling', 'A donor contributes to user''s Seedling', 'Sponsor, Co-Sponsors',
  'Celebrate incoming donation and prompt thank-you note', 'Thank donor and view campaign progress', 'Someone donated to your Seedling! 🎉', 'Your Seedling just received a donation! Tap to see the update and thank your supporter.',
  'Good News: New Donation Received!', 'A supporter just contributed to your Seedling! Your cause is closer to its goal.  BOX: View Seedling', 'Someone just donated to your Seedling! Check out your updated progress.  BOX: View Seedling', 'View Seedling', 'Production Ready clone verified for production release.', 'Cloned from rule CI-PART-057',
  'READY FOR PROD', 'Highest', 'PROD', 'CI-PART-057', datetime('now'), datetime('now'), datetime('now')
);