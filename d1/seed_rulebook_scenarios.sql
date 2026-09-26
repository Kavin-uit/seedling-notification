-- Seed all 409 RuleBook Scenarios into scenarios table
DELETE FROM scenarios WHERE engine_category = 'RuleBook';
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-001', 'CI-ID-001', 'RuleBook', 'Account Created', 'User registers', 'User',
  'Welcome and establish belonging', 'Tier 3 - Ambient/Digest', '[Identity] Account Created', 'In-App; rare milestone Push',
  'Account Created (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-002', 'CI-ID-002', 'RuleBook', 'Email Verification Required', 'Account created', 'User',
  'Verify identity', 'Tier 3 - Ambient/Digest', '[Identity] Email Verification Required', 'In-App; rare milestone Push',
  'Email Verification Required (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-003', 'CI-ID-003', 'RuleBook', 'Email Verified', 'Verification complete', 'User',
  'Reinforce progress', 'Tier 3 - Ambient/Digest', '[Identity] Email Verified', 'In-App; rare milestone Push',
  'Email Verified (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-004', 'CI-ID-004', 'RuleBook', 'Phone Verification Required', 'Phone added', 'User',
  'Secure account', 'Tier 3 - Ambient/Digest', '[Identity] Phone Verification Required', 'In-App; rare milestone Push',
  'Phone Verification Required (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-005', 'CI-ID-005', 'RuleBook', 'Phone Verified', 'Verification complete', 'User',
  'Confirm security', 'Tier 3 - Ambient/Digest', '[Identity] Phone Verified', 'In-App; rare milestone Push',
  'Phone Verified (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-006', 'CI-ID-006', 'RuleBook', 'Profile Incomplete', 'Required fields missing', 'User',
  'Encourage profile completion', 'Tier 3 - Ambient/Digest', '[Identity] Profile Incomplete', 'In-App; rare milestone Push',
  'Profile Incomplete (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-007', 'CI-ID-007', 'RuleBook', 'Profile Completed', 'Profile reaches 100%', 'User',
  'Celebrate progress', 'Tier 3 - Ambient/Digest', '[Identity] Profile Completed', 'In-App; rare milestone Push',
  'Profile Completed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-008', 'CI-ID-008', 'RuleBook', 'Profile Updated', 'User edits profile', 'User',
  'Confirm changes', 'Tier 3 - Ambient/Digest', '[Identity] Profile Updated', 'In-App; rare milestone Push',
  'Profile Updated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-009', 'CI-ID-009', 'RuleBook', 'Profile Photo Missing', 'No avatar', 'User',
  'Personalize identity', 'Tier 3 - Ambient/Digest', '[Identity] Profile Photo Missing', 'In-App; rare milestone Push',
  'Profile Photo Missing (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-010', 'CI-ID-010', 'RuleBook', 'Profile Photo Added', 'Photo uploaded', 'User',
  'Reinforce authenticity', 'Tier 3 - Ambient/Digest', '[Identity] Profile Photo Added', 'In-App; rare milestone Push',
  'Profile Photo Added (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-011', 'CI-ID-011', 'RuleBook', 'Interests Not Selected', 'No interests chosen', 'User',
  'Improve recommendations', 'Tier 3 - Ambient/Digest', '[Identity] Interests Not Selected', 'In-App; rare milestone Push',
  'Interests Not Selected (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-012', 'CI-ID-012', 'RuleBook', 'Interests Updated', 'Interests changed', 'User',
  'Acknowledge personalization', 'Tier 3 - Ambient/Digest', '[Identity] Interests Updated', 'In-App; rare milestone Push',
  'Interests Updated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-013', 'CI-ID-013', 'RuleBook', 'Location Added', 'Location saved', 'User',
  'Improve local relevance', 'Tier 3 - Ambient/Digest', '[Identity] Location Added', 'In-App; rare milestone Push',
  'Location Added (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-014', 'CI-ID-014', 'RuleBook', 'First Login', 'Initial login', 'User',
  'Begin journey', 'Tier 3 - Ambient/Digest', '[Identity] First Login', 'In-App; rare milestone Push',
  'First Login (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-015', 'CI-ID-015', 'RuleBook', 'Returning Login', 'Returning after absence', 'User',
  'Re-engage', 'Tier 3 - Ambient/Digest', '[Identity] Returning Login', 'In-App; rare milestone Push',
  'Returning Login (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-015', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-016', 'CI-ID-016', 'RuleBook', 'Inactive 7 Days', 'No activity', 'User',
  'Reconnect', 'Tier 3 - Ambient/Digest', '[Identity] Inactive 7 Days', 'In-App; rare milestone Push',
  'Inactive 7 Days (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-016', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-017', 'CI-ID-017', 'RuleBook', 'Inactive 30 Days', 'Extended inactivity', 'User',
  'Reignite interest', 'Tier 3 - Ambient/Digest', '[Identity] Inactive 30 Days', 'In-App; rare milestone Push',
  'Inactive 30 Days (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-017', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-018', 'CI-ID-018', 'RuleBook', 'Notification Permission Not Granted', 'Permission declined', 'User',
  'Explain value', 'Tier 3 - Ambient/Digest', '[Identity] Notification Permission Not Granted', 'In-App; rare milestone Push',
  'Notification Permission Not Granted (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-018', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-019', 'CI-ID-019', 'RuleBook', 'Notifications Enabled', 'Permission granted', 'User',
  'Confirm success', 'Tier 3 - Ambient/Digest', '[Identity] Notifications Enabled', 'In-App; rare milestone Push',
  'Notifications Enabled (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-019', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-020', 'CI-ID-020', 'RuleBook', 'Contacts Connected', 'Address book linked', 'User',
  'Expand network', 'Tier 3 - Ambient/Digest', '[Identity] Contacts Connected', 'In-App; rare milestone Push',
  'Contacts Connected (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-020', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-021', 'CI-ID-021', 'RuleBook', 'Social Account Connected', 'OAuth completed', 'User',
  'Simplify access', 'Tier 3 - Ambient/Digest', '[Identity] Social Account Connected', 'In-App; rare milestone Push',
  'Social Account Connected (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-021', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-022', 'CI-ID-022', 'RuleBook', 'First Organization Followed', 'First nonprofit followed', 'User',
  'Reinforce discovery', 'Tier 3 - Ambient/Digest', '[Identity] First Organization Followed', 'In-App; rare milestone Push',
  'First Organization Followed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-022', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-023', 'CI-ID-023', 'RuleBook', 'First Creator Followed', 'First Grower followed', 'User',
  'Build community', 'Tier 3 - Ambient/Digest', '[Identity] First Creator Followed', 'In-App; rare milestone Push',
  'First Creator Followed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-023', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-024', 'CI-ID-024', 'RuleBook', 'First Favorite Saved', 'First bookmark', 'User',
  'Encourage return visits', 'Tier 3 - Ambient/Digest', '[Identity] First Favorite Saved', 'In-App; rare milestone Push',
  'First Favorite Saved (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-024', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-025', 'CI-ID-025', 'RuleBook', 'Username Changed', 'Username updated', 'User',
  'Confirm identity change', 'Tier 3 - Ambient/Digest', '[Identity] Username Changed', 'In-App; rare milestone Push',
  'Username Changed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-025', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-026', 'CI-ID-026', 'RuleBook', 'Password Changed', 'Password updated', 'User',
  'Security confirmation', 'Tier 3 - Ambient/Digest', '[Identity] Password Changed', 'In-App; rare milestone Push',
  'Password Changed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-026', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-027', 'CI-ID-027', 'RuleBook', 'Password Reset Requested', 'Reset initiated', 'User',
  'Protect account', 'Tier 3 - Ambient/Digest', '[Identity] Password Reset Requested', 'In-App; rare milestone Push',
  'Password Reset Requested (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-027', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-028', 'CI-ID-028', 'RuleBook', 'Password Reset Completed', 'Reset successful', 'User',
  'Confirm security', 'Tier 3 - Ambient/Digest', '[Identity] Password Reset Completed', 'In-App; rare milestone Push',
  'Password Reset Completed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-028', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-029', 'CI-ID-029', 'RuleBook', 'New Device Login', 'New device detected', 'User',
  'Security awareness', 'Tier 3 - Ambient/Digest', '[Identity] New Device Login', 'In-App; rare milestone Push',
  'New Device Login (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-029', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-030', 'CI-ID-030', 'RuleBook', 'Suspicious Login Detected', 'Risk detected', 'User',
  'Protect account', 'Tier 3 - Ambient/Digest', '[Identity] Suspicious Login Detected', 'In-App; rare milestone Push',
  'Suspicious Login Detected (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-030', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-031', 'CI-ID-031', 'RuleBook', 'Account Locked', 'Security threshold reached', 'User',
  'Explain next steps', 'Tier 3 - Ambient/Digest', '[Identity] Account Locked', 'In-App; rare milestone Push',
  'Account Locked (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-031', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-032', 'CI-ID-032', 'RuleBook', 'Account Restored', 'Access reinstated', 'User',
  'Welcome back', 'Tier 3 - Ambient/Digest', '[Identity] Account Restored', 'In-App; rare milestone Push',
  'Account Restored (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-032', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-033', 'CI-ID-033', 'RuleBook', 'Terms Updated', 'Terms accepted', 'User',
  'Confirm compliance', 'Tier 3 - Ambient/Digest', '[Identity] Terms Updated', 'In-App; rare milestone Push',
  'Terms Updated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-033', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-034', 'CI-ID-034', 'RuleBook', 'Privacy Preferences Updated', 'Settings changed', 'User',
  'Confirm changes', 'Tier 3 - Ambient/Digest', '[Identity] Privacy Preferences Updated', 'In-App; rare milestone Push',
  'Privacy Preferences Updated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-034', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-035', 'CI-ID-035', 'RuleBook', 'Anniversary', 'One year since joining', 'User',
  'Celebrate membership', 'Tier 3 - Ambient/Digest', '[Identity] Anniversary', 'In-App; rare milestone Push',
  'Anniversary (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-035', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-036', 'CI-ID-036', 'RuleBook', 'Birthday', 'User birthday', 'User',
  'Strengthen relationship', 'Tier 3 - Ambient/Digest', '[Identity] Birthday', 'In-App; rare milestone Push',
  'Birthday (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-036', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-037', 'CI-ID-037', 'RuleBook', 'Referral Invitation Sent', 'User invites friend', 'User',
  'Reinforce advocacy', 'Tier 3 - Ambient/Digest', '[Identity] Referral Invitation Sent', 'In-App; rare milestone Push',
  'Referral Invitation Sent (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-037', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-038', 'CI-ID-038', 'RuleBook', 'Referral Joined', 'Friend creates account', 'User',
  'Celebrate success', 'Tier 3 - Ambient/Digest', '[Identity] Referral Joined', 'In-App; rare milestone Push',
  'Referral Joined (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-038', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-039', 'CI-ID-039', 'RuleBook', 'Referral Activated', 'Friend becomes active', 'User',
  'Reinforce network growth', 'Tier 3 - Ambient/Digest', '[Identity] Referral Activated', 'In-App; rare milestone Push',
  'Referral Activated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-039', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-040', 'CI-ID-040', 'RuleBook', 'Identity Verification Requested', 'Enhanced verification required', 'User',
  'Establish trust', 'Tier 3 - Ambient/Digest', '[Identity] Identity Verification Requested', 'In-App; rare milestone Push',
  'Identity Verification Requested (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-040', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-041', 'CI-ID-041', 'RuleBook', 'Identity Verification Approved', 'Verification completed', 'User',
  'Confirm trusted status', 'Tier 3 - Ambient/Digest', '[Identity] Identity Verification Approved', 'In-App; rare milestone Push',
  'Identity Verification Approved (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-041', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-042', 'CI-ID-042', 'RuleBook', 'Identity Verification Declined', 'Verification failed', 'User',
  'Provide guidance', 'Tier 3 - Ambient/Digest', '[Identity] Identity Verification Declined', 'In-App; rare milestone Push',
  'Identity Verification Declined (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-042', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-043', 'CI-ID-043', 'RuleBook', 'Account Deactivated', 'User deactivates account', 'User',
  'Confirm action', 'Tier 3 - Ambient/Digest', '[Identity] Account Deactivated', 'In-App; rare milestone Push',
  'Account Deactivated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-043', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-044', 'CI-ID-044', 'RuleBook', 'Account Reactivated', 'User returns', 'User',
  'Welcome back', 'Tier 3 - Ambient/Digest', '[Identity] Account Reactivated', 'In-App; rare milestone Push',
  'Account Reactivated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-044', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-045', 'CI-ID-045', 'RuleBook', 'Welcome Tour Started', 'First successful login', 'User',
  'Introduce core concepts', 'Tier 3 - Ambient/Digest', '[Identity] Welcome Tour Started', 'In-App; rare milestone Push',
  'Welcome Tour Started (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-045', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-046', 'CI-ID-046', 'RuleBook', 'Welcome Tour Completed', 'Guided tour finished', 'User',
  'Celebrate readiness', 'Tier 3 - Ambient/Digest', '[Identity] Welcome Tour Completed', 'In-App; rare milestone Push',
  'Welcome Tour Completed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-046', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-047', 'CI-ID-047', 'RuleBook', 'Skip Onboarding', 'User skips onboarding', 'User',
  'Leave door open to return', 'Tier 3 - Ambient/Digest', '[Identity] Skip Onboarding', 'In-App; rare milestone Push',
  'Skip Onboarding (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-047', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-048', 'CI-ID-048', 'RuleBook', 'Resume Onboarding', 'Incomplete onboarding detected', 'User',
  'Continue onboarding', 'Tier 3 - Ambient/Digest', '[Identity] Resume Onboarding', 'In-App; rare milestone Push',
  'Resume Onboarding (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-048', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-049', 'CI-ID-049', 'RuleBook', 'Preferred Language Selected', 'Language chosen', 'User',
  'Personalize experience', 'Tier 3 - Ambient/Digest', '[Identity] Preferred Language Selected', 'In-App; rare milestone Push',
  'Preferred Language Selected (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-049', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-050', 'CI-ID-050', 'RuleBook', 'Accessibility Preferences Updated', 'Accessibility settings changed', 'User',
  'Confirm accessibility', 'Tier 3 - Ambient/Digest', '[Identity] Accessibility Preferences Updated', 'In-App; rare milestone Push',
  'Accessibility Preferences Updated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-050', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-051', 'CI-ID-051', 'RuleBook', 'Dark Mode Enabled', 'Appearance changed', 'User',
  'Confirm preference', 'Tier 3 - Ambient/Digest', '[Identity] Dark Mode Enabled', 'In-App; rare milestone Push',
  'Dark Mode Enabled (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-051', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-052', 'CI-ID-052', 'RuleBook', 'Communication Preferences Updated', 'Notification/email settings changed', 'User',
  'Confirm preferences', 'Tier 3 - Ambient/Digest', '[Identity] Communication Preferences Updated', 'In-App; rare milestone Push',
  'Communication Preferences Updated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-052', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-053', 'CI-ID-053', 'RuleBook', 'Welcome Back After 90 Days', 'Long inactivity', 'User',
  'Reconnect emotionally', 'Tier 3 - Ambient/Digest', '[Identity] Welcome Back After 90 Days', 'In-App; rare milestone Push',
  'Welcome Back After 90 Days (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-053', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-054', 'CI-ID-054', 'RuleBook', 'First Session Completed', 'User exits first session', 'User',
  'Encourage second visit', 'Tier 3 - Ambient/Digest', '[Identity] First Session Completed', 'In-App; rare milestone Push',
  'First Session Completed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-054', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-055', 'CI-ID-055', 'RuleBook', 'Second Session Completed', 'Second visit', 'User',
  'Reinforce habit', 'Tier 3 - Ambient/Digest', '[Identity] Second Session Completed', 'In-App; rare milestone Push',
  'Second Session Completed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-055', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-056', 'CI-ID-056', 'RuleBook', 'First Week Anniversary', '7 days after signup', 'User',
  'Celebrate early journey', 'Tier 3 - Ambient/Digest', '[Identity] First Week Anniversary', 'In-App; rare milestone Push',
  'First Week Anniversary (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-056', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-057', 'CI-ID-057', 'RuleBook', 'First Month Anniversary', '30 days after signup', 'User',
  'Reflect on progress', 'Tier 3 - Ambient/Digest', '[Identity] First Month Anniversary', 'In-App; rare milestone Push',
  'First Month Anniversary (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-057', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-058', 'CI-ID-058', 'RuleBook', 'Organization Account Created', 'Nonprofit registers', 'Organization',
  'Welcome organization', 'Tier 3 - Ambient/Digest', '[Identity] Organization Account Created', 'In-App; rare milestone Push',
  'Organization Account Created (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-058', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-059', 'CI-ID-059', 'RuleBook', 'Organization Verified', 'Verification approved', 'Organization',
  'Confirm trusted status', 'Tier 3 - Ambient/Digest', '[Identity] Organization Verified', 'In-App; rare milestone Push',
  'Organization Verified (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-059', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-060', 'CI-ID-060', 'RuleBook', 'Corporate Account Created', 'Corporate registers', 'Corporate Admin',
  'Welcome corporate partner', 'Tier 3 - Ambient/Digest', '[Identity] Corporate Account Created', 'In-App; rare milestone Push',
  'Corporate Account Created (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-060', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-061', 'CI-ID-061', 'RuleBook', 'Creator Account Enabled', 'Creator capabilities granted', 'User',
  'Encourage storytelling', 'Tier 3 - Ambient/Digest', '[Identity] Creator Account Enabled', 'In-App; rare milestone Push',
  'Creator Account Enabled (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-061', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-062', 'CI-ID-062', 'RuleBook', 'Account Merge Completed', 'Duplicate accounts merged', 'User',
  'Confirm successful merge', 'Tier 3 - Ambient/Digest', '[Identity] Account Merge Completed', 'In-App; rare milestone Push',
  'Account Merge Completed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-062', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-063', 'CI-ID-063', 'RuleBook', 'Consent Granted', 'Marketing/privacy consent accepted', 'User',
  'Acknowledge preferences', 'Tier 3 - Ambient/Digest', '[Identity] Consent Granted', 'In-App; rare milestone Push',
  'Consent Granted (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-063', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-064', 'CI-ID-064', 'RuleBook', 'Consent Withdrawn', 'Consent revoked', 'User',
  'Respect preferences', 'Tier 3 - Ambient/Digest', '[Identity] Consent Withdrawn', 'In-App; rare milestone Push',
  'Consent Withdrawn (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-064', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-065', 'CI-ID-065', 'RuleBook', 'Data Export Requested', 'Privacy request', 'User',
  'Confirm request', 'Tier 3 - Ambient/Digest', '[Identity] Data Export Requested', 'In-App; rare milestone Push',
  'Data Export Requested (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-065', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-066', 'CI-ID-066', 'RuleBook', 'Data Export Ready', 'Export generated', 'User',
  'Deliver requested data', 'Tier 3 - Ambient/Digest', '[Identity] Data Export Ready', 'In-App; rare milestone Push',
  'Data Export Ready (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-066', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-067', 'CI-ID-067', 'RuleBook', 'Account Scheduled for Deletion', 'Deletion requested', 'User',
  'Allow reconsideration', 'Tier 3 - Ambient/Digest', '[Identity] Account Scheduled for Deletion', 'In-App; rare milestone Push',
  'Account Scheduled for Deletion (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-067', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-068', 'CI-ID-068', 'RuleBook', 'Account Permanently Deleted', 'Retention period expired', 'User',
  'Confirm deletion', 'Tier 3 - Ambient/Digest', '[Identity] Account Permanently Deleted', 'In-App; rare milestone Push',
  'Account Permanently Deleted (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-068', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-069', 'CI-ID-069', 'RuleBook', 'Username Available', 'Desired username becomes available', 'User',
  'Encourage personalization', 'Tier 3 - Ambient/Digest', '[Identity] Username Available', 'In-App; rare milestone Push',
  'Username Available (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-069', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-id-070', 'CI-ID-070', 'RuleBook', 'Verified Badge Awarded', 'Trust criteria met', 'User',
  'Recognize authenticity', 'Tier 3 - Ambient/Digest', '[Identity] Verified Badge Awarded', 'In-App; rare milestone Push',
  'Verified Badge Awarded (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Identity accumulates far more often than it interrupts.', 'Cooldown: Long • Suppression: Usually accumulate until meaningful milestone', 'Usually accumulate until a meaningful milestone.', 'Engine: Identity | Attention: Reflective | Score: 50 | Timing: Milestones and reflection | Memory: Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-ID-070', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-001', 'CI-DISC-001', 'RuleBook', 'Personalized Feed Available', 'User opens app', 'User',
  'Present relevant stories', 'Tier 3 - Ambient/Digest', '[Discovery] Personalized Feed Available', 'In-App only',
  'Personalized Feed Available (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-002', 'CI-DISC-002', 'RuleBook', 'New Seedling Matches Interests', 'Campaign published', 'User',
  'Inspire exploration', 'Tier 3 - Ambient/Digest', '[Discovery] New Seedling Matches Interests', 'In-App only',
  'New Seedling Matches Interests (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-003', 'CI-DISC-003', 'RuleBook', 'New Nonprofit Matches Interests', 'Organization joins', 'User',
  'Expand discovery', 'Tier 3 - Ambient/Digest', '[Discovery] New Nonprofit Matches Interests', 'In-App only',
  'New Nonprofit Matches Interests (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-004', 'CI-DISC-004', 'RuleBook', 'New Grower Matches Interests', 'Creator joins', 'User',
  'Build community', 'Tier 3 - Ambient/Digest', '[Discovery] New Grower Matches Interests', 'In-App only',
  'New Grower Matches Interests (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-005', 'CI-DISC-005', 'RuleBook', 'Trending Seedling', 'Engagement threshold reached', 'User',
  'Surface momentum', 'Tier 3 - Ambient/Digest', '[Discovery] Trending Seedling', 'In-App only',
  'Trending Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-006', 'CI-DISC-006', 'RuleBook', 'Trending Nonprofit', 'Organization trending', 'User',
  'Highlight impact', 'Tier 3 - Ambient/Digest', '[Discovery] Trending Nonprofit', 'In-App only',
  'Trending Nonprofit (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-007', 'CI-DISC-007', 'RuleBook', 'Trending Topic', 'Topic gains activity', 'User',
  'Increase awareness', 'Tier 3 - Ambient/Digest', '[Discovery] Trending Topic', 'In-App only',
  'Trending Topic (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-008', 'CI-DISC-008', 'RuleBook', 'Friend Follows Nonprofit', 'Friend activity', 'User',
  'Encourage social discovery', 'Tier 3 - Ambient/Digest', '[Discovery] Friend Follows Nonprofit', 'In-App only',
  'Friend Follows Nonprofit (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-009', 'CI-DISC-009', 'RuleBook', 'Friend Follows Grower', 'Friend activity', 'User',
  'Encourage social discovery', 'Tier 3 - Ambient/Digest', '[Discovery] Friend Follows Grower', 'In-App only',
  'Friend Follows Grower (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-010', 'CI-DISC-010', 'RuleBook', 'Friend Supports Seedling', 'Friend donation or engagement', 'User',
  'Leverage social proof', 'Tier 3 - Ambient/Digest', '[Discovery] Friend Supports Seedling', 'In-App only',
  'Friend Supports Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-011', 'CI-DISC-011', 'RuleBook', 'Friend Comments', 'Friend participates', 'User',
  'Encourage conversation', 'Tier 3 - Ambient/Digest', '[Discovery] Friend Comments', 'In-App only',
  'Friend Comments (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-012', 'CI-DISC-012', 'RuleBook', 'Friend Shares Story', 'Story published', 'User',
  'Promote authentic discovery', 'Tier 3 - Ambient/Digest', '[Discovery] Friend Shares Story', 'In-App only',
  'Friend Shares Story (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-013', 'CI-DISC-013', 'RuleBook', 'Nearby Seedling', 'Location match', 'User',
  'Promote local impact', 'Tier 3 - Ambient/Digest', '[Discovery] Nearby Seedling', 'In-App only',
  'Nearby Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-014', 'CI-DISC-014', 'RuleBook', 'Nearby Nonprofit', 'Location match', 'User',
  'Increase local engagement', 'Tier 3 - Ambient/Digest', '[Discovery] Nearby Nonprofit', 'In-App only',
  'Nearby Nonprofit (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-015', 'CI-DISC-015', 'RuleBook', 'Local Emergency', 'External event', 'User',
  'Highlight urgent need', 'Tier 3 - Ambient/Digest', '[Discovery] Local Emergency', 'In-App only',
  'Local Emergency (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-015', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-016', 'CI-DISC-016', 'RuleBook', 'Disaster Response Available', 'External feed', 'User',
  'Encourage immediate action', 'Tier 3 - Ambient/Digest', '[Discovery] Disaster Response Available', 'In-App only',
  'Disaster Response Available (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-016', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-017', 'CI-DISC-017', 'RuleBook', 'New Category Available', 'Platform expansion', 'User',
  'Encourage exploration', 'Tier 3 - Ambient/Digest', '[Discovery] New Category Available', 'In-App only',
  'New Category Available (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-017', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-018', 'CI-DISC-018', 'RuleBook', 'Continue Watching', 'Previous session', 'User',
  'Resume discovery', 'Tier 3 - Ambient/Digest', '[Discovery] Continue Watching', 'In-App only',
  'Continue Watching (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-018', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-019', 'CI-DISC-019', 'RuleBook', 'Recommended Because You Follow', 'Recommendation generated', 'User',
  'Increase relevance', 'Tier 3 - Ambient/Digest', '[Discovery] Recommended Because You Follow', 'In-App only',
  'Recommended Because You Follow (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-019', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-020', 'CI-DISC-020', 'RuleBook', 'Recommended Because Friends Support', 'Social recommendation', 'User',
  'Increase trust', 'Tier 3 - Ambient/Digest', '[Discovery] Recommended Because Friends Support', 'In-App only',
  'Recommended Because Friends Support (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-020', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-021', 'CI-DISC-021', 'RuleBook', 'Recommended Because You Donated', 'Behavioral recommendation', 'User',
  'Deepen engagement', 'Tier 3 - Ambient/Digest', '[Discovery] Recommended Because You Donated', 'In-App only',
  'Recommended Because You Donated (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-021', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-022', 'CI-DISC-022', 'RuleBook', 'Recommended Because You Watched', 'Behavioral recommendation', 'User',
  'Continue exploration', 'Tier 3 - Ambient/Digest', '[Discovery] Recommended Because You Watched', 'In-App only',
  'Recommended Because You Watched (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-022', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-023', 'CI-DISC-023', 'RuleBook', 'Hidden Gem Discovered', 'Equity algorithm', 'User',
  'Increase equitable exposure', 'Tier 3 - Ambient/Digest', '[Discovery] Hidden Gem Discovered', 'In-App only',
  'Hidden Gem Discovered (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-023', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-024', 'CI-DISC-024', 'RuleBook', 'New Campaign from Followed Nonprofit', 'Campaign created', 'User',
  'Maintain relationship', 'Tier 3 - Ambient/Digest', '[Discovery] New Campaign from Followed Nonprofit', 'In-App only',
  'New Campaign from Followed Nonprofit (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-024', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-025', 'CI-DISC-025', 'RuleBook', 'New Campaign from Followed Grower', 'Campaign created', 'User',
  'Strengthen creator connection', 'Tier 3 - Ambient/Digest', '[Discovery] New Campaign from Followed Grower', 'In-App only',
  'New Campaign from Followed Grower (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-025', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-026', 'CI-DISC-026', 'RuleBook', 'Organization Near Fundraising Goal', 'Milestone reached', 'User',
  'Increase urgency', 'Tier 3 - Ambient/Digest', '[Discovery] Organization Near Fundraising Goal', 'In-App only',
  'Organization Near Fundraising Goal (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-026', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-027', 'CI-DISC-027', 'RuleBook', 'Because You Haven''t Explored', 'Diversity algorithm', 'User',
  'Broaden perspective', 'Tier 3 - Ambient/Digest', '[Discovery] Because You Haven''t Explored', 'In-App only',
  'Because You Haven''t Explored (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-027', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-028', 'CI-DISC-028', 'RuleBook', 'Your Feed Has Changed', 'Significant updates', 'User',
  'Encourage return', 'Tier 3 - Ambient/Digest', '[Discovery] Your Feed Has Changed', 'In-App only',
  'Your Feed Has Changed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-028', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-029', 'CI-DISC-029', 'RuleBook', 'New Search Trend', 'Popular search emerging', 'User',
  'Promote discovery', 'Tier 3 - Ambient/Digest', '[Discovery] New Search Trend', 'In-App only',
  'New Search Trend (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-029', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-030', 'CI-DISC-030', 'RuleBook', 'First Search Performed', 'Initial search', 'User',
  'Reinforce exploration', 'Tier 3 - Ambient/Digest', '[Discovery] First Search Performed', 'In-App only',
  'First Search Performed (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-030', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-031', 'CI-DISC-031', 'RuleBook', 'Friend Joins Seedling', 'Contact registers', 'User',
  'Strengthen social graph', 'Tier 3 - Ambient/Digest', '[Discovery] Friend Joins Seedling', 'In-App only',
  'Friend Joins Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-031', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-032', 'CI-DISC-032', 'RuleBook', 'People You May Know', 'Mutual connections', 'User',
  'Grow network', 'Tier 3 - Ambient/Digest', '[Discovery] People You May Know', 'In-App only',
  'People You May Know (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-032', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-033', 'CI-DISC-033', 'RuleBook', 'Organization Recommended by Friend', 'Social signal', 'User',
  'Increase trust', 'Tier 3 - Ambient/Digest', '[Discovery] Organization Recommended by Friend', 'In-App only',
  'Organization Recommended by Friend (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-033', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-034', 'CI-DISC-034', 'RuleBook', 'Cause You Haven''t Supported', 'Behavior analysis', 'User',
  'Broaden giving', 'Tier 3 - Ambient/Digest', '[Discovery] Cause You Haven''t Supported', 'In-App only',
  'Cause You Haven''t Supported (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-034', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-035', 'CI-DISC-035', 'RuleBook', 'New Organization Near You', 'Location', 'User',
  'Build local community', 'Tier 3 - Ambient/Digest', '[Discovery] New Organization Near You', 'In-App only',
  'New Organization Near You (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-035', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-036', 'CI-DISC-036', 'RuleBook', 'Campaign Shared Near You', 'Local sharing', 'User',
  'Promote local engagement', 'Tier 3 - Ambient/Digest', '[Discovery] Campaign Shared Near You', 'In-App only',
  'Campaign Shared Near You (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-036', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-037', 'CI-DISC-037', 'RuleBook', 'Breaking News Related Cause', 'News integration', 'User',
  'Provide context', 'Tier 3 - Ambient/Digest', '[Discovery] Breaking News Related Cause', 'In-App only',
  'Breaking News Related Cause (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-037', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-038', 'CI-DISC-038', 'RuleBook', 'Creator Goes Live', 'Live event', 'User',
  'Drive participation', 'Tier 3 - Ambient/Digest', '[Discovery] Creator Goes Live', 'In-App only',
  'Creator Goes Live (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-038', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-disc-039', 'CI-DISC-039', 'RuleBook', 'Limited-Time Feature', 'Platform promotion', 'User',
  'Increase feature adoption', 'Tier 3 - Ambient/Digest', '[Discovery] Limited-Time Feature', 'In-App only',
  'Limited-Time Feature (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Discovery guides attention after the app is open; it does not create a push interruption.', 'Cooldown: N/A • Suppression: Never initiate an interruption', 'Display in-app only after attention has already been earned.', 'Engine: Discovery | Attention: Passive | Score: 20 | Timing: During browsing | Memory: Current app/session activity; recent cause affinity',
  'TESTED', 'Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-DISC-039', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-001', 'CI-OPP-001', 'RuleBook', '1 day before Seedling closes', 'Number of days before Seedling closes', 'Sponsor - Co-Sponsor(s)',
  'Let Grower know when Seedling is about to close so they can do one final push to get final donations', 'Tier 2 - Event-Driven', '[Opportunity] 1 day before Seedling closes', 'One best Push today + In-App',
  '1 day before Seedling closes (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-002', 'CI-OPP-002', 'RuleBook', '1 day before Seedling closes', 'Number of days before Seedling closes', 'Donor',
  'Let potential donors know when Seedling is about to close so they can make donations', 'Tier 2 - Event-Driven', '[Opportunity] 1 day before Seedling closes', 'One best Push today + In-App',
  '1 day before Seedling closes (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-003', 'CI-OPP-003', 'RuleBook', '100th Donation Milestone', 'Donation milestone', 'Followers',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] 100th Donation Milestone', 'One best Push today + In-App',
  '100th Donation Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-004', 'CI-OPP-004', 'RuleBook', '7 days before Seedling closes', 'Number of days before Seedling closes', 'Sponsor - Co-Sponsor(s)',
  'Let Grower know when Seedling is about to close so they can do one final push to get final donations', 'Tier 2 - Event-Driven', '[Opportunity] 7 days before Seedling closes', 'One best Push today + In-App',
  '7 days before Seedling closes (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-005', 'CI-OPP-005', 'RuleBook', '7 days before Seedling closes', 'Number of days before Seedling closes', 'Donor',
  'Let potential donors know when Seedling is about to close so they can make donations', 'Tier 2 - Event-Driven', '[Opportunity] 7 days before Seedling closes', 'One best Push today + In-App',
  '7 days before Seedling closes (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-006', 'CI-OPP-006', 'RuleBook', 'A Cause That Matches Your Giving', 'Behavioral model', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] A Cause That Matches Your Giving', 'One best Push today + In-App',
  'A Cause That Matches Your Giving (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-007', 'CI-OPP-007', 'RuleBook', 'A Cause You May Also Like', 'Donation completed', 'Donor',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] A Cause You May Also Like', 'One best Push today + In-App',
  'A Cause You May Also Like (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-008', 'CI-OPP-008', 'RuleBook', 'A New Matching Opportunity', 'Matching pool exhausted', 'Interested users',
  'A matching gift is active for this campaign.', 'Tier 2 - Event-Driven', '[Opportunity] A New Matching Opportunity', 'One best Push today + In-App',
  'A New Matching Opportunity (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-009', 'CI-OPP-009', 'RuleBook', 'A Nonprofit You Follow Needs You', 'Organization update', 'Follower',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] A Nonprofit You Follow Needs You', 'One best Push today + In-App',
  'A Nonprofit You Follow Needs You (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-010', 'CI-OPP-010', 'RuleBook', 'Adopt a Shelter Pet Day', 'Adopt a Shelter Pet Day', 'Pet adoption',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Adopt a Shelter Pet Day', 'One best Push today + In-App',
  'Adopt a Shelter Pet Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-011', 'CI-OPP-011', 'RuleBook', 'American Heart Month', 'American Heart Month', 'Heart health',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] American Heart Month', 'One best Push today + In-App',
  'American Heart Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-012', 'CI-OPP-012', 'RuleBook', 'Anonymous Angel Opportunity', 'Season', 'Qualified users',
  'Complete campaign anonymously', 'Tier 2 - Event-Driven', '[Opportunity] Anonymous Angel Opportunity', 'One best Push today + In-App',
  'Anonymous Angel Opportunity (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-013', 'CI-OPP-013', 'RuleBook', 'Arbor Day', 'Arbor Day', 'Tree planting',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Arbor Day', 'One best Push today + In-App',
  'Arbor Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-014', 'CI-OPP-014', 'RuleBook', 'Autism Acceptance Month', 'April', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Autism Acceptance Month', 'One best Push today + In-App',
  'Autism Acceptance Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-015', 'CI-OPP-015', 'RuleBook', 'Back-to-College', 'August', 'Education supporters',
  'Academic cycle', 'Tier 3 - Ambient/Digest', '[Opportunity] Back-to-College', 'One best Push today + In-App',
  'Back-to-College (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-015', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-016', 'CI-OPP-016', 'RuleBook', 'Back-to-School Giving', 'Late July / August', 'All users',
  'Support education', 'Tier 3 - Ambient/Digest', '[Opportunity] Back-to-School Giving', 'One best Push today + In-App',
  'Back-to-School Giving (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-016', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-017', 'CI-OPP-017', 'RuleBook', 'Be the 100th Donor', 'Season', 'Qualified users',
  'Milestone', 'Tier 2 - Event-Driven', '[Opportunity] Be the 100th Donor', 'One best Push today + In-App',
  'Be the 100th Donor (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-017', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-018', 'CI-OPP-018', 'RuleBook', 'No donation to Seedling after 4 hours', 'Season', 'Qualified users',
  'Start momentum', 'Tier 2 - Event-Driven', '[Opportunity] No donation to Seedling after 4 hours', 'One best Push today + In-App',
  'No donation to Seedling after 4 hours (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-018', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-019', 'CI-OPP-019', 'RuleBook', 'Birthday - 30 Days', 'Recommendation generated', 'User',
  'Birthday is approaching and enough time remains to launch.', 'Tier 2 - Event-Driven', '[Opportunity] Birthday - 30 Days', 'One best Push today + In-App',
  'Birthday - 30 Days (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-019', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-020', 'CI-OPP-020', 'RuleBook', 'Birthday - 60 Days', 'Need published', 'Eligible User',
  'User''s birthday is 60 days away.', 'Tier 2 - Event-Driven', '[Opportunity] Birthday - 60 Days', 'One best Push today + In-App',
  'Birthday - 60 Days (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-020', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-021', 'CI-OPP-021', 'RuleBook', 'Birthday Giving Opportunity', 'Birthday upcoming', 'User',
  'User''s birthday is approaching.', 'Tier 2 - Event-Driven', '[Opportunity] Birthday Giving Opportunity', 'One best Push today + In-App',
  'Birthday Giving Opportunity (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-021', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-022', 'CI-OPP-022', 'RuleBook', 'Black History Month', 'February', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Black History Month', 'One best Push today + In-App',
  'Black History Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-022', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-023', 'CI-OPP-023', 'RuleBook', 'Breast Cancer Awareness Month', 'October', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Breast Cancer Awareness Month', 'One best Push today + In-App',
  'Breast Cancer Awareness Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-023', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-024', 'CI-OPP-024', 'RuleBook', 'Childhood Cancer Awareness Month', 'September', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Childhood Cancer Awareness Month', 'One best Push today + In-App',
  'Childhood Cancer Awareness Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-024', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-025', 'CI-OPP-025', 'RuleBook', 'Childhood Immunization Week', 'Childhood Immunization Week', 'Public health',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Childhood Immunization Week', 'One best Push today + In-App',
  'Childhood Immunization Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-025', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-026', 'CI-OPP-026', 'RuleBook', 'City Day of Service', 'City Day of Service', 'Municipal volunteer event',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] City Day of Service', 'One best Push today + In-App',
  'City Day of Service (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-026', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-027', 'CI-OPP-027', 'RuleBook', 'Cold Weather Shelter Need', 'Severe cold', 'Local users',
  'Weather-aware', 'Tier 2 - Event-Driven', '[Opportunity] Cold Weather Shelter Need', 'One best Push today + In-App',
  'Cold Weather Shelter Need (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-027', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-028', 'CI-OPP-028', 'RuleBook', 'Create Your First Seasonal Seedling', 'Nov 15-Dec 31', 'Eligible creators',
  'Encourage participation', 'Tier 3 - Ambient/Digest', '[Opportunity] Create Your First Seasonal Seedling', 'One best Push today + In-App',
  'Create Your First Seasonal Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-028', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-029', 'CI-OPP-029', 'RuleBook', 'Cyber Monday Matching', 'Cyber Monday', 'Online donors',
  'Digital shopping tie-in', 'Tier 2 - Event-Driven', '[Opportunity] Cyber Monday Matching', 'One best Push today + In-App',
  'Cyber Monday Matching (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-029', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-030', 'CI-OPP-030', 'RuleBook', 'Discover Another Cause', 'Eligibility changed', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Discover Another Cause', 'One best Push today + In-App',
  'Discover Another Cause (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-030', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-031', 'CI-OPP-031', 'RuleBook', 'Diwali Giving', 'Diwali Giving', 'Festival of Lights generosity',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Diwali Giving', 'One best Push today + In-App',
  'Diwali Giving (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-031', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-032', 'CI-OPP-032', 'RuleBook', 'Donation Anniversary', '1 year after donation', 'Previous donor',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Donation Anniversary', 'One best Push today + In-App',
  'Donation Anniversary (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-032', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-033', 'CI-OPP-033', 'RuleBook', 'Dormant Passion Reawakening', 'Dormant Passion Reawakening', 'Reconnect with past interests',
  'Recognition', 'Tier 2 - Event-Driven', '[Opportunity] Dormant Passion Reawakening', 'One best Push today + In-App',
  'Dormant Passion Reawakening (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-033', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-034', 'CI-OPP-034', 'RuleBook', 'Earth Day', 'Earth Day approaching', 'All users',
  'Support environmental causes', 'Tier 3 - Ambient/Digest', '[Opportunity] Earth Day', 'One best Push today + In-App',
  'Earth Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-034', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-035', 'CI-OPP-035', 'RuleBook', 'Earth Day Countdown', '30 days before Earth Day', 'Environmental supporters',
  'Planning window', 'Tier 3 - Ambient/Digest', '[Opportunity] Earth Day Countdown', 'One best Push today + In-App',
  'Earth Day Countdown (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-035', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-036', 'CI-OPP-036', 'RuleBook', 'Easter Outreach', 'Easter Outreach', 'Seasonal outreach and service',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Easter Outreach', 'One best Push today + In-App',
  'Easter Outreach (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-036', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-037', 'CI-OPP-037', 'RuleBook', 'Emergency Relief Appeal', 'Major breaking disaster', 'Relevant audience',
  'Time-sensitive', 'Tier 2 - Event-Driven', '[Opportunity] Emergency Relief Appeal', 'One best Push today + In-App',
  'Emergency Relief Appeal (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-037', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-038', 'CI-OPP-038', 'RuleBook', 'Employee Giving Campaign', 'Employee Giving Campaign', 'Company campaign',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Employee Giving Campaign', 'One best Push today + In-App',
  'Employee Giving Campaign (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-038', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-039', 'CI-OPP-039', 'RuleBook', 'Employer Giving Week', 'Corporate calendar', 'Employees',
  '', 'Tier 2 - Event-Driven', '[Opportunity] Employer Giving Week', 'One best Push today + In-App',
  'Employer Giving Week (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-039', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-040', 'CI-OPP-040', 'RuleBook', 'Employer Match', 'Goal nearly reached', 'User',
  'User''s employer matches donations.', 'Tier 2 - Event-Driven', '[Opportunity] Employer Match', 'One best Push today + In-App',
  'Employer Match (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-040', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-041', 'CI-OPP-041', 'RuleBook', 'Employer Match Available', 'Employer identified', 'User',
  'A matching gift is active for this campaign.', 'Tier 2 - Event-Driven', '[Opportunity] Employer Match Available', 'One best Push today + In-App',
  'Employer Match Available (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-041', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-042', 'CI-OPP-042', 'RuleBook', 'Extreme Heat Response', 'Heat emergency', 'Regional users',
  'Urgency', 'Tier 2 - Event-Driven', '[Opportunity] Extreme Heat Response', 'One best Push today + In-App',
  'Extreme Heat Response (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-042', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-043', 'CI-OPP-043', 'RuleBook', 'Father''s Day Tribute Seedling', 'Father''s Day', 'All users',
  'Honor loved ones', 'Tier 3 - Ambient/Digest', '[Opportunity] Father''s Day Tribute Seedling', 'One best Push today + In-App',
  'Father''s Day Tribute Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-043', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-044', 'CI-OPP-044', 'RuleBook', 'Final Week Countdown', 'Last week', 'All Users',
  'Urgency', 'Tier 2 - Event-Driven', '[Opportunity] Final Week Countdown', 'One best Push today + In-App',
  'Final Week Countdown (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-044', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-045', 'CI-OPP-045', 'RuleBook', 'Find a New Cause', 'Week 2', 'Returning donors',
  'Discovery', 'Tier 2 - Event-Driven', '[Opportunity] Find a New Cause', 'One best Push today + In-App',
  'Find a New Cause (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-045', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-046', 'CI-OPP-046', 'RuleBook', 'Finish Someone''s Campaign', 'Season', 'Qualified users',
  'Complete campaigns', 'Tier 2 - Event-Driven', '[Opportunity] Finish Someone''s Campaign', 'One best Push today + In-App',
  'Finish Someone''s Campaign (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-046', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-047', 'CI-OPP-047', 'RuleBook', 'First Day of Spring', 'Season begins', 'All users',
  'Seasonal optimism', 'Tier 3 - Ambient/Digest', '[Opportunity] First Day of Spring', 'One best Push today + In-App',
  'First Day of Spring (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-047', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-048', 'CI-OPP-048', 'RuleBook', 'First Donation Needed', 'No donations after 24 hours', 'Eligible users',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] First Donation Needed', 'One best Push today + In-App',
  'First Donation Needed (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-048', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-049', 'CI-OPP-049', 'RuleBook', 'First Snow', 'First Snow', 'Winter preparedness',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] First Snow', 'One best Push today + In-App',
  'First Snow (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-049', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-050', 'CI-OPP-050', 'RuleBook', 'Follower Created Seedling', 'Follower/Followed', 'User',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Follower Created Seedling', 'One best Push today + In-App',
  'Follower Created Seedling (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-050', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-051', 'CI-OPP-051', 'RuleBook', 'Followed Created Seedling', 'Follower/Followed', 'User',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Followed Created Seedling', 'One best Push today + In-App',
  'Followed Created Seedling (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-051', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-052', 'CI-OPP-052', 'RuleBook', 'Follower Made First Donation', 'Follower/Followed', 'User',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Follower Made First Donation', 'One best Push today + In-App',
  'Follower Made First Donation (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-052', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-053', 'CI-OPP-053', 'RuleBook', 'Followed Made First Donation', 'Follower/Followed', 'User',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Followed Made First Donation', 'One best Push today + In-App',
  'Followed Made First Donation (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-053', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-054', 'CI-OPP-054', 'RuleBook', 'Follower Reached Giving Milestone', 'Follower/Followed', 'User',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Follower Reached Giving Milestone', 'One best Push today + In-App',
  'Follower Reached Giving Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-054', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-055', 'CI-OPP-055', 'RuleBook', 'Followed Reached Giving Milestone', 'Follower/Followed', 'User',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Followed Reached Giving Milestone', 'One best Push today + In-App',
  'Followed Reached Giving Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-055', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-056', 'CI-OPP-056', 'RuleBook', 'Giving Season Kickoff', 'December 1', 'All users',
  'Launch year-end generosity', 'Tier 3 - Ambient/Digest', '[Opportunity] Giving Season Kickoff', 'One best Push today + In-App',
  'Giving Season Kickoff (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-056', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-057', 'CI-OPP-057', 'RuleBook', 'Giving Tuesday', 'Friend activity', 'User',
  'User has participated in year-end giving.', 'Tier 3 - Ambient/Digest', '[Opportunity] Giving Tuesday', 'One best Push today + In-App',
  'Giving Tuesday (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-057', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-058', 'CI-OPP-058', 'RuleBook', 'Goal 25% Complete', 'Campaign near goal', 'Interested users',
  'Real-time', 'Tier 2 - Event-Driven', '[Opportunity] Goal 25% Complete', 'One best Push today + In-App',
  'Goal 25% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-058', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-059', 'CI-OPP-059', 'RuleBook', 'Goal 50% Complete', 'Campaign near goal', 'Interested users',
  'Real-time', 'Tier 2 - Event-Driven', '[Opportunity] Goal 50% Complete', 'One best Push today + In-App',
  'Goal 50% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-059', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-060', 'CI-OPP-060', 'RuleBook', 'Goal 75% Complete', 'Campaign near goal', 'Interested users',
  'Real-time', 'Tier 2 - Event-Driven', '[Opportunity] Goal 75% Complete', 'One best Push today + In-App',
  'Goal 75% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-060', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-061', 'CI-OPP-061', 'RuleBook', 'Goal 90% Complete', 'Campaign near goal', 'Interested users',
  'Real-time', 'Tier 2 - Event-Driven', '[Opportunity] Goal 90% Complete', 'One best Push today + In-App',
  'Goal 90% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-061', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-062', 'CI-OPP-062', 'RuleBook', 'Graduation Season', 'May/June', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Graduation Season', 'One best Push today + In-App',
  'Graduation Season (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-062', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-063', 'CI-OPP-063', 'RuleBook', 'Grammys Week', 'Grammys Week', 'Music education',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Grammys Week', 'One best Push today + In-App',
  'Grammys Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-063', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-064', 'CI-OPP-064', 'RuleBook', 'GreenHouse Auto-Funding Reminder', 'Low GreenHouse balance', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] GreenHouse Auto-Funding Reminder', 'One best Push today + In-App',
  'GreenHouse Auto-Funding Reminder (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-064', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-065', 'CI-OPP-065', 'RuleBook', 'GreenHouse Funds Available', 'GreenHouse balance available', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] GreenHouse Funds Available', 'One best Push today + In-App',
  'GreenHouse Funds Available (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-065', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-066', 'CI-OPP-066', 'RuleBook', 'Seedling''s Grow Good Week', 'Grow Good Week', 'Annual Seedling campaign',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Seedling''s Grow Good Week', 'One best Push today + In-App',
  'Seedling''s Grow Good Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-066', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-067', 'CI-OPP-067', 'RuleBook', 'Hanukkah Giving', 'Hanukkah Giving', 'Holiday giving opportunities',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Hanukkah Giving', 'One best Push today + In-App',
  'Hanukkah Giving (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-067', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-068', 'CI-OPP-068', 'RuleBook', 'Heatwave Animal Rescue', 'Extreme heat', 'Animal supporters',
  'Weather-aware', 'Tier 2 - Event-Driven', '[Opportunity] Heatwave Animal Rescue', 'One best Push today + In-App',
  'Heatwave Animal Rescue (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-068', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-069', 'CI-OPP-069', 'RuleBook', 'Holiday Giving Challenge', 'December', 'All users',
  'Drive year-end generosity', 'Tier 3 - Ambient/Digest', '[Opportunity] Holiday Giving Challenge', 'One best Push today + In-App',
  'Holiday Giving Challenge (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-069', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-070', 'CI-OPP-070', 'RuleBook', 'Human Rights Day', 'December 10', 'Human rights supporters',
  'UN day', 'Tier 3 - Ambient/Digest', '[Opportunity] Human Rights Day', 'One best Push today + In-App',
  'Human Rights Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-070', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-071', 'CI-OPP-071', 'RuleBook', 'Hurricane Season', 'Season begins', 'Regional users',
  '', 'Tier 2 - Event-Driven', '[Opportunity] Hurricane Season', 'One best Push today + In-App',
  'Hurricane Season (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-071', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-072', 'CI-OPP-072', 'RuleBook', 'Independence Day', 'July 4 week', 'All users',
  'Channel celebration into giving', 'Tier 3 - Ambient/Digest', '[Opportunity] Independence Day', 'One best Push today + In-App',
  'Independence Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-072', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-073', 'CI-OPP-073', 'RuleBook', 'Inspired? Here''s Another Story', 'Story completed', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Inspired? Here''s Another Story', 'One best Push today + In-App',
  'Inspired? Here''s Another Story (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-073', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-074', 'CI-OPP-074', 'RuleBook', 'International Day of Charity', 'Sept 5', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] International Day of Charity', 'One best Push today + In-App',
  'International Day of Charity (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-074', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-075', 'CI-OPP-075', 'RuleBook', 'International Literacy Day', 'September 8', 'Education supporters',
  'UN day', 'Tier 3 - Ambient/Digest', '[Opportunity] International Literacy Day', 'One best Push today + In-App',
  'International Literacy Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-075', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-076', 'CI-OPP-076', 'RuleBook', 'International Volunteer Day', 'December 5', 'Volunteers',
  'UN day', 'Tier 3 - Ambient/Digest', '[Opportunity] International Volunteer Day', 'One best Push today + In-App',
  'International Volunteer Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-076', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-077', 'CI-OPP-077', 'RuleBook', 'International Women''s Day', 'March 8', 'Women''s causes supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] International Women''s Day', 'One best Push today + In-App',
  'International Women''s Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-077', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-078', 'CI-OPP-078', 'RuleBook', 'Invite Friends Opportunity', 'Low momentum detected', 'Supporter',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Invite Friends Opportunity', 'One best Push today + In-App',
  'Invite Friends Opportunity (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-078', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-079', 'CI-OPP-079', 'RuleBook', 'Join the Conversation', 'Season', 'Supporters',
  'Increase comments', 'Tier 2 - Event-Driven', '[Opportunity] Join the Conversation', 'One best Push today + In-App',
  'Join the Conversation (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-079', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-080', 'CI-OPP-080', 'RuleBook', 'Juneteenth', 'June 19', 'All users',
  'Promote equality-related causes', 'Tier 3 - Ambient/Digest', '[Opportunity] Juneteenth', 'One best Push today + In-App',
  'Juneteenth (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-080', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-081', 'CI-OPP-081', 'RuleBook', 'Labor Day', 'Week before', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Labor Day', 'One best Push today + In-App',
  'Labor Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-081', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-082', 'CI-OPP-082', 'RuleBook', 'LGBTQ+ Pride Month', 'June', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] LGBTQ+ Pride Month', 'One best Push today + In-App',
  'LGBTQ+ Pride Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-082', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-083', 'CI-OPP-083', 'RuleBook', 'Local Breaking Need', 'Local Breaking Need', 'Urgent nearby opportunity',
  '', 'Tier 2 - Event-Driven', '[Opportunity] Local Breaking Need', 'One best Push today + In-App',
  'Local Breaking Need (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-083', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-084', 'CI-OPP-084', 'RuleBook', 'Local Disaster Near User', 'Disaster within radius', 'Nearby users',
  'Geo-aware', 'Tier 2 - Event-Driven', '[Opportunity] Local Disaster Near User', 'One best Push today + In-App',
  'Local Disaster Near User (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-084', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-085', 'CI-OPP-085', 'RuleBook', 'Low Participation Seedling', 'Campaign stagnating', 'Relevant users',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Low Participation Seedling', 'One best Push today + In-App',
  'Low Participation Seedling (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-085', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-086', 'CI-OPP-086', 'RuleBook', 'Magic Moment: Anonymous Angel', 'CI detects user can fully fund remaining balance', 'Qualified donor',
  'Present a high-impact completion opportunity', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Anonymous Angel', 'One best Push today + In-App',
  'Magic Moment: Anonymous Angel (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-086', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-087', 'CI-OPP-087', 'RuleBook', 'Magic Moment: Be the First Donor', 'New Seedling has no donations', 'Likely supporters',
  'Encourage early momentum', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Be the First Donor', 'One best Push today + In-App',
  'Magic Moment: Be the First Donor (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-087', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-088', 'CI-OPP-088', 'RuleBook', 'Creator Posted an Update', 'New video update', 'Existing supporters',
  'Re-engage supporters', 'Tier 2 - Event-Driven', '[Opportunity] Creator Posted an Update', 'One best Push today + In-App',
  'Creator Posted an Update (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-088', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-089', 'CI-OPP-089', 'RuleBook', 'Magic Moment: Donation #100', 'Next donation reaches milestone', 'Any supporter',
  'Celebrate milestone', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Donation #100', 'One best Push today + In-App',
  'Magic Moment: Donation #100 (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-089', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-090', 'CI-OPP-090', 'RuleBook', 'Magic Moment: Finish This Seedling', 'Campaign is within 10% of goal', 'Interested supporters',
  'Drive completion', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Finish This Seedling', 'One best Push today + In-App',
  'Magic Moment: Finish This Seedling (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-090', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-091', 'CI-OPP-091', 'RuleBook', 'Follower Donated', 'Friend activity detected', 'Connected users',
  'Leverage social proof', 'Tier 2 - Event-Driven', '[Opportunity] Follower Donated', 'One best Push today + In-App',
  'Follower Donated (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-091', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-092', 'CI-OPP-092', 'RuleBook', 'Followed Donated', 'Friend activity detected', 'Connected users',
  'Leverage social proof', 'Tier 2 - Event-Driven', '[Opportunity] Followed Donated', 'One best Push today + In-App',
  'Followed Donated (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-092', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-093', 'CI-OPP-093', 'RuleBook', 'Follower Commented', 'New comments on supported Seedling', 'Your Followers',
  'Increase community interaction', 'Tier 2 - Event-Driven', '[Opportunity] Follower Commented', 'One best Push today + In-App',
  'Follower Commented (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-093', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-094', 'CI-OPP-094', 'RuleBook', 'Follower Commented', 'New comments on supported Seedling', 'Followed Creators',
  'Increase community interaction', 'Tier 2 - Event-Driven', '[Opportunity] Follower Commented', 'One best Push today + In-App',
  'Follower Commented (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-094', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-095', 'CI-OPP-095', 'RuleBook', 'Magic Moment: Last Chance to Finish', 'Campaign ends within hours', 'Interested supporters',
  'Create urgency', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Last Chance to Finish', 'One best Push today + In-App',
  'Magic Moment: Last Chance to Finish (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-095', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-096', 'CI-OPP-096', 'RuleBook', 'Magic Moment: Trending Seedling', 'Rapid engagement growth', 'Relevant audience',
  'Surface momentum', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Trending Seedling', 'One best Push today + In-App',
  'Magic Moment: Trending Seedling (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-096', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-097', 'CI-OPP-097', 'RuleBook', 'Magic Moment: Your Gift Inspired Others', 'Subsequent donations attributed after user''s gift', 'Recent donor',
  'Reinforce giving', 'Tier 2 - Event-Driven', '[Opportunity] Magic Moment: Your Gift Inspired Others', 'One best Push today + In-App',
  'Magic Moment: Your Gift Inspired Others (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-097', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-098', 'CI-OPP-098', 'RuleBook', 'Make Your First Gift of the Season', 'Nov 15-Dec 31', 'All Users',
  'First donation', 'Tier 2 - Event-Driven', '[Opportunity] Make Your First Gift of the Season', 'One best Push today + In-App',
  'Make Your First Gift of the Season (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-098', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-099', 'CI-OPP-099', 'RuleBook', 'Martin Luther King Jr. Day', 'MLK Day approaching', 'All users',
  'Promote service', 'Tier 3 - Ambient/Digest', '[Opportunity] Martin Luther King Jr. Day', 'One best Push today + In-App',
  'Martin Luther King Jr. Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-099', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-100', 'CI-OPP-100', 'RuleBook', 'Memorial Day', 'Memorial Day approaching', 'All users',
  'Honor fallen service members', 'Tier 3 - Ambient/Digest', '[Opportunity] Memorial Day', 'One best Push today + In-App',
  'Memorial Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-100', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-101', 'CI-OPP-101', 'RuleBook', 'Mental Health Awareness Month', 'May', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Mental Health Awareness Month', 'One best Push today + In-App',
  'Mental Health Awareness Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-101', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-102', 'CI-OPP-102', 'RuleBook', 'Seedling Milestone', 'Campaign milestone', 'Eligible User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Seedling Milestone', 'One best Push today + In-App',
  'Seedling Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-102', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-103', 'CI-OPP-103', 'RuleBook', 'Military Appreciation Month', 'May', 'Veteran supporters',
  'Awareness month', 'Tier 3 - Ambient/Digest', '[Opportunity] Military Appreciation Month', 'One best Push today + In-App',
  'Military Appreciation Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-103', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-104', 'CI-OPP-104', 'RuleBook', '1 Million Dollar Platform Milestone', 'Platform milestone', 'All users',
  'Seedling milestone', 'Tier 2 - Event-Driven', '[Opportunity] 1 Million Dollar Platform Milestone', 'One best Push today + In-App',
  '1 Million Dollar Platform Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-104', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-105', 'CI-OPP-105', 'RuleBook', 'X Million Dollar Platform Milestone', 'Platform milestone', 'All users',
  'Seedling milestone', 'Tier 2 - Event-Driven', '[Opportunity] X Million Dollar Platform Milestone', 'One best Push today + In-App',
  'X Million Dollar Platform Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-105', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-106', 'CI-OPP-106', 'RuleBook', 'Mother''s Day', '2 weeks prior', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Mother''s Day', 'One best Push today + In-App',
  'Mother''s Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-106', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-107', 'CI-OPP-107', 'RuleBook', 'Mother''s Day Tribute Seedling', 'Mother''s Day', 'All users',
  'Honor loved ones', 'Tier 3 - Ambient/Digest', '[Opportunity] Mother''s Day Tribute Seedling', 'One best Push today + In-App',
  'Mother''s Day Tribute Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-107', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-108', 'CI-OPP-108', 'RuleBook', 'National Cat Day', 'National Cat Day', 'Cat rescue and adoption',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] National Cat Day', 'One best Push today + In-App',
  'National Cat Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-108', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-109', 'CI-OPP-109', 'RuleBook', 'National Dog Day', 'National Dog Day', 'Dog rescue and adoption',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] National Dog Day', 'One best Push today + In-App',
  'National Dog Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-109', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-110', 'CI-OPP-110', 'RuleBook', 'National Hunger Action Month', 'September', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] National Hunger Action Month', 'One best Push today + In-App',
  'National Hunger Action Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-110', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-111', 'CI-OPP-111', 'RuleBook', 'National Parks Week', 'National Parks Week', 'Park conservation',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] National Parks Week', 'One best Push today + In-App',
  'National Parks Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-111', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-112', 'CI-OPP-112', 'RuleBook', 'National Philanthropy Day', 'November 15', 'All users',
  'Philanthropy awareness', 'Tier 3 - Ambient/Digest', '[Opportunity] National Philanthropy Day', 'One best Push today + In-App',
  'National Philanthropy Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-112', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-113', 'CI-OPP-113', 'RuleBook', 'National Volunteer Month', 'April', 'Volunteers',
  'Volunteerism', 'Tier 3 - Ambient/Digest', '[Opportunity] National Volunteer Month', 'One best Push today + In-App',
  'National Volunteer Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-113', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-114', 'CI-OPP-114', 'RuleBook', 'National Volunteer Week', 'April', 'Volunteers',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] National Volunteer Week', 'One best Push today + In-App',
  'National Volunteer Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-114', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-115', 'CI-OPP-115', 'RuleBook', 'New Seedling Posted', 'Organization onboarded', 'Relevant users',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] New Seedling Posted', 'One best Push today + In-App',
  'New Seedling Posted (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-115', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-116', 'CI-OPP-116', 'RuleBook', 'New Seedling Update Posted', 'New campaign update', 'Followers',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] New Seedling Update Posted', 'One best Push today + In-App',
  'New Seedling Update Posted (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-116', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-117', 'CI-OPP-117', 'RuleBook', 'New Year''s Resolution', 'January 1', 'Relevant Users',
  'Annual fresh-start moment.', 'Tier 3 - Ambient/Digest', '[Opportunity] New Year''s Resolution', 'One best Push today + In-App',
  'New Year''s Resolution (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-117', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-118', 'CI-OPP-118', 'RuleBook', 'Older Americans Month', 'May', 'Senior causes supporters',
  'Awareness month', 'Tier 3 - Ambient/Digest', '[Opportunity] Older Americans Month', 'One best Push today + In-App',
  'Older Americans Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-118', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-119', 'CI-OPP-119', 'RuleBook', 'One Final Gift', 'Dec 30', 'All Users',
  'Year-end gift', 'Tier 2 - Event-Driven', '[Opportunity] One Final Gift', 'One best Push today + In-App',
  'One Final Gift (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-119', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-120', 'CI-OPP-120', 'RuleBook', 'One Final Gift', 'Dec 31', 'All Users',
  'Year-end gift', 'Tier 2 - Event-Driven', '[Opportunity] One Final Gift', 'One best Push today + In-App',
  'One Final Gift (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-120', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-121', 'CI-OPP-121', 'RuleBook', 'Seedling Posted Nearby', 'Geo/time match', 'User',
  'Alert user to local cause', 'Tier 2 - Event-Driven', '[Opportunity] Seedling Posted Nearby', 'One best Push today + In-App',
  'Seedling Posted Nearby (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-121', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-122', 'CI-OPP-122', 'RuleBook', 'Seedling Viewed Multiple Times', 'Repeat visits', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Seedling Viewed Multiple Times', 'One best Push today + In-App',
  'Seedling Viewed Multiple Times (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-122', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-123', 'CI-OPP-123', 'RuleBook', 'Organ Donation Month', 'Organ Donation Month', 'Organ donor awareness',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Organ Donation Month', 'One best Push today + In-App',
  'Organ Donation Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-123', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-124', 'CI-OPP-124', 'RuleBook', 'Oscars Week', 'Oscars Week', 'Arts education campaigns',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Oscars Week', 'One best Push today + In-App',
  'Oscars Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-124', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-125', 'CI-OPP-125', 'RuleBook', 'Park Restoration Weekend', 'Park Restoration Weekend', 'Community restoration',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Park Restoration Weekend', 'One best Push today + In-App',
  'Park Restoration Weekend (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-125', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-126', 'CI-OPP-126', 'RuleBook', 'Passover Service', 'Passover Service', 'Community support opportunities',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Passover Service', 'One best Push today + In-App',
  'Passover Service (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-126', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-127', 'CI-OPP-127', 'RuleBook', 'Pet Adoption Day Opportunity', 'National Adopt a Pet Day', 'Animal lovers',
  'Support rescues', 'Tier 3 - Ambient/Digest', '[Opportunity] Pet Adoption Day Opportunity', 'One best Push today + In-App',
  'Pet Adoption Day Opportunity (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-127', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-128', 'CI-OPP-128', 'RuleBook', 'Pet Adoption Month', 'May', 'Animal supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Pet Adoption Month', 'One best Push today + In-App',
  'Pet Adoption Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-128', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-129', 'CI-OPP-129', 'RuleBook', 'Picked Just For You', 'Recommendation engine', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Picked Just For You', 'One best Push today + In-App',
  'Picked Just For You (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-129', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-130', 'CI-OPP-130', 'RuleBook', 'Plant a Seedling in Someone''s Honor', 'Thanksgiving-Dec 31', 'Creators',
  'Honor someone', 'Tier 2 - Event-Driven', '[Opportunity] Plant a Seedling in Someone''s Honor', 'One best Push today + In-App',
  'Plant a Seedling in Someone''s Honor (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-130', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-131', 'CI-OPP-131', 'RuleBook', 'Presidents'' Day', 'Federal holiday approaching', 'All users',
  'Inspire civic/community giving', 'Tier 3 - Ambient/Digest', '[Opportunity] Presidents'' Day', 'One best Push today + In-App',
  'Presidents'' Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-131', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-132', 'CI-OPP-132', 'RuleBook', 'Ramadan Giving', 'Ramadan Giving', 'Charitable giving during Ramadan',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Ramadan Giving', 'One best Push today + In-App',
  'Ramadan Giving (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-132', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-133', 'CI-OPP-133', 'RuleBook', 'Random Act of Kindness Day', 'Feb 17', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Random Act of Kindness Day', 'One best Push today + In-App',
  'Random Act of Kindness Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-133', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-134', 'CI-OPP-134', 'RuleBook', 'Read Across America', 'Read Across America', 'Literacy',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Read Across America', 'One best Push today + In-App',
  'Read Across America (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-134', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-135', 'CI-OPP-135', 'RuleBook', 'Ready to Revisit This Cause?', 'User bookmarks', 'User',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Ready to Revisit This Cause?', 'One best Push today + In-App',
  'Ready to Revisit This Cause? (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-135', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-136', 'CI-OPP-136', 'RuleBook', 'Retirement Legacy Seedling', 'Retirement detected', 'Retirees',
  'Celebrate legacy', 'Tier 3 - Ambient/Digest', '[Opportunity] Retirement Legacy Seedling', 'One best Push today + In-App',
  'Retirement Legacy Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-136', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-137', 'CI-OPP-137', 'RuleBook', 'School Supply Drive', 'July', 'Education supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] School Supply Drive', 'One best Push today + In-App',
  'School Supply Drive (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-137', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-138', 'CI-OPP-138', 'RuleBook', 'Seedling Season of Generosity', 'Annual Nov-Dec campaign', 'All users',
  'Seedling-owned annual giving season', 'Tier 3 - Ambient/Digest', '[Opportunity] Seedling Season of Generosity', 'One best Push today + In-App',
  'Seedling Season of Generosity (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-138', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-139', 'CI-OPP-139', 'RuleBook', 'Seedling Season of Generosity Begins', 'Nov 15', 'All Users',
  'Kick off annual giving season', 'Tier 3 - Ambient/Digest', '[Opportunity] Seedling Season of Generosity Begins', 'One best Push today + In-App',
  'Seedling Season of Generosity Begins (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-139', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-140', 'CI-OPP-140', 'RuleBook', 'Share One More Time', 'Final week', 'Creators',
  'Increase sharing', 'Tier 2 - Event-Driven', '[Opportunity] Share One More Time', 'One best Push today + In-App',
  'Share One More Time (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-140', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-141', 'CI-OPP-141', 'RuleBook', 'Share Opportunity', 'Campaign ready to share', 'Supporter',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Share Opportunity', 'One best Push today + In-App',
  'Share Opportunity (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-141', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-142', 'CI-OPP-142', 'RuleBook', 'Share Your Story', 'Nov 15-Dec 31', 'Creators',
  'Record video', 'Tier 2 - Event-Driven', '[Opportunity] Share Your Story', 'One best Push today + In-App',
  'Share Your Story (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-142', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-143', 'CI-OPP-143', 'RuleBook', 'Small Business Saturday Partnerships', 'Saturday after Thanksgiving', 'Local supporters',
  'Community focus', 'Tier 3 - Ambient/Digest', '[Opportunity] Small Business Saturday Partnerships', 'One best Push today + In-App',
  'Small Business Saturday Partnerships (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-143', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-144', 'CI-OPP-144', 'RuleBook', 'Tax Refund Season', 'Tax Refund Season', 'Give from refund',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Tax Refund Season', 'One best Push today + In-App',
  'Tax Refund Season (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-144', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-145', 'CI-OPP-145', 'RuleBook', 'Teacher Appreciation Week', 'Teacher Appreciation Week', 'Support educators',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Teacher Appreciation Week', 'One best Push today + In-App',
  'Teacher Appreciation Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-145', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-146', 'CI-OPP-146', 'RuleBook', 'Thanksgiving', 'Week before', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Thanksgiving', 'One best Push today + In-App',
  'Thanksgiving (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-146', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-147', 'CI-OPP-147', 'RuleBook', 'Thanksgiving Gratitude Gift', 'Thanksgiving', 'All Users',
  'Holiday giving', 'Tier 3 - Ambient/Digest', '[Opportunity] Thanksgiving Gratitude Gift', 'One best Push today + In-App',
  'Thanksgiving Gratitude Gift (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-147', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-148', 'CI-OPP-148', 'RuleBook', 'Thanksgiving Gratitude Opportunity', 'Week before Thanksgiving', 'All users',
  'Connect gratitude with generosity', 'Tier 3 - Ambient/Digest', '[Opportunity] Thanksgiving Gratitude Opportunity', 'One best Push today + In-App',
  'Thanksgiving Gratitude Opportunity (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-148', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-149', 'CI-OPP-149', 'RuleBook', 'This Week''s 5 Picks to Click', 'Weekly digest', 'User',
  'Curated list of Seedlings', 'Tier 2 - Event-Driven', '[Opportunity] This Week''s 5 Picks to Click', 'One best Push today + In-App',
  'This Week''s 5 Picks to Click (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-149', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-150', 'CI-OPP-150', 'RuleBook', 'This Month''s 5 Picks to Click', 'Weekly digest', 'User',
  'Curated list of Seedlings', 'Tier 2 - Event-Driven', '[Opportunity] This Month''s 5 Picks to Click', 'One best Push today + In-App',
  'This Month''s 5 Picks to Click (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-150', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-151', 'CI-OPP-151', 'RuleBook', 'Today''s Featured Seedling', 'Editorial selection', 'Users',
  'This opportunity aligns with the user''s interests or relationships.', 'Tier 2 - Event-Driven', '[Opportunity] Today''s Featured Seedling', 'One best Push today + In-App',
  'Today''s Featured Seedling (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-151', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-152', 'CI-OPP-152', 'RuleBook', 'Top Grower Recognition', 'Top Grower Recognition', 'Recognize leading Growers',
  'Recognition', 'Tier 2 - Event-Driven', '[Opportunity] Top Grower Recognition', 'One best Push today + In-App',
  'Top Grower Recognition (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-152', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-153', 'CI-OPP-153', 'RuleBook', 'Trending Cause', 'Trending Cause', 'AI detects emerging cause',
  'Timing', 'Tier 2 - Event-Driven', '[Opportunity] Trending Cause', 'One best Push today + In-App',
  'Trending Cause (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-153', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-154', 'CI-OPP-154', 'RuleBook', 'Valentine''s Day', 'Feb 14 approaching', 'Users',
  'Seasonal', 'Tier 3 - Ambient/Digest', '[Opportunity] Valentine''s Day', 'One best Push today + In-App',
  'Valentine''s Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-154', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-155', 'CI-OPP-155', 'RuleBook', 'Veterans Day', 'Week before', 'Veteran supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Veterans Day', 'One best Push today + In-App',
  'Veterans Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-155', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-156', 'CI-OPP-156', 'RuleBook', 'Volunteer Appreciation Week', 'April', 'Volunteers',
  'Volunteer retention', 'Tier 3 - Ambient/Digest', '[Opportunity] Volunteer Appreciation Week', 'One best Push today + In-App',
  'Volunteer Appreciation Week (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-156', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-157', 'CI-OPP-157', 'RuleBook', 'Wedding Celebration Seedling', 'Wedding planning', 'Couples',
  'Replace gifts with impact', 'Tier 3 - Ambient/Digest', '[Opportunity] Wedding Celebration Seedling', 'One best Push today + In-App',
  'Wedding Celebration Seedling (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-157', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-158', 'CI-OPP-158', 'RuleBook', 'Wildfire Season', 'Season begins', 'Regional users',
  '', 'Tier 2 - Event-Driven', '[Opportunity] Wildfire Season', 'One best Push today + In-App',
  'Wildfire Season (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-158', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-159', 'CI-OPP-159', 'RuleBook', 'Women''s History Month', 'March', 'Relevant users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Women''s History Month', 'One best Push today + In-App',
  'Women''s History Month (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-159', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-160', 'CI-OPP-160', 'RuleBook', 'World Animal Day', 'October 4', 'Animal supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] World Animal Day', 'One best Push today + In-App',
  'World Animal Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-160', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-161', 'CI-OPP-161', 'RuleBook', 'World Blood Donor Day', 'World Blood Donor Day', 'Blood donation awareness',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] World Blood Donor Day', 'One best Push today + In-App',
  'World Blood Donor Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-161', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-162', 'CI-OPP-162', 'RuleBook', 'World Cleanup Day', 'World Cleanup Day', 'Community cleanups',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] World Cleanup Day', 'One best Push today + In-App',
  'World Cleanup Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-162', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-163', 'CI-OPP-163', 'RuleBook', 'World Food Day', 'October 16', 'Food insecurity supporters',
  'UN observance', 'Tier 3 - Ambient/Digest', '[Opportunity] World Food Day', 'One best Push today + In-App',
  'World Food Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-163', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-164', 'CI-OPP-164', 'RuleBook', 'World Kindness Day', 'Nov 13', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] World Kindness Day', 'One best Push today + In-App',
  'World Kindness Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-164', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-165', 'CI-OPP-165', 'RuleBook', 'World Oceans Day', 'June 8', 'Environmental supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] World Oceans Day', 'One best Push today + In-App',
  'World Oceans Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-165', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-166', 'CI-OPP-166', 'RuleBook', 'World Refugee Day', 'June 20', 'Humanitarian supporters',
  'UN day', 'Tier 3 - Ambient/Digest', '[Opportunity] World Refugee Day', 'One best Push today + In-App',
  'World Refugee Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-166', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-167', 'CI-OPP-167', 'RuleBook', 'World Water Day', 'March 22', 'Water supporters',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] World Water Day', 'One best Push today + In-App',
  'World Water Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-167', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-168', 'CI-OPP-168', 'RuleBook', 'World Wildlife Day', 'World Wildlife Day', 'Wildlife conservation',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] World Wildlife Day', 'One best Push today + In-App',
  'World Wildlife Day (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-168', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-169', 'CI-OPP-169', 'RuleBook', 'Year-End Bonus', 'Year-End Bonus', 'Share year-end bonus',
  '', 'Tier 3 - Ambient/Digest', '[Opportunity] Year-End Bonus', 'One best Push today + In-App',
  'Year-End Bonus (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-169', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-opp-170', 'CI-OPP-170', 'RuleBook', 'Year-End Tax Giving', 'December', 'Users',
  'Annual', 'Tier 3 - Ambient/Digest', '[Opportunity] Year-End Tax Giving', 'One best Push today + In-App',
  'Year-End Tax Giving (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Select the strongest eligible reason to return today.', 'Cooldown: 24 hours • Suppression: Suppress competing opportunity pushes', 'Deliver only if strongest opportunity available today.', 'Engine: Opportunity | Attention: Interruptive | Score: 70 | Timing: Best moment today | Memory: Opportunity push already used today; last push timestamp',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-OPP-170', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-001', 'CI-PART-001', 'RuleBook', 'First App Session', 'First app open', 'User',
  'Welcome active participation', 'Tier 2 - Event-Driven', '[Participation] First App Session', 'In-App always; conditional Push',
  'First App Session (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-002', 'CI-PART-002', 'RuleBook', 'First Seedling Viewed', 'Campaign viewed', 'User',
  'Encourage deeper engagement', 'Tier 2 - Event-Driven', '[Participation] First Seedling Viewed', 'In-App always; conditional Push',
  'First Seedling Viewed (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-003', 'CI-PART-003', 'RuleBook', 'Like Added', 'Creator Liked comment', 'Person who liked the comment',
  'Confirm participation', 'Tier 2 - Event-Driven', '[Participation] Like Added', 'In-App always; conditional Push',
  'Like Added (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-004', 'CI-PART-004', 'RuleBook', 'Like Added', 'Follower of (Name) liked comment', 'Follower of Commenter',
  'Confirm participation', 'Tier 2 - Event-Driven', '[Participation] Like Added', 'In-App always; conditional Push',
  'Like Added (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 15-minute batching window; summary push fires at window close | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-005', 'CI-PART-005', 'RuleBook', 'Like Added', 'Donor to (Seedling) liked comment', 'Donor',
  'Confirm participation', 'Tier 2 - Event-Driven', '[Participation] Like Added', 'In-App always; conditional Push',
  'Like Added (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 15-minute batching window; summary push fires at window close | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-006', 'CI-PART-006', 'RuleBook', 'Comment Posted', 'Comment submitted', 'Comment author',
  'Grow conversation', 'Tier 2 - Event-Driven', '[Participation] Comment Posted', 'In-App always; conditional Push',
  'Comment Posted (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-007', 'CI-PART-007', 'RuleBook', 'Comment Posted', 'Comment submitted', 'Follower of Commenter',
  'Grow conversation', 'Tier 2 - Event-Driven', '[Participation] Comment Posted', 'In-App always; conditional Push',
  'Comment Posted (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 15-minute batching window; summary push fires at window close | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-008', 'CI-PART-008', 'RuleBook', 'Comment Posted', 'Comment submitted', 'Donor of Seedling',
  'Grow conversation', 'Tier 2 - Event-Driven', '[Participation] Comment Posted', 'In-App always; conditional Push',
  'Comment Posted (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 15-minute batching window; summary push fires at window close | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-009', 'CI-PART-009', 'RuleBook', 'Comment Posted', 'Comment submitted', 'Creator of Seedling',
  'Grow conversation', 'Tier 2 - Event-Driven', '[Participation] Comment Posted', 'In-App always; conditional Push',
  'Comment Posted (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 15-minute batching window; summary push fires at window close | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-010', 'CI-PART-010', 'RuleBook', 'Comment Replied To', 'Reply posted', 'Original commenter',
  'Continue discussion', 'Tier 2 - Event-Driven', '[Participation] Comment Replied To', 'In-App always; conditional Push',
  'Comment Replied To (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-011', 'CI-PART-011', 'RuleBook', 'Comment Liked', 'Reaction received', 'Comment author',
  'Recognize contribution', 'Tier 2 - Event-Driven', '[Participation] Comment Liked', 'In-App always; conditional Push',
  'Comment Liked (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-012', 'CI-PART-012', 'RuleBook', 'Post Shared', 'Content shared', 'User',
  'Celebrate advocacy', 'Tier 2 - Event-Driven', '[Participation] Post Shared', 'In-App always; conditional Push',
  'Post Shared (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-013', 'CI-PART-013', 'RuleBook', 'Share Opened', 'Recipient opens shared content', 'Sharer',
  'Reinforce impact', 'Tier 2 - Event-Driven', '[Participation] Share Opened', 'In-App always; conditional Push',
  'Share Opened (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-014', 'CI-PART-014', 'RuleBook', 'Organization Followed', 'Follow created', 'User',
  'Build long-term relationship', 'Tier 2 - Event-Driven', '[Participation] Organization Followed', 'In-App always; conditional Push',
  'Organization Followed (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-015', 'CI-PART-015', 'RuleBook', 'Grower Followed', 'Follow created', 'User',
  'Strengthen creator connection', 'Tier 2 - Event-Driven', '[Participation] Grower Followed', 'In-App always; conditional Push',
  'Grower Followed (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-015', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-016', 'CI-PART-016', 'RuleBook', 'Participation Streak', 'Daily activity', 'User',
  'Reinforce habit', 'Tier 2 - Event-Driven', '[Participation] Participation Streak', 'In-App always; conditional Push',
  'Participation Streak (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-016', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-017', 'CI-PART-017', 'RuleBook', 'Participation Streak Lost', 'Streak broken', 'User',
  'Re-engage', 'Tier 2 - Event-Driven', '[Participation] Participation Streak Lost', 'In-App always; conditional Push',
  'Participation Streak Lost (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-017', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-018', 'CI-PART-018', 'RuleBook', 'Daily Check-in', 'Daily visit', 'User',
  'Build habit', 'Tier 2 - Event-Driven', '[Participation] Daily Check-in', 'In-App always; conditional Push',
  'Daily Check-in (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-018', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-019', 'CI-PART-019', 'RuleBook', 'Weekly Recap Ready', 'Week complete', 'User',
  'Reflect participation', 'Tier 2 - Event-Driven', '[Participation] Weekly Recap Ready', 'In-App always; conditional Push',
  'Weekly Recap Ready (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-019', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-020', 'CI-PART-020', 'RuleBook', 'Monthly Recap Ready', 'Month complete', 'User',
  'Celebrate activity', 'Tier 2 - Event-Driven', '[Participation] Monthly Recap Ready', 'In-App always; conditional Push',
  'Monthly Recap Ready (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-020', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-021', 'CI-PART-021', 'RuleBook', 'Challenge Joined', 'User joins challenge', 'User',
  'Confirm participation', 'Tier 2 - Event-Driven', '[Participation] Challenge Joined', 'In-App always; conditional Push',
  'Challenge Joined (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-021', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-022', 'CI-PART-022', 'RuleBook', 'Challenge Completed', 'Challenge finished', 'User',
  'Celebrate achievement', 'Tier 2 - Event-Driven', '[Participation] Challenge Completed', 'In-App always; conditional Push',
  'Challenge Completed (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-022', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-023', 'CI-PART-023', 'RuleBook', 'Live Event Started', 'Event begins', 'Registered users',
  'Drive attendance', 'Tier 2 - Event-Driven', '[Participation] Live Event Started', 'In-App always; conditional Push',
  'Live Event Started (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-023', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-024', 'CI-PART-024', 'RuleBook', 'Live Event Ended', 'Event completed', 'Attendees',
  'Capture feedback', 'Tier 2 - Event-Driven', '[Participation] Live Event Ended', 'In-App always; conditional Push',
  'Live Event Ended (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-024', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-025', 'CI-PART-025', 'RuleBook', 'Content Reported', 'Report submitted', 'Reporter',
  'Review content', 'Tier 2 - Event-Driven', '[Participation] Content Reported', 'In-App always; conditional Push',
  'Content Reported (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-025', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-026', 'CI-PART-026', 'RuleBook', 'Report Resolved', 'Moderation completed', 'Reporter',
  'Close loop', 'Tier 2 - Event-Driven', '[Participation] Report Resolved', 'In-App always; conditional Push',
  'Report Resolved (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-026', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-027', 'CI-PART-027', 'RuleBook', 'Milestone Participation', '100th interaction', 'User',
  'Celebrate commitment', 'Tier 2 - Event-Driven', '[Participation] Milestone Participation', 'In-App always; conditional Push',
  'Milestone Participation (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-027', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-028', 'CI-PART-028', 'RuleBook', 'Dormant Participant', 'No activity 14 days', 'User',
  'Re-engage', 'Tier 2 - Event-Driven', '[Participation] Dormant Participant', 'In-App always; conditional Push',
  'Dormant Participant (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-028', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-029', 'CI-PART-029', 'RuleBook', 'Highly Active Participant', 'High engagement', 'User',
  'Recognize loyalty', 'Tier 2 - Event-Driven', '[Participation] Highly Active Participant', 'In-App always; conditional Push',
  'Highly Active Participant (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-029', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-030', 'CI-PART-030', 'RuleBook', 'First Meaningful Interaction', 'First like/comment/share', 'User',
  'Celebrate engagement', 'Tier 2 - Event-Driven', '[Participation] First Meaningful Interaction', 'In-App always; conditional Push',
  'First Meaningful Interaction (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-030', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-031', 'CI-PART-031', 'RuleBook', 'Seedling Goal Reached', 'Collective participation milestone', 'Participants',
  'Celebrate community', 'Tier 2 - Event-Driven', '[Participation] Seedling Goal Reached', 'In-App always; conditional Push',
  'Seedling Goal Reached (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-031', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-032', 'CI-PART-032', 'RuleBook', 'Campaign Goal Reached', 'Collective participation milestone', 'Participants',
  'Celebrate community', 'Tier 2 - Event-Driven', '[Participation] Campaign Goal Reached', 'In-App always; conditional Push',
  'Campaign Goal Reached (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-032', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-033', 'CI-PART-033', 'RuleBook', 'Feedback Requested', 'Session ends', 'User',
  'Improve experience', 'Tier 2 - Event-Driven', '[Participation] Feedback Requested', 'In-App always; conditional Push',
  'Feedback Requested (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-033', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-034', 'CI-PART-034', 'RuleBook', 'Participation Anniversary', 'One year active', 'User',
  'Celebrate journey', 'Tier 2 - Event-Driven', '[Participation] Participation Anniversary', 'In-App always; conditional Push',
  'Participation Anniversary (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-034', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-035', 'CI-PART-035', 'RuleBook', 'Comment Thread Trending', 'Thread accelerates', 'Participants',
  'Rejoin conversation', 'Tier 2 - Event-Driven', '[Participation] Comment Thread Trending', 'In-App always; conditional Push',
  'Comment Thread Trending (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-035', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-036', 'CI-PART-036', 'RuleBook', 'Unread Activity Waiting', 'Pending notifications', 'User',
  'Prompt return', 'Tier 2 - Event-Driven', '[Participation] Unread Activity Waiting', 'In-App always; conditional Push',
  'Unread Activity Waiting (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-036', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-037', 'CI-PART-037', 'RuleBook', 'Like Received', 'Someone reacts to your post', 'Content author',
  'Recognize engagement', 'Tier 2 - Event-Driven', '[Participation] Like Received', 'In-App always; conditional Push',
  'Like Received (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 15-minute batching window; summary push fires at window close | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-037', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-038', 'CI-PART-038', 'RuleBook', 'Multiple Likes Received', 'Reaction threshold reached', 'Content author',
  'Highlight momentum', 'Tier 2 - Event-Driven', '[Participation] Multiple Likes Received', 'In-App always; conditional Push',
  'Multiple Likes Received (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-038', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-039', 'CI-PART-039', 'RuleBook', 'New Follower Milestone', 'Follower milestone reached', 'User',
  'Celebrate influence', 'Tier 2 - Event-Driven', '[Participation] New Follower Milestone', 'In-App always; conditional Push',
  'New Follower Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-039', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-040', 'CI-PART-040', 'RuleBook', 'Sponsor Responded', 'Co-Sponsor responds to invite', 'Participant',
  'Deepen relationship', 'Tier 2 - Event-Driven', '[Participation] Sponsor Responded', 'In-App always; conditional Push',
  'Sponsor Responded (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-040', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-041', 'CI-PART-041', 'RuleBook', 'Co-Sponsor Invited', 'Sponsor invites a Co-Sponsor', 'Participant',
  'Invitation', 'Tier 2 - Event-Driven', '[Participation] Co-Sponsor Invited', 'In-App always; conditional Push',
  'Co-Sponsor Invited (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-041', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-042', 'CI-PART-042', 'RuleBook', 'Co-Sponsor Invitation Responded to', 'Co-Sponsor accepts invite', 'Participant',
  'Deepen relationship', 'Tier 2 - Event-Driven', '[Participation] Co-Sponsor Invitation Responded to', 'In-App always; conditional Push',
  'Co-Sponsor Invitation Responded to (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-042', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-043', 'CI-PART-043', 'RuleBook', 'Organization Responded', 'Organization replies', 'Participant',
  'Build trust', 'Tier 2 - Event-Driven', '[Participation] Organization Responded', 'In-App always; conditional Push',
  'Organization Responded (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-043', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-044', 'CI-PART-044', 'RuleBook', 'Donation Celebrated in Feed', 'Donation shared', 'Donor',
  'Celebrate participation', 'Tier 2 - Event-Driven', '[Participation] Donation Celebrated in Feed', 'In-App always; conditional Push',
  'Donation Celebrated in Feed (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-044', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-045', 'CI-PART-045', 'RuleBook', 'Followed Started Following Cause', 'Friend action', 'User',
  'Promote discovery', 'Tier 2 - Event-Driven', '[Participation] Followed Started Following Cause', 'In-App always; conditional Push',
  'Followed Started Following Cause (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-045', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-046', 'CI-PART-046', 'RuleBook', 'Followed Commented on Followed Cause', 'Friend activity', 'User',
  'Join discussion', 'Tier 2 - Event-Driven', '[Participation] Followed Commented on Followed Cause', 'In-App always; conditional Push',
  'Followed Commented on Followed Cause (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-046', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-047', 'CI-PART-047', 'RuleBook', 'Milestone Badge Earned', 'Participation badge', 'User',
  'Reward engagement', 'Tier 2 - Event-Driven', '[Participation] Milestone Badge Earned', 'In-App always; conditional Push',
  'Milestone Badge Earned (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-047', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-048', 'CI-PART-048', 'RuleBook', 'Badge Level Increased', 'Badge upgraded', 'User',
  'Celebrate progress', 'Tier 2 - Event-Driven', '[Participation] Badge Level Increased', 'In-App always; conditional Push',
  'Badge Level Increased (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-048', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-049', 'CI-PART-049', 'RuleBook', 'Top Participant This Week', 'Leaderboard', 'User',
  'Recognize involvement', 'Tier 2 - Event-Driven', '[Participation] Top Participant This Week', 'In-App always; conditional Push',
  'Top Participant This Week (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-049', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-050', 'CI-PART-050', 'RuleBook', 'Quiet Week Reminder', 'Low weekly activity', 'User',
  'Re-engage', 'Tier 2 - Event-Driven', '[Participation] Quiet Week Reminder', 'In-App always; conditional Push',
  'Quiet Week Reminder (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-050', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-051', 'CI-PART-051', 'RuleBook', 'Challenge Reminder', 'Challenge incomplete', 'Participant',
  'Prompt completion', 'Tier 2 - Event-Driven', '[Participation] Challenge Reminder', 'In-App always; conditional Push',
  'Challenge Reminder (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-051', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-052', 'CI-PART-052', 'RuleBook', 'Challenge Success Shared', 'Challenge completed', 'Community',
  'Celebrate success', 'Tier 2 - Event-Driven', '[Participation] Challenge Success Shared', 'In-App always; conditional Push',
  'Challenge Success Shared (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-052', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-053', 'CI-PART-053', 'RuleBook', 'LiveStream Check-In', 'User arrives', 'Organizer',
  'Track attendance', 'Tier 2 - Event-Driven', '[Participation] LiveStream Check-In', 'In-App always; conditional Push',
  'LiveStream Check-In (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-053', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-054', 'CI-PART-054', 'RuleBook', 'LiveStream Follow-Up', 'Event completed', 'Attendee',
  'Continue engagement', 'Tier 2 - Event-Driven', '[Participation] LiveStream Follow-Up', 'In-App always; conditional Push',
  'LiveStream Follow-Up (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-054', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-055', 'CI-PART-055', 'RuleBook', 'Participation Preferences Updated', 'Settings changed', 'User',
  'Confirm changes', 'Tier 2 - Event-Driven', '[Participation] Participation Preferences Updated', 'In-App always; conditional Push',
  'Participation Preferences Updated (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-055', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-056', 'CI-PART-056', 'RuleBook', 'Participation Summary Ready', 'Quarterly summary', 'User',
  'Reflect impact', 'Tier 2 - Event-Driven', '[Participation] Participation Summary Ready', 'In-App always; conditional Push',
  'Participation Summary Ready (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Reinforce social behavior without creating unnecessary notification noise.', 'Cooldown: 15 minutes • Suppression: Merge similar social events', 'Merge if similar participation exists; otherwise reinforce social behavior.', 'Engine: Participation | Attention: Social | Score: 65 | Timing: 5–10 minute batching window | Memory: Open Participation batching window; last push timestamp and engine',
  'TESTED', 'Medium', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-056', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-057', 'CI-PART-057', 'RuleBook', 'Donation Received on Your Seedling', 'Donation', 'Seedling Sponsor, Co-Sponsors',
  'Show the Sponsor and Co-Sponsors that others are joining the cause.', 'Tier 1 - Guaranteed', '[Participation] Donation Received on Your Seedling', 'Immediate Push + In-App',
  'Donation Received on Your Seedling (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Every verified donation is a guaranteed creator/organization celebration; rotate approved messages.', 'Cooldown: None • Suppression: Never', 'Deliver because creator celebration is guaranteed; rotate approved message.', 'Engine: Participation | Attention: Guaranteed | Score: 98 | Timing: Immediate | Memory: Sponsor donation rotation position only',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-057', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-part-058', 'CI-PART-058', 'RuleBook', 'Donation Received for Your Organization', 'Donation', 'Supported organization',
  'Show the organization that a community is forming around its mission.', 'Tier 1 - Guaranteed', '[Participation] Donation Received for Your Organization', 'Immediate Push + In-App',
  'Donation Received for Your Organization (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Every verified donation is a guaranteed creator/organization celebration; rotate approved messages.', 'Cooldown: None • Suppression: Never', 'Deliver because creator celebration is guaranteed; rotate approved message.', 'Engine: Participation | Attention: Guaranteed | Score: 98 | Timing: Immediate | Memory: Sponsor donation rotation position only',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-PART-058', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-001', 'CI-CONTR-001', 'RuleBook', 'Donation Made via Credit/Debit Card', 'Donor makes donation', 'Donor',
  'Thank donor', 'Tier 1 - Guaranteed', '[Contribution] Donation Made via Credit/Debit Card', 'In-App always; Push if user left app',
  'Donation Made via Credit/Debit Card (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-002', 'CI-CONTR-002', 'RuleBook', 'Annual Giving Summary Ready', 'Year-end generated', 'Donor',
  'Support tax reporting', 'Tier 1 - Guaranteed', '[Contribution] Annual Giving Summary Ready', 'In-App always; Push if user left app',
  'Annual Giving Summary Ready (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-003', 'CI-CONTR-003', 'RuleBook', 'ACH Donation Confirmed', 'Funds settled', 'Donor',
  'Build trust', 'Tier 1 - Guaranteed', '[Contribution] ACH Donation Confirmed', 'In-App always; Push if user left app',
  'ACH Donation Confirmed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-004', 'CI-CONTR-004', 'RuleBook', 'ACH Donation Failed', 'Payment declined', 'Donor',
  'Resolve issue', 'Tier 1 - Guaranteed', '[Contribution] ACH Donation Failed', 'In-App always; Push if user left app',
  'ACH Donation Failed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-005', 'CI-CONTR-005', 'RuleBook', 'ACH Donation Pending', 'ACH or delayed payment', 'Donor',
  'Set expectations', 'Tier 1 - Guaranteed', '[Contribution] ACH Donation Pending', 'In-App always; Push if user left app',
  'ACH Donation Pending (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-006', 'CI-CONTR-006', 'RuleBook', 'Donation Receipt Available', 'Receipt generated', 'Donor',
  'Provide documentation', 'Tier 1 - Guaranteed', '[Contribution] Donation Receipt Available', 'In-App always; Push if user left app',
  'Donation Receipt Available (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-007', 'CI-CONTR-007', 'RuleBook', 'GreenHouse Auto-Reload', 'Automatic funding', 'User',
  'Maintain balance', 'Tier 1 - Guaranteed', '[Contribution] GreenHouse Auto-Reload', 'In-App always; Push if user left app',
  'GreenHouse Auto-Reload (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-008', 'CI-CONTR-008', 'RuleBook', 'GreenHouse Auto-Reload Failed', 'Auto reload unsuccessful', 'User',
  'Resolve payment', 'Tier 1 - Guaranteed', '[Contribution] GreenHouse Auto-Reload Failed', 'In-App always; Push if user left app',
  'GreenHouse Auto-Reload Failed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-009', 'CI-CONTR-009', 'RuleBook', 'GreenHouse Balance Low', 'Threshold reached', 'User',
  'Encourage refill', 'Tier 1 - Guaranteed', '[Contribution] GreenHouse Balance Low', 'In-App always; Push if user left app',
  'GreenHouse Balance Low (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-010', 'CI-CONTR-010', 'RuleBook', 'GreenHouse Balance Low Auto Reload', 'Threshold reached', 'User',
  'Encourage refill', 'Tier 1 - Guaranteed', '[Contribution] GreenHouse Balance Low Auto Reload', 'In-App always; Push if user left app',
  'GreenHouse Balance Low Auto Reload (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-011', 'CI-CONTR-011', 'RuleBook', 'GreenHouse Deposit Added', 'Funds deposited', 'User',
  'Confirm balance', 'Tier 1 - Guaranteed', '[Contribution] GreenHouse Deposit Added', 'In-App always; Push if user left app',
  'GreenHouse Deposit Added (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-012', 'CI-CONTR-012', 'RuleBook', 'GreenHouse Donation Made', 'Donation from balance', 'User',
  'Confirm transaction', 'Tier 1 - Guaranteed', '[Contribution] GreenHouse Donation Made', 'In-App always; Push if user left app',
  'GreenHouse Donation Made (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-013', 'CI-CONTR-013', 'RuleBook', 'Offline Donation Recorded', 'Manual entry', 'Organization',
  'Confirm accounting', 'Tier 1 - Guaranteed', '[Contribution] Offline Donation Recorded', 'In-App always; Push if user left app',
  'Offline Donation Recorded (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-014', 'CI-CONTR-014', 'RuleBook', 'Payment Method Added', 'New payment method', 'User',
  'Confirm setup', 'Tier 1 - Guaranteed', '[Contribution] Payment Method Added', 'In-App always; Push if user left app',
  'Payment Method Added (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-015', 'CI-CONTR-015', 'RuleBook', 'Payment Method Expiring', 'Card nearing expiration', 'Donor',
  'Prevent failed payments', 'Tier 1 - Guaranteed', '[Contribution] Payment Method Expiring', 'In-App always; Push if user left app',
  'Payment Method Expiring (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-015', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-016', 'CI-CONTR-016', 'RuleBook', 'Payment Method Preferences Updated', 'Giving settings changed', 'Donor',
  'Confirm preferences', 'Tier 1 - Guaranteed', '[Contribution] Payment Method Preferences Updated', 'In-App always; Push if user left app',
  'Payment Method Preferences Updated (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-016', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-017', 'CI-CONTR-017', 'RuleBook', 'Payment Method Updated', 'Payment details changed', 'Donor',
  'Confirm update', 'Tier 1 - Guaranteed', '[Contribution] Payment Method Updated', 'In-App always; Push if user left app',
  'Payment Method Updated (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-017', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-018', 'CI-CONTR-018', 'RuleBook', 'Receipt Downloaded', 'Receipt accessed', 'Donor',
  'Confirm access', 'Tier 1 - Guaranteed', '[Contribution] Receipt Downloaded', 'In-App always; Push if user left app',
  'Receipt Downloaded (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-018', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-019', 'CI-CONTR-019', 'RuleBook', 'Recurring Donation Cancelled', 'Subscription cancelled', 'Donor',
  'Acknowledge preference', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Cancelled', 'In-App always; Push if user left app',
  'Recurring Donation Cancelled (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-019', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-020', 'CI-CONTR-020', 'RuleBook', 'Recurring Donation Created', 'Monthly gift established', 'Donor',
  'Celebrate commitment', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Created', 'In-App always; Push if user left app',
  'Recurring Donation Created (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-020', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-021', 'CI-CONTR-021', 'RuleBook', 'Recurring Donation Failed', 'Recurring payment fails', 'Donor',
  'Resolve payment', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Failed', 'In-App always; Push if user left app',
  'Recurring Donation Failed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-021', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-022', 'CI-CONTR-022', 'RuleBook', 'Recurring Donation Paused', 'Subscription paused', 'Donor',
  'Confirm change', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Paused', 'In-App always; Push if user left app',
  'Recurring Donation Paused (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-022', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-023', 'CI-CONTR-023', 'RuleBook', 'Recurring Donation Processed', 'Scheduled payment succeeds', 'Donor',
  'Confirm contribution', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Processed', 'In-App always; Push if user left app',
  'Recurring Donation Processed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-023', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-024', 'CI-CONTR-024', 'RuleBook', 'Recurring Donation Resumed', 'Subscription resumed', 'Donor',
  'Welcome back', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Resumed', 'In-App always; Push if user left app',
  'Recurring Donation Resumed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-024', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-025', 'CI-CONTR-025', 'RuleBook', 'Recurring Donation Upcoming', 'Scheduled payment approaching', 'Donor',
  'Prepare donor', 'Tier 1 - Guaranteed', '[Contribution] Recurring Donation Upcoming', 'In-App always; Push if user left app',
  'Recurring Donation Upcoming (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-025', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-026', 'CI-CONTR-026', 'RuleBook', 'Refund Issued', 'Donation refunded', 'Donor',
  'Explain transaction', 'Tier 1 - Guaranteed', '[Contribution] Refund Issued', 'In-App always; Push if user left app',
  'Refund Issued (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-026', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-027', 'CI-CONTR-027', 'RuleBook', 'Tax Acknowledgement Ready', 'IRS acknowledgment prepared', 'Donor',
  'Provide compliance', 'Tier 1 - Guaranteed', '[Contribution] Tax Acknowledgement Ready', 'In-App always; Push if user left app',
  'Tax Acknowledgement Ready (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-027', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-contr-028', 'CI-CONTR-028', 'RuleBook', 'Tax Season Reminder', 'Annual statement available', 'Donor',
  'Support tax filing', 'Tier 1 - Guaranteed', '[Contribution] Tax Season Reminder', 'In-App always; Push if user left app',
  'Tax Season Reminder (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Cooldown: None • Suppression: Never', 'Deliver because verified generosity deserves immediate recognition.', 'Engine: Contribution | Attention: Guaranteed | Score: 95 | Timing: Immediate | Memory: Current app/session activity; last in-app experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CONTR-028', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-001', 'CI-CAMP-001', 'RuleBook', 'Campaign Launched', 'Campaign goes live', 'Followers',
  'Announce launch', 'Tier 2 - Event-Driven', '[Campaign] Campaign Launched', 'In-App; Push for meaningful milestones only',
  'Campaign Launched (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-002', 'CI-CAMP-002', 'RuleBook', 'Campaign Featured', 'Editorial selection', 'Users',
  'Increase visibility', 'Tier 2 - Event-Driven', '[Campaign] Campaign Featured', 'In-App; Push for meaningful milestones only',
  'Campaign Featured (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-003', 'CI-CAMP-003', 'RuleBook', 'Campaign Trending', 'Engagement threshold reached', 'Users',
  'Highlight momentum', 'Tier 2 - Event-Driven', '[Campaign] Campaign Trending', 'In-App; Push for meaningful milestones only',
  'Campaign Trending (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-004', 'CI-CAMP-004', 'RuleBook', 'Goal 25% Complete', 'Dynamic', 'Campaign near goal',
  'Interested users', 'Tier 2 - Event-Driven', '[Campaign] Goal 25% Complete', 'In-App; Push for meaningful milestones only',
  'Goal 25% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-005', 'CI-CAMP-005', 'RuleBook', 'Goal 50% Complete', 'Dynamic', 'Campaign near goal',
  'Interested users', 'Tier 2 - Event-Driven', '[Campaign] Goal 50% Complete', 'In-App; Push for meaningful milestones only',
  'Goal 50% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-006', 'CI-CAMP-006', 'RuleBook', 'Goal 75% Complete', 'Dynamic', 'Campaign near goal',
  'Interested users', 'Tier 2 - Event-Driven', '[Campaign] Goal 75% Complete', 'In-App; Push for meaningful milestones only',
  'Goal 75% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-007', 'CI-CAMP-007', 'RuleBook', 'Goal 90% Complete', 'Dynamic', 'Campaign near goal',
  'Interested users', 'Tier 2 - Event-Driven', '[Campaign] Goal 90% Complete', 'In-App; Push for meaningful milestones only',
  'Goal 90% Complete (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-008', 'CI-CAMP-008', 'RuleBook', 'Funding Goal Achieved', 'Goal reached', 'Supporters',
  'Celebrate success', 'Tier 2 - Event-Driven', '[Campaign] Funding Goal Achieved', 'In-App; Push for meaningful milestones only',
  'Funding Goal Achieved (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-009', 'CI-CAMP-009', 'RuleBook', 'Campaign Extended', 'End date changed', 'Supporters',
  'Communicate opportunity', 'Tier 2 - Event-Driven', '[Campaign] Campaign Extended', 'In-App; Push for meaningful milestones only',
  'Campaign Extended (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-010', 'CI-CAMP-010', 'RuleBook', 'Campaign Near Deadline', '48/24 hours remaining', 'Interested Users',
  'Create urgency', 'Tier 2 - Event-Driven', '[Campaign] Campaign Near Deadline', 'In-App; Push for meaningful milestones only',
  'Campaign Near Deadline (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-011', 'CI-CAMP-011', 'RuleBook', 'Campaign Ended', 'Campaign closes', 'Supporters',
  'Thank participants', 'Tier 2 - Event-Driven', '[Campaign] Campaign Ended', 'In-App; Push for meaningful milestones only',
  'Campaign Ended (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-012', 'CI-CAMP-012', 'RuleBook', 'Campaign Updated', 'Content changed', 'Followers',
  'Share latest news', 'Tier 2 - Event-Driven', '[Campaign] Campaign Updated', 'In-App; Push for meaningful milestones only',
  'Campaign Updated (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-013', 'CI-CAMP-013', 'RuleBook', 'Campaign Viewed Milestone', 'View threshold reached', 'Organization',
  'Celebrate awareness', 'Tier 3 - Ambient/Digest', '[Campaign] Campaign Viewed Milestone', 'In-App; Push for meaningful milestones only',
  'Campaign Viewed Milestone (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-014', 'CI-CAMP-014', 'RuleBook', 'Campaign Share Milestone', 'Share threshold reached', 'Organization',
  'Recognize advocacy', 'Tier 2 - Event-Driven', '[Campaign] Campaign Share Milestone', 'In-App; Push for meaningful milestones only',
  'Campaign Share Milestone (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-015', 'CI-CAMP-015', 'RuleBook', 'Campaign Anniversary', 'One year since launch', 'Organization',
  'Celebrate legacy', 'Tier 2 - Event-Driven', '[Campaign] Campaign Anniversary', 'In-App; Push for meaningful milestones only',
  'Campaign Anniversary (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-015', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-016', 'CI-CAMP-016', 'RuleBook', 'Campaign Performance Summary', 'Weekly/monthly analytics', 'Organization',
  'Improve effectiveness', 'Tier 3 - Ambient/Digest', '[Campaign] Campaign Performance Summary', 'In-App; Push for meaningful milestones only',
  'Campaign Performance Summary (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-016', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-017', 'CI-CAMP-017', 'RuleBook', 'Campaign Goal Increased', 'Funding goal raised', 'Supporters',
  'Explain expansion', 'Tier 2 - Event-Driven', '[Campaign] Campaign Goal Increased', 'In-App; Push for meaningful milestones only',
  'Campaign Goal Increased (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-017', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-018', 'CI-CAMP-018', 'RuleBook', 'Campaign Goal Reduced', 'Funding goal lowered', 'Supporters',
  'Maintain transparency', 'Tier 2 - Event-Driven', '[Campaign] Campaign Goal Reduced', 'In-App; Push for meaningful milestones only',
  'Campaign Goal Reduced (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-018', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-019', 'CI-CAMP-019', 'RuleBook', 'Campaign Milestone Celebration', 'Major milestone achieved', 'Supporters',
  'Celebrate together', 'Tier 2 - Event-Driven', '[Campaign] Campaign Milestone Celebration', 'In-App; Push for meaningful milestones only',
  'Campaign Milestone Celebration (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-019', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-020', 'CI-CAMP-020', 'RuleBook', 'Campaign Search Milestone', 'Search impressions threshold', 'Organization',
  'Show discoverability', 'Tier 3 - Ambient/Digest', '[Campaign] Campaign Search Milestone', 'In-App; Push for meaningful milestones only',
  'Campaign Search Milestone (Tier 3 - Ambient/Digest)', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-020', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-camp-021', 'CI-CAMP-021', 'RuleBook', 'Campaign Completion Report', 'Final analytics available', 'Organization',
  'Review results', 'Tier 2 - Event-Driven', '[Campaign] Campaign Completion Report', 'In-App; Push for meaningful milestones only',
  'Campaign Completion Report (Tier 2 - Event-Driven)', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Communicate collective progress only when the milestone deserves attention.', 'Cooldown: Long • Suppression: Suppress routine progress noise', 'Deliver only for meaningful collective milestones.', 'Engine: Campaign | Attention: Milestone | Score: 60 | Timing: Meaningful milestones | Memory: Recent campaign milestone; last push timestamp',
  'TESTED', 'Medium-Low', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-CAMP-021', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-001', 'CI-GOV-001', 'RuleBook', 'Seedling Submitted for Review', 'Seedling Submitted', 'Sponsor, Co-Sponsors',
  'Acknowledge submission', 'Tier 1 - Guaranteed', '[Governance] Seedling Submitted for Review', 'Push + In-App',
  'Seedling Submitted for Review (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-002', 'CI-GOV-002', 'RuleBook', 'Seedling Approved', 'Seedling Approved', 'Sponsor, Co-Sponsors',
  'Acknowledge Acceptance', 'Tier 1 - Guaranteed', '[Governance] Seedling Approved', 'Push + In-App',
  'Seedling Approved (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-003', 'CI-GOV-003', 'RuleBook', 'Seedling Rejected', 'Seedling Rejected', 'Sponsor, Co-Sponsors',
  'Explain decision', 'Tier 1 - Guaranteed', '[Governance] Seedling Rejected', 'Push + In-App',
  'Seedling Rejected (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-004', 'CI-GOV-004', 'RuleBook', 'Comment Reported', 'Comment Flagged by user', 'Reporter',
  'Acknowledge report', 'Tier 1 - Guaranteed', '[Governance] Comment Reported', 'Push + In-App',
  'Comment Reported (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-005', 'CI-GOV-005', 'RuleBook', 'Comment Removed', 'Comment Removed', 'Commenter',
  'Notify author', 'Tier 1 - Guaranteed', '[Governance] Comment Removed', 'Push + In-App',
  'Comment Removed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-006', 'CI-GOV-006', 'RuleBook', 'Comment Removed', 'Comment Removed', 'Reporter',
  'Close the loop on report', 'Tier 1 - Guaranteed', '[Governance] Comment Removed', 'Push + In-App',
  'Comment Removed (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-007', 'CI-GOV-007', 'RuleBook', 'Account Warning', 'Offending activity', 'Commenter',
  'Policy warning', 'Tier 1 - Guaranteed', '[Governance] Account Warning', 'Push + In-App',
  'Account Warning (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-008', 'CI-GOV-008', 'RuleBook', 'Temporary Account Restriction', 'Offending issue', 'Commenter',
  'Notify restriction', 'Tier 1 - Guaranteed', '[Governance] Temporary Account Restriction', 'Push + In-App',
  'Temporary Account Restriction (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-gov-009', 'CI-GOV-009', 'RuleBook', 'Account Restored', 'Account reinstated', 'Commenter',
  'Notify restoration', 'Tier 1 - Guaranteed', '[Governance] Account Restored', 'Push + In-App',
  'Account Restored (Tier 1 - Guaranteed)', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Cooldown: None • Suppression: Exact duplicates only', 'Always deliver unless exact duplicate.', 'Engine: Governance | Attention: Critical | Score: 100 | Timing: Immediate | Memory: Recent exact-duplicate event IDs; recent governance experience',
  'TESTED', 'High', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-GOV-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-001', 'CI-NARR-001', 'RuleBook', 'Generate Seedling title', 'Generate Seedling title requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Generate Seedling title', 'In-App only',
  'Generate Seedling title (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-001', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-002', 'CI-NARR-002', 'RuleBook', 'Generate Seedling description', 'Generate Seedling description requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Generate Seedling description', 'In-App only',
  'Generate Seedling description (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-002', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-003', 'CI-NARR-003', 'RuleBook', 'Generate campaign title', 'Generate campaign title requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Generate campaign title', 'In-App only',
  'Generate campaign title (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-003', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-004', 'CI-NARR-004', 'RuleBook', 'Generate campaign description', 'Generate campaign description requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Generate campaign description', 'In-App only',
  'Generate campaign description (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-004', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-005', 'CI-NARR-005', 'RuleBook', 'Seedling Birthday Challenge - Generate Seedling title', 'Generate Seedling title requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Seedling Birthday Challenge - Generate Seedling title', 'In-App only',
  'Seedling Birthday Challenge - Generate Seedling title (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-005', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-006', 'CI-NARR-006', 'RuleBook', 'Seedling Birthday Challenge - Generate Seedling description', 'Generate Seedling description requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Seedling Birthday Challenge - Generate Seedling description', 'In-App only',
  'Seedling Birthday Challenge - Generate Seedling description (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-006', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-007', 'CI-NARR-007', 'RuleBook', 'Seedling Birthday Challenge - Generate campaign title', 'Generate campaign title requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Seedling Birthday Challenge - Generate campaign title', 'In-App only',
  'Seedling Birthday Challenge - Generate campaign title (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-007', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-008', 'CI-NARR-008', 'RuleBook', 'Seedling Birthday Challenge - Generate campaign description', 'Generate campaign description requested or context detected', 'User',
  '', 'Tier 4 - Session-Bound', '[Narrative] Seedling Birthday Challenge - Generate campaign description', 'In-App only',
  'Seedling Birthday Challenge - Generate campaign description (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-008', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-009', 'CI-NARR-009', 'RuleBook', 'Sharing - Facebook sharing text', 'Facebook sharing text requested or context detected', 'User',
  'Need help sharing your story? We''ve got a few ideas.', 'Tier 4 - Session-Bound', '[Narrative] Sharing - Facebook sharing text', 'In-App only',
  'Sharing - Facebook sharing text (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-009', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-010', 'CI-NARR-010', 'RuleBook', 'Sharing - Instagram caption', 'Instagram caption requested or context detected', 'User',
  'Need help sharing your story? We''ve got a few ideas.', 'Tier 4 - Session-Bound', '[Narrative] Sharing - Instagram caption', 'In-App only',
  'Sharing - Instagram caption (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-010', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-011', 'CI-NARR-011', 'RuleBook', 'Sharing - X post', 'X caption requested or context detected', 'User',
  'Need help sharing your story? We''ve got a few ideas.', 'Tier 4 - Session-Bound', '[Narrative] Sharing - X post', 'In-App only',
  'Sharing - X post (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-011', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-012', 'CI-NARR-012', 'RuleBook', 'Sharing - LinkedIn post', 'LinkedIn post requested or context detected', 'User',
  'Need help sharing your story? We''ve got a few ideas.', 'Tier 4 - Session-Bound', '[Narrative] Sharing - LinkedIn post', 'In-App only',
  'Sharing - LinkedIn post (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-012', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-013', 'CI-NARR-013', 'RuleBook', 'Sharing - Email invitation', 'Email invitation requested or context detected', 'User',
  'Need help sharing your story? We''ve got a few ideas.', 'Tier 4 - Session-Bound', '[Narrative] Sharing - Email invitation', 'In-App only',
  'Sharing - Email invitation (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-013', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
INSERT INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, assignee_name, assignee_email,
  assignee_avatar, rule_id, created_at, updated_at
) VALUES (
  'rule-ci-narr-014', 'CI-NARR-014', 'RuleBook', 'Sharing - SMS invitation', 'SMS invitation requested or context detected', 'User',
  'Need help sharing your story? We''ve got a few ideas.', 'Tier 4 - Session-Bound', '[Narrative] Sharing - SMS invitation', 'In-App only',
  'Sharing - SMS invitation (Tier 4 - Session-Bound)', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'Respond because the user explicitly requested assistance.', 'Cooldown: None • Suppression: None', 'Respond only to explicit user request.', 'Engine: Narrative | Attention: User Initiated | Score: 100 | Timing: On demand | Memory: Current user request and editing context',
  'TESTED', 'User initiated', 'STAGING', 'Seedling QA', 'qa@seedling.org',
  '', 'CI-NARR-014', '2026-09-26 12:00:00', '2026-09-26 12:00:00'
);
