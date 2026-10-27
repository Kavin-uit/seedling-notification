import json
import subprocess
import os

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_SQL = os.path.join(PROJECT_DIR, 'd1', 'load_grounds_crew_rules_and_scenarios.sql')

# Load rules from node data
res = subprocess.check_output(
    ["node", "-e", "import('./src/data/notificationRules.ts').then(m => console.log(JSON.stringify(m.ALL_NOTIFICATION_RULES)))"],
    cwd=PROJECT_DIR
)
all_rules = json.loads(res)
rules_map = {r["ruleId"]: r for r in all_rules}

# Get remote rules to know which are missing
res_remote = subprocess.check_output(
    ["npx", "wrangler", "d1", "execute", "seedling-notifications-db", "--remote", "--command=SELECT rule_id FROM notification_rules", "--json"],
    cwd=PROJECT_DIR
)
remote_data = json.loads(res_remote)
remote_rules = set(row["rule_id"] for row in remote_data[0]["results"])

missing_rules = [r for r in all_rules if r["ruleId"] not in remote_rules]
print(f"Total missing rules to insert into notification_rules: {len(missing_rules)}")

def esc(val):
    if val is None:
        return ""
    return str(val).replace("'", "''")

statements = []
statements.append("-- 1. Update engine_sheets with latest Contribution Engine Sheet URL")
statements.append("""UPDATE engine_sheets 
SET sheet_url = 'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/edit?usp=sharing&ouid=102314279700789110504&rtpof=true&sd=true',
    csv_export_url = 'https://docs.google.com/spreadsheets/d/1AtbvUxwJMRP4C4HxWFtPqEFnsx_EsocC/export?format=csv',
    updated_at = datetime('now')
WHERE engine_category = 'Contribution';""")

statements.append("\n-- 2. Insert missing notification rules (including CI-CONTR-029, 030, 031)")
for r in missing_rules:
    stmt = f"""INSERT OR REPLACE INTO notification_rules (
  rule_id, engine, rule_name, trigger, audience, communication_objective,
  priority, delivery, channel_tier, email_delivery_policy, cooldown, suppression,
  source_workbook, attention_class, candidate_score, guaranteed_experience,
  batch_eligible, runtime_memory_dependency, attention_queue_group, rotation_group,
  timing, merge_policy, default_decision_reason, experience_type, memory_keys,
  decision_reason_template, candidate_audiences, candidate_experiences, template_id,
  change_notes, created_at, updated_at
) VALUES (
  '{esc(r.get("ruleId"))}', '{esc(r.get("engine"))}', '{esc(r.get("ruleName"))}', '{esc(r.get("trigger"))}', '{esc(r.get("audience"))}', '{esc(r.get("communicationObjective"))}',
  '{esc(r.get("priority"))}', '{esc(r.get("delivery"))}', '{esc(r.get("channelTier"))}', '{esc(r.get("emailDeliveryPolicy"))}', '{esc(r.get("cooldown"))}', '{esc(r.get("suppression"))}',
  '{esc(r.get("sourceWorkbook"))}', '{esc(r.get("attentionClass"))}', '{esc(r.get("candidateScore"))}', '{esc(r.get("guaranteedExperience"))}',
  '{esc(r.get("batchEligible"))}', '{esc(r.get("runtimeMemoryDependency"))}', '{esc(r.get("attentionQueueGroup"))}', '{esc(r.get("rotationGroup"))}',
  '{esc(r.get("timing"))}', '{esc(r.get("mergePolicy"))}', '{esc(r.get("defaultDecisionReason"))}', '{esc(r.get("experienceType"))}', '{esc(r.get("memoryKeys"))}',
  '{esc(r.get("decisionReasonTemplate"))}', '{esc(r.get("candidateAudiences"))}', '{esc(r.get("candidateExperiences"))}', '{esc(r.get("templateId"))}',
  '{esc(r.get("changeNotes"))}', datetime('now'), datetime('now')
);"""
    statements.append(stmt)

statements.append("\n-- 3. Insert or Replace the 3 Target Scenarios in scenarios table")

# ce-17: Grounds Crew Enrollment Confirmed
ce_17_email = """Welcome to The Grounds Crew! You've made generosity a habit, and your first gift is already at work. Your (Amount) gift today is supporting (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5).

Each time a new set of 5 Picks to Click launches, your donation to Seedling Social Giving goes out and is regranted among those 5 Picks -- hand-picked Seedlings that deserve a boost -- no more than once per calendar month, and we'll send you one note each time so you always know what you're growing. [IF NEXT BATCH DATE ANNOUNCED] The next Picks launch on (Next Batch Date), so your next gift goes out then.

YOUR ENROLLMENT: Gift amount: (Amount). Funding source: (Card ending #### | GreenHouse balance). First contribution: today. Your contribution is charged when each new set of 5 Picks to Click launches. New Picks launch no more than once per calendar month, so you'll never be charged more than once in a calendar month. If no new Picks launch in a month, you won't be charged that month. You can change your amount or funding source, pause, or cancel anytime in the app under The Grounds Crew, or email support@seedlingsocial.org.  BOX: Meet Your Picks

Add the card/ACH or GreenHouse closing from Support All 5 Gift Made."""

stmt_ce_17 = f"""INSERT OR REPLACE INTO scenarios (
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
  '{esc(ce_17_email)}',
  'Welcome to The Grounds Crew! Your first gift is supporting this batch''s 5 Picks. You''ll be charged (Amount) each time new Picks launch, no more than once per calendar month. Manage or cancel anytime in the app under The Grounds Crew.  BOX: Meet Your Picks',
  'take user to Grounds Crew hub (current 5 Picks, amounts, membership settings incl. cancel)',
  '',
  'TO DO',
  'High',
  'STAGING',
  'CI-CONTR-030',
  datetime('now'),
  datetime('now')
);"""
statements.append(stmt_ce_17)

# ce-18: Grounds Crew Batch Gift Processed
ce_18_email = """New Picks are here, and your (Amount) Grounds Crew gift just went out to support them.

[IF LAST BATCH RESULTS ENTERED] WHAT THE LAST BATCH GREW: Together the Crew gave (Crew Total Last Batch) to (Last Seedling 1), (Last Seedling 2), (Last Seedling 3), (Last Seedling 4), and (Last Seedling 5). [One result line per Seedling, e.g. (Last Seedling 1) reached (Percent) of its goal.]

MEET YOUR 5 NEW PICKS: (Seedling 1) for (Nonprofit 1) -- (One-line description). [Repeat for Seedlings 2-5.]

Since joining, you've helped (Count) Seedlings grow across (Crew Gift Count) Grounds Crew gifts. Your next gift goes out when the next set of Picks launches, no more than once per calendar month.  BOX: Meet the Picks   BOX: Share This Batch

[IF CREW MILESTONE] Opening line: The Grounds Crew just passed (Milestone) given, all time. You're part of every dollar.
[IF NO LAST BATCH RESULTS ENTERED, OR FIRST BATCH DAY SINCE ENROLLMENT] Skip WHAT THE LAST BATCH GREW; open with: Your second Grounds Crew gift just went out to 5 brand-new Picks.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds to your GreenHouse, so no new acknowledgment is issued. GreenHouse balance remaining: (Balance).

[IF THIS GIFT TRIGGERED AUTO-REPLENISH -- required notice, ToS 4.3] AUTO-REPLENISH CHARGE: (Replenish Amount) was charged to (Card ending ####) on (Date) to refill your GreenHouse. This is a new donation to Seedling Social Giving; your acknowledgment is saved in your giving history. Change or turn off Auto-Replenish anytime in GreenHouse settings.  BOX: Meet the New Picks"""

stmt_ce_18 = f"""INSERT OR REPLACE INTO scenarios (
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
  '{esc(ce_18_email)}',
  'Your Grounds Crew gift is now supporting the 5 new Picks to Click. Last batch the Crew grew 5 Seedlings, and you''ve helped (Count) Seedlings grow.  BOX: Meet the Picks',
  'take user to video intro of the new Picks first, then the Grounds Crew hub listing the 5 Picks; Share opens the share card with the member''s personal tracked link',
  '',
  'TO DO',
  'High',
  'STAGING',
  'CI-CONTR-031',
  datetime('now'),
  datetime('now')
);"""
statements.append(stmt_ce_18)

# ce-19: Support All 5 Gift Made
ce_19_email = """Thank you! Your gift of (Amount) is supporting all 5 of (this week's / this month's) Picks to Click: (Seedling 1), (Seedling 2), (Seedling 3), (Seedling 4), and (Seedling 5). Five causes, one generous act -- and every one of them is closer to its goal because of you.

[CARD/ACH-FUNDED closing] Your donation acknowledgment from Seedling Social Giving is saved in your giving history and will be included in your year-end giving summary.

[GREENHOUSE-FUNDED closing] This gift is a grant recommendation from your GreenHouse -- your donation to Seedling Social Giving was already recorded when you added those funds on (Deposit Date), so no new acknowledgment is issued.  BOX: See Your Impact"""

ce_19_in_app = "Thank you! Your gift is supporting all 5 Picks to Click -- five Seedlings are closer to their goals, and that's 5 donations toward your next badge! [GREENHOUSE] Sent from your GreenHouse.  BOX: See Your Impact   |   Secondary line (non-members only): Want to do this every month automatically? Join The Grounds Crew.  BOX: Join The Grounds Crew"

stmt_ce_19 = f"""INSERT OR REPLACE INTO scenarios (
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
  '{esc(ce_19_email)}',
  '{esc(ce_19_in_app)}',
  'take user to Support all 5 impact summary (all 5 Seedlings with amounts, progress bars, and any badges/goals this gift unlocked)',
  '',
  'TO DO',
  'High',
  'STAGING',
  'CI-CONTR-029',
  datetime('now'),
  datetime('now')
);"""
statements.append(stmt_ce_19)

statements.append("\n-- 4. Insert or Replace into production_notifications table")
stmt_prod_29 = f"""INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-029', 'ce-19', 'PROD-CONTRIB-19', 'Contribution', 'Support All 5 Gift Made',
  'Donor completes a Support all 5 gift (all 5 recommendations recorded under one parent_gift_id)', 'Donor (parent/guardian for family accounts)',
  'Thank donor once for the whole gift and show five-fold impact', 'Positive moment; explore The Grounds Crew',
  'You just supported all 5! 💚', 'Your gift is supporting all 5 Picks to Click -- five Seedlings just moved closer to their goals. Thank you!',
  'You Just Supported All 5! 💚', '{esc(ce_19_email)}', '{esc(ce_19_in_app)}',
  'take user to Support all 5 impact summary (all 5 Seedlings with amounts, progress bars, and any badges/goals this gift unlocked)',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-029',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-029', datetime('now'), datetime('now'), datetime('now')
);"""
statements.append(stmt_prod_29)

stmt_prod_30 = f"""INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-030', 'ce-17', 'PROD-CONTRIB-17', 'Contribution', 'Grounds Crew Enrollment Confirmed',
  'Donor enrolls in The Grounds Crew (if the first contribution processes the same day, it is included in this message)', 'Donor (parent/guardian for family accounts)',
  'Welcome the new member and deliver the enrollment confirmation required by ToS 4.4 (contribution amount, first charge at enrollment, charged each time a new batch launches -- no more than once per calendar month -- until cancelled, how to cancel)', 'Stay enrolled; meet the Picks',
  'Welcome to The Grounds Crew! 🌱', 'You''re on The Grounds Crew! Your first gift is already supporting this batch''s 5 Picks to Click.',
  'Welcome to The Grounds Crew! 🌱', '{esc(ce_17_email)}',
  'Welcome to The Grounds Crew! Your first gift is supporting this batch''s 5 Picks. You''ll be charged (Amount) each time new Picks launch, no more than once per calendar month. Manage or cancel anytime in the app under The Grounds Crew.  BOX: Meet Your Picks',
  'take user to Grounds Crew hub (current 5 Picks, amounts, membership settings incl. cancel)',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-030',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-030', datetime('now'), datetime('now'), datetime('now')
);"""
statements.append(stmt_prod_30)

stmt_prod_31 = f"""INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  'prod-ci-contr-031', 'ce-18', 'PROD-CONTRIB-18', 'Contribution', 'Grounds Crew Batch Gift Processed',
  'New Picks batch released AND the member''s Grounds Crew charge for that batch processed (card charge succeeds or GreenHouse balance applied)', 'Donor (Grounds Crew member)',
  'Confirm the gift once, celebrate what the last batch grew, and introduce the new Picks', 'Open app to meet new Picks; stay enrolled; share',
  'Your Grounds Crew gift is out 💚', 'Your Grounds Crew gift is out! The Crew grew 5 Seedlings last batch. Come meet your 5 new Picks.   [IF AUTO-REPLENISH CHARGED] Your Grounds Crew gift is out, and Auto-Replenish added (Replenish Amount) to your GreenHouse.',
  'Your Grounds Crew Gift Is Out: Meet Your New Picks 💚', '{esc(ce_18_email)}',
  'Your Grounds Crew gift is now supporting the 5 new Picks to Click. Last batch the Crew grew 5 Seedlings, and you''ve helped (Count) Seedlings grow.  BOX: Meet the Picks',
  'take user to video intro of the new Picks first, then the Grounds Crew hub listing the 5 Picks; Share opens the share card with the member''s personal tracked link',
  'Production Ready clone verified for production release.', 'Cloned from rule CI-CONTR-031',
  'READY FOR PROD', 'High', 'PROD', 'CI-CONTR-031', datetime('now'), datetime('now'), datetime('now')
);"""
statements.append(stmt_prod_31)

with open(OUTPUT_SQL, "w") as f:
    f.write("\n\n".join(statements) + "\n")

print(f"Generated {OUTPUT_SQL} with {len(statements)} sections.")
