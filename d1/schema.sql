-- Cloudflare D1 Database Schema for Seedling Notification Scenarios
-- Production Edge SQLite Database

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
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_scenarios_engine ON scenarios(engine_category);
CREATE INDEX IF NOT EXISTS idx_scenarios_status ON scenarios(status);

-- Seed initial 20 scenarios
INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-1', 'GOV-1', 'Governance', 'Seedling Submitted for Review',
  'Seedling Submitted', 'Sponsor, Co-Sponsors', 'Acknowledge submission',
  'Review Seedling', 'Your Seedling is in review', 'Your Seedling is in Review',
  'Your Seedling Is in Review', 'Thanks for submitting your Seedling! Our team is reviewing it now, and we''ll let you know as soon as it''s ready to go live.  BOX: View Status',
  'Thanks! Your Seedling has been submitted for review -- once we have completed our review we''ll let you know!',
  'take user to Seedling review status', 'TO DO', 'High', 'STAGING',
  '2026-09-18T09:00:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-2', 'GOV-2', 'Governance', 'Seedling Approved',
  'Seedling Approved', 'Sponsor, Co-Sponsors', 'Acknowledge Acceptance',
  'Post Seedling', 'You''re live! 🎉', 'Congratulations -- your Seedling is Live!',
  'You''re Live! 🎉', 'Great news -- your Seedling has been approved and is now live on Seedling. Now''s the time to start sharing it with your community and inviting support.  BOX: Share Your Seedling',
  'Your Seedling has been approved and is now live on Seedling. Time to start sharing it with your community.  BOX: Share',
  'take user directly to Seedling', 'TO DO', 'Highest', 'STAGING',
  '2026-09-18T09:15:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-3', 'GOV-3', 'Governance', 'Seedling Rejected',
  'Seedling Rejected', 'Sponsor, Co-Sponsors', 'Explain decision',
  'Modify Seedling', 'Your Seedling needs a change', 'We couldn''t publish your Seedling -- Here''s why',
  'Your Seedling Needs a Change', 'We weren''t able to publish your Seedling because it doesn''t currently meet our community guidelines. Review the reason we''ve provided, make the needed changes, and reach out to support if you have questions.  BOX: Edit Seedling',
  'Your Seedling doesn''t meet our community guidelines. Review the reason provided and contact support if you have questions.',
  'take user to Seedling edit screen with rejection reason', 'TO DO', 'High', 'DEV',
  '2026-09-18T09:30:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-4', 'GOV-4', 'Governance', 'Comment Reported',
  'Comment Flagged by user', 'Reporter', 'Acknowledge report',
  'Review Comment', 'Thanks for the report', 'Thank you for reporting a Seedling comment',
  'Thanks for the Report', 'Thanks for helping keep Seedling welcoming. We''ll review the comment you reported, and if it merits removal, we''ll take care of it.',
  'Thanks for helping keep Seedling welcoming. We''ll review the reported comment and if it merits removal we will do so.',
  'confirm in place, no navigation required', 'TO DO', 'Medium', 'STAGING',
  '2026-09-19T10:00:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-5', 'GOV-5', 'Governance', 'Comment Removed',
  'Comment Removed', 'Commenter', 'Notify author',
  'Comment removed', 'A comment was removed', 'One of your comments has been removed.',
  'A Comment Was Removed', 'One of your comments has been removed because it violated our Community Guidelines. Take a look at our guidelines if you have questions.  BOX: View Guidelines',
  'We removed one of your comments because it violated our Community Guidelines.',
  'take user to Community Guidelines', 'TO DO', 'High', 'PROD',
  '2026-09-19T10:15:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-6', 'GOV-6', 'Governance', 'Comment Removed',
  'Comment Removed', 'Reporter', 'Close the loop on report',
  'Confirm resolution', 'Update on your report', 'Thanks for helping keep Seedling welcoming.',
  'Update on Your Report', 'Thanks for helping keep Seedling welcoming. The comment you reported has been removed for violating our Community Guidelines.',
  'The comment you reported has been removed for violating our Community Guidelines.',
  'confirm in place, no navigation required', 'TO DO', 'Low', 'STAGING',
  '2026-09-19T11:00:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-7', 'GOV-7', 'Governance', 'Account Warning',
  'Offending activity', 'Commenter', 'Policy warning',
  'Warning', 'A notice about your account', 'Important notice about your account.',
  'A Notice About Your Account', 'Your recent activity may violate our Community Guidelines. Please take a moment to review our policies so your account stays in good standing.  BOX: View Guidelines',
  'Your recent activity may violate our Community Guidelines. Please review our policies.',
  'take user to Community Guidelines', 'TO DO', 'High', 'STAGING',
  '2026-09-20T10:00:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-8', 'GOV-8', 'Governance', 'Temporary Account Restriction',
  'Offending issue', 'Commenter', 'Notify restriction',
  'Restricted use', 'Your account is temporarily restricted', 'Your account has been temporarily restricted.',
  'Your Account Is Temporarily Restricted', 'Your account has been temporarily restricted while we review recent activity. Some features will be unavailable in the meantime.  BOX: View Account Status',
  'Some account features are temporarily unavailable while we review your account.',
  'take user to account status page', 'TO DO', 'Highest', 'STAGING',
  '2026-09-20T10:15:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'gov-9', 'GOV-9', 'Governance', 'Account Restored',
  'Account reinstated', 'Commenter', 'Notify restoration',
  'Full use', 'Welcome back! ✅', 'Your account has been restored.',
  'Welcome Back! ✅', 'Thank you for your patience -- your account has been restored and is fully active again. We''re glad to have you back.  BOX: View Account',
  'Thank you for your patience. Your account is fully active again.',
  'take user to account settings', 'TO DO', 'Medium', 'STAGING',
  '2026-09-20T10:30:00Z', '2026-09-22T12:00:00Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-1', 'CONTRIB-1', 'Contribution', 'Donation Made via Credit/Debit Card',
  'Donor makes donation', 'Donor', 'Thank donor',
  'Positive moment', 'Thank you! 💚', 'Your donation moved (Seedling) one step closer to its goal -- thank you!',
  'Thank You! 💚', 'Thank you! Your donation moved (Seedling) one step closer to its goal. Every gift counts, and yours just made a real difference.  BOX: View Donation', 'Your donation is complete -- (Seedling) is one step closer to its goal. Thank you!',
  'take user directly to Seedling', 'TO DO', 'High', 'STAGING',
  '2026-09-20T01:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-2', 'CONTRIB-2', 'Contribution', 'ACH Donation Confirmed',
  'Funds settled', 'Donor', 'Build trust',
  'Retain confidence', 'Your ACH donation is confirmed ✅', 'Your ACH donation has been confirmed.',
  'Your ACH Donation Is Confirmed ✅', 'Your ACH payment has fully processed and your donation is complete. Thank you for growing good.  BOX: View Donation', 'Your ACH payment has fully processed and your donation is complete.',
  'take user to donation details', 'TO DO', 'Medium', 'STAGING',
  '2026-09-20T02:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-3', 'CONTRIB-3', 'Contribution', 'ACH Donation Failed',
  'Payment declined', 'Donor', 'Resolve issue',
  'Retry donation', 'We hit a snag with your donation', 'We couldn''t process your ACH donation.',
  'We Hit a Snag With Your Donation', 'We weren''t able to process your ACH donation. Please update your payment method or try again so your gift can go through.  BOX: Update Payment', 'Your ACH payment didn''t go through -- please update your payment method or try again.',
  'take user to payment method update screen', 'TO DO', 'Highest', 'STAGING',
  '2026-09-20T03:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-4', 'CONTRIB-4', 'Contribution', 'ACH Donation Pending',
  'ACH or delayed payment', 'Donor', 'Set expectations',
  'Await settlement', 'Your donation is on its way', 'Your ACH donation is being processed.',
  'Your Donation Is on Its Way', 'Your ACH payment is on its way. We''ll let you know as soon as it''s confirmed -- no action needed in the meantime.  BOX: View Status', 'Your ACH payment is on its way. We''ll let you know as soon as it''s confirmed.',
  'take user to donation status', 'TO DO', 'Medium', 'STAGING',
  '2026-09-20T04:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-5', 'CONTRIB-5', 'Contribution', 'Donation Receipt Available',
  'Receipt generated', 'Donor', 'Provide documentation',
  'Download receipt', 'Your receipt is ready 🧾', 'Your donation receipt is ready.',
  'Your Receipt Is Ready 🧾', 'Your donation receipt is ready whenever you need it. Download or email it for your records anytime.  BOX: View Receipt', 'Download or email your official donation receipt anytime.  BOX: View Receipt',
  'take user to donation receipt', 'TO DO', 'High', 'STAGING',
  '2026-09-20T05:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-6', 'CONTRIB-6', 'Contribution', 'GreenHouse Auto-Reload',
  'Automatic funding', 'User', 'Maintain balance',
  'Continue giving', 'Your GreenHouse is topped up', 'Your GreenHouse was automatically refilled.',
  'Your GreenHouse Is Topped Up', 'Your GreenHouse balance has been automatically replenished, so you''re ready for your next act of generosity whenever inspiration strikes.  BOX: View GreenHouse', 'Your GreenHouse balance has been replenished so you''re ready for your next act of generosity.',
  'take user to GreenHouse balance', 'TO DO', 'Medium', 'STAGING',
  '2026-09-20T06:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-7', 'CONTRIB-7', 'Contribution', 'GreenHouse Auto-Reload Failed',
  'Auto reload unsuccessful', 'User', 'Resolve payment',
  'Update funding source', 'We couldn''t refill your GreenHouse', 'We couldn''t refill your GreenHouse.',
  'We Couldn''t Refill Your GreenHouse', 'Your GreenHouse auto-reload didn''t go through. Update your funding source to keep your GreenHouse topped up and ready to give.  BOX: Update Funding Source', 'Your GreenHouse auto-reload didn''t go through. Update your funding source to keep your GreenHouse topped up.  BOX: Update Funding Source',
  'take user to GreenHouse reload process', 'TO DO', 'Highest', 'STAGING',
  '2026-09-20T07:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-8', 'CONTRIB-8', 'Contribution', 'GreenHouse Balance Low',
  'Threshold reached', 'User', 'Encourage refill',
  'Add funds', 'Your GreenHouse is running low', 'Your GreenHouse balance is running low.',
  'Your GreenHouse Is Running Low', 'Your GreenHouse balance is running low. Add funds so you''re ready for your next donation whenever the moment strikes.  BOX: Add Funds', 'Your GreenHouse balance is running low. Add funds so you''re ready for your next donation.  BOX: Add Funds',
  'take user to GreenHouse', 'TO DO', 'High', 'STAGING',
  '2026-09-20T08:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-9', 'CONTRIB-9', 'Contribution', 'GreenHouse Balance Low Auto Reload',
  'Threshold reached', 'User', 'Encourage refill',
  'Add funds', 'Your GreenHouse is running low', 'Your GreenHouse balance is running low and will be re-loaded based on your preferences.',
  'Your GreenHouse Is Running Low', 'Your GreenHouse balance is running low. Based on your preferences, it''ll be topped up automatically -- no action needed on your part.  BOX: View GreenHouse', 'Your GreenHouse balance is running low. Based on your auto-reload preferences, it''ll be topped up automatically -- no action needed.',
  'take user to GreenHouse', 'TO DO', 'High', 'STAGING',
  '2026-09-20T09:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-10', 'CONTRIB-10', 'Contribution', 'GreenHouse Deposit Added',
  'Funds deposited', 'User', 'Confirm balance',
  'Use GreenHouse', 'Funds added! 💰', 'You''ve added funds to your GreenHouse.',
  'Funds Added! 💰', 'Your funds have been added to your GreenHouse and are ready to donate whenever inspiration strikes.  BOX: View GreenHouse', 'Your funds have been added to your GreenHouse and are ready to donate whenever inspiration strikes.',
  'take user to GreenHouse', 'TO DO', 'High', 'STAGING',
  '2026-09-20T10:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-11', 'CONTRIB-11', 'Contribution', 'GreenHouse Donation Made',
  'Donation from balance', 'User', 'Confirm transaction',
  'Continue giving', 'Donation sent from your GreenHouse', 'Your donation was sent from your GreenHouse.',
  'Donation Sent From Your GreenHouse', 'Your donation was sent using your GreenHouse balance. Thank you for growing good.  BOX: View Donation', 'Your donation was sent using your GreenHouse balance. Thank you for Growing Good.',
  'take user directly to Seedling', 'TO DO', 'High', 'STAGING',
  '2026-09-20T11:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-12', 'CONTRIB-12', 'Contribution', 'Payment Method Added',
  'New payment method', 'User', 'Confirm setup',
  'Complete donation', 'Payment method added ✅', 'Payment method added successfully.',
  'Payment Method Added ✅', 'Your new payment method has been added successfully and is ready for future donations.  BOX: View Payment Methods', 'Your new payment method is ready for future donations.',
  'take user to payment methods', 'TO DO', 'Medium', 'STAGING',
  '2026-09-20T12:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-13', 'CONTRIB-13', 'Contribution', 'Payment Method Expiring',
  'Card nearing expiration', 'Donor', 'Prevent failed payments',
  'Update payment', 'Your card is expiring soon', 'Your payment method expires soon.',
  'Your Card Is Expiring Soon', 'Your payment method expires soon. Update it now to avoid any interruption to your giving.  BOX: Update Payment', 'Update your payment information to avoid interrupted giving.',
  'take user to payment method update screen', 'TO DO', 'High', 'STAGING',
  '2026-09-20T13:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-14', 'CONTRIB-14', 'Contribution', 'Payment Method Preferences Updated',
  'Giving settings changed', 'Donor', 'Confirm preferences',
  'Maintain trust', 'Preferences updated', 'Payment preferences updated.',
  'Preferences Updated', 'Your preferred payment settings have been saved exactly the way you wanted.  BOX: View Preferences', 'Your preferred payment settings have been saved.',
  'take user to payment preferences', 'TO DO', 'Low', 'STAGING',
  '2026-09-20T14:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-15', 'CONTRIB-15', 'Contribution', 'Payment Method Updated',
  'Payment details changed', 'Donor', 'Confirm update',
  'Maintain continuity', 'Payment method updated', 'Your payment method has been updated.',
  'Payment Method Updated', 'Your payment method has been updated. Your changes have been saved and are ready to use.  BOX: View Payment Methods', 'Your changes have been saved and are ready to use.',
  'take user to payment methods', 'TO DO', 'Medium', 'STAGING',
  '2026-09-20T15:00:00Z', '2026-09-21T08:04:09.486Z'
);

INSERT OR IGNORE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, status,
  priority, environment, created_at, updated_at
) VALUES (
  'ce-16', 'CONTRIB-16', 'Contribution', 'Receipt Downloaded',
  'Receipt accessed', 'Donor', 'Confirm access',
  'Retain records', 'Receipt downloaded', 'Receipt downloaded.',
  'Receipt Downloaded', 'Your donation receipt has been downloaded successfully and is ready for your records.', 'Your donation receipt has been downloaded successfully.',
  'confirm in place, no navigation required', 'TO DO', 'Low', 'STAGING',
  '2026-09-20T16:00:00Z', '2026-09-21T08:04:09.486Z'
);

