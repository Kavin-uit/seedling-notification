-- Official Seedling Scenarios Schema and Seed Data
CREATE TABLE IF NOT EXISTS scenarios (
  id TEXT PRIMARY KEY,
  key TEXT NOT NULL,
  engine_category TEXT NOT NULL DEFAULT 'Governance',
  governance_event TEXT NOT NULL,
  trigger TEXT NOT NULL DEFAULT '',
  audience TEXT NOT NULL DEFAULT '',
  communication_objective TEXT NOT NULL DEFAULT '',
  desired_outcome TEXT NOT NULL DEFAULT '',
  push_subject TEXT NOT NULL DEFAULT '',
  push_body TEXT NOT NULL DEFAULT '',
  email_subject TEXT NOT NULL DEFAULT '',
  email_body TEXT NOT NULL DEFAULT '',
  in_app_experience TEXT NOT NULL DEFAULT '',
  cta TEXT NOT NULL DEFAULT '',
  comments TEXT DEFAULT '',
  status TEXT NOT NULL DEFAULT 'TO DO',
  priority TEXT NOT NULL DEFAULT 'Medium',
  environment TEXT NOT NULL DEFAULT 'STAGING',
  rule_id TEXT DEFAULT '',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS scenario_attachments (
  id TEXT PRIMARY KEY,
  scenario_id TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_type TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  r2_key TEXT NOT NULL,
  public_url TEXT NOT NULL,
  tag TEXT DEFAULT 'screenshot',
  created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_attachments_scenario_id ON scenario_attachments(scenario_id);

CREATE TABLE IF NOT EXISTS engine_sheets (
  engine_category TEXT PRIMARY KEY,
  sheet_name TEXT NOT NULL,
  sheet_url TEXT NOT NULL,
  csv_export_url TEXT NOT NULL,
  enabled INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

INSERT OR REPLACE INTO engine_sheets VALUES
('Governance', 'Governance Content Sheet', 'https://docs.google.com/spreadsheets/d/1WQP9fY_pMUqZG28TX8gGSDL2vtb58ZAP/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true', 'https://docs.google.com/spreadsheets/d/1WQP9fY_pMUqZG28TX8gGSDL2vtb58ZAP/export?format=csv', 1, datetime('now'), datetime('now')),
('Contribution', 'Contribution Content Sheet', 'https://docs.google.com/spreadsheets/d/1BfxirN7r6XpPDKRyx4ydoornE78He-6n/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true', 'https://docs.google.com/spreadsheets/d/1BfxirN7r6XpPDKRyx4ydoornE78He-6n/export?format=csv', 1, datetime('now'), datetime('now')),
('Participation', 'Participation Content Sheet', 'https://docs.google.com/spreadsheets/d/1sbkCjQX8F5NvR3BZDU2j_YBOQIYguGVy/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true', 'https://docs.google.com/spreadsheets/d/1sbkCjQX8F5NvR3BZDU2j_YBOQIYguGVy/export?format=csv', 1, datetime('now'), datetime('now')),
('Identity', 'Identity Content Sheet', 'https://docs.google.com/spreadsheets/d/1gW1y-0azkHNdgDELrl-WNKOzYmfO9cjr/edit?gid=2121080523#gid=2121080523', 'https://docs.google.com/spreadsheets/d/1gW1y-0azkHNdgDELrl-WNKOzYmfO9cjr/export?format=csv&gid=2121080523', 1, datetime('now'), datetime('now')),
('Opportunity', 'Opportunity Content Sheet', 'https://docs.google.com/spreadsheets/d/1jD0q7YXiHRo6BAp64F36n6kE48xWonvZ/edit?gid=659053223#gid=659053223', 'https://docs.google.com/spreadsheets/d/1jD0q7YXiHRo6BAp64F36n6kE48xWonvZ/export?format=csv&gid=659053223', 1, datetime('now'), datetime('now')),
('Discovery', 'Discovery Content Sheet', 'https://docs.google.com/spreadsheets/d/1a6VS21ynlS1lAM9PQVxqUoQGneI_3-pF/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true', 'https://docs.google.com/spreadsheets/d/1a6VS21ynlS1lAM9PQVxqUoQGneI_3-pF/export?format=csv', 1, datetime('now'), datetime('now')),
('Campaign', 'Campaign Content Sheet', 'https://docs.google.com/spreadsheets/d/1puRDHto_1yuqVqor24t6TtaUcEP3xG5d/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true', 'https://docs.google.com/spreadsheets/d/1puRDHto_1yuqVqor24t6TtaUcEP3xG5d/export?format=csv', 1, datetime('now'), datetime('now'));

DELETE FROM scenarios;

INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('gov-1', 'GOV-1', 'Governance', 'Seedling Submitted for Review', 'Seedling Submitted', 'Sponsor, Co-Sponsors', 'Acknowledge submission', 'Review Seedling', 'Your Seedling is in review', 'Your Seedling is in Review', 'Your Seedling Is in Review', 'Thanks for submitting your Seedling! Our team is reviewing it now, and we''ll let you know as soon as it''s ready to go live.  BOX: View Status', 'Thanks! Your Seedling has been submitted for review -- once we have completed our review we''ll let you know!', 'take user to Seedling review status', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('gov-2', 'GOV-2', 'Governance', 'Seedling Approved', 'Seedling Approved', 'Sponsor, Co-Sponsors', 'Acknowledge Acceptance', 'Post Seedling', 'You''re live! 🎉', 'Congratulations -- your Seedling is Live!', 'You''re Live! 🎉', 'Great news -- your Seedling has been approved and is now live on Seedling. Now''s the time to start sharing it with your community and inviting support.  BOX: Share Your Seedling', 'Your Seedling has been approved and is now live on Seedling. Time to start sharing it with your community.  BOX: Share', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('gov-3', 'GOV-3', 'Governance', 'Seedling Rejected', 'Seedling Rejected', 'Sponsor, Co-Sponsors', 'Explain decision', 'Modify Seedling', 'Your Seedling needs a change', 'We couldn''t publish your Seedling -- Here''s why', 'Your Seedling Needs a Change', 'We weren''t able to publish your Seedling because it doesn''t currently meet our community guidelines. Review the reason we''ve provided, make the needed changes, and reach out to support if you have questions.  BOX: Edit Seedling', 'Your Seedling doesn''t meet our community guidelines. Review the reason provided and contact support if you have questions.', 'take user to Seedling edit screen with rejection reason', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('gov-4', 'GOV-4', 'Governance', 'Comment Reported', 'Comment Flagged by user', 'Reporter', 'Acknowledge report', 'Review Comment', 'Thanks for the report', 'Thank you for reporting a Seedling comment', 'Thanks for the Report', 'Thanks for helping keep Seedling welcoming. We''ll review the comment you reported, and if it merits removal, we''ll take care of it.', 'Thanks for helping keep Seedling welcoming. We''ll review the reported comment and if it merits removal we will do so.', 'confirm in place, no navigation required', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('gov-5', 'GOV-5', 'Governance', 'Comment Removed', 'Comment Removed', 'Commenter', 'Notify author', 'Comment removed', 'A comment was removed', 'One of your comments has been removed.', 'A Comment Was Removed', 'One of your comments has been removed because it violated our Community Guidelines. Take a look at our guidelines if you have questions.  BOX: View Guidelines', 'We removed one of your comments because it violated our Community Guidelines.', 'take user to Community Guidelines', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('gov-6', 'GOV-6', 'Governance', 'Comment Removed', 'Comment Removed', 'Reporter', 'Close the loop on report', 'Confirm resolution', 'Update on your report', 'Thanks for helping keep Seedling welcoming.', 'Update on Your Report', 'Thanks for helping keep Seedling welcoming. The comment you reported has been removed for violating our Community Guidelines.', 'The comment you reported has been removed for violating our Community Guidelines.', 'confirm in place, no navigation required', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-1', 'CONTRIB-1', 'Contribution', 'Donation Made via Credit/Debit Card', 'Donor makes donation', 'Donor', 'Thank donor', 'Positive moment', 'Thank you! 💚', 'Your donation moved (Seedling) one step closer to its goal -- thank you!', 'Thank You! 💚', 'Thank you! Your donation moved (Seedling) one step closer to its goal. Every gift counts, and yours just made a real difference.  BOX: View Donation', 'Your donation is complete -- (Seedling) is one step closer to its goal. Thank you!', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-3', 'CONTRIB-3', 'Contribution', 'ACH Donation Failed', 'Payment declined', 'Donor', 'Resolve issue', 'Retry donation', 'We hit a snag with your donation', 'We couldn''t process your ACH donation.', 'We Hit a Snag With Your Donation', 'We weren''t able to process your ACH donation. Please update your payment method or try again so your gift can go through.  BOX: Update Payment', 'Your ACH payment didn''t go through -- please update your payment method or try again.', 'take user to payment method update screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-4', 'CONTRIB-4', 'Contribution', 'ACH Donation Pending', 'ACH or delayed payment', 'Donor', 'Set expectations', 'Await settlement', 'Your donation is on its way', 'Your ACH donation is being processed.', 'Your Donation Is on Its Way', 'Your ACH payment is on its way. We''ll let you know as soon as it''s confirmed -- no action needed in the meantime.  BOX: View Status', 'Your ACH payment is on its way. We''ll let you know as soon as it''s confirmed.', 'take user to donation status', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-5', 'CONTRIB-5', 'Contribution', 'Donation Receipt Available', 'Receipt generated', 'Donor', 'Provide documentation', 'Download receipt', 'Your receipt is ready 🧾', 'Your donation receipt is ready.', 'Your Receipt Is Ready 🧾', 'Your donation receipt is ready whenever you need it. Download or email it for your records anytime.  BOX: View Receipt', 'Download or email your official donation receipt anytime.  BOX: View Receipt', 'take user to donation receipt', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-6', 'CONTRIB-6', 'Contribution', 'GreenHouse Auto-Reload', 'Automatic funding', 'User', 'Maintain balance', 'Continue giving', 'Your GreenHouse is topped up', 'Your GreenHouse was automatically refilled.', 'Your GreenHouse Is Topped Up', 'Your GreenHouse balance has been automatically replenished, so you''re ready for your next act of generosity whenever inspiration strikes.  BOX: View GreenHouse', 'Your GreenHouse balance has been replenished so you''re ready for your next act of generosity.', 'take user to GreenHouse balance', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-7', 'CONTRIB-7', 'Contribution', 'GreenHouse Auto-Reload Failed', 'Auto reload unsuccessful', 'User', 'Resolve payment', 'Update funding source', 'We couldn''t refill your GreenHouse', 'We couldn''t refill your GreenHouse.', 'We Couldn''t Refill Your GreenHouse', 'Your GreenHouse auto-reload didn''t go through. Update your funding source to keep your GreenHouse topped up and ready to give.  BOX: Update Funding Source', 'Your GreenHouse auto-reload didn''t go through. Update your funding source to keep your GreenHouse topped up.  BOX: Update Funding Source', 'take user to GreenHouse reload process', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-8', 'CONTRIB-8', 'Contribution', 'GreenHouse Deposit Added', 'Funds deposited', 'User', 'Confirm balance', 'Use GreenHouse', 'Funds added! 💰', 'You''ve added funds to your GreenHouse.', 'Funds Added! 💰', 'Your funds have been added to your GreenHouse and are ready to donate whenever inspiration strikes.  BOX: View GreenHouse', 'Your funds have been added to your GreenHouse and are ready to donate whenever inspiration strikes.', 'take user to GreenHouse', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-9', 'CONTRIB-9', 'Contribution', 'GreenHouse Donation Made', 'Donation from balance', 'User', 'Confirm transaction', 'Continue giving', 'Donation sent from your GreenHouse', 'Your donation was sent from your GreenHouse.', 'Donation Sent From Your GreenHouse', 'Your donation was sent using your GreenHouse balance. Thank you for growing good.  BOX: View Donation', 'Your donation was sent using your GreenHouse balance. Thank you for Growing Good.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-10', 'CONTRIB-10', 'Contribution', 'Payment Method Added', 'New payment method', 'User', 'Confirm setup', 'Complete donation', 'Payment method added ✅', 'Payment method added successfully.', 'Payment Method Added ✅', 'Your new payment method has been added successfully and is ready for future donations.  BOX: View Payment Methods', 'Your new payment method is ready for future donations.', 'take user to payment methods', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-11', 'CONTRIB-11', 'Contribution', 'Payment Method Expiring', 'Card nearing expiration', 'Donor', 'Prevent failed payments', 'Update payment', 'Your card is expiring soon', 'Your payment method expires soon.', 'Your Card Is Expiring Soon', 'Your payment method expires soon. Update it now to avoid any interruption to your giving.  BOX: Update Payment', 'Update your payment information to avoid interrupted giving.', 'take user to payment method update screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-12', 'CONTRIB-12', 'Contribution', 'Payment Method Preferences Updated', 'Giving settings changed', 'Donor', 'Confirm preferences', 'Maintain trust', 'Preferences updated', 'Payment preferences updated.', 'Preferences Updated', 'Your preferred payment settings have been saved exactly the way you wanted.  BOX: View Preferences', 'Your preferred payment settings have been saved.', 'take user to payment preferences', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-13', 'CONTRIB-13', 'Contribution', 'Payment Method Updated', 'Payment details changed', 'Donor', 'Confirm update', 'Maintain continuity', 'Payment method updated', 'Your payment method has been updated.', 'Payment Method Updated', 'Your payment method has been updated. Your changes have been saved and are ready to use.  BOX: View Payment Methods', 'Your changes have been saved and are ready to use.', 'take user to payment methods', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('contrib-14', 'CONTRIB-14', 'Contribution', 'Receipt Downloaded', 'Receipt accessed', 'Donor', 'Confirm access', 'Retain records', 'Receipt downloaded', 'Receipt downloaded.', 'Receipt Downloaded', 'Your donation receipt has been downloaded successfully and is ready for your records.', 'Your donation receipt has been downloaded successfully.', 'confirm in place, no navigation required', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('ce-17', 'CONTRIB-17', 'Contribution', 'Grounds Crew Enrollment Confirmed', 'Donor enrolls in The Grounds Crew (if the first contribution processes the same day, it is included in this message)', 'Donor (parent/guardian for family accounts)', 'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (contribution amount, first charge at enrollment, charged each time a new batch launches -- no more than once per calendar month -- until cancelled, how to cancel)', 'Stay enrolled; meet the Picks', 'Welcome to The Grounds Crew! 🌱', 'You''re on The Grounds Crew! Your first gift is already supporting this batch''s 5 Picks to Click.', 'Welcome to The Grounds Crew! 🌱', 'Welcome to The Grounds Crew! You''ve made generosity a habit, and your first gift is already at work. Your (Amount) gift today is supporting (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5).

Each time a new set of 5 Picks to Click launches, your donation to Seedling Social Giving goes out and is regranted among those 5 Picks -- hand-picked Seedlings that deserve a boost -- no more than once per calendar month, and we''ll send you one note each time so you always know what you''re growing. [IF NEXT BATCH DATE ANNOUNCED] The next Picks launch on (Next Batch Date), so your next gift goes out then.

YOUR ENROLLMENT: Gift amount: (Amount). Funding source: (Card ending #### | GreenHouse balance). First contribution: today. Your contribution is charged when each new set of 5 Picks to Click launches. New Picks launch no more than once per calendar month, so you''ll never be charged more than once in a calendar month. If no new Picks launch in a month, you won''t be charged that month. You can change your amount or funding source, pause, or cancel anytime in the app under The Grounds Crew, or email support@seedlingsocial.org.  BOX: Meet Your Picks

Add the card/ACH or GreenHouse closing from Support All 5 Gift Made.', 'Welcome to The Grounds Crew! Your first gift is supporting this batch''s 5 Picks. You''ll be charged (Amount) each time new Picks launch, no more than once per calendar month. Manage or cancel anytime in the app under The Grounds Crew.  BOX: Meet Your Picks', 'take user to Grounds Crew hub (current 5 Picks, amounts, membership settings incl. cancel)', 'TO DO', 'High', 'STAGING', 'CI-CONTR-030', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('ce-18', 'CONTRIB-18', 'Contribution', 'Grounds Crew Batch Gift Processed', 'New Picks batch released AND the member''s Grounds Crew charge for that batch processed (card charge succeeds or GreenHouse balance applied)', 'Donor (Grounds Crew member)', 'Confirm the gift once, celebrate what the last batch grew, and introduce the new Picks', 'Open app to meet new Picks; stay enrolled', 'Your Grounds Crew gift is out 💚', 'Your Grounds Crew gift is out! The Crew grew 5 Seedlings last batch. Come meet your 5 new Picks.   [IF AUTO-REPLENISH CHARGED] Your Grounds Crew gift is out, and Auto-Replenish added (Replenish Amount) to your GreenHouse.', 'Your Grounds Crew Gift Is Out: Meet Your New Picks 💚', 'New Picks are here, and your (Amount) Grounds Crew gift just went out to support them.

[IF LAST BATCH RESULTS ENTERED] WHAT THE LAST BATCH GREW: Together the Crew gave (Crew Total Last Batch) to (Last Seedling 1), (Last Seedling 2), (Last Seedling 3), (Last Seedling 4), and (Last Seedling 5). [One result line per Seedling, e.g. (Last Seedling 1) reached (Percent) of its goal.]

MEET YOUR 5 NEW PICKS: (Seedling 1) for (Nonprofit 1) -- (One-line description). [Repeat for Seedlings 2-5.]

Since joining, you''ve helped (Count) Seedlings grow across (Crew Gift Count) Grounds Crew gifts. Your next gift goes out when the next set of Picks launches, no more than once per calendar month.  BOX: Meet the Picks   BOX: Share This Batch

[IF CREW MILESTONE] Opening line: The Grounds Crew just passed (Milestone) given, all time. You''re part of every dollar.
[IF NO LAST BATCH RESULTS ENTERED, OR FIRST BATCH DAY SINCE ENROLLMENT] Skip WHAT THE LAST BATCH GREW; open with: Your second Grounds Crew gift just went out to 5 brand-new Picks.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds to your GreenHouse, so no new acknowledgment is issued. GreenHouse balance remaining: (Balance).

[IF THIS GIFT TRIGGERED AUTO-REPLENISH -- required notice, ToS 4.3] AUTO-REPLENISH CHARGE: (Replenish Amount) was charged to (Card ending ####) on (Date) to refill your GreenHouse. This is a new donation to Seedling Social Giving; your acknowledgment is saved in your giving history. Change or turn off Auto-Replenish anytime in GreenHouse settings.  BOX: Meet the New Picks', 'Your Grounds Crew gift is now supporting the 5 new Picks to Click. Last batch the Crew grew 5 Seedlings, and you''ve helped (Count) Seedlings grow.  BOX: Meet the Picks', 'take user to video intro of the new Picks first, then the Grounds Crew hub listing the 5 Picks; Share opens the share card with the member''s personal tracked link', 'TO DO', 'High', 'STAGING', 'CI-CONTR-031', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('ce-19', 'CONTRIB-19', 'Contribution', 'Support All 5 Gift Made', 'Donor completes a Support all 5 gift (all 5 recommendations recorded under one parent_gift_id)', 'Donor (parent/guardian for family accounts)', 'Thank donor once for the whole gift and show five-fold impact', 'Positive moment; explore The Grounds Crew', 'You just supported all 5! 💚', 'Your gift is supporting all 5 Picks to Click -- five Seedlings just moved closer to their goals. Thank you!', 'You Just Supported All 5! 💚', 'Thank you! Your gift of (Amount) is supporting all 5 of (this week''s / this month''s) Picks to Click: (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5). Five causes, one generous act -- and every one of them is closer to its goal because of you.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds on (Deposit Date), so no new acknowledgment is issued.  BOX: See Your Impact', 'Thank you! Your gift is supporting all 5 Picks to Click -- five Seedlings are closer to their goals, and that''s 5 donations toward your next badge! [GREENHOUSE] Sent from your GreenHouse.  BOX: See Your Impact   |   Secondary line (non-members only): Want to do this every month automatically? Join The Grounds Crew.  BOX: Join The Grounds Crew', 'take user to Support all 5 impact summary (all 5 Seedlings with amounts, progress bars, and any badges/goals this gift unlocked)', 'TO DO', 'High', 'STAGING', 'CI-CONTR-029', datetime('now'), datetime('now'));

-- Participation Engine Scenarios
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-1', 'PART-1', 'Participation', 'First App Session', 'First app open', 'User', 'Welcome active participation', 'Explore platform', 'Welcome to Seedling! 🌱', 'Welcome to Seedling! Your journey to Grow Good starts today. 🌱', 'Welcome to Seedling! 🌱', 'Welcome to Seedling! Every act of generosity begins with a single step, and you''ve just taken yours. Explore inspiring causes, discover the stories behind them, and find what moves you to give.  BOX: Explore Seedling', 'Welcome to Seedling! Every act of generosity begins with a single step. Explore causes, discover inspiring stories, and support what matters most to you.', 'take user to discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-3', 'PART-3', 'Participation', 'Like Added', 'Creator Liked comment', 'Person who liked the comment', 'Confirm participation', 'Continue engaging', 'Nice one! 👍', 'You brightened someone''s day with your support.', 'Nice One! 👍', 'You brightened someone''s day with a simple like. Small moments like this help conversations -- and communities -- grow.  BOX: Keep Engaging', 'Your like let someone know their comment mattered. Small moments like this help conversations grow.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-4', 'PART-4', 'Participation', 'Like Added', 'Follower of (Name) liked comment', 'Follower of Commenter', 'Confirm participation', 'Continue engaging', 'Your friends are liking things', '(Count) people, whom you follow, liked a comment in the past 15 minutes.', 'Your Friends Are Liking Things', 'People you follow have been liking a comment recently -- take a look and see what caught their attention.  BOX: View Comment', 'See the comment your friends have been liking and join the conversation.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-5', 'PART-5', 'Participation', 'Like Added', 'Donor to (Seedling) liked comment', 'Donor', 'Confirm participation', 'Continue engaging', 'Activity on a Seedling you support', '(Count) people liked a Seedling you donated to in the past 15 minutes.', 'Activity on a Seedling You Support', 'A Seedling you''ve supported is getting some comment activity. Take a look and see what people are saying.  BOX: View Comment', 'See the comment activity on a Seedling you''ve supported.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-6', 'PART-6', 'Participation', 'Comment Posted', 'Comment submitted', 'Comment author', 'Grow conversation', 'Reply or react', 'Thanks for chiming in!', 'Thanks for joining the conversation!', 'Thanks for Chiming In!', 'Thanks for joining the conversation. Your comment is live -- check back to see if anyone replies.  BOX: View Comment', 'Your comment is live. Keep the conversation going by checking back for replies.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-7', 'PART-7', 'Participation', 'Comment Posted', 'Comment submitted', 'Follower of Commenter', 'Grow conversation', 'Reply or react', 'Your friends are talking', '(Count) people, whom you follow, commented on a Seedling in the past 15 minutes.', 'Your Friends Are Talking', 'People you follow have been commenting on a Seedling recently. See what they had to say and join the conversation.  BOX: View Comments', 'See what the people you follow have been saying.', 'take user directly to the comments in Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-8', 'PART-8', 'Participation', 'Comment Posted', 'Comment submitted', 'Donor of Seedling', 'Grow conversation', 'Reply or react', 'New activity on your Seedling', '(Count) new comments on a Seedling you donated to in the past 15 minutes.', 'New Activity on Your Seedling', 'There''s new conversation happening on a Seedling you''ve donated to. Take a look at what people are saying.  BOX: View Comments', 'See the latest conversation on a Seedling you''ve supported.', 'take user directly to the comments in Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-9', 'PART-9', 'Participation', 'Comment Posted', 'Comment submitted', 'Creator of Seedling', 'Grow conversation', 'Reply or react', 'Your Seedling is sparking conversation', '(Count) people commented on your Seedling in the past 15 minutes.', 'Your Seedling Is Sparking Conversation', 'Your Seedling is sparking some great conversation. See what people are saying and jump in.  BOX: View Comments', 'Your Seedling is sparking conversation -- see what people are saying and join in.', 'take user directly to the comments in Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-10', 'PART-10', 'Participation', 'Comment Replied To', 'Reply posted', 'Original commenter', 'Continue discussion', 'Return to thread', 'You got a reply!', '(Name) replied to your comment -- see what they had to say.', 'You Got a Reply!', 'Someone replied to your comment -- see what they had to say and keep the conversation going.  BOX: View Reply', 'Someone replied to your comment. See what they said and keep the conversation going.', 'take user directly to comment in Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-11', 'PART-11', 'Participation', 'Comment Liked', 'Reaction received', 'Comment author', 'Recognize contribution', 'Continue participating', 'Someone liked your comment ❤️', 'Someone appreciated your comment. ❤️', 'Someone Liked Your Comment ❤️', 'Someone appreciated what you had to say. Keep sharing your thoughts with the community.  BOX: View Comment', 'Someone liked your comment. Keep sharing your thoughts with the community.', 'take user to feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-14', 'PART-14', 'Participation', 'Organization Followed', 'Follow created', 'User', 'Build long-term relationship', 'Receive updates', 'You''re now following (nonprofit)', 'You''re now following (nonprofit).', 'You''re Now Following (Nonprofit)', 'You''re now following (nonprofit). You''ll see their updates in your feed, including new Seedlings and milestones they reach.  BOX: View Profile', 'You''ll now see updates from (nonprofit) in your feed, including new Seedlings and milestones.', 'take user to feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-15', 'PART-15', 'Participation', 'Grower Followed', 'Follow created', 'User', 'Strengthen creator connection', 'Receive updates', 'You''re now following (Name)', 'You''re now following (Name).', 'You''re Now Following (Name)', 'You''re now following (Name). You''ll see their updates in your feed, including new stories and Seedlings they create.  BOX: View Profile', 'You''ll now see updates from (Name) in your feed, including new stories and Seedlings.', 'take user to feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-31', 'PART-31', 'Participation', 'Seedling Goal Reached', 'Collective participation milestone', 'Participants', 'Celebrate community', 'Share success', 'Goal reached! 🎉', '(Seedling) goal has been reached -- thank you for your support!', 'Goal Reached! 🎉', '(Seedling) reached its goal thanks to everyone who pitched in, including you. See the final results and celebrate the impact you helped create.  BOX: View Results', '(Seedling) reached its goal thanks to everyone who pitched in, including you. See the final results.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-32', 'PART-32', 'Participation', 'Campaign Goal Reached', 'Collective participation milestone', 'Participants', 'Celebrate community', 'Share success', 'Campaign goal reached! 🎉', '(Seedling Campaign) goal has been reached -- thank you for your support!', 'Campaign Goal Reached! 🎉', '(Seedling Campaign) reached its goal thanks to everyone who pitched in, including you. See the final results and celebrate the impact you helped create.  BOX: View Results', '(Seedling Campaign) reached its goal thanks to everyone who pitched in, including you. See the final results.', 'take user directly to Seedling Campaign page', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-37', 'PART-37', 'Participation', 'Like Received', 'Someone reacts to your post', 'Content author', 'Recognize engagement', 'Return to conversation', 'Your Seedling''s getting love ❤️', '(Count) people liked your Seedling in the past 15 minutes.', 'Your Seedling''s Getting Love ❤️', 'Your Seedling is getting some love. See who''s engaging with your story and thank them for their support.  BOX: View Seedling', 'Your Seedling is getting some love. See who''s engaging with your story.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
-- CI-PART-038: (disabled — commented out, redundant with 037's digest)
-- INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-38', 'PART-38', 'Participation', 'Multiple Likes Received', 'Reaction threshold reached', 'Content author', 'Highlight momentum', 'Continue posting', 'Your Seedling''s on a roll! 🔥', 'Your Seedling''s getting some love!', 'Your Seedling''s on a Roll! 🔥', 'Your Seedling''s getting some love -- see who''s been engaging with your story.  BOX: View Seedling', 'Your Seedling''s getting some love -- see who''s been engaging.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-39', 'PART-39', 'Participation', 'New Follower Milestone', 'Follower milestone reached', 'User', 'Celebrate influence', 'Keep contributing', 'Your following is growing!', 'More people are following your journey.', 'Your Following Is Growing!', 'More people are following your journey on Seedling. See who''s joined your community and say hello.  BOX: View Followers', 'More people are following your journey. See who''s joined your community.', 'take user to profile page to see new followers', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-41', 'PART-41', 'Participation', 'Co-Sponsor Invited', 'Sponsor invites a Co-Sponsor', 'Participant', 'Invitation', 'Reply', 'You''ve been invited!', '(Name) invited you to be a Co-Sponsor', 'You''ve Been Invited!', '(Name) has invited you to co-sponsor a Seedling. Review the invitation and let them know your answer.  BOX: Respond', '(Name) has invited you to co-sponsor a Seedling. Review the invitation and let them know your answer.  BOX: Respond', 'take user to co-sponsor invitation screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-42', 'PART-42', 'Participation', 'Co-Sponsor Invitation Responded to', 'Co-Sponsor accepts invite', 'Participant', 'Deepen relationship', 'Reply', 'Your invitation was accepted!', '(Name) has accepted your Co-sponsor invitation!', 'Your Invitation Was Accepted!', '(Name) has accepted your invitation to co-sponsor -- welcome them to the team and start growing good together.  BOX: View Seedling', '(Name) has accepted your invitation to co-sponsor -- welcome them to the team.', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('part-57', 'PART-57', 'Participation', 'Donation Received on Your Seedling', 'Donation', 'Seedling Sponsor, Co-Sponsors', 'Show the Sponsor and Co-Sponsors that others are joining the cause.', 'Maintain activity', 'Ka-Ching! / Bravo! / You''re Crushing It! (rotate each send)', 'Someone just donated to your Seedling!', 'Ka-Ching! / Bravo! / You''re Crushing It! (Rotate Each Send)', 'Great news -- someone just made a donation to your Seedling! Every gift brings your cause closer to its goal, and this one came from someone who believes in what you''re building. Take a look and see who joined in.  BOX: See Who Donated', '', 'take user directly to donation', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));

-- Identity Engine Scenarios
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-1', 'ID-1', 'Identity', 'Account Created', 'User registers', 'User', 'Welcome and establish belonging', 'Complete onboarding', 'You just joined something good 🌱', 'Welcome to Seedling! 🌱', 'You Just Joined Something Good 🌱', 'Welcome to Seedling! We''re so glad you''re here. Every person who joins brings the opportunity to make a difference -- explore inspiring causes, meet compassionate people, and discover how small acts of generosity grow into something extraordinary.  BOX: Get Started', 'We''re so glad you''re here. Every person who joins Seedling brings the opportunity to make a difference. Explore inspiring causes, meet compassionate people, and discover how small acts of generosity can grow into something extraordinary.', 'take user to welcome tour', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-2', 'ID-2', 'Identity', 'Email Verification Required', 'Account created', 'User', 'Verify identity', 'Verified account', 'Just one more step', 'Just one quick step left.', 'Just One More Step', 'You''re almost set up! Please verify your email to finish creating your account. It helps protect your account and makes sure you receive updates from the people and causes you follow.  BOX: Verify Email', 'Please verify your email to finish setting up your account. It helps protect your account and ensures you receive updates from the people and causes you choose to follow.', 'take user to email verification screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-3', 'ID-3', 'Identity', 'Email Verified', 'Verification complete', 'User', 'Reinforce progress', 'Continue onboarding', 'You''re all set! ✅', 'You''re all set!', 'You''re All Set! ✅', 'Thanks for verifying your email. Your account is ready, and your journey of Growing Good can begin.  BOX: Continue', 'Thanks for verifying your email. Your account is ready, and your journey of Growing Good can begin.', 'take user to next onboarding step', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-4', 'ID-4', 'Identity', 'Phone Verification Required', 'Phone added', 'User', 'Secure account', 'Verified phone', 'Secure your account', 'Let''s secure your account.', 'Secure Your Account', 'Thanks for adding your phone number. Please verify it so we can better protect your account and help you recover it if you ever need to.  BOX: Verify Phone', 'Thanks for adding your phone number. Please verify it so we can better protect your account and help you recover it if you ever need to.', 'take user to phone verification screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-5', 'ID-5', 'Identity', 'Phone Verified', 'Verification complete', 'User', 'Confirm security', 'Continue onboarding', 'Phone verified! ✅', 'Your phone is verified. ✅', 'Phone Verified! ✅', 'Perfect! Your phone number has been verified and your account is even more secure.  BOX: Continue', 'Perfect! Your phone number has been verified and your account is even more secure.', 'take user to next onboarding step', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-8', 'ID-8', 'Identity', 'Profile Updated', 'User edits profile', 'User', 'Confirm changes', 'Maintain profile', 'Profile updated', 'Your profile has been updated.', 'Profile Updated', 'Your profile has been updated. Thanks for keeping your information current.  BOX: View Profile', 'Your changes have been saved. Thanks for keeping your information up to date.', 'take user to profile', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-9', 'ID-9', 'Identity', 'Profile Photo Missing', 'No avatar', 'User', 'Personalize identity', 'Upload photo', 'Add a photo 📸', 'Add a photo and say hello.', 'Add a Photo 📸', 'A profile photo helps people recognize you and makes every interaction feel more personal. Add one whenever you''re ready.  BOX: Add Photo', 'A profile photo helps people recognize you and makes every interaction feel more personal.', 'take user to profile photo upload', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-10', 'ID-10', 'Identity', 'Profile Photo Added', 'Photo uploaded', 'User', 'Reinforce authenticity', 'Increase engagement', 'Great photo! 📸', 'Great photo!', 'Great Photo! 📸', 'Looking good! Your profile now feels even more welcoming to the Seedling community.  BOX: View Profile', 'Looking good! Your profile now feels even more welcoming.', 'take user to profile', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-13', 'ID-13', 'Identity', 'Location Added', 'Location saved', 'User', 'Improve local relevance', 'Enable local discovery', 'Thanks for sharing your location', 'Thanks for sharing your location.', 'Thanks for Sharing Your Location', 'Thanks for sharing your location. We''ll use it to help you discover local nonprofits, events, and opportunities whenever they''re available.  BOX: Explore Local', 'We''ll use it to help you discover local nonprofits, events, and opportunities whenever they''re available.', 'take user to local discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-16', 'ID-16', 'Identity', 'Inactive 7 Days', 'No activity', 'User', 'Reconnect', 'Return to app', 'We miss you 🌱', 'We miss you. Come back and Grow Good. 🌱', 'We Miss You 🌱', 'It''s only been a week, but there''s already something new to discover. We''d love to welcome you back.  BOX: Come Back', 'It''s only been a week, but there''s already something new to discover. We''d love to welcome you back.', 'take user to discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-17', 'ID-17', 'Identity', 'Inactive 30 Days', 'Extended inactivity', 'User', 'Reignite interest', 'Resume participation', 'Come back and see what''s growing 🌱', 'Come back and see what''s growing. 🌱', 'Come Back and See What''s Growing 🌱', 'It''s been a little while. New stories, nonprofits, and opportunities are waiting whenever you''re ready to return.  BOX: Explore Seedling', 'It''s been a little while. New stories, nonprofits, and opportunities are waiting whenever you''re ready.', 'take user to discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-21', 'ID-21', 'Identity', 'Social Account Connected', 'OAuth completed', 'User', 'Simplify access', 'Increase trust', 'You''re connected! 🔗', 'You''re connected!', 'You''re Connected! 🔗', 'Your social account is linked, making signing in and sharing even easier.  BOX: View Settings', 'Your social account is linked, making signing in and sharing even easier.', 'take user to account settings', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-22', 'ID-22', 'Identity', 'First Organization Followed', 'First nonprofit followed', 'User', 'Reinforce discovery', 'Follow additional organizations', 'Nice first follow! 🌱', 'Nice first follow!', 'Nice First Follow! 🌱', 'Following nonprofits is a great way to stay connected with the causes you care about. Consider following a few more.  BOX: Discover Nonprofits', 'Following nonprofits is a great way to stay connected with the causes you care about.', 'take user to organization discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-23', 'ID-23', 'Identity', 'First Creator Followed', 'First Grower followed', 'User', 'Build community', 'Discover more creators', 'Your community is growing', 'Your community is growing.', 'Your Community Is Growing', 'Following other Growers is a great way to discover inspiring stories and ideas. Take a look at who else you might enjoy following.  BOX: Discover Growers', 'Following other Growers is a great way to discover inspiring stories and ideas.', 'take user to creator discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-24', 'ID-24', 'Identity', 'First Favorite Saved', 'First bookmark', 'User', 'Encourage return visits', 'Build personal collection', 'Saved for later', 'Saved for later.', 'Saved for Later', 'We''ll keep your favorites handy so they''re easy to find whenever you''re ready to take another look.  BOX: View Favorites', 'We''ll keep your favorites handy so they''re easy to find.', 'take user to favorites list', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-25', 'ID-25', 'Identity', 'Username Changed', 'Username updated', 'User', 'Confirm identity change', 'Continue activity', 'Username updated', 'Your username has been updated.', 'Username Updated', 'Your username has been updated and is now live across Seedling.  BOX: View Profile', 'Your new username is now live across Seedling.', 'take user to profile', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-26', 'ID-26', 'Identity', 'Password Changed', 'Password updated', 'User', 'Security confirmation', 'Increase trust', 'Password changed 🔒', 'Your password has been changed.', 'Password Changed 🔒', 'Thanks for taking a moment to keep your account secure. If this wasn''t you, please contact us right away.  BOX: Review Account', 'Thanks for taking a moment to keep your account secure.', 'take user to account security settings', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-27', 'ID-27', 'Identity', 'Password Reset Requested', 'Reset initiated', 'User', 'Protect account', 'Complete reset', 'Password reset requested', 'Password reset requested.', 'Password Reset Requested', 'If you requested this reset, you''re on the right track -- follow the link to choose a new password. If not, please let us know immediately.  BOX: Reset Password', 'If you requested this reset, you''re on the right track. If not, let us know immediately.', 'take user to password reset screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-28', 'ID-28', 'Identity', 'Password Reset Completed', 'Reset successful', 'User', 'Confirm security', 'Resume access', 'Password updated ✅', 'Password updated successfully.', 'Password Updated ✅', 'Your password has been updated successfully. You''re all set -- welcome back.  BOX: Log In', 'You''re all set. Welcome back.', 'take user to login screen', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-29', 'ID-29', 'Identity', 'New Device Login', 'New device detected', 'User', 'Security awareness', 'Confirm legitimacy', 'New device detected', 'New device detected.', 'New Device Detected', 'We noticed a sign-in from a new device. If it was you, there''s nothing else to do. If not, please secure your account right away.  BOX: Review Activity', 'We noticed a sign-in from a new device. If it was you, there''s nothing else to do.', 'take user to account security settings', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-35', 'ID-35', 'Identity', 'Anniversary', 'One year since joining', 'User', 'Celebrate membership', 'Renew engagement', 'Happy Seedling Anniversary! 🎉', 'Happy Seedling Anniversary! 🎉', 'Happy Seedling Anniversary! 🎉', 'One year ago you joined a community built around generosity. Thank you for Growing Good with us -- take a look at the difference you''ve made.  BOX: View Impact', 'One year ago you joined a community built around generosity. Thank you for Growing Good with us.', 'take user to impact summary', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-36', 'ID-36', 'Identity', 'Birthday', 'User birthday', 'User', 'Strengthen relationship', 'Encourage participation', 'Happy Birthday! 🎂', 'Happy Birthday! 🎂', 'Happy Birthday! 🎂', 'We hope you have a wonderful day. When you''re ready, let''s turn this birthday into an opportunity to make a difference for a cause you love.  BOX: Create a Seedling', 'We hope you have a wonderful day. When you''re ready, let''s turn this birthday into an opportunity to make a difference.', 'take user to video of how to create a Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-53', 'ID-53', 'Identity', 'Welcome Back After 90 Days', 'Long inactivity', 'User', 'Reconnect emotionally', 'Return to community', 'We''ve missed you 🌱', 'Welcome back—we''ve missed you. 🌱', 'We''ve Missed You 🌱', 'A lot has happened while you''ve been away. We''d love to help you catch up on the stories and causes you''ve missed.  BOX: Explore Seedling', 'A lot has happened while you''ve been away. We''d love to help you catch up.', 'take user to discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-56', 'ID-56', 'Identity', 'First Week Anniversary', '7 days after signup', 'User', 'Celebrate early journey', 'Remain active', 'One week already! 🌱', 'One week already!', 'One Week Already! 🌱', 'Thanks for spending your first week with Seedling. Here''s to many more.  BOX: Explore Seedling', 'Thanks for spending your first week with Seedling.', 'take user to discovery feed', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('id-57', 'ID-57', 'Identity', 'First Month Anniversary', '30 days after signup', 'User', 'Reflect on progress', 'Increase engagement', 'One month of Growing Good! 🌱', 'One month of Growing Good!', 'One Month of Growing Good! 🌱', 'Thank you for being part of the community this past month. We hope you''ve discovered causes that inspire you.  BOX: View Impact', 'Thank you for being part of the community. We hope you''ve discovered causes that inspire you.', 'take user to impact summary', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));

-- Opportunity Engine Scenarios
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-1', 'OPP-1', 'Opportunity', '1 day before Seedling closes', 'Number of days before Seedling closes', 'Sponsor - Co-Sponsor(s)', 'Let Grower know when Seedling is about to close so they can do one final push to get final donations', 'Share', 'Last chance! ⏰', 'Last chance! Your Seedling closes tomorrow -- share it now for a final push.', 'Last Chance! ⏰', 'This is it -- your Seedling closes in 24 hours. One more share could make all the difference. Reach out to friends and family one last time before it''s too late.  BOX: Share', 'This is it -- your Seedling closes in 24 hours. One more share could make all the difference.  BOX: Share', 'Go to Seedling, open Share UI', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-2', 'OPP-2', 'Opportunity', '1 day before Seedling closes', 'Number of days before Seedling closes', 'Donor', 'Let potential donors know when Seedling is about to close so they can make donations', 'Donate', 'Last chance to give ⏰', 'Last chance! This Seedling closes tomorrow -- make your donation today.', 'Last Chance to Give ⏰', 'This Seedling closes in 24 hours. Your donation today could be one of the last that counts toward reaching its goal.  BOX: Donate', 'This Seedling closes in 24 hours. Your donation today could be one of the last that counts.  BOX: Donate', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-3', 'OPP-3', 'Opportunity', '100th Donation Milestone', 'Donation milestone', 'Followers', 'Timing', '', 'Be the 100th donor! 🎉', 'Want to be the 100th Donation for this Seedling?', 'Be the 100th Donor! 🎉', 'A 100th Donation Milestone is an opportunity to make a real difference. Watch the story, learn about the cause, and support it if it speaks to you.  BOX: View Seedling', 'A 100th Donation Milestone is an opportunity to make a real difference. Watch the story, learn about the cause, and support it if it speaks to you.', 'Go to Seedling, pop up message.', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-4', 'OPP-4', 'Opportunity', '7 days before Seedling closes', 'Number of days before Seedling closes', 'Sponsor - Co-Sponsor(s)', 'Let Grower know when Seedling is about to close so they can do one final push to get final donations', 'Share', 'One week left!', 'One week left! Share your Seedling now to build momentum before it closes.', 'One Week Left!', 'Your Seedling closes in 7 days -- now is a great time to reach out to friends and family for one more push before time runs out.  BOX: Share', 'Your Seedling closes in 7 days -- now is a great time to reach out to friends and family for one more push.  BOX: Share', 'Go to Seedling, open Share UI', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-5', 'OPP-5', 'Opportunity', '7 days before Seedling closes', 'Number of days before Seedling closes', 'Donor', 'Let potential donors know when Seedling is about to close so they can make donations', 'Donate', 'One week left to help', 'One week left! Help this Seedling reach its goal before it closes.', 'One Week Left to Help', 'This Seedling closes in 7 days. There''s still time for your donation to make a real difference before it''s gone.  BOX: Donate', 'This Seedling closes in 7 days. There''s still time for your donation to make a real difference.  BOX: Donate', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-7', 'OPP-7', 'Opportunity', 'A Cause You May Also Like', 'Donation completed', 'Donor', 'This opportunity aligns with the user''s interests or relationships.', 'View similar opportunities', 'One good deed leads to another', 'One good deed leads to another. Discover another cause you''ll love.', 'One Good Deed Leads to Another', 'Based on the causes you''ve supported, we think this nonprofit may resonate with you. Watch the Seedling and see if it''s a cause you''d like to support.  BOX: View Seedling', 'Based on the causes you''ve supported, we think this nonprofit may resonate with you. Watch the Seedling and see if it''s a cause you''d like to support.', 'Go to Seedling, pop up message.', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-9', 'OPP-9', 'Opportunity', 'A Nonprofit You Follow Needs You', 'Organization update', 'Follower', 'This opportunity aligns with the user''s interests or relationships.', 'View', '(Nonprofit) needs you 🌱', '(Nonprofit Name) just launched a new Seedling. See how you can help. 🌱', '(Nonprofit) Needs You 🌱', '(Nonprofit Name) just launched a new Seedling. See how you can help make a difference.  BOX: View Seedling', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-19', 'OPP-19', 'Opportunity', 'Birthday - 30 Days', 'Recommendation generated', 'User', 'Birthday is approaching and enough time remains to launch.', 'Open opportunity', 'One month to your birthday 🎂', 'Your birthday is a month away. Ready to Grow Good?', 'One Month to Your Birthday 🎂', 'Your birthday is only a month away. This is the ideal time to publish your Birthday Challenge, record your story, and begin inviting friends and family to celebrate by supporting a cause that''s meaningful to you.  BOX: Create a Seedling', 'Your birthday is only a month away.   This is the ideal time to publish your Birthday Challenge, record your story, and begin inviting friends and family to celebrate by supporting a cause that''s meaningful to you. BOX: Create a Seedling', 'take user to video of how to create a Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-20', 'OPP-20', 'Opportunity', 'Birthday - 60 Days', 'Need published', 'Eligible User', 'User''s birthday is 60 days away.', 'View opportunity', 'Your birthday can change lives 🌱', 'Your birthday can change lives. 🌱', 'Your Birthday Can Change Lives 🌱', 'What if this year''s birthday became your most meaningful one yet? Create a Birthday Seedling and invite friends to celebrate by supporting a cause you care about.  BOX: Create a Seedling', 'What if this year’s birthday became your most meaningful one yet? Create a Birthday Seedling and invite friends to celebrate by supporting a cause you care about. BOX: Create a Seedling', 'take user to video of how to create a Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-21', 'OPP-21', 'Opportunity', 'Birthday Giving Opportunity', 'Birthday upcoming', 'User', 'User''s birthday is approaching.', 'Create fundraiser', 'Celebrate by giving back 🎉', 'Your birthday is coming up. Celebrate by making a difference.', 'Celebrate by Giving Back 🎉', 'Turn your celebration into something meaningful by creating a Birthday Seedling and inviting friends to join you.  BOX: Create a Seedling', 'Turn your celebration into something meaningful by creating a Birthday Seedling and inviting friends to join you.   BOX: Create a Seedling', 'take user to video of how to create a Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-51', 'OPP-51', 'Opportunity', 'Follower Created Seedling', 'Follower/Followed', 'User', 'Timing', 'Become first supporter', '(Name) just created a Seedling', '(Name), who follows you, just created a Seedling for (Nonprofit).  See why this cause matters to them.', '(Name) Just Created a Seedling', '(Name), who follows you, just created a Seedling for (Nonprofit). See why this cause matters to them and consider being the first to support it.  BOX: View Seedling', '', 'take user directly to seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-52', 'OPP-52', 'Opportunity', 'Followed Created Seedling', 'Follower/Followed', 'User', 'Timing', 'Become first supporter', '(Name) just created a Seedling', '(Name), who you follow, just created a Seedling for (Nonprofit).  See why this cause matters to them.', '(Name) Just Created a Seedling', '(Name), who you follow, just created a Seedling for (Nonprofit). See why this cause matters to them and consider being the first to support it.  BOX: View Seedling', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-92', 'OPP-92', 'Opportunity', 'Follower Donated', 'Friend activity detected', 'Connected users', 'Leverage social proof', 'Additional donation', '(Name) just donated', '(Name), who follows you, just donated to a Seedling -- check it out.', '(Name) Just Donated', '(Name), who follows you, just donated to a Seedling. Take a look and see what moved them to give.  BOX: View Seedling', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-93', 'OPP-93', 'Opportunity', 'Followed Donated', 'Friend activity detected', 'Connected users', 'Leverage social proof', 'Additional donation', '(Name) just donated', '(Name), who you follow, just donated to a Seedling -- check it out.', '(Name) Just Donated', '(Name), who you follow, just donated to a Seedling. Take a look and see what moved them to give.  BOX: View Seedling', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-94', 'OPP-94', 'Opportunity', 'Follower Commented', 'New comments on supported Seedling', 'Your Followers', 'Increase community interaction', 'Comment', '(Name) joined the conversation', '(Name), who follows you, just commented to a Seedling -- check it out.', '(Name) Joined the Conversation', '(Name), who follows you, just commented on a Seedling. Take a look and join the conversation.  BOX: View Comment', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('opp-95', 'OPP-95', 'Opportunity', 'Follower Commented', 'New comments on supported Seedling', 'Followed Creators', 'Increase community interaction', 'Comment', '(Name) joined the conversation', '(Name), who you follow, just commented to a Seedling -- check it out.', '(Name) Joined the Conversation', '(Name), who you follow, just commented on a Seedling. Take a look and join the conversation.  BOX: View Comment', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));

-- Discovery Engine Scenarios
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('disc-8', 'DISC-8', 'Discovery', 'Friend Follows Nonprofit', 'Friend activity', 'User', 'Encourage social discovery', 'View nonprofit', '(Name) found a nonprofit', '(Name), who you follow, is now following (nonprofit)', '(Name) Found a Nonprofit', '(Name), who you follow, is now following (nonprofit). Take a look and see what drew them in.  BOX: View Nonprofit', '', 'take user to nonprofit profile', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('disc-9', 'DISC-9', 'Discovery', 'Friend Follows Grower', 'Friend activity', 'User', 'Encourage social discovery', 'Follow creator', '(Name) found a new Grower', '(Name), who you follow, is now following (Name)', '(Name) Found a New Grower', '(Name), who you follow, is now following (Name). Take a look and see what drew them in.  BOX: View Profile', '', 'take user to creator profile', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, created_at, updated_at) VALUES ('disc-10', 'DISC-10', 'Discovery', 'Friend Supports Seedling', 'Friend donation or engagement', 'User', 'Leverage social proof', 'Visit campaign', '(Name) just gave', '(Name), who you follow, has donated to (Seedling)', '(Name) Just Gave', '(Name), who you follow, has donated to (Seedling). See what moved them to give and consider joining in.  BOX: View Seedling', '', 'take user directly to Seedling', 'TO DO', 'Medium', 'STAGING', datetime('now'), datetime('now'));
 
-- Campaign Engine Scenarios
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-1', 'CAMP-1', 'Campaign', 'Campaign Launched', 'Campaign goes live', 'Followers', 'Announce launch', 'Visit campaign', '(Campaign) is live! 🌱', '(Campaign) just launched. See how Seedlings totals are added up to the Campaign goal.', '(Campaign) Is Live! 🌱', '(Campaign) is officially live. Every Seedling under this campaign adds to a shared goal -- take a look at the full picture and find a Seedling to support.  BOX: View Campaign', '(Campaign) is live. Every Seedling under this campaign adds to a shared goal -- see the full picture and find a Seedling to support.  BOX: View Campaign', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-001', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-4', 'CAMP-4', 'Campaign', 'Goal 25% Complete', 'Dynamic', 'Campaign near goal', 'Interested users', 'Donate', '25% funded! 🎯', '(Campaign) has reached 25% of its goal -- can you help keep it going?', '25% Funded! 🎯', '(Campaign) has reached 25% of its goal. Can you help keep the momentum going?  BOX: View Seedling', '', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-004', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-5', 'CAMP-5', 'Campaign', 'Goal 50% Complete', 'Dynamic', 'Campaign near goal', 'Interested users', 'Donate', 'Halfway there! 🎯', '(Campaign) has reached 50% of its goal -- can you help keep the momentum?', 'Halfway There! 🎯', '(Campaign) has reached 50% of its goal. Can you help keep the momentum going?  BOX: View Seedling', '', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-005', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-6', 'CAMP-6', 'Campaign', 'Goal 75% Complete', 'Dynamic', 'Campaign near goal', 'Interested users', 'Donate', '75% there -- so close! 🎯', '(Campaign) has reached 75% of its goal -- we''re getting close -- can you help keep it going?', '75% There -- So Close! 🎯', '(Campaign) has reached 75% of its goal. We''re getting close -- can you help keep it going?  BOX: View Seedling', '', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-006', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-7', 'CAMP-7', 'Campaign', 'Goal 90% Complete', 'Dynamic', 'Campaign near goal', 'Interested users', 'Donate', '90%! Almost there 🎯', '(Campaign) has reached 90% of its goal -- can you help it cross the finish line?', '90%! Almost There 🎯', '(Campaign) has reached 90% of its goal. Can you help it cross the finish line?  BOX: View Seedling', '', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-007', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-8', 'CAMP-8', 'Campaign', 'Funding Goal Achieved', 'Goal reached', 'Supporters', 'Celebrate success', 'Share impact', 'We did it! 🎉', 'We did it! (Campaign) has reached its goal.', 'We Did It! 🎉', '(Campaign) reached its goal! Thank you for being part of it. Share the news and help the impact travel even further.  BOX: Share', '(Campaign) reached its goal! Thank you for being part of it -- share the news and help the impact travel further.  BOX: Share', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-008', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-12', 'CAMP-12', 'Campaign', 'Campaign Updated', 'Content changed', 'Followers', 'Share latest news', 'View update', 'There''s an update for you', 'A campaign you''re following has been updated.', 'There''s an Update for You', 'A campaign you''re following has just been updated. See what''s changed and what it means for the cause.  BOX: View Update', 'There''s a new update on a campaign you''re following -- see what''s changed.', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-012', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-13', 'CAMP-13', 'Campaign', 'Campaign Viewed Milestone', 'View threshold reached', 'Organization', 'Celebrate awareness', 'Promote further', 'People are noticing (Campaign)', 'People are discovering (campaign). Keep the momentum growing.', 'People Are Noticing (Campaign)', '(Campaign) is getting noticed by more people. Consider sharing it further to keep the momentum growing.  BOX: Share', '(Campaign) is getting noticed. Consider sharing it further to keep the momentum growing.  BOX: Share', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-013', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-17', 'CAMP-17', 'Campaign', 'Campaign Goal Increased', 'Funding goal raised', 'Supporters', 'Explain expansion', 'Continue giving', 'The goal just grew', '(Campaign) goal has increased. Help reach the new target.', 'The Goal Just Grew', '(Campaign) has raised its funding goal to reach even more impact. Help it get there by continuing to give.  BOX: Contribute', '(Campaign) has raised its funding goal to reach even more impact. Help it get there.  BOX: Contribute', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-017', datetime('now'), datetime('now'));
INSERT INTO scenarios (id, key, engine_category, governance_event, trigger, audience, communication_objective, desired_outcome, push_subject, push_body, email_subject, email_body, in_app_experience, cta, status, priority, environment, rule_id, created_at, updated_at) VALUES ('camp-18', 'CAMP-18', 'Campaign', 'Campaign Goal Reduced', 'Funding goal lowered', 'Supporters', 'Maintain transparency', 'Review update', 'An update on the goal', '(Campaign) goal has been updated. See what''s changed.', 'An Update on the Goal', 'The funding goal for (Campaign) has changed. Here''s what''s different and why, so you''re always in the loop.  BOX: View Update', 'The funding goal for (Campaign) has changed. Here''s what''s different and why.', 'take user to campaign for seedling', 'TO DO', 'Medium', 'STAGING', 'CI-CAMP-018', datetime('now'), datetime('now'));



-- Notification Rules Table

CREATE TABLE IF NOT EXISTS notification_rules (
  rule_id TEXT PRIMARY KEY,
  engine TEXT NOT NULL,
  rule_name TEXT NOT NULL,
  trigger TEXT DEFAULT '',
  audience TEXT DEFAULT '',
  communication_objective TEXT DEFAULT '',
  priority TEXT DEFAULT 'Medium',
  delivery TEXT DEFAULT '',
  channel_tier TEXT DEFAULT '',
  email_delivery_policy TEXT DEFAULT '',
  cooldown TEXT DEFAULT '',
  suppression TEXT DEFAULT '',
  source_workbook TEXT DEFAULT '',
  attention_class TEXT DEFAULT '',
  candidate_score TEXT DEFAULT '',
  guaranteed_experience TEXT DEFAULT '',
  batch_eligible TEXT DEFAULT '',
  runtime_memory_dependency TEXT DEFAULT '',
  attention_queue_group TEXT DEFAULT '',
  rotation_group TEXT DEFAULT '',
  timing TEXT DEFAULT '',
  merge_policy TEXT DEFAULT '',
  default_decision_reason TEXT DEFAULT '',
  experience_type TEXT DEFAULT '',
  memory_keys TEXT DEFAULT '',
  decision_reason_template TEXT DEFAULT '',
  candidate_audiences TEXT DEFAULT '',
  candidate_experiences TEXT DEFAULT '',
  template_id TEXT DEFAULT '',
  change_notes TEXT DEFAULT '',
  scenario_id TEXT DEFAULT '',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_rules_engine ON notification_rules(engine);

CREATE INDEX IF NOT EXISTS idx_rules_scenario_id ON notification_rules(scenario_id);


-- Updated Master Notification Rules Migration
INSERT OR REPLACE INTO engine_sheets (engine_category, sheet_name, sheet_url, csv_export_url, enabled, created_at, updated_at)
VALUES (
  'RuleBook',
  'Master Notification Rule Book',
  'https://docs.google.com/spreadsheets/d/1meD4cYwKNVGcmyRS8_kLzZdxcOAZZvqR/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true',
  'https://docs.google.com/spreadsheets/d/1meD4cYwKNVGcmyRS8_kLzZdxcOAZZvqR/export?format=xlsx',
  1,
  datetime('now'),
  datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-001', 'Identity', 'Account Created',
  'User registers', 'User', 'Welcome and establish belonging', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-002', 'Identity', 'Email Verification Required',
  'Account created', 'User', 'Verify identity', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-003', 'Identity', 'Email Verified',
  'Verification complete', 'User', 'Reinforce progress', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-004', 'Identity', 'Phone Verification Required',
  'Phone added', 'User', 'Secure account', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-005', 'Identity', 'Phone Verified',
  'Verification complete', 'User', 'Confirm security', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-006', 'Identity', 'Profile Incomplete',
  'Required fields missing', 'User', 'Encourage profile completion', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-007', 'Identity', 'Profile Completed',
  'Profile reaches 100%', 'User', 'Celebrate progress', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-007', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-008', 'Identity', 'Profile Updated',
  'User edits profile', 'User', 'Confirm changes', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-008', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-009', 'Identity', 'Profile Photo Missing',
  'No avatar', 'User', 'Personalize identity', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-010', 'Identity', 'Profile Photo Added',
  'Photo uploaded', 'User', 'Reinforce authenticity', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-010', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-011', 'Identity', 'Interests Not Selected',
  'No interests chosen', 'User', 'Improve recommendations', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-011', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-012', 'Identity', 'Interests Updated',
  'Interests changed', 'User', 'Acknowledge personalization', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-013', 'Identity', 'Location Added',
  'Location saved', 'User', 'Improve local relevance', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-014', 'Identity', 'First Login',
  'Initial login', 'User', 'Begin journey', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-014', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-015', 'Identity', 'Returning Login',
  'Returning after absence', 'User', 'Re-engage', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-015', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-016', 'Identity', 'Inactive 7 Days',
  'No activity', 'User', 'Reconnect', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-016', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-017', 'Identity', 'Inactive 30 Days',
  'Extended inactivity', 'User', 'Reignite interest', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-017', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-018', 'Identity', 'Notification Permission Not Granted',
  'Permission declined', 'User', 'Explain value', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-018', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-019', 'Identity', 'Notifications Enabled',
  'Permission granted', 'User', 'Confirm success', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-019', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-020', 'Identity', 'Contacts Connected',
  'Address book linked', 'User', 'Expand network', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-020', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-021', 'Identity', 'Social Account Connected',
  'OAuth completed', 'User', 'Simplify access', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-021', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-022', 'Identity', 'First Organization Followed',
  'First nonprofit followed', 'User', 'Reinforce discovery', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-022', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-023', 'Identity', 'First Creator Followed',
  'First Grower followed', 'User', 'Build community', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-023', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-024', 'Identity', 'First Favorite Saved',
  'First bookmark', 'User', 'Encourage return visits', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-024', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-025', 'Identity', 'Username Changed',
  'Username updated', 'User', 'Confirm identity change', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-025', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-026', 'Identity', 'Password Changed',
  'Password updated', 'User', 'Security confirmation', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-026', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-027', 'Identity', 'Password Reset Requested',
  'Reset initiated', 'User', 'Protect account', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-027', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-028', 'Identity', 'Password Reset Completed',
  'Reset successful', 'User', 'Confirm security', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-028', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-029', 'Identity', 'New Device Login',
  'New device detected', 'User', 'Security awareness', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-029', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-030', 'Identity', 'Suspicious Login Detected',
  'Risk detected', 'User', 'Protect account', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-030', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-031', 'Identity', 'Account Locked',
  'Security threshold reached', 'User', 'Explain next steps', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-031', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-032', 'Identity', 'Account Restored',
  'Access reinstated', 'User', 'Welcome back', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-032', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-033', 'Identity', 'Terms Updated',
  'Terms accepted', 'User', 'Confirm compliance', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-033', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-034', 'Identity', 'Privacy Preferences Updated',
  'Settings changed', 'User', 'Confirm changes', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-034', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-035', 'Identity', 'Anniversary',
  'One year since joining', 'User', 'Celebrate membership', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-035', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-036', 'Identity', 'Birthday',
  'User birthday', 'User', 'Strengthen relationship', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-036', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-037', 'Identity', 'Referral Invitation Sent',
  'User invites friend', 'User', 'Reinforce advocacy', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-037', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-038', 'Identity', 'Referral Joined',
  'Friend creates account', 'User', 'Celebrate success', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-038', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-039', 'Identity', 'Referral Activated',
  'Friend becomes active', 'User', 'Reinforce network growth', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-039', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-040', 'Identity', 'Identity Verification Requested',
  'Enhanced verification required', 'User', 'Establish trust', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-040', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-041', 'Identity', 'Identity Verification Approved',
  'Verification completed', 'User', 'Confirm trusted status', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-041', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-042', 'Identity', 'Identity Verification Declined',
  'Verification failed', 'User', 'Provide guidance', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-042', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-043', 'Identity', 'Account Deactivated',
  'User deactivates account', 'User', 'Confirm action', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-043', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-044', 'Identity', 'Account Reactivated',
  'User returns', 'User', 'Welcome back', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-044', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-045', 'Identity', 'Welcome Tour Started',
  'First successful login', 'User', 'Introduce core concepts', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-045', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-046', 'Identity', 'Welcome Tour Completed',
  'Guided tour finished', 'User', 'Celebrate readiness', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-046', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-047', 'Identity', 'Skip Onboarding',
  'User skips onboarding', 'User', 'Leave door open to return', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-047', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-048', 'Identity', 'Resume Onboarding',
  'Incomplete onboarding detected', 'User', 'Continue onboarding', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-048', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-049', 'Identity', 'Preferred Language Selected',
  'Language chosen', 'User', 'Personalize experience', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-049', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-050', 'Identity', 'Accessibility Preferences Updated',
  'Accessibility settings changed', 'User', 'Confirm accessibility', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-050', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-051', 'Identity', 'Dark Mode Enabled',
  'Appearance changed', 'User', 'Confirm preference', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-051', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-052', 'Identity', 'Communication Preferences Updated',
  'Notification/email settings changed', 'User', 'Confirm preferences', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-052', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-053', 'Identity', 'Welcome Back After 90 Days',
  'Long inactivity', 'User', 'Reconnect emotionally', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-053', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-054', 'Identity', 'First Session Completed',
  'User exits first session', 'User', 'Encourage second visit', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-054', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-055', 'Identity', 'Second Session Completed',
  'Second visit', 'User', 'Reinforce habit', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-055', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-056', 'Identity', 'First Week Anniversary',
  '7 days after signup', 'User', 'Celebrate early journey', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-056', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-057', 'Identity', 'First Month Anniversary',
  '30 days after signup', 'User', 'Reflect on progress', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-057', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-058', 'Identity', 'Organization Account Created',
  'Nonprofit registers', 'Organization', 'Welcome organization', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'Organization', '',
  'TPL-CI-ID-058', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-059', 'Identity', 'Organization Verified',
  'Verification approved', 'Organization', 'Confirm trusted status', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'Organization', '',
  'TPL-CI-ID-059', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-060', 'Identity', 'Corporate Account Created',
  'Corporate registers', 'Corporate Admin', 'Welcome corporate partner', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'Corporate Admin', '',
  'TPL-CI-ID-060', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-061', 'Identity', 'Creator Account Enabled',
  'Creator capabilities granted', 'User', 'Encourage storytelling', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-061', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-062', 'Identity', 'Account Merge Completed',
  'Duplicate accounts merged', 'User', 'Confirm successful merge', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-062', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-063', 'Identity', 'Consent Granted',
  'Marketing/privacy consent accepted', 'User', 'Acknowledge preferences', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-063', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-064', 'Identity', 'Consent Withdrawn',
  'Consent revoked', 'User', 'Respect preferences', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-064', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-065', 'Identity', 'Data Export Requested',
  'Privacy request', 'User', 'Confirm request', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-065', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-066', 'Identity', 'Data Export Ready',
  'Export generated', 'User', 'Deliver requested data', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-066', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-067', 'Identity', 'Account Scheduled for Deletion',
  'Deletion requested', 'User', 'Allow reconsideration', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-067', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-068', 'Identity', 'Account Permanently Deleted',
  'Retention period expired', 'User', 'Confirm deletion', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-068', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-069', 'Identity', 'Username Available',
  'Desired username becomes available', 'User', 'Encourage personalization', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-069', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-ID-070', 'Identity', 'Verified Badge Awarded',
  'Trust criteria met', 'User', 'Recognize authenticity', 'Medium',
  'In-App; rare milestone Push', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Usually accumulate until meaningful milestone', 'Seedling_Identity_Engine_Messaging.xlsx', 'Reflective', '50',
  'No', 'Yes', 'Identity milestones accumulated but not yet delivered; recent high-priority experience',
  'Identity Reflection', '', 'Milestones and reflection', 'Yes',
  'Identity accumulates far more often than it interrupts.', 'Reflection', 'IdentityMilestones, RecentHighPriority',
  'Usually accumulate until a meaningful milestone.', 'User', '',
  'TPL-CI-ID-070', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-001', 'Discovery', 'Personalized Feed Available',
  'User opens app', 'User', 'Present relevant stories', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-002', 'Discovery', 'New Seedling Matches Interests',
  'Campaign published', 'User', 'Inspire exploration', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-003', 'Discovery', 'New Nonprofit Matches Interests',
  'Organization joins', 'User', 'Expand discovery', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-004', 'Discovery', 'New Grower Matches Interests',
  'Creator joins', 'User', 'Build community', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-005', 'Discovery', 'Trending Seedling',
  'Engagement threshold reached', 'User', 'Surface momentum', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-006', 'Discovery', 'Trending Nonprofit',
  'Organization trending', 'User', 'Highlight impact', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-007', 'Discovery', 'Trending Topic',
  'Topic gains activity', 'User', 'Increase awareness', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-007', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-008', 'Discovery', 'Friend Follows Nonprofit',
  'Friend activity', 'User', 'Encourage social discovery', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-008', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-009', 'Discovery', 'Friend Follows Grower',
  'Friend activity', 'User', 'Encourage social discovery', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-010', 'Discovery', 'Friend Supports Seedling',
  'Friend donation or engagement', 'User', 'Leverage social proof', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption. Split gifts: one card per friend per parent gift ("(Name) supported all 5 Picks").', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', 'Donation confirmation / reinforcement',
  'TPL-CI-DISC-010', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Once per split gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-011', 'Discovery', 'Friend Comments',
  'Friend participates', 'User', 'Encourage conversation', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-011', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-012', 'Discovery', 'Friend Shares Story',
  'Story published', 'User', 'Promote authentic discovery', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-013', 'Discovery', 'Nearby Seedling',
  'Location match', 'User', 'Promote local impact', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-014', 'Discovery', 'Nearby Nonprofit',
  'Location match', 'User', 'Increase local engagement', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-014', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-015', 'Discovery', 'Local Emergency',
  'External event', 'User', 'Highlight urgent need', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-015', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-016', 'Discovery', 'Disaster Response Available',
  'External feed', 'User', 'Encourage immediate action', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-016', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-017', 'Discovery', 'New Category Available',
  'Platform expansion', 'User', 'Encourage exploration', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-017', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-018', 'Discovery', 'Continue Watching',
  'Previous session', 'User', 'Resume discovery', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-018', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-019', 'Discovery', 'Recommended Because You Follow',
  'Recommendation generated', 'User', 'Increase relevance', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-019', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-020', 'Discovery', 'Recommended Because Friends Support',
  'Social recommendation', 'User', 'Increase trust', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-020', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-021', 'Discovery', 'Recommended Because You Donated',
  'Behavioral recommendation', 'User', 'Deepen engagement', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption. Split gifts: run once per parent gift and exclude the 5 Picks just supported.', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-021', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Once per split gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-022', 'Discovery', 'Recommended Because You Watched',
  'Behavioral recommendation', 'User', 'Continue exploration', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-022', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-023', 'Discovery', 'Hidden Gem Discovered',
  'Equity algorithm', 'User', 'Increase equitable exposure', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-023', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-024', 'Discovery', 'New Campaign from Followed Nonprofit',
  'Campaign created', 'User', 'Maintain relationship', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-024', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-025', 'Discovery', 'New Campaign from Followed Grower',
  'Campaign created', 'User', 'Strengthen creator connection', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-025', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-026', 'Discovery', 'Organization Near Fundraising Goal',
  'Milestone reached', 'User', 'Increase urgency', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-026', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-027', 'Discovery', 'Because You Haven''t Explored',
  'Diversity algorithm', 'User', 'Broaden perspective', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-027', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-028', 'Discovery', 'Your Feed Has Changed',
  'Significant updates', 'User', 'Encourage return', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-028', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-029', 'Discovery', 'New Search Trend',
  'Popular search emerging', 'User', 'Promote discovery', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-029', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-030', 'Discovery', 'First Search Performed',
  'Initial search', 'User', 'Reinforce exploration', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-030', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-031', 'Discovery', 'Friend Joins Seedling',
  'Contact registers', 'User', 'Strengthen social graph', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-031', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-032', 'Discovery', 'People You May Know',
  'Mutual connections', 'User', 'Grow network', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-032', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-033', 'Discovery', 'Organization Recommended by Friend',
  'Social signal', 'User', 'Increase trust', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-033', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-034', 'Discovery', 'Cause You Haven''t Supported',
  'Behavior analysis', 'User', 'Broaden giving', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-034', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-035', 'Discovery', 'New Organization Near You',
  'Location', 'User', 'Build local community', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-035', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-036', 'Discovery', 'Campaign Shared Near You',
  'Local sharing', 'User', 'Promote local engagement', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-036', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-037', 'Discovery', 'Breaking News Related Cause',
  'News integration', 'User', 'Provide context', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-037', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-038', 'Discovery', 'Creator Goes Live',
  'Live event', 'User', 'Drive participation', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'Sponsor; Co-Sponsors', 'Seedling live notification',
  'TPL-CI-DISC-038', 'New rule split/renamed from CI-DISC-067 (Creator Goes Live (Future)); metadata inherited from that rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-DISC-039', 'Discovery', 'Limited-Time Feature',
  'Platform promotion', 'User', 'Increase feature adoption', 'Low',
  'In-App only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'N/A',
  'Never initiate an interruption', 'Seedling_Discovery_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'N/A', 'Current app/session activity; recent cause affinity',
  'In-App Guidance', '', 'During browsing', 'N/A',
  'Discovery guides attention after the app is open; it does not create a push interruption.', 'Guidance', 'ActiveSession, AffinityProfile',
  'Display in-app only after attention has already been earned.', 'User', '',
  'TPL-CI-DISC-039', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-001', 'Opportunity', '1 day before Seedling closes',
  'Number of days before Seedling closes', 'Sponsor - Co-Sponsor(s)', 'Let Grower know when Seedling is about to close so they can do one final push to get final donations', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Creator', '',
  'TPL-CI-OPP-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-002', 'Opportunity', '1 day before Seedling closes',
  'Number of days before Seedling closes', 'Donor', 'Let potential donors know when Seedling is about to close so they can make donations', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Donor', '',
  'TPL-CI-OPP-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-003', 'Opportunity', '100th Donation Milestone',
  'Donation milestone', 'Followers', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Followers', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-004', 'Opportunity', '7 days before Seedling closes',
  'Number of days before Seedling closes', 'Sponsor - Co-Sponsor(s)', 'Let Grower know when Seedling is about to close so they can do one final push to get final donations', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Creator', '',
  'TPL-CI-OPP-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-005', 'Opportunity', '7 days before Seedling closes',
  'Number of days before Seedling closes', 'Donor', 'Let potential donors know when Seedling is about to close so they can make donations', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Donor', '',
  'TPL-CI-OPP-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-006', 'Opportunity', 'A Cause That Matches Your Giving',
  'Behavioral model', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-007', 'Opportunity', 'A Cause You May Also Like',
  'Donation completed', 'Donor', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Suppressed for 72 hours after a split gift (Support all 5 / Grounds Crew).', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Donor', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-007', '2026-10-18 revision (Split gifts / GreenHouse / year-end): 72-hour hold after split gifts.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-008', 'Opportunity', 'A New Matching Opportunity',
  'Matching pool exhausted', 'Interested users', 'A matching gift is active for this campaign.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested users', '',
  'TPL-CI-OPP-008', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-009', 'Opportunity', 'A Nonprofit You Follow Needs You',
  'Organization update', 'Follower', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Follower', '',
  'TPL-CI-OPP-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-010', 'Opportunity', 'Adopt a Shelter Pet Day',
  'Adopt a Shelter Pet Day', 'Pet adoption', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Pet adoption', '',
  'TPL-CI-OPP-010', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-011', 'Opportunity', 'American Heart Month',
  'American Heart Month', 'Heart health', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Heart health', '',
  'TPL-CI-OPP-011', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-012', 'Opportunity', 'Anonymous Angel Opportunity',
  'Season', 'Qualified users', 'Complete campaign anonymously', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Qualified users', '',
  'TPL-CI-OPP-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-013', 'Opportunity', 'Arbor Day',
  'Arbor Day', 'Tree planting', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Tree planting', '',
  'TPL-CI-OPP-013', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-014', 'Opportunity', 'Autism Acceptance Month',
  'April', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-014', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-015', 'Opportunity', 'Back-to-College',
  'August', 'Education supporters', 'Academic cycle', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Education supporters', '',
  'TPL-CI-OPP-015', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-016', 'Opportunity', 'Back-to-School Giving',
  'Late July / August', 'All users', 'Support education', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-016', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-017', 'Opportunity', 'Be the 100th Donor',
  'Season', 'Qualified users', 'Milestone', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Qualified users', '',
  'TPL-CI-OPP-017', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-018', 'Opportunity', 'No donation to Seedling after 4 hours',
  'Season', 'Qualified users', 'Start momentum', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today. A split gift counts as a donation and resolves this nudge.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Qualified users', '',
  'TPL-CI-OPP-018', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Split gift counts as a donation.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-019', 'Opportunity', 'Birthday - 30 Days',
  'Recommendation generated', 'User', 'Birthday is approaching and enough time remains to launch.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-019', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-020', 'Opportunity', 'Birthday - 60 Days',
  'Need published', 'Eligible User', 'User''s birthday is 60 days away.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Eligible User', '',
  'TPL-CI-OPP-020', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-021', 'Opportunity', 'Birthday Giving Opportunity',
  'Birthday upcoming', 'User', 'User''s birthday is approaching.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-021', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-022', 'Opportunity', 'Black History Month',
  'February', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-022', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-023', 'Opportunity', 'Breast Cancer Awareness Month',
  'October', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-023', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-024', 'Opportunity', 'Childhood Cancer Awareness Month',
  'September', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-024', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-025', 'Opportunity', 'Childhood Immunization Week',
  'Childhood Immunization Week', 'Public health', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Public health', '',
  'TPL-CI-OPP-025', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-026', 'Opportunity', 'City Day of Service',
  'City Day of Service', 'Municipal volunteer event', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Municipal volunteer event', '',
  'TPL-CI-OPP-026', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-027', 'Opportunity', 'Cold Weather Shelter Need',
  'Severe cold', 'Local users', 'Weather-aware', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Local users', '',
  'TPL-CI-OPP-027', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-028', 'Opportunity', 'Create Your First Seasonal Seedling',
  'Nov 15-Dec 31', 'Eligible creators', 'Encourage participation', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Eligible creators', '',
  'TPL-CI-OPP-028', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-029', 'Opportunity', 'Cyber Monday Matching',
  'Cyber Monday', 'Online donors', 'Digital shopping tie-in', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Online donors', '',
  'TPL-CI-OPP-029', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-030', 'Opportunity', 'Discover Another Cause',
  'Eligibility changed', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-030', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-031', 'Opportunity', 'Diwali Giving',
  'Diwali Giving', 'Festival of Lights generosity', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Festival of Lights generosity', '',
  'TPL-CI-OPP-031', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-032', 'Opportunity', 'Donation Anniversary',
  '1 year after donation', 'Previous donor', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Support all 5: one anniversary per parent gift. Grounds Crew contributions: replaced by CI-OPP-175 Grounds Crew Anniversary.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Previous donor', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-032', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Consolidated for split gifts.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-033', 'Opportunity', 'Dormant Passion Reawakening',
  'Dormant Passion Reawakening', 'Reconnect with past interests', 'Recognition', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Reconnect with past interests', '',
  'TPL-CI-OPP-033', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-034', 'Opportunity', 'Earth Day',
  'Earth Day approaching', 'All users', 'Support environmental causes', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-034', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-035', 'Opportunity', 'Earth Day Countdown',
  '30 days before Earth Day', 'Environmental supporters', 'Planning window', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Environmental supporters', '',
  'TPL-CI-OPP-035', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-036', 'Opportunity', 'Easter Outreach',
  'Easter Outreach', 'Seasonal outreach and service', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Seasonal outreach and service', '',
  'TPL-CI-OPP-036', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-037', 'Opportunity', 'Emergency Relief Appeal',
  'Major breaking disaster', 'Relevant audience', 'Time-sensitive', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant audience', '',
  'TPL-CI-OPP-037', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-038', 'Opportunity', 'Employee Giving Campaign',
  'Employee Giving Campaign', 'Company campaign', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Company campaign', '',
  'TPL-CI-OPP-038', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-039', 'Opportunity', 'Employer Giving Week',
  'Corporate calendar', 'Employees', '', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Employees', '',
  'TPL-CI-OPP-039', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-040', 'Opportunity', 'Employer Match',
  'Goal nearly reached', 'User', 'User''s employer matches donations.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-040', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-041', 'Opportunity', 'Employer Match Available',
  'Employer identified', 'User', 'A matching gift is active for this campaign.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-041', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-042', 'Opportunity', 'Extreme Heat Response',
  'Heat emergency', 'Regional users', 'Urgency', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Regional users', '',
  'TPL-CI-OPP-042', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-043', 'Opportunity', 'Father''s Day Tribute Seedling',
  'Father''s Day', 'All users', 'Honor loved ones', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-043', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-044', 'Opportunity', 'Final Week Countdown',
  'Last week', 'All Users', 'Urgency', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All Users', '',
  'TPL-CI-OPP-044', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-045', 'Opportunity', 'Find a New Cause',
  'Week 2', 'Returning donors', 'Discovery', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Returning donors', '',
  'TPL-CI-OPP-045', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-046', 'Opportunity', 'Finish Someone''s Campaign',
  'Season', 'Qualified users', 'Complete campaigns', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Qualified users', '',
  'TPL-CI-OPP-046', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-047', 'Opportunity', 'First Day of Spring',
  'Season begins', 'All users', 'Seasonal optimism', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-047', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-048', 'Opportunity', 'First Donation Needed',
  'No donations after 24 hours', 'Eligible users', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today. A split gift counts as a donation and resolves this nudge.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Eligible users', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-048', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Split gift counts as a donation.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-049', 'Opportunity', 'First Snow',
  'First Snow', 'Winter preparedness', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Winter preparedness', '',
  'TPL-CI-OPP-049', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-050', 'Opportunity', 'Follower Created Seedling',
  'Follower/Followed', 'User', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-050', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-051', 'Opportunity', 'Followed Created Seedling',
  'Follower/Followed', 'User', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-051', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-052', 'Opportunity', 'Follower Made First Donation',
  'Follower/Followed', 'User', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'If the first donation was a split gift, use copy "...made their first gift -- to all 5 Picks to Click!"', 'Friends', '',
  'TPL-CI-OPP-052', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Copy variant for split-gift first donations.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-053', 'Opportunity', 'Followed Made First Donation',
  'Follower/Followed', 'User', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'If the first donation was a split gift, use copy "...made their first gift -- to all 5 Picks to Click!"', 'Friends', '',
  'TPL-CI-OPP-053', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Copy variant for split-gift first donations.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-054', 'Opportunity', 'Follower Reached Giving Milestone',
  'Follower/Followed', 'User', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Friends', '',
  'TPL-CI-OPP-054', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-055', 'Opportunity', 'Followed Reached Giving Milestone',
  'Follower/Followed', 'User', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Friends', '',
  'TPL-CI-OPP-055', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-056', 'Opportunity', 'Giving Season Kickoff',
  'December 1', 'All users', 'Launch year-end generosity', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-056', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-057', 'Opportunity', 'Giving Tuesday',
  'Friend activity', 'User', 'User has participated in year-end giving.', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-057', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-058', 'Opportunity', 'Goal 25% Complete',
  'Campaign near goal', 'Interested users', 'Real-time', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested users', '',
  'TPL-CI-OPP-058', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-059', 'Opportunity', 'Goal 50% Complete',
  'Campaign near goal', 'Interested users', 'Real-time', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested users', '',
  'TPL-CI-OPP-059', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-060', 'Opportunity', 'Goal 75% Complete',
  'Campaign near goal', 'Interested users', 'Real-time', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested users', '',
  'TPL-CI-OPP-060', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-061', 'Opportunity', 'Goal 90% Complete',
  'Campaign near goal', 'Interested users', 'Real-time', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested users', '',
  'TPL-CI-OPP-061', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-062', 'Opportunity', 'Graduation Season',
  'May/June', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-062', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-063', 'Opportunity', 'Grammys Week',
  'Grammys Week', 'Music education', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Music education', '',
  'TPL-CI-OPP-063', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-064', 'Opportunity', 'GreenHouse Auto-Replenish Reminder',
  'Low GreenHouse balance', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-064', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Renamed to Auto-Replenish (ToS terminology).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-065', 'Opportunity', 'GreenHouse Funds Available',
  'GreenHouse balance available', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-065', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-066', 'Opportunity', 'Seedling''s Grow Good Week',
  'Grow Good Week', 'Annual Seedling campaign', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Annual Seedling campaign', '',
  'TPL-CI-OPP-066', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-067', 'Opportunity', 'Hanukkah Giving',
  'Hanukkah Giving', 'Holiday giving opportunities', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Holiday giving opportunities', '',
  'TPL-CI-OPP-067', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-068', 'Opportunity', 'Heatwave Animal Rescue',
  'Extreme heat', 'Animal supporters', 'Weather-aware', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Animal supporters', '',
  'TPL-CI-OPP-068', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-069', 'Opportunity', 'Holiday Giving Challenge',
  'December', 'All users', 'Drive year-end generosity', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-069', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-070', 'Opportunity', 'Human Rights Day',
  'December 10', 'Human rights supporters', 'UN day', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Human rights supporters', '',
  'TPL-CI-OPP-070', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-071', 'Opportunity', 'Hurricane Season',
  'Season begins', 'Regional users', '', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Regional users', '',
  'TPL-CI-OPP-071', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-072', 'Opportunity', 'Independence Day',
  'July 4 week', 'All users', 'Channel celebration into giving', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-072', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-073', 'Opportunity', 'Inspired? Here''s Another Story',
  'Story completed', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-073', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-074', 'Opportunity', 'International Day of Charity',
  'Sept 5', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-074', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-075', 'Opportunity', 'International Literacy Day',
  'September 8', 'Education supporters', 'UN day', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Education supporters', '',
  'TPL-CI-OPP-075', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-076', 'Opportunity', 'International Volunteer Day',
  'December 5', 'Volunteers', 'UN day', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Volunteers', '',
  'TPL-CI-OPP-076', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-077', 'Opportunity', 'International Women''s Day',
  'March 8', 'Women''s causes supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Women''s causes supporters', '',
  'TPL-CI-OPP-077', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-078', 'Opportunity', 'Invite Friends Opportunity',
  'Low momentum detected', 'Supporter', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Supporter', '',
  'TPL-CI-OPP-078', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-079', 'Opportunity', 'Join the Conversation',
  'Season', 'Supporters', 'Increase comments', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Supporters', '',
  'TPL-CI-OPP-079', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-080', 'Opportunity', 'Juneteenth',
  'June 19', 'All users', 'Promote equality-related causes', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-080', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-081', 'Opportunity', 'Labor Day',
  'Week before', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-081', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-082', 'Opportunity', 'LGBTQ+ Pride Month',
  'June', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-082', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-083', 'Opportunity', 'Local Breaking Need',
  'Local Breaking Need', 'Urgent nearby opportunity', '', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Urgent nearby opportunity', '',
  'TPL-CI-OPP-083', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-084', 'Opportunity', 'Local Disaster Near User',
  'Disaster within radius', 'Nearby users', 'Geo-aware', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Nearby users', '',
  'TPL-CI-OPP-084', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-085', 'Opportunity', 'Low Participation Seedling',
  'Campaign stagnating', 'Relevant users', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-085', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-086', 'Opportunity', 'Magic Moment: Anonymous Angel',
  'CI detects user can fully fund remaining balance', 'Qualified donor', 'Present a high-impact completion opportunity', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Qualified donor', '',
  'TPL-CI-OPP-086', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-087', 'Opportunity', 'Magic Moment: Be the First Donor',
  'New Seedling has no donations', 'Likely supporters', 'Encourage early momentum', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Likely supporters', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-087', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-088', 'Opportunity', 'Creator Posted an Update',
  'New video update', 'Existing supporters', 'Re-engage supporters', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Existing supporters', '',
  'TPL-CI-OPP-088', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-089', 'Opportunity', 'Magic Moment: Donation #100',
  'Next donation reaches milestone', 'Any supporter', 'Celebrate milestone', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Any supporter', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-089', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-090', 'Opportunity', 'Magic Moment: Finish This Seedling',
  'Campaign is within 10% of goal', 'Interested supporters', 'Drive completion', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested supporters', '',
  'TPL-CI-OPP-090', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-091', 'Opportunity', 'Follower Donated',
  'Friend activity detected', 'Connected users', 'Leverage social proof', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Split gifts: replaced by CI-OPP-171 Follower Supported All 5 / CI-OPP-173 Follower Joined The Grounds Crew (one per recipient); Grounds Crew monthly contributions are not shared.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '',
  'TPL-CI-OPP-091', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Replaced by split-gift social rules.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-092', 'Opportunity', 'Followed Donated',
  'Friend activity detected', 'Connected users', 'Leverage social proof', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Split gifts: replaced by CI-OPP-172 Followed Supported All 5 / CI-OPP-174 Followed Joined The Grounds Crew (one per recipient); Grounds Crew monthly contributions are not shared.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '',
  'TPL-CI-OPP-092', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Replaced by split-gift social rules.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-093', 'Opportunity', 'Follower Commented',
  'New comments on supported Seedling', 'Your Followers', 'Increase community interaction', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-OPP-093', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-094', 'Opportunity', 'Follower Commented',
  'New comments on supported Seedling', 'Followed Creators', 'Increase community interaction', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-OPP-094', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-095', 'Opportunity', 'Magic Moment: Last Chance to Finish',
  'Campaign ends within hours', 'Interested supporters', 'Create urgency', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Interested supporters', '',
  'TPL-CI-OPP-095', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-096', 'Opportunity', 'Magic Moment: Trending Seedling',
  'Rapid engagement growth', 'Relevant audience', 'Surface momentum', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant audience', '',
  'TPL-CI-OPP-096', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-097', 'Opportunity', 'Magic Moment: Your Gift Inspired Others',
  'Subsequent donations attributed after user''s gift', 'Recent donor', 'Reinforce giving', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes -- one per parent_gift_id for split gifts (Grounds Crew: one per month), combining attributed gifts across all 5; held until the quiet period ends.',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Recent donor', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-097', '2026-10-18 revision (Split gifts / GreenHouse / year-end): One per split gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-098', 'Opportunity', 'Make Your First Gift of the Season',
  'Nov 15-Dec 31', 'All Users', 'First donation', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All Users', '',
  'TPL-CI-OPP-098', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-099', 'Opportunity', 'Martin Luther King Jr. Day',
  'MLK Day approaching', 'All users', 'Promote service', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-099', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-100', 'Opportunity', 'Memorial Day',
  'Memorial Day approaching', 'All users', 'Honor fallen service members', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-100', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-101', 'Opportunity', 'Mental Health Awareness Month',
  'May', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-101', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-102', 'Opportunity', 'Seedling Milestone',
  'Campaign milestone', 'Eligible User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Eligible User', '',
  'TPL-CI-OPP-102', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-103', 'Opportunity', 'Military Appreciation Month',
  'May', 'Veteran supporters', 'Awareness month', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Veteran supporters', '',
  'TPL-CI-OPP-103', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-104', 'Opportunity', '1 Million Dollar Platform Milestone',
  'Platform milestone', 'All users', 'Seedling milestone', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-104', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-105', 'Opportunity', 'X Million Dollar Platform Milestone',
  'Platform milestone', 'All users', 'Seedling milestone', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-105', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-106', 'Opportunity', 'Mother''s Day',
  '2 weeks prior', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-106', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-107', 'Opportunity', 'Mother''s Day Tribute Seedling',
  'Mother''s Day', 'All users', 'Honor loved ones', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-107', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-108', 'Opportunity', 'National Cat Day',
  'National Cat Day', 'Cat rescue and adoption', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Cat rescue and adoption', '',
  'TPL-CI-OPP-108', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-109', 'Opportunity', 'National Dog Day',
  'National Dog Day', 'Dog rescue and adoption', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Dog rescue and adoption', '',
  'TPL-CI-OPP-109', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-110', 'Opportunity', 'National Hunger Action Month',
  'September', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-110', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-111', 'Opportunity', 'National Parks Week',
  'National Parks Week', 'Park conservation', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Park conservation', '',
  'TPL-CI-OPP-111', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-112', 'Opportunity', 'National Philanthropy Day',
  'November 15', 'All users', 'Philanthropy awareness', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-112', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-113', 'Opportunity', 'National Volunteer Month',
  'April', 'Volunteers', 'Volunteerism', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Volunteers', '',
  'TPL-CI-OPP-113', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-114', 'Opportunity', 'National Volunteer Week',
  'April', 'Volunteers', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Volunteers', '',
  'TPL-CI-OPP-114', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-115', 'Opportunity', 'New Seedling Posted',
  'Organization onboarded', 'Relevant users', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-115', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-116', 'Opportunity', 'New Seedling Update Posted',
  'New campaign update', 'Followers', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Followers', '',
  'TPL-CI-OPP-116', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-117', 'Opportunity', 'New Year''s Resolution',
  'January 1', 'Relevant Users', 'Annual fresh-start moment.', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant Users', '',
  'TPL-CI-OPP-117', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-118', 'Opportunity', 'Older Americans Month',
  'May', 'Senior causes supporters', 'Awareness month', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Senior causes supporters', '',
  'TPL-CI-OPP-118', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-119', 'Opportunity', 'One Final Gift',
  'Dec 30', 'All Users', 'Year-end gift', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All Users', '',
  'TPL-CI-OPP-119', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Copy now promotes a GreenHouse Contribution before year end (choose Seedlings later).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-120', 'Opportunity', 'One Final Gift',
  'Dec 31', 'All Users', 'Year-end gift', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All Users', '',
  'TPL-CI-OPP-120', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Copy now promotes a GreenHouse Contribution before year end (choose Seedlings later).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-121', 'Opportunity', 'Seedling Posted Nearby',
  'Geo/time match', 'User', 'Alert user to local cause', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-121', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-122', 'Opportunity', 'Seedling Viewed Multiple Times',
  'Repeat visits', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-122', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-123', 'Opportunity', 'Organ Donation Month',
  'Organ Donation Month', 'Organ donor awareness', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Organ donor awareness', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-123', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-124', 'Opportunity', 'Oscars Week',
  'Oscars Week', 'Arts education campaigns', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Arts education campaigns', '',
  'TPL-CI-OPP-124', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-125', 'Opportunity', 'Park Restoration Weekend',
  'Park Restoration Weekend', 'Community restoration', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Community restoration', '',
  'TPL-CI-OPP-125', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-126', 'Opportunity', 'Passover Service',
  'Passover Service', 'Community support opportunities', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Community support opportunities', '',
  'TPL-CI-OPP-126', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-127', 'Opportunity', 'Pet Adoption Day Opportunity',
  'National Adopt a Pet Day', 'Animal lovers', 'Support rescues', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Animal lovers', '',
  'TPL-CI-OPP-127', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-128', 'Opportunity', 'Pet Adoption Month',
  'May', 'Animal supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Animal supporters', '',
  'TPL-CI-OPP-128', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-129', 'Opportunity', 'Picked Just For You',
  'Recommendation engine', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-129', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-130', 'Opportunity', 'Plant a Seedling in Someone''s Honor',
  'Thanksgiving-Dec 31', 'Creators', 'Honor someone', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Creators', '',
  'TPL-CI-OPP-130', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-131', 'Opportunity', 'Presidents'' Day',
  'Federal holiday approaching', 'All users', 'Inspire civic/community giving', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-131', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-132', 'Opportunity', 'Ramadan Giving',
  'Ramadan Giving', 'Charitable giving during Ramadan', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Charitable giving during Ramadan', '',
  'TPL-CI-OPP-132', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-133', 'Opportunity', 'Random Act of Kindness Day',
  'Feb 17', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-133', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-134', 'Opportunity', 'Read Across America',
  'Read Across America', 'Literacy', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Literacy', '',
  'TPL-CI-OPP-134', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-135', 'Opportunity', 'Ready to Revisit This Cause?',
  'User bookmarks', 'User', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-135', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-136', 'Opportunity', 'Retirement Legacy Seedling',
  'Retirement detected', 'Retirees', 'Celebrate legacy', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Retirees', '',
  'TPL-CI-OPP-136', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-137', 'Opportunity', 'School Supply Drive',
  'July', 'Education supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Education supporters', '',
  'TPL-CI-OPP-137', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-138', 'Opportunity', 'Seedling Season of Generosity',
  'Annual Nov-Dec campaign', 'All users', 'Seedling-owned annual giving season', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-138', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-139', 'Opportunity', 'Seedling Season of Generosity Begins',
  'Nov 15', 'All Users', 'Kick off annual giving season', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All Users', '',
  'TPL-CI-OPP-139', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-140', 'Opportunity', 'Share One More Time',
  'Final week', 'Creators', 'Increase sharing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Creators', '',
  'TPL-CI-OPP-140', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-141', 'Opportunity', 'Share Opportunity',
  'Campaign ready to share', 'Supporter', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Supporter', '',
  'TPL-CI-OPP-141', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-142', 'Opportunity', 'Share Your Story',
  'Nov 15-Dec 31', 'Creators', 'Record video', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Creators', '',
  'TPL-CI-OPP-142', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-143', 'Opportunity', 'Small Business Saturday Partnerships',
  'Saturday after Thanksgiving', 'Local supporters', 'Community focus', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Local supporters', '',
  'TPL-CI-OPP-143', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-144', 'Opportunity', 'Tax Refund Season',
  'Tax Refund Season', 'Give from refund', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Give from refund', '',
  'TPL-CI-OPP-144', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-145', 'Opportunity', 'Teacher Appreciation Week',
  'Teacher Appreciation Week', 'Support educators', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Support educators', '',
  'TPL-CI-OPP-145', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-146', 'Opportunity', 'Thanksgiving',
  'Week before', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-146', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-147', 'Opportunity', 'Thanksgiving Gratitude Gift',
  'Thanksgiving', 'All Users', 'Holiday giving', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All Users', '',
  'TPL-CI-OPP-147', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-148', 'Opportunity', 'Thanksgiving Gratitude Opportunity',
  'Week before Thanksgiving', 'All users', 'Connect gratitude with generosity', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'All users', '',
  'TPL-CI-OPP-148', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-149', 'Opportunity', 'This Week''s 5 Picks to Click',
  'Weekly digest', 'User', 'Curated list of Seedlings', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Support all 5 donors: suppressed for the set of Picks they already supported. Grounds Crew members: still sent unless this week''s Picks equal the monthly Picks.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-149', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Never ask donors to fund Picks they already funded.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-150', 'Opportunity', 'This Month''s 5 Picks to Click',
  'Weekly digest', 'User', 'Curated list of Seedlings', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Grounds Crew members: suppressed -- CI-CONTR-031 is their Picks reveal on each batch day. Support all 5 donors: suppressed for the set they already supported.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'User', '',
  'TPL-CI-OPP-150', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Grounds Crew suppression wording updated for batches.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-151', 'Opportunity', 'Today''s Featured Seedling',
  'Editorial selection', 'Users', 'This opportunity aligns with the user''s interests or relationships.', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-151', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-152', 'Opportunity', 'Top Grower Recognition',
  'Top Grower Recognition', 'Recognize leading Growers', 'Recognition', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Recognize leading Growers', '',
  'TPL-CI-OPP-152', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-153', 'Opportunity', 'Trending Cause',
  'Trending Cause', 'AI detects emerging cause', 'Timing', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'AI detects emerging cause', '',
  'TPL-CI-OPP-153', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-154', 'Opportunity', 'Valentine''s Day',
  'Feb 14 approaching', 'Users', 'Seasonal', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-154', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-155', 'Opportunity', 'Veterans Day',
  'Week before', 'Veteran supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Veteran supporters', '',
  'TPL-CI-OPP-155', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-156', 'Opportunity', 'Volunteer Appreciation Week',
  'April', 'Volunteers', 'Volunteer retention', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Volunteers', '',
  'TPL-CI-OPP-156', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-157', 'Opportunity', 'Wedding Celebration Seedling',
  'Wedding planning', 'Couples', 'Replace gifts with impact', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Couples', '',
  'TPL-CI-OPP-157', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-158', 'Opportunity', 'Wildfire Season',
  'Season begins', 'Regional users', '', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Regional users', '',
  'TPL-CI-OPP-158', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-159', 'Opportunity', 'Women''s History Month',
  'March', 'Relevant users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Relevant users', '',
  'TPL-CI-OPP-159', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-160', 'Opportunity', 'World Animal Day',
  'October 4', 'Animal supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Animal supporters', '',
  'TPL-CI-OPP-160', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-161', 'Opportunity', 'World Blood Donor Day',
  'World Blood Donor Day', 'Blood donation awareness', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Blood donation awareness', '',
  'TPL-CI-OPP-161', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-162', 'Opportunity', 'World Cleanup Day',
  'World Cleanup Day', 'Community cleanups', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Community cleanups', '',
  'TPL-CI-OPP-162', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-163', 'Opportunity', 'World Food Day',
  'October 16', 'Food insecurity supporters', 'UN observance', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Food insecurity supporters', '',
  'TPL-CI-OPP-163', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-164', 'Opportunity', 'World Kindness Day',
  'Nov 13', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-164', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-165', 'Opportunity', 'World Oceans Day',
  'June 8', 'Environmental supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Environmental supporters', '',
  'TPL-CI-OPP-165', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-166', 'Opportunity', 'World Refugee Day',
  'June 20', 'Humanitarian supporters', 'UN day', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Humanitarian supporters', '',
  'TPL-CI-OPP-166', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-167', 'Opportunity', 'World Water Day',
  'March 22', 'Water supporters', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Water supporters', '',
  'TPL-CI-OPP-167', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-168', 'Opportunity', 'World Wildlife Day',
  'World Wildlife Day', 'Wildlife conservation', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Wildlife conservation', '',
  'TPL-CI-OPP-168', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-169', 'Opportunity', 'Year-End Bonus',
  'Year-End Bonus', 'Share year-end bonus', '', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Share year-end bonus', '',
  'TPL-CI-OPP-169', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-170', 'Opportunity', 'Year-End Tax Giving',
  'December', 'Users', 'Annual', 'Medium',
  'One best Push today + In-App', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', '24 hours',
  'Suppress competing opportunity pushes CALENDAR APPROVAL GATE: sends only if approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD) with a featured Seedling or marked general; unreviewed on the send date = held; rejected = suppressed for that year.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Users', '',
  'TPL-CI-OPP-170', '2026-10-18: Calendared rule now requires approval in the CI Opportunity Calendar (unreviewed = held).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-171', 'Opportunity', 'Follower Supported All 5',
  'Follower completes Support all 5', 'Connected users', 'Leverage social proof; promote Support all 5', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes -- one per recipient per parent gift / enrollment',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '',
  'TPL-CI-OPP-171', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-091.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-172', 'Opportunity', 'Followed Supported All 5',
  'Followed user completes Support all 5', 'Connected users', 'Leverage social proof; promote Support all 5', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes -- one per recipient per parent gift / enrollment',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '',
  'TPL-CI-OPP-172', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-092.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-173', 'Opportunity', 'Follower Joined The Grounds Crew',
  'Follower enrolls in The Grounds Crew', 'Connected users', 'Leverage social proof; promote The Grounds Crew', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes -- one per recipient per parent gift / enrollment',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '',
  'TPL-CI-OPP-173', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-091.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-174', 'Opportunity', 'Followed Joined The Grounds Crew',
  'Followed user enrolls in The Grounds Crew', 'Connected users', 'Leverage social proof; promote The Grounds Crew', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. One per recipient per split gift; Grounds Crew monthly contributions never shared.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes -- one per recipient per parent gift / enrollment',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Connected users', '',
  'TPL-CI-OPP-174', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule; metadata inherited from CI-OPP-092.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-175', 'Opportunity', 'Grounds Crew Anniversary',
  '3, 6 and 12 months after Grounds Crew enrollment, then every 12 months', 'Grounds Crew member', 'Celebrate commitment', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. Support all 5: one anniversary per parent gift. Grounds Crew contributions: replaced by CI-OPP-175 Grounds Crew Anniversary. One per milestone. Respects the split-gift quiet period (delay, not drop).', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Grounds Crew member', 'Donation confirmation / reinforcement',
  'TPL-CI-OPP-175', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Now at 3, 6 and 12 months, then yearly; adds an invite to join The Grounds Crew (referral credit via CI-ID-037/038/039).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-OPP-176', 'Opportunity', 'Grounds Crew Field Note',
  'Owner-approved field note published for one of the current batch''s Picks (partway through a batch)', 'Grounds Crew member', 'Show one human moment from a Seedling the member is supporting; no ask', 'Medium',
  'One best Push today + In-App', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '24 hours',
  'Suppress competing opportunity pushes. One per batch; not within 3 days of batch day; respects the split-gift quiet period (delay, not drop). CALENDAR APPROVAL GATE: sends only if the field note is approved in the CI Opportunity Calendar (https://claude.ai/artifact/1H8JHMohC32zD2ePadYScD); unreviewed on the send date = held; rejected = suppressed.', 'Seedling_Opportunity_Engine_Messaging.xlsx', 'Interruptive', '70',
  'No', 'Yes', 'Opportunity push already used today; last push timestamp',
  'Return Opportunity', '', 'Best moment today -- on the approved send date in the CI Opportunity Calendar', 'Yes',
  'Select the strongest eligible reason to return today.', 'Opportunity', 'OpportunityToday, LastPush',
  'Deliver only if strongest opportunity available today.', 'Grounds Crew member', 'Impact story / reinforcement',
  'TPL-CI-OPP-176', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-001', 'Participation', 'First App Session',
  'First app open', 'User', 'Welcome active participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-002', 'Participation', 'First Seedling Viewed',
  'Campaign viewed', 'User', 'Encourage deeper engagement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-003', 'Participation', 'Like Added',
  'Creator Liked comment', 'Person who liked the comment', 'Confirm participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-004', 'Participation', 'Like Added',
  'Follower of (Name) liked comment', 'Follower of Commenter', 'Confirm participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '15-minute batching window; summary push fires at window close', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-005', 'Participation', 'Like Added',
  'Donor to (Seedling) liked comment', 'Donor', 'Confirm participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '15-minute batching window; summary push fires at window close', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-006', 'Participation', 'Comment Posted',
  'Comment submitted', 'Comment author', 'Grow conversation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-007', 'Participation', 'Comment Posted',
  'Comment submitted', 'Follower of Commenter', 'Grow conversation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '15-minute batching window; summary push fires at window close', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-007', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-008', 'Participation', 'Comment Posted',
  'Comment submitted', 'Donor of Seedling', 'Grow conversation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '15-minute batching window; summary push fires at window close', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-008', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-009', 'Participation', 'Comment Posted',
  'Comment submitted', 'Creator of Seedling', 'Grow conversation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '15-minute batching window; summary push fires at window close', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', '', 'Owner comment notification',
  'TPL-CI-PART-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-010', 'Participation', 'Comment Replied To',
  'Reply posted', 'Original commenter', 'Continue discussion', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Original commenter', '',
  'TPL-CI-PART-010', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-011', 'Participation', 'Comment Liked',
  'Reaction received', 'Comment author', 'Recognize contribution', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Comment author', '',
  'TPL-CI-PART-011', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-012', 'Participation', 'Post Shared',
  'Content shared', 'User', 'Celebrate advocacy', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-013', 'Participation', 'Share Opened',
  'Recipient opens shared content', 'Sharer', 'Reinforce impact', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Sharer', '',
  'TPL-CI-PART-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-014', 'Participation', 'Organization Followed',
  'Follow created', 'User', 'Build long-term relationship', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-014', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-015', 'Participation', 'Grower Followed',
  'Follow created', 'User', 'Strengthen creator connection', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-015', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-016', 'Participation', 'Participation Streak',
  'Daily activity', 'User', 'Reinforce habit', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events. A split gift counts as 5 donations (owner decision) but everything it unlocks is batched into ONE celebration: shown in the parent In-App impact summary immediately; any Push held until the quiet period ends.', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-016', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Split gift counts as 5; one batched celebration.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-017', 'Participation', 'Participation Streak Lost',
  'Streak broken', 'User', 'Re-engage', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-017', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-018', 'Participation', 'Daily Check-in',
  'Daily visit', 'User', 'Build habit', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-018', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-019', 'Participation', 'Weekly Recap Ready',
  'Week complete', 'User', 'Reflect participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-019', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-020', 'Participation', 'Monthly Recap Ready',
  'Month complete', 'User', 'Celebrate activity', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-020', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-021', 'Participation', 'Challenge Joined',
  'User joins challenge', 'User', 'Confirm participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-021', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-022', 'Participation', 'Challenge Completed',
  'Challenge finished', 'User', 'Celebrate achievement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-022', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-023', 'Participation', 'Live Event Started',
  'Event begins', 'Registered users', 'Drive attendance', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Registered users', '',
  'TPL-CI-PART-023', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-024', 'Participation', 'Live Event Ended',
  'Event completed', 'Attendees', 'Capture feedback', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Attendees', '',
  'TPL-CI-PART-024', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-025', 'Participation', 'Content Reported',
  'Report submitted', 'Reporter', 'Review content', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Moderators', '',
  'TPL-CI-PART-025', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-026', 'Participation', 'Report Resolved',
  'Moderation completed', 'Reporter', 'Close loop', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Reporter', '',
  'TPL-CI-PART-026', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-027', 'Participation', 'Milestone Participation',
  '100th interaction', 'User', 'Celebrate commitment', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-027', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-028', 'Participation', 'Dormant Participant',
  'No activity 14 days', 'User', 'Re-engage', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-028', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-029', 'Participation', 'Highly Active Participant',
  'High engagement', 'User', 'Recognize loyalty', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-029', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-030', 'Participation', 'First Meaningful Interaction',
  'First like/comment/share', 'User', 'Celebrate engagement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Owner; Followers of Commenter; Followers of Seedling; Moderators (if applicable)', 'Owner comment notification; Social activity; Discovery signal',
  'TPL-CI-PART-030', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-031', 'Participation', 'Seedling Goal Reached',
  'Collective participation milestone', 'Participants', 'Celebrate community', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events. If a donor''s split-gift allocation completed the goal: shown in the parent In-App impact summary; that donor''s standalone Push held at least 2 hours after the parent; multiple goals merge into one. Other participants unchanged.', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participants', '',
  'TPL-CI-PART-031', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Delayed/merged for the split-gift donor only.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-032', 'Participation', 'Campaign Goal Reached',
  'Collective participation milestone', 'Participants', 'Celebrate community', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participants', '',
  'TPL-CI-PART-032', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-033', 'Participation', 'Feedback Requested',
  'Session ends', 'User', 'Improve experience', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-033', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-034', 'Participation', 'Participation Anniversary',
  'One year active', 'User', 'Celebrate journey', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-034', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-035', 'Participation', 'Comment Thread Trending',
  'Thread accelerates', 'Participants', 'Rejoin conversation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participants', '',
  'TPL-CI-PART-035', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-036', 'Participation', 'Unread Activity Waiting',
  'Pending notifications', 'User', 'Prompt return', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-036', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-037', 'Participation', 'Like Received',
  'Someone reacts to your post', 'Content author', 'Recognize engagement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '15-minute batching window; summary push fires at window close', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise -- achieved by batching into one summary-with-count push per 15-minute window, not by silently reusing the first event''s own message for the whole window.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Never report each like/comment individually. Collect activity for this recipient in a 15-minute window; when the window closes, send ONE summary push with a count (e.g. "5 people commented on your Seedling in the past 15 minutes"). Tapping the notification takes the user directly to the comments/Seedling. If the window closes with zero events, no push is sent.', 'Content author', '',
  'TPL-CI-PART-037', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-038', 'Participation', 'Multiple Likes Received',
  'Reaction threshold reached', 'Content author', 'Highlight momentum', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Content author', '',
  'TPL-CI-PART-038', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-039', 'Participation', 'New Follower Milestone',
  'Follower milestone reached', 'User', 'Celebrate influence', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-039', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-040', 'Participation', 'Sponsor Responded',
  'Co-Sponsor responds to invite', 'Participant', 'Deepen relationship', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participant', '',
  'TPL-CI-PART-040', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-041', 'Participation', 'Co-Sponsor Invited',
  'Sponsor invites a Co-Sponsor', 'Participant', 'Invitation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participant', '',
  'TPL-CI-PART-041', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-042', 'Participation', 'Co-Sponsor Invitation Responded to',
  'Co-Sponsor accepts invite', 'Participant', 'Deepen relationship', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participant', '',
  'TPL-CI-PART-042', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-043', 'Participation', 'Organization Responded',
  'Organization replies', 'Participant', 'Build trust', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participant', '',
  'TPL-CI-PART-043', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-044', 'Participation', 'Donation Celebrated in Feed',
  'Donation shared', 'Donor', 'Celebrate participation', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events. Split gifts: one per parent_gift_id ("Your gift is being celebrated across 5 Seedlings"); In-App immediately, Push held until the split-gift quiet period ends.', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Donor', 'Donation confirmation / reinforcement',
  'TPL-CI-PART-044', '2026-10-18 revision (Split gifts / GreenHouse / year-end): One per split gift; push respects quiet period.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-045', 'Participation', 'Followed Started Following Cause',
  'Friend action', 'User', 'Promote discovery', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-045', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-046', 'Participation', 'Followed Commented on Followed Cause',
  'Friend activity', 'User', 'Join discussion', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-046', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-047', 'Participation', 'Milestone Badge Earned',
  'Participation badge', 'User', 'Reward engagement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events. A split gift counts as 5 donations (owner decision) but any badges it unlocks are batched into ONE celebration: shown in the parent In-App impact summary immediately; any Push held until the quiet period ends.', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-047', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Split gift counts as 5; one batched badge celebration.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-048', 'Participation', 'Badge Level Increased',
  'Badge upgraded', 'User', 'Celebrate progress', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-048', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-049', 'Participation', 'Top Participant This Week',
  'Leaderboard', 'User', 'Recognize involvement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-049', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-050', 'Participation', 'Quiet Week Reminder',
  'Low weekly activity', 'User', 'Re-engage', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-050', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-051', 'Participation', 'Challenge Reminder',
  'Challenge incomplete', 'Participant', 'Prompt completion', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Participant', '',
  'TPL-CI-PART-051', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-052', 'Participation', 'Challenge Success Shared',
  'Challenge completed', 'Community', 'Celebrate success', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Community', '',
  'TPL-CI-PART-052', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-053', 'Participation', 'LiveStream Check-In',
  'User arrives', 'Organizer', 'Track attendance', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Organizer', '',
  'TPL-CI-PART-053', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-054', 'Participation', 'LiveStream Follow-Up',
  'Event completed', 'Attendee', 'Continue engagement', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'Attendee', '',
  'TPL-CI-PART-054', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-055', 'Participation', 'Participation Preferences Updated',
  'Settings changed', 'User', 'Confirm changes', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-055', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-056', 'Participation', 'Participation Summary Ready',
  'Quarterly summary', 'User', 'Reflect impact', 'Medium',
  'In-App always; conditional Push', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', '15 minutes',
  'Merge similar social events', 'Seedling_Participation_Engine_Messaging.xlsx', 'Social', '65',
  'No', 'Yes', 'Open Participation batching window; last push timestamp and engine',
  'Social Reinforcement', '', '5–10 minute batching window', 'Yes',
  'Reinforce social behavior without creating unnecessary notification noise.', 'Reinforcement', 'ParticipationBatch, LastPush',
  'Merge if similar participation exists; otherwise reinforce social behavior.', 'User', '',
  'TPL-CI-PART-056', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-057', 'Participation', 'Donation Received on Your Seedling',
  'Donation', 'Seedling Sponsor, Co-Sponsors', 'Show the Sponsor and Co-Sponsors that others are joining the cause.', 'High',
  'Immediate Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Participation_Engine_Messaging.xlsx', 'Guaranteed', '98',
  'Yes', 'No', 'Sponsor donation rotation position only',
  'Guaranteed Creator Reinforcement', 'SponsorDonationCelebration', 'Immediate', 'Only for split gifts where one sponsor owns 2+ of the 5 Picks: one message "Someone just donated to (Count) of your Seedlings!". Otherwise No.',
  'Every verified donation is a guaranteed creator/organization celebration; rotate approved messages.', 'Celebration', 'SponsorRotationPosition',
  'Deliver because creator celebration is guaranteed; rotate approved message.', 'Seedling creator', 'Donation confirmation / reinforcement',
  'TPL-CI-PART-057', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Merge edge case for sponsors with multiple Picks.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-PART-058', 'Participation', 'Donation Received for Your Organization',
  'Donation', 'Supported organization', 'Show the organization that a community is forming around its mission.', 'High',
  'Immediate Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Participation_Engine_Messaging.xlsx', 'Guaranteed', '98',
  'Yes', 'No', 'Sponsor donation rotation position only',
  'Guaranteed Creator Reinforcement', 'SponsorDonationCelebration', 'Immediate', 'Only for split gifts where one organization is behind 2+ of the 5 Picks: one merged message. Otherwise No.',
  'Every verified donation is a guaranteed creator/organization celebration; rotate approved messages.', 'Celebration', 'SponsorRotationPosition',
  'Deliver because creator celebration is guaranteed; rotate approved message.', 'Supported organization', 'Donation confirmation / reinforcement',
  'TPL-CI-PART-058', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Merge edge case for orgs with multiple Picks.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-001', 'Contribution', 'Donation Made via Credit/Debit Card',
  'Donor makes donation', 'Donor', 'Thank donor', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling). Per-gift donation acknowledgments are not attached or emailed; they are saved to giving history and delivered via the year-end messages (CI-CONTR-034 December, CI-CONTR-002 January).', 'None',
  'Never -- EXCEPT child allocations of a split gift (parent_gift_id present, gift_type SUPPORT_ALL_5 or GROUNDS_CREW): suppressed on all channels; the parent rule (CI-CONTR-029/030/031) confirms instead. Split Gift Policy POL-SPLIT-03.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', 'Donation confirmation / reinforcement',
  'TPL-CI-CONTR-001', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Suppressed for split-gift children; acknowledgment no longer emailed per gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-002', 'Contribution', 'Annual Giving Summary Ready',
  'Early January (by Jan 31) -- official statement for the prior calendar year', 'Donor', 'Support tax reporting', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- the official annual statement. Totals = money-in events (card/ACH charges, GreenHouse Contributions incl. Auto-Replenish) dated by charge/transfer date; GreenHouse grant recommendations listed separately, never added to the total.', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Once, early January (covers every gift through 11:59pm Dec 31)', 'Yes -- absorbs CI-CONTR-027 Tax Acknowledgement Ready (one year-end message)',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-002', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Moved to early January as the official year-end statement; absorbs Tax Acknowledgement Ready.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-003', 'Contribution', 'ACH Donation Confirmed',
  'Funds settled', 'Donor', 'Build trust', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling). Per-gift donation acknowledgments are not attached or emailed; they are saved to giving history and delivered via the year-end messages (CI-CONTR-034 December, CI-CONTR-002 January).', 'None',
  'Never; de-duplicated to one per parent_gift_id for split gifts (split-gift copy).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'Yes -- one per parent_gift_id',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-003', '2026-10-18 revision (Split gifts / GreenHouse / year-end): One per parent gift for split gifts.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-004', 'Contribution', 'ACH Donation Failed',
  'Payment declined', 'Donor', 'Resolve issue', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never suppressed or delayed; de-duplicated to one per parent_gift_id; bypasses the split-gift quiet period.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'Yes -- one per parent_gift_id',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-004', '2026-10-18 revision (Split gifts / GreenHouse / year-end): De-duplicated per parent gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-005', 'Contribution', 'ACH Donation Pending',
  'ACH or delayed payment', 'Donor', 'Set expectations', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Split gifts: standalone suppressed -- the parent message adds "Your bank payment is processing." Single gifts: unchanged.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'Yes -- into the parent split-gift message',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-005', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Merged into parent message for split gifts.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-006', 'Contribution', 'Donation Acknowledgment Available',
  'Money-in event (card charge, ACH settlement, GreenHouse Contribution incl. Auto-Replenish)', 'Donor', 'Provide documentation', 'High',
  'Silent -- saved to In-App giving history; no Push, no Email', 'Tier 3 - Ambient/Digest', 'None per gift. Acknowledgments reach donors through the year-end messages: CI-CONTR-034 Year-End Giving Preview (December) and CI-CONTR-002 Annual Giving Summary (January). Never generated for GreenHouse grant recommendations (ToS 4.3).', 'None',
  'No notification is ever sent; the acknowledgment record is always created at the money-in event.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Passive', '20',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Silent at the money-in event', 'Yes -- rolls into the year-end summary',
  'Acknowledgments are kept on file and delivered at year end, not pushed per gift.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Record acknowledgment silently; deliver via year-end messages.', 'Donor', '',
  'TPL-CI-CONTR-006', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Renamed from Donation Receipt Available; now silent (giving history only) for ALL donations; never for GreenHouse recommendations.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-007', 'Contribution', 'GreenHouse Auto-Replenish Charged',
  'Auto-Replenish charge succeeds (balance fell below minimum)', 'User', 'Maintain balance', 'High',
  'Push + In-App + Email (required)', 'Tier 1 - Guaranteed', 'REQUIRED (ToS 4.3): Email AND Push every time a replenishment is charged; email continues even if push is disabled. Acknowledgment saved silently to giving history.', 'None',
  'NEVER -- required by Terms of Service (POL-SPLIT-11). May be held up to 15 minutes after a parent split-gift message so it does not stack. When triggered by a Grounds Crew monthly contribution, delivered as a labeled section inside CI-CONTR-031 (sent by Email + Push).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate, or parent message + up to 15 minutes; evaluated once after the whole parent transaction (POL-SPLIT-06)', 'Yes -- into CI-CONTR-031 when triggered by a Grounds Crew contribution',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'User', '',
  'TPL-CI-CONTR-007', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Renamed to Auto-Replenish; required notice -- never suppressed.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-008', 'Contribution', 'GreenHouse Auto-Replenish Failed',
  'Auto-Replenish charge unsuccessful (incl. paused after repeated failures)', 'User', 'Resolve payment', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'NEVER -- required notice (ToS 4.3, POL-SPLIT-11); bypasses the quiet period; one per parent transaction; merges with CI-CONTR-032 when a Grounds Crew month is skipped.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediately after any parent message', 'Yes -- with CI-CONTR-032 when both apply',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'User', '',
  'TPL-CI-CONTR-008', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Renamed to Auto-Replenish; required notice; covers the paused-after-failures variant.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-009', 'Contribution', 'GreenHouse Balance Low',
  'Threshold reached', 'User', 'Encourage refill', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Evaluated once after the whole parent transaction (POL-SPLIT-06). After a split gift: folded into the parent message as one line; no standalone Push/Email for 12 hours.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'Yes -- into the parent split-gift message',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'User', '',
  'TPL-CI-CONTR-009', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Evaluated once per split gift; folded into parent.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-010', 'Contribution', 'GreenHouse Balance Low Auto-Replenish',
  'Threshold reached', 'User', 'Encourage refill', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Evaluated once after the whole parent transaction (POL-SPLIT-06). After a split gift: folded into the parent message as one line; no standalone Push/Email for 12 hours.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'Yes -- into the parent split-gift message',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'User', '',
  'TPL-CI-CONTR-010', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Renamed to Auto-Replenish; evaluated once per split gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-011', 'Contribution', 'GreenHouse Deposit Added',
  'Funds deposited', 'User', 'Confirm balance', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- confirms the donation (GreenHouse Contribution) to Seedling Social Giving. Acknowledgment saved to giving history, not attached.', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'User', '',
  'TPL-CI-CONTR-011', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Copy now confirms the donation to Seedling; acknowledgment saved, not sent separately.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-012', 'Contribution', 'GreenHouse Donation Made',
  'Donation from balance', 'User', 'Confirm transaction', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- grant-recommendation confirmation. Never triggers an acknowledgment (ToS 4.3).', 'None',
  'Never -- EXCEPT child allocations of a split gift (parent_gift_id present, gift_type SUPPORT_ALL_5 or GROUNDS_CREW): suppressed on all channels; the parent rule (CI-CONTR-029/030/031) confirms instead. Split Gift Policy POL-SPLIT-03.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate',
  'Deliver because verified generosity deserves immediate recognition.', 'User', 'Donation confirmation / reinforcement',
  'TPL-CI-CONTR-012', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Suppressed for split-gift children; copy reframed as grant recommendation.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-013', 'Contribution', 'Offline Donation Recorded',
  'Manual entry', 'Organization', 'Confirm accounting', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Organization', '',
  'TPL-CI-CONTR-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-014', 'Contribution', 'Payment Method Added',
  'New payment method', 'User', 'Confirm setup', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'User', '',
  'TPL-CI-CONTR-014', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-015', 'Contribution', 'Payment Method Expiring',
  'Card nearing expiration', 'Donor', 'Prevent failed payments', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-015', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-016', 'Contribution', 'Payment Method Preferences Updated',
  'Giving settings changed', 'Donor', 'Confirm preferences', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-016', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-017', 'Contribution', 'Payment Method Updated',
  'Payment details changed', 'Donor', 'Confirm update', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-017', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-018', 'Contribution', 'Acknowledgment Downloaded',
  'Acknowledgment or summary downloaded', 'Donor', 'Confirm access', 'High',
  'In-App only (confirm in place)', 'Tier 4 - Session-Bound', 'None -- confirms a user action in place.', 'None',
  'Never', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Passive', '20',
  'No', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-018', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Downgraded to In-App only; no Push/Email for a user action.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-019', 'Contribution', 'Recurring Donation Cancelled',
  'Subscription cancelled', 'Donor', 'Acknowledge preference', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-039 Grounds Crew Cancelled (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-019', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-039.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-020', 'Contribution', 'Recurring Donation Created',
  'Monthly gift established', 'Donor', 'Celebrate commitment', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-030 Grounds Crew Enrollment Confirmed (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-020', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-030.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-021', 'Contribution', 'Recurring Donation Failed',
  'Recurring payment fails', 'Donor', 'Resolve payment', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-037 Grounds Crew Payment Failed (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-021', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-037.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-022', 'Contribution', 'Recurring Donation Paused',
  'Subscription paused', 'Donor', 'Confirm change', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-038 Grounds Crew Paused (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-022', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-038.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-023', 'Contribution', 'Recurring Donation Processed',
  'Scheduled payment succeeds', 'Donor', 'Confirm contribution', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-031 Grounds Crew Monthly Gift Processed (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-023', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-031.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-024', 'Contribution', 'Recurring Donation Resumed',
  'Subscription resumed', 'Donor', 'Welcome back', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-040 Grounds Crew Resumed (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-024', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-040.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-025', 'Contribution', 'Recurring Donation Upcoming',
  'Scheduled payment approaching', 'Donor', 'Prepare donor', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never for single gifts. When gift_type = GROUNDS_CREW: suppressed and replaced by CI-CONTR-036 Grounds Crew Contribution Upcoming (one message per enrollment instead of x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-025', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Grounds Crew uses CI-CONTR-036.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-026', 'Contribution', 'Refund Issued',
  'Donation refunded (processing error, duplicate, or verified fraud only -- ToS 7)', 'Donor', 'Explain transaction', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Never; de-duplicated to one per parent gift. Refund goes to the original payment method; acknowledgment voided/adjusted. Does not apply to GreenHouse grant recommendations (not refundable, ToS 4.3) -- see CI-CONTR-035 for redirects.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Immediate', 'Yes -- one per parent_gift_id',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', 'Donation confirmation / reinforcement',
  'TPL-CI-CONTR-026', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Aligned to ToS 7; one per parent gift.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-027', 'Contribution', 'Tax Acknowledgement Ready',
  'IRS acknowledgment prepared', 'Donor', 'Provide compliance', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Merged into CI-CONTR-002 Annual Giving Summary (January); no standalone send.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'With CI-CONTR-002 (early January)', 'Yes -- into CI-CONTR-002',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-027', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Folded into the January year-end summary.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-028', 'Contribution', 'Tax Season Reminder',
  'Mid-February, once', 'Donor', 'Support tax filing', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Suppressed if the user has already opened the Annual Giving Summary.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Current app/session activity; last in-app experience',
  'Donation Confirmation', '', 'Once, mid-February', 'No',
  'Verified generosity must be acknowledged; avoid only a redundant push while the donor is active.', 'Recognition', 'CurrentSession, LastInApp, DonorState',
  'Deliver because verified generosity deserves immediate recognition.', 'Donor', '',
  'TPL-CI-CONTR-028', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Single mid-February reminder.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-029', 'Contribution', 'Support All 5 Gift Made',
  'Donor completes a Support all 5 gift (all 5 recommendations recorded under one parent_gift_id)', 'Donor (parent/guardian for family accounts)', 'Thank donor once for the whole gift and show five-fold impact', 'High',
  'In-App always; Push if user left app', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- financial confirmation. Card/ACH-funded: confirms the donation to Seedling Social Giving; the acknowledgment is saved to giving history (not attached) and included in the year-end summary. GreenHouse-funded: grant-recommendation confirmation only; no acknowledgment (ToS 4.3).', 'None',
  'Never suppressed. SUPPRESSES the child messages it replaces (CI-CONTR-001/012/006 for the same parent_gift_id) -- Split Gift Policy POL-SPLIT-03.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '96',
  'Yes', 'No', 'ParentGiftID, status of all 5 recommendations, current session',
  'Split Gift Confirmation', '', 'After the collect window closes (all 5 recorded, max 120 seconds), then Immediate. Starts the 12-hour split-gift quiet period.', 'Yes -- merges 5 donation confirmations into one message; also shows any badges/goals the gift unlocked',
  'One gift, one thank-you: confirm the whole split gift once instead of five times.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate, SplitGiftQuietUntil, AccountGuardian',
  'Deliver one Support all 5 thank-you; choose card/ACH or GreenHouse closing from FundingSource.', 'Donor (parent/guardian for family accounts)', '',
  'TPL-CI-CONTR-029', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-030', 'Contribution', 'Grounds Crew Enrollment Confirmed',
  'Donor enrolls in The Grounds Crew (if the first contribution processes the same day, it is included in this message)', 'Donor (parent/guardian for family accounts)', 'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (contribution amount, first charge at enrollment, charged each time a new batch of Picks launches -- no more than once per calendar month -- until cancelled, how to cancel)', 'High',
  'In-App always; Push if user left app; Email always (required)', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push. Must include the enrollment terms and cancellation instructions (ToS 4.4).', 'None',
  'NEVER -- required enrollment confirmation (POL-SPLIT-11). Suppresses CI-CONTR-020 (x5). If the first contribution processes the same day, it absorbs that month''s CI-CONTR-031 and CI-CONTR-001/012 (x5).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '97',
  'Yes', 'No', 'SubscriptionID, first charge date, funding source, current session',
  'Split Gift Confirmation', '', 'Immediate at enrollment (collect window applies only if the first contribution processes at once). Starts the quiet period.', 'Yes -- merges recurring-created + optional first gift into one message',
  'Welcome the member once, state the terms clearly, and promise a calm once-a-month cadence.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate, SplitGiftQuietUntil, AccountGuardian, SubscriptionID, FirstChargeDate',
  'Deliver the enrollment confirmation with required terms; include first gift if processed today.', 'Donor (parent/guardian for family accounts)', '',
  'TPL-CI-CONTR-030', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Enrollment terms describe batch-based charging (no more than once per calendar month).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-031', 'Contribution', 'Grounds Crew Batch Gift Processed',
  'New Picks batch released AND the member''s Grounds Crew charge for that batch processed (card charge succeeds or GreenHouse balance applied)', 'Donor (Grounds Crew member)', 'Confirm the gift once, celebrate what the last batch grew (when results were entered), and introduce the new Picks (replaces the Picks to Click digest for members)', 'High',
  'Push + In-App + Email (one per month)', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- financial confirmation. Card/ACH-funded: confirms the donation to Seedling Social Giving; the acknowledgment is saved to giving history (not attached) and included in the year-end summary. GreenHouse-funded: grant-recommendation confirmation only; no acknowledgment (ToS 4.3). When the contribution triggers Auto-Replenish, this message carries the required Auto-Replenish charge notice as a labeled section (Email + Push), replacing a separate CI-CONTR-007.', 'One per batch per enrollment (at most one batch per calendar month)',
  'Never suppressed. Suppresses CI-CONTR-023 (x5) and CI-CONTR-001/012 (x5) for the month, absorbs CI-CONTR-007 when Auto-Replenish was triggered, and replaces the monthly Picks to Click digest (CI-OPP-150) for this member.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '96',
  'Yes', 'No', 'SubscriptionID, month, recommendation status, lifetime Seedlings supported, Auto-Replenish triggered, batch ID, last-batch results (manually entered; optional), Crew total for last batch, Crew gift count, first-batch-day flag, Crew milestone flag',
  'Split Gift Confirmation', '', 'After the collect window closes; delivered at the member''s best engagement time on processing day. If it carries an Auto-Replenish notice, delivered the same day. Starts the quiet period.', 'Yes -- merges the month''s 5 recurring confirmations + Picks reveal (+ Auto-Replenish notice) into one message',
  'Each batch earns exactly one touch: confirm the gift, celebrate the last batch, and introduce the new Picks together.', 'Recognition', 'CurrentSession, LastInApp, DonorState, ParentGiftID, FundingSource, GreenHouseDepositDate, SplitGiftQuietUntil, AccountGuardian, SubscriptionID, LifetimeSeedlingsSupported, AutoReplenishTriggered, BatchID, LastBatchResults, CrewTotalLastBatch, CrewGiftCount, FirstBatchDay, CrewMilestone',
  'Deliver one Grounds Crew batch confirmation + Picks reveal; include last-batch results when entered; add Auto-Replenish section when triggered.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-031', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Renamed from Monthly Gift Processed; fires per batch; opens with last-batch results when entered.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-032', 'Contribution', 'Grounds Crew Contribution Skipped',
  'GreenHouse-funded Grounds Crew batch launch date arrives and the GreenHouse balance is insufficient (after any Auto-Replenish attempt)', 'Donor (Grounds Crew member)', 'Required notice (ToS 4.4): this month''s contribution was not made', 'High',
  'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push.', 'One per batch',
  'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event. Merges with CI-CONTR-008 when an Auto-Replenish attempt also failed.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'SubscriptionID, GreenHouse balance, Auto-Replenish state',
  'Donation Confirmation', '', 'Immediate on the scheduled date, after any Auto-Replenish attempt resolves', 'Yes -- with CI-CONTR-008 when both apply',
  'Required and actionable: tell the member once and nudge Auto-Replenish so it does not recur.', 'Resolution', 'DonorState, SubscriptionID, GreenHouseBalance, AutoReplenishState, AccountGuardian',
  'Deliver the required skipped-month notice with an Auto-Replenish nudge.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-032', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Trigger is the batch launch date.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-033', 'Contribution', 'Auto-Replenish Turned On',
  'User turns on GreenHouse Auto-Replenish', 'User (parent/guardian for family accounts)', 'Required confirmation (ToS 4.3): minimum balance, replenishment amount, payment method, continuing charges, how to turn off', 'High',
  'In-App always; Push if user left app; Email always (required)', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push. Must include minimum balance, replenishment amount, payment method, continuing-charge statement and how to turn off (ToS 4.3).', 'None',
  'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Auto-Replenish settings, current session',
  'Donation Confirmation', '', 'Immediate when Auto-Replenish is turned on', 'No',
  'Required confirmation of a standing charge authorization.', 'Confirmation', 'DonorState, AutoReplenishSettings, AccountGuardian',
  'Deliver the Auto-Replenish confirmation with all required terms.', 'User (parent/guardian for family accounts)', '',
  'TPL-CI-CONTR-033', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-034', 'Contribution', 'Year-End Giving Preview',
  'Second week of December -- users with at least one donation in the current calendar year', 'Donor', 'Year-to-date giving recap; promote a GreenHouse Contribution before Dec 31; Grounds Crew members also see batches and Seedlings supported this year', 'High',
  'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, once per year (December). Doubles as the GreenHouse year-end promotion.', 'Once per calendar year',
  'Skipped for users with no donations this year (they receive Opportunity One Final Gift instead). Respects the split-gift quiet period (delay, not drop).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '90',
  'Yes', 'No', 'Year-to-date donations, Seedlings supported',
  'Donation Confirmation', '', 'Second week of December, best engagement time', 'No',
  'One year-to-date recap replaces per-gift acknowledgment emails and promotes a GreenHouse Contribution before Dec 31.', 'Recognition', 'DonorState, YTDDonations, LifetimeSeedlingsSupported, CrewBatchCountYTD, CrewSeedlingCountYTD',
  'Deliver the December giving recap with the GreenHouse year-end prompt.', 'Donor', '',
  'TPL-CI-CONTR-034', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Adds a Grounds Crew section for members.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-035', 'Contribution', 'Recommendation Redirected',
  'Seedling redirects funds because a recommended Seedling/nonprofit is ineligible, inactive, or cannot receive funds (ToS 4.1, 4.4)', 'Donor', 'Keep trust: explain where the support went', 'High',
  'In-App + Email (no Push)', 'Tier 2 - Event-Driven', 'In-App + Email always (trust notice); no Push.', 'One per parent gift or month',
  'Never suppressed; consolidated to one per parent gift / Grounds Crew month when several recommendations are redirected.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '80',
  'Yes', 'No', 'Redirect events per gift',
  'Donation Confirmation', '', 'When the redirect is decided (often after the Seedling closes); held until any quiet period ends', 'Yes -- one per parent gift',
  'Recommendations are nonbinding (ToS 4.1); telling donors where support went protects trust.', 'Resolution', 'DonorState, ParentGiftID, SubscriptionID',
  'Deliver one redirect explanation per gift.', 'Donor', '',
  'TPL-CI-CONTR-035', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-036', 'Contribution', 'Grounds Crew Contribution Upcoming',
  '48 hours before a scheduled Grounds Crew batch launch date (batch dates are always set at least 48 hours ahead)', 'Donor (Grounds Crew member)', 'One light reminder; prevent skipped months for GreenHouse-funded members', 'High',
  'In-App + Email (no Push)', 'Tier 1 - Guaranteed', 'In-App + Email, once per month; no Push.', 'One per batch',
  'Replaces CI-CONTR-025 (x5) for Grounds Crew. Respects the quiet period (delay, not drop).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '85',
  'Yes', 'No', 'SubscriptionID, next contribution date, GreenHouse balance, Auto-Replenish state',
  'Donation Confirmation', '', '48 hours before the batch launch date', 'Yes -- replaces 5 Recurring Donation Upcoming messages',
  'One light reminder; warns GreenHouse-funded members who are short and nudges Auto-Replenish.', 'Reminder', 'DonorState, SubscriptionID, GreenHouseBalance, AutoReplenishState, NextBatchDate',
  'Deliver one Grounds Crew reminder; add short-balance + Auto-Replenish nudge when applicable.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-036', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Fires 48 hours before each scheduled batch launch; batch dates are always set 48+ hours ahead.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-037', 'Contribution', 'Grounds Crew Payment Failed',
  'Card-funded Grounds Crew batch charge fails', 'Donor (Grounds Crew member)', 'Required notice (ToS 4.4): resolve payment', 'High',
  'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push.', 'One per attempt',
  'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event. Replaces CI-CONTR-021 (x5) for Grounds Crew.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'SubscriptionID, retry schedule',
  'Donation Confirmation', '', 'Immediate', 'Yes -- replaces 5 Recurring Donation Failed messages',
  'Required and actionable; once per failed attempt.', 'Resolution', 'DonorState, SubscriptionID, AccountGuardian',
  'Deliver one Grounds Crew payment failure notice.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-037', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): Charge is per batch.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-038', 'Contribution', 'Grounds Crew Paused',
  'Member pauses The Grounds Crew, or enrollment is paused after repeated failed payments (ToS 4.4)', 'Donor (Grounds Crew member)', 'Confirm the pause and how to resume', 'High',
  'In-App always; Push if user left app; Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always.', 'None',
  'Never; replaces CI-CONTR-022 (x5) for Grounds Crew. Paused-after-failures variant is a required notice (POL-SPLIT-11).', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'SubscriptionID, pause reason',
  'Donation Confirmation', '', 'Immediate', 'Yes -- replaces 5 Recurring Donation Paused messages',
  'One action, one confirmation.', 'Confirmation', 'DonorState, SubscriptionID',
  'Deliver one Grounds Crew paused confirmation (member or failure variant).', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-038', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-039', 'Contribution', 'Grounds Crew Cancelled',
  'Member cancels The Grounds Crew', 'Donor (Grounds Crew member)', 'Confirm cancellation (ToS 4.4, 7); maintain goodwill', 'High',
  'In-App always; Push if user left app; Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always.', 'None',
  'Never; replaces CI-CONTR-019 (x5) for Grounds Crew.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'SubscriptionID',
  'Donation Confirmation', '', 'Immediate', 'Yes -- replaces 5 Recurring Donation Cancelled messages',
  'One action, one confirmation; states contributions already processed are final.', 'Confirmation', 'DonorState, SubscriptionID',
  'Deliver one Grounds Crew cancellation confirmation.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-039', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-040', 'Contribution', 'Grounds Crew Resumed',
  'Member resumes The Grounds Crew', 'Donor (Grounds Crew member)', 'Welcome back; confirm next contribution', 'High',
  'In-App always; Push if user left app; Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always.', 'None',
  'Never; replaces CI-CONTR-024 (x5) for Grounds Crew.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'SubscriptionID, next contribution date',
  'Donation Confirmation', '', 'Immediate', 'Yes -- replaces 5 Recurring Donation Resumed messages',
  'One action, one confirmation.', 'Confirmation', 'DonorState, SubscriptionID',
  'Deliver one Grounds Crew resumed confirmation.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-040', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-041', 'Contribution', 'Grounds Crew Program Change Notice',
  'Material change to The Grounds Crew program (advance notice required, ToS 4.4)', 'Donor (Grounds Crew member)', 'Required advance notice of material program changes', 'High',
  'Push + In-App + Email', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push.', 'None',
  'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event. Batch-timing notice (Dec 2026): sent manually by the owner by push and email.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '95',
  'Yes', 'No', 'Program change record',
  'Donation Confirmation', '', 'In advance of the effective date (lead time set by policy/counsel)', 'No',
  'Required advance notice of material program changes (ToS 4.4).', 'Notice', 'DonorState, SubscriptionID',
  'Deliver the required program change notice.', 'Donor (Grounds Crew member)', '',
  'TPL-CI-CONTR-041', '2026-10-23 revision (Grounds Crew batch charging, CI_Grounds_Crew_Batch_Proposal REV 2): The batch-timing change notice is a manual owner send by push and email after the updated Terms are published (not automated).', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CONTR-042', 'Contribution', 'GreenHouse Inactive Balance Notice',
  'GreenHouse balance has had no grant recommendations for 22 months (60 days before the 24-month mark, ToS 4.3)', 'User', 'Required notice where practicable before an inactive balance is regranted', 'High',
  'In-App + Email; Push', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- REQUIRED by Terms of Service (POL-SPLIT-11). Email is sent even if the user has disabled push. (notice where practicable before regranting an inactive balance, ToS 4.3).', 'Once per inactivity period',
  'NEVER -- required by Terms of Service (POL-SPLIT-11). Bypasses the split-gift quiet period; de-duplicated to one per event.', 'Seedling_Contribution_Engine_Messaging.xlsx', 'Guaranteed', '90',
  'Yes', 'No', 'Last recommendation date, GreenHouse balance',
  'Donation Confirmation', '', 'Once, 60 days before the 24-month inactivity mark', 'No',
  'Required notice and a strong prompt to recommend Seedlings or join The Grounds Crew.', 'Notice', 'DonorState, GreenHouseBalance, LastRecommendationDate',
  'Deliver the inactive-balance notice with Choose Seedlings / Grounds Crew options.', 'User', '',
  'TPL-CI-CONTR-042', '2026-10-18 revision (Split gifts / GreenHouse / year-end): New rule.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-001', 'Campaign', 'Campaign Launched',
  'Campaign goes live', 'Followers', 'Announce launch', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Sponsor; Co-Sponsors', 'Seedling live notification',
  'TPL-CI-CAMP-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-002', 'Campaign', 'Campaign Featured',
  'Editorial selection', 'Users', 'Increase visibility', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Users', '',
  'TPL-CI-CAMP-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-003', 'Campaign', 'Campaign Trending',
  'Engagement threshold reached', 'Users', 'Highlight momentum', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Users', '',
  'TPL-CI-CAMP-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-004', 'Campaign', 'Goal 25% Complete',
  'Dynamic', 'Campaign near goal', 'Interested users', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise. If a donor''s split-gift allocation crossed this milestone: shown in the parent In-App impact summary; that donor''s Push held at least 2 hours after the parent; multiple milestones merge. Other supporters unchanged.', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-004', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Delayed/merged for the split-gift donor only.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-005', 'Campaign', 'Goal 50% Complete',
  'Dynamic', 'Campaign near goal', 'Interested users', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise. If a donor''s split-gift allocation crossed this milestone: shown in the parent In-App impact summary; that donor''s Push held at least 2 hours after the parent; multiple milestones merge. Other supporters unchanged.', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-005', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Delayed/merged for the split-gift donor only.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-006', 'Campaign', 'Goal 75% Complete',
  'Dynamic', 'Campaign near goal', 'Interested users', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise. If a donor''s split-gift allocation crossed this milestone: shown in the parent In-App impact summary; that donor''s Push held at least 2 hours after the parent; multiple milestones merge. Other supporters unchanged.', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-006', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Delayed/merged for the split-gift donor only.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-007', 'Campaign', 'Goal 90% Complete',
  'Dynamic', 'Campaign near goal', 'Interested users', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise. If a donor''s split-gift allocation crossed this milestone: shown in the parent In-App impact summary; that donor''s Push held at least 2 hours after the parent; multiple milestones merge. Other supporters unchanged.', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-007', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Delayed/merged for the split-gift donor only.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-008', 'Campaign', 'Funding Goal Achieved',
  'Goal reached', 'Supporters', 'Celebrate success', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise. If a donor''s split-gift allocation crossed this milestone: shown in the parent In-App impact summary; that donor''s Push held at least 2 hours after the parent; multiple milestones merge. Other supporters unchanged.', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-008', '2026-10-18 revision (Split gifts / GreenHouse / year-end): Delayed/merged for the split-gift donor only.', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-009', 'Campaign', 'Campaign Extended',
  'End date changed', 'Supporters', 'Communicate opportunity', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-010', 'Campaign', 'Campaign Near Deadline',
  '48/24 hours remaining', 'Interested Users', 'Create urgency', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Interested Users', '',
  'TPL-CI-CAMP-010', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-011', 'Campaign', 'Campaign Ended',
  'Campaign closes', 'Supporters', 'Thank participants', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-011', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-012', 'Campaign', 'Campaign Updated',
  'Content changed', 'Followers', 'Share latest news', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Followers', '',
  'TPL-CI-CAMP-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-013', 'Campaign', 'Campaign Viewed Milestone',
  'View threshold reached', 'Organization', 'Celebrate awareness', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Organization', '',
  'TPL-CI-CAMP-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-014', 'Campaign', 'Campaign Share Milestone',
  'Share threshold reached', 'Organization', 'Recognize advocacy', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Organization', '',
  'TPL-CI-CAMP-014', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-015', 'Campaign', 'Campaign Anniversary',
  'One year since launch', 'Organization', 'Celebrate legacy', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Organization', '',
  'TPL-CI-CAMP-015', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-016', 'Campaign', 'Campaign Performance Summary',
  'Weekly/monthly analytics', 'Organization', 'Improve effectiveness', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Organization', '',
  'TPL-CI-CAMP-016', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-017', 'Campaign', 'Campaign Goal Increased',
  'Funding goal raised', 'Supporters', 'Explain expansion', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-017', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-018', 'Campaign', 'Campaign Goal Reduced',
  'Funding goal lowered', 'Supporters', 'Maintain transparency', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-018', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-019', 'Campaign', 'Campaign Milestone Celebration',
  'Major milestone achieved', 'Supporters', 'Celebrate together', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Supporters', '',
  'TPL-CI-CAMP-019', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-020', 'Campaign', 'Campaign Search Milestone',
  'Search impressions threshold', 'Organization', 'Show discoverability', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 3 - Ambient/Digest', 'In-App is the primary home for this content; Push fires only per the engine’s normal frequency cap. No 1:1 Email -- eligible for a periodic digest only, to avoid overloading users with low-value pings.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Organization', '',
  'TPL-CI-CAMP-020', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-CAMP-021', 'Campaign', 'Campaign Completion Report',
  'Final analytics available', 'Organization', 'Review results', 'Medium-Low',
  'In-App; Push for meaningful milestones only', 'Tier 2 - Event-Driven', 'Push + In-App to recipients who have the app; Email also sent as the reach channel for recipients who have not downloaded the app, so the moment still reaches everyone once without double-touching engaged app users.', 'Long',
  'Suppress routine progress noise', 'Seedling_Campaign_Engine_Messaging.xlsx', 'Milestone', '60',
  'No', 'Yes', 'Recent campaign milestone; last push timestamp',
  'Collective Progress', '', 'Meaningful milestones', 'Yes',
  'Communicate collective progress only when the milestone deserves attention.', 'Celebration', 'CampaignState',
  'Deliver only for meaningful collective milestones.', 'Organization', '',
  'TPL-CI-CAMP-021', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-001', 'Governance', 'Seedling Submitted for Review',
  'Seedling Submitted', 'Sponsor, Co-Sponsors', 'Acknowledge submission', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-002', 'Governance', 'Seedling Approved',
  'Seedling Approved', 'Sponsor, Co-Sponsors', 'Acknowledge Acceptance', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-003', 'Governance', 'Seedling Rejected',
  'Seedling Rejected', 'Sponsor, Co-Sponsors', 'Explain decision', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-004', 'Governance', 'Comment Reported',
  'Comment Flagged by user', 'Reporter', 'Acknowledge report', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Reporter, Commenter', '',
  'TPL-CI-GOV-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-005', 'Governance', 'Comment Removed',
  'Comment Removed', 'Commenter', 'Notify author', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Reporter, Commenter', '',
  'TPL-CI-GOV-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-006', 'Governance', 'Comment Removed',
  'Comment Removed', 'Reporter', 'Close the loop on report', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', '', '',
  'TPL-CI-GOV-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-007', 'Governance', 'Account Warning',
  'Offending activity', 'Commenter', 'Policy warning', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Commenter', '',
  'TPL-CI-GOV-007', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-008', 'Governance', 'Temporary Account Restriction',
  'Offending issue', 'Commenter', 'Notify restriction', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Commenter', '',
  'TPL-CI-GOV-008', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-009', 'Governance', 'Account Restored',
  'Account reinstated', 'Commenter', 'Notify restoration', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status. Reserved for compliance, account-status, and financial confirmations, plus guaranteed high-value moments (e.g., a donation landing on your Seedling).', 'None',
  'Exact duplicates only', 'Seedling_Governance_Engine_Messaging.xlsx', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Trust & Safety', '', 'Immediate', 'No',
  'High-trust communication; deliver immediately unless it is an exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Commenter', '',
  'TPL-CI-GOV-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-001', 'Narrative', 'Generate Seedling title',
  'Generate Seedling title requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 Optional Titles for ''Generate Seedling title''.', '',
  'TPL-CI-NARR-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-002', 'Narrative', 'Generate Seedling description',
  'Generate Seedling description requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 optional Descriptions for ''Generate Seedling description''.', '',
  'TPL-CI-NARR-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-003', 'Narrative', 'Generate campaign title',
  'Generate campaign title requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'if Campaign box is selected, generate 3 Optional Titles for ''Generate Campaign title''.', '',
  'TPL-CI-NARR-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-004', 'Narrative', 'Generate campaign description',
  'Generate campaign description requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'if Campaign box is selected, generate 3 optional Descriptions for ''Generate Campaign description''.', '',
  'TPL-CI-NARR-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-005', 'Narrative', 'Seedling Birthday Challenge - Generate Seedling title',
  'Generate Seedling title requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 Optional Titles for ''Generate Seedling title''.', '',
  'TPL-CI-NARR-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-006', 'Narrative', 'Seedling Birthday Challenge - Generate Seedling description',
  'Generate Seedling description requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 optional Descriptions for ''Generate Seedling description''.', '',
  'TPL-CI-NARR-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-007', 'Narrative', 'Seedling Birthday Challenge - Generate campaign title',
  'Generate campaign title requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'if Campaign box is selected, generate 3 Optional Titles for ''Generate Campaign title''.', '',
  'TPL-CI-NARR-007', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-008', 'Narrative', 'Seedling Birthday Challenge - Generate campaign description',
  'Generate campaign description requested or context detected', 'User', '', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'if Campaign box is selected, generate 3 optional Descriptions for ''Generate Campaign description''.', '',
  'TPL-CI-NARR-008', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-009', 'Narrative', 'Sharing - Facebook sharing text',
  'Facebook sharing text requested or context detected', 'User', 'Need help sharing your story? We''ve got a few ideas.', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 Facebook sharing text options that match the Seedling, nonprofit, and creator''s voice. Keep the creator in control and never post automatically.', '',
  'TPL-CI-NARR-009', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-010', 'Narrative', 'Sharing - Instagram caption',
  'Instagram caption requested or context detected', 'User', 'Need help sharing your story? We''ve got a few ideas.', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 Instagram caption options that match the Seedling, nonprofit, and creator''s voice. Keep the creator in control and never post automatically.', '',
  'TPL-CI-NARR-010', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-011', 'Narrative', 'Sharing - X post',
  'X caption requested or context detected', 'User', 'Need help sharing your story? We''ve got a few ideas.', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 X post options that match the Seedling, nonprofit, and creator''s voice. Keep the creator in control and never post automatically.', '',
  'TPL-CI-NARR-011', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-012', 'Narrative', 'Sharing - LinkedIn post',
  'LinkedIn post requested or context detected', 'User', 'Need help sharing your story? We''ve got a few ideas.', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 LinkedIn post options that match the Seedling, nonprofit, and creator''s voice. Keep the creator in control and never post automatically.', '',
  'TPL-CI-NARR-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-013', 'Narrative', 'Sharing - Email invitation',
  'Email invitation requested or context detected', 'User', 'Need help sharing your story? We''ve got a few ideas.', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 Email invitation options that match the Seedling, nonprofit, and creator''s voice. Keep the creator in control and never post automatically.', '',
  'TPL-CI-NARR-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-NARR-014', 'Narrative', 'Sharing - SMS invitation',
  'SMS invitation requested or context detected', 'User', 'Need help sharing your story? We''ve got a few ideas.', 'User initiated',
  'In-App only', 'Tier 4 - Session-Bound', 'In-App only. No Push, no Email -- this fires while the user is actively in a live, in-context flow with no meaningful off-app moment to bring them back to.', 'None',
  'None', 'Seedling_Narrative_Engine_Messaging.xlsx', 'User Initiated', '100',
  'Yes', 'N/A', 'Current user request and editing context',
  'Creator Assistance', '', 'On demand', 'N/A',
  'Respond because the user explicitly requested assistance.', 'Guidance', 'CurrentEditingContext',
  'Respond only to explicit user request.', 'Generate 3 SMS invitation options that match the Seedling, nonprofit, and creator''s voice. Keep the creator in control and never post automatically.', '',
  'TPL-CI-NARR-014', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-010', 'Governance', 'Seedling Update Submitted for Review',
  'Sponsor submits a Seedling update that includes a new video', 'Sponsor, Co-Sponsors', 'Acknowledge update submission', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None',
  'Exact duplicates only', 'Hand-authored - Seedling update flow, 2026-09-02', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Governance Action', '', 'Immediate', 'No',
  'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-010', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-011', 'Governance', 'Seedling Update Completed',
  'Sponsor submits a Seedling update with no new video - merges automatically', 'Sponsor, Co-Sponsors', 'Confirm update completed', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None',
  'Exact duplicates only', 'Hand-authored - Seedling update flow, 2026-09-02', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Governance Action', '', 'Immediate', 'No',
  'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-011', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-012', 'Governance', 'Seedling Update Approved',
  'Admin approves a Seedling update that included a new video', 'Sponsor, Co-Sponsors', 'Acknowledge update approval', 'Highest',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None',
  'Exact duplicates only', 'Hand-authored - Seedling update flow, 2026-09-02', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Governance Action', '', 'Immediate', 'No',
  'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-012', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-GOV-013', 'Governance', 'Seedling Approved - Scheduled Go-Live',
  'Admin approves a new Seedling whose start date is in the future', 'Sponsor, Co-Sponsors', 'Acknowledge acceptance and confirm the go-live date', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App + Email, always -- sent to every recipient regardless of app-download status.', 'None',
  'Exact duplicates only', 'Hand-authored - Seedling scheduled go-live approval, 2026-10-08', 'Critical', '100',
  'Yes', 'No', 'Recent exact-duplicate event IDs; recent governance experience',
  'Governance Action', '', 'Immediate', 'No',
  'Always deliver unless exact duplicate.', 'Governance', 'RecentGovernance, DuplicateEvents',
  'Always deliver unless exact duplicate.', 'Sponsor, Co-Sponsors', '',
  'TPL-CI-GOV-013', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-001', 'Manual', '5 Picks to Click',
  'Admin triggers manual broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Showcase 5 hand-picked Seedlings to drive engagement and donations', 'Medium',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - 5 Picks to Click admin broadcast, 2026-09-30', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent 5 Picks to Click.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent 5 Picks to Click.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-001', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-002', 'Manual', 'Introducing The Grounds Crew',
  'Admin sends Grounds Crew intro broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Introduce The Grounds Crew subscription program', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - Grounds Crew intro admin broadcast, 2026-10-05', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent Introducing The Grounds Crew.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent Introducing The Grounds Crew.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-002', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-003', 'Manual', 'Welcome to Seedling',
  'Admin sends Welcome to Seedling broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Re-engage users with Seedling mission and video', 'Medium',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - Welcome to Seedling admin broadcast, 2026-10-06', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent Welcome to Seedling.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent Welcome to Seedling.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-003', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-004', 'Manual', 'How Your GreenHouse Works',
  'Admin sends How Your GreenHouse Works broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Educate users on GreenHouse giving wallet', 'Medium',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - How Your GreenHouse Works admin broadcast, 2026-10-06', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent How Your GreenHouse Works.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent How Your GreenHouse Works.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-004', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-005', 'Manual', 'Seedling Birthday Challenge',
  'Admin sends Birthday Challenge broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Encourage users to dedicate upcoming birthday to a cause', 'Medium',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - Seedling Birthday Challenge admin broadcast, 2026-10-06', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent the Seedling Birthday Challenge.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent the Seedling Birthday Challenge.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-005', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-006', 'Manual', 'What''s New on Seedling',
  'Admin sends What''s New on Seedling broadcast from CI Rulebook page', 'All Users (excluding Admins), or users picked by the admin', 'Tell users what''s new on Seedling', 'Medium',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - What''s New on Seedling admin broadcast, 2026-10-09', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent What''s New on Seedling.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent What''s New on Seedling.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-006', '', '', datetime('now'), datetime('now')
);
INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective, priority,
  delivery, channel_tier, email_delivery_policy, cooldown, suppression, source_workbook,
  attention_class, candidate_score, guaranteed_experience, batch_eligible,
  runtime_memory_dependency, attention_queue_group, rotation_group, timing,
  merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences,
  template_id, change_notes, scenario_id, created_at, updated_at
) VALUES (
  'CI-MANU-007', 'Manual', 'Seedling Spotlight Broadcast',
  'Admin triggers spotlight broadcast linking directly to a specific Seedling campaign', 'All Users (excluding Admins), or targeted segment', 'Spotlight a critical or urgent Seedling campaign', 'High',
  'Push + In-App', 'Tier 1 - Guaranteed', 'Push + In-App, always. Email only when push can''t reach the user (no app installed). Never SMS.', '24 hours',
  'Suppress competing manual pushes', 'Hand-authored - Seedling Spotlight admin broadcast', 'Interruptive', '80',
  'Yes', 'No', 'LastPush',
  'Manual Broadcast', '', 'Immediate', 'No',
  'Deliver because an admin sent Seedling Spotlight Broadcast.', 'Opportunity', 'LastPush',
  'Deliver because an admin sent Seedling Spotlight Broadcast.', 'All Users (excluding Admins)', '',
  'TPL-CI-MANU-007', '', '', datetime('now'), datetime('now')
);

UPDATE scenarios SET rule_id = 'CI-CONTR-030' WHERE id = 'ce-17' OR key = 'CONTRIB-17';
UPDATE scenarios SET rule_id = 'CI-CONTR-031' WHERE id = 'ce-18' OR key = 'CONTRIB-18';
UPDATE scenarios SET rule_id = 'CI-CONTR-029' WHERE id = 'ce-19' OR key = 'CONTRIB-19';
