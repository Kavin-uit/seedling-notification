-- Add Grounds Crew scenarios to Contribution Engine
UPDATE engine_sheets 
SET sheet_url = 'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true',
    csv_export_url = 'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/export?format=csv',
    updated_at = datetime('now')
WHERE engine_category = 'Contribution';

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
  'Donor enrolls in The Grounds Crew (if the first monthly contribution processes the same day, it is included in this message)',
  'Donor (parent/guardian for family accounts)',
  'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (monthly amount, first charge date, continues monthly until cancelled, how to cancel)',
  'Stay enrolled; meet the Picks',
  'Welcome to The Grounds Crew! 🌱',
  'You''re on The Grounds Crew! Each month your gift will support that month''s 5 Picks to Click.',
  'Welcome to The Grounds Crew! 🌱',
  'Welcome to The Grounds Crew! You''ve made generosity a habit. Each month, your donation to Seedling Social Giving is regranted among that month''s 5 Picks to Click -- hand-picked Seedlings that deserve a boost. We''ll send you one note each month when your gift goes out and introduce the new Picks -- no flood of notifications, just the good stuff.

YOUR ENROLLMENT: Monthly amount: (Amount). Funding source: (Card ending #### | GreenHouse balance). First contribution: (First Charge Date). Your contribution repeats on or about the same day each month until you cancel. You can change your amount or funding source, or cancel, anytime in the app under The Grounds Crew, or by emailing support@seedlingsocial.org.

[IF FIRST CONTRIBUTION PROCESSED TODAY] Your first gift is already supporting (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5). Add the card/ACH or GreenHouse closing from Support All 5 Gift Made.  BOX: Meet Your Picks',
  'Welcome to The Grounds Crew! Monthly amount: (Amount), starting (First Charge Date) and repeating monthly until you cancel. Manage or cancel anytime in the app under The Grounds Crew, or email support@seedlingsocial.org.  BOX: Meet Your Picks',
  'take user to Grounds Crew hub (current 5 Picks, amounts, membership settings incl. cancel)',
  '',
  'TO DO',
  'Medium',
  'STAGING',
  '',
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
  'Grounds Crew Monthly Gift Processed',
  'Monthly Grounds Crew contribution processed (card charge succeeds or GreenHouse balance applied) for the new month''s Picks',
  'Donor (Grounds Crew member)',
  'Confirm the month''s gift once and introduce the new Picks (replaces the monthly Picks to Click digest for members)',
  'Open app to meet new Picks; stay enrolled',
  'Your Grounds Crew gift is out 💚',
  'Your Grounds Crew gift is now supporting this month''s 5 Picks to Click. Come meet them!   [IF AUTO-REPLENISH CHARGED] Your Grounds Crew gift is out, and Auto-Replenish added (Replenish Amount) to your GreenHouse.',
  'Your Grounds Crew Gift Is Out 💚',
  'Thanks for being on The Grounds Crew! Your (Amount) gift this month is supporting (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5). Since joining, you''ve helped (Count) Seedlings grow.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds to your GreenHouse, so no new acknowledgment is issued. GreenHouse balance remaining: (Balance).

[IF THIS GIFT TRIGGERED AUTO-REPLENISH -- required notice, ToS 4.3] AUTO-REPLENISH CHARGE: (Replenish Amount) was charged to (Card ending ####) on (Date) to refill your GreenHouse. This is a new donation to Seedling Social Giving; your acknowledgment is saved in your giving history. Change or turn off Auto-Replenish anytime in GreenHouse settings.  BOX: Meet This Month''s Picks',
  'Your Grounds Crew gift is now supporting this month''s 5 Picks to Click. You''ve helped (Count) Seedlings grow.  BOX: Meet the Picks',
  'take user to video intro of the new Picks first, then the Grounds Crew hub listing the 5 Picks',
  '',
  'TO DO',
  'Medium',
  'STAGING',
  '',
  datetime('now'),
  datetime('now')
);
