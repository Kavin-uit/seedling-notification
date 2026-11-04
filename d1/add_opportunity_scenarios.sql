-- Add 4 new Opportunity Engine scenarios
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
