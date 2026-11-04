import json
import subprocess
import os

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_SQL = os.path.join(PROJECT_DIR, 'd1', 'load_opportunity_rules_and_scenarios.sql')
ADD_SCENARIOS_SQL = os.path.join(PROJECT_DIR, 'd1', 'add_opportunity_scenarios.sql')

# Load rules from node data
res = subprocess.check_output(
    ["node", "-e", "import('./src/data/notificationRules.ts').then(m => console.log(JSON.stringify(m.ALL_NOTIFICATION_RULES)))"],
    cwd=PROJECT_DIR
)
all_rules = json.loads(res)
rules_map = {r["ruleId"]: r for r in all_rules}

target_rule_ids = ['CI-OPP-171', 'CI-OPP-172', 'CI-OPP-173', 'CI-OPP-174']

def esc(val):
    if val is None:
        return ""
    return str(val).replace("'", "''")

statements = []
statements.append("-- 1. Ensure Opportunity Engine Sheet is properly registered in engine_sheets")
statements.append("""INSERT OR REPLACE INTO engine_sheets (
  engine_category, sheet_name, sheet_url, csv_export_url, enabled, created_at, updated_at
) VALUES (
  'Opportunity',
  'Opportunity Content Sheet',
  'https://docs.google.com/spreadsheets/d/1jD0q7YXiHRo6BAp64F36n6kE48xWonvZ/edit?gid=659053223#gid=659053223',
  'https://docs.google.com/spreadsheets/d/1jD0q7YXiHRo6BAp64F36n6kE48xWonvZ/export?format=csv&gid=659053223',
  1,
  datetime('now'),
  datetime('now')
);""")

statements.append("\n-- 2. Insert or Replace the 4 Target Notification Rules into notification_rules")
for r_id in target_rule_ids:
    r = rules_map.get(r_id)
    if not r:
        raise ValueError(f"Rule {r_id} not found in notificationRules.ts")
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

scenarios_data = [
    {
        "id": "opp-171",
        "key": "OPP-171",
        "engine_category": "Opportunity",
        "governance_event": "Follower Supported All 5",
        "trigger": "Follower completes Support all 5",
        "audience": "Connected users",
        "communication_objective": "Leverage social proof; promote Support all 5",
        "desired_outcome": "Support all 5",
        "push_subject": "(Name) supported all 5! 💚",
        "push_body": "(Name), who follows you, just supported all 5 Picks to Click -- check them out.",
        "email_subject": "(Name) Supported All 5 Picks 💚",
        "email_body": "(Name), who follows you, just supported all 5 of (this week's / this month's) Picks to Click. Take a look at the five Seedlings they helped grow -- you can support all 5 with one tap, too.  BOX: View the Picks",
        "in_app_experience": "",
        "cta": "take user to Picks to Click list with Support all 5 button",
        "comments": "",
        "status": "TO DO",
        "priority": "Medium",
        "environment": "STAGING",
        "rule_id": "CI-OPP-171"
    },
    {
        "id": "opp-172",
        "key": "OPP-172",
        "engine_category": "Opportunity",
        "governance_event": "Followed Supported All 5",
        "trigger": "Followed user completes Support all 5",
        "audience": "Connected users",
        "communication_objective": "Leverage social proof; promote Support all 5",
        "desired_outcome": "Support all 5",
        "push_subject": "(Name) supported all 5! 💚",
        "push_body": "(Name), whom you follow, just supported all 5 Picks to Click -- check them out.",
        "email_subject": "(Name) Supported All 5 Picks 💚",
        "email_body": "(Name), whom you follow, just supported all 5 of (this week's / this month's) Picks to Click. Take a look at the five Seedlings they helped grow -- you can support all 5 with one tap, too.  BOX: View the Picks",
        "in_app_experience": "",
        "cta": "take user to Picks to Click list with Support all 5 button",
        "comments": "",
        "status": "TO DO",
        "priority": "Medium",
        "environment": "STAGING",
        "rule_id": "CI-OPP-172"
    },
    {
        "id": "opp-173",
        "key": "OPP-173",
        "engine_category": "Opportunity",
        "governance_event": "Follower Joined The Grounds Crew",
        "trigger": "Follower enrolls in The Grounds Crew",
        "audience": "Connected users",
        "communication_objective": "Leverage social proof; promote The Grounds Crew",
        "desired_outcome": "Join The Grounds Crew",
        "push_subject": "(Name) joined The Grounds Crew 🌱",
        "push_body": "(Name), who follows you, just joined The Grounds Crew -- supporting 5 Picks to Click every month.",
        "email_subject": "(Name) Joined The Grounds Crew 🌱",
        "email_body": "(Name), who follows you, just joined The Grounds Crew, supporting this month's 5 Picks to Click -- and next month's, and the month after. Join them and make generosity a monthly habit.  BOX: Learn About The Grounds Crew",
        "in_app_experience": "",
        "cta": "take user to The Grounds Crew page",
        "comments": "",
        "status": "TO DO",
        "priority": "Medium",
        "environment": "STAGING",
        "rule_id": "CI-OPP-173"
    },
    {
        "id": "opp-174",
        "key": "OPP-174",
        "engine_category": "Opportunity",
        "governance_event": "Followed Joined The Grounds Crew",
        "trigger": "Followed user enrolls in The Grounds Crew",
        "audience": "Connected users",
        "communication_objective": "Leverage social proof; promote The Grounds Crew",
        "desired_outcome": "Join The Grounds Crew",
        "push_subject": "(Name) joined The Grounds Crew 🌱",
        "push_body": "(Name), whom you follow, just joined The Grounds Crew -- supporting 5 Picks to Click every month.",
        "email_subject": "(Name) Joined The Grounds Crew 🌱",
        "email_body": "(Name), whom you follow, just joined The Grounds Crew, supporting this month's 5 Picks to Click -- and next month's, and the month after. Join them and make generosity a monthly habit.  BOX: Learn About The Grounds Crew",
        "in_app_experience": "",
        "cta": "take user to The Grounds Crew page",
        "comments": "",
        "status": "TO DO",
        "priority": "Medium",
        "environment": "STAGING",
        "rule_id": "CI-OPP-174"
    }
]

scenario_stmts = []
statements.append("\n-- 3. Insert or Replace the 4 Target Scenarios in scenarios table")
for sc in scenarios_data:
    stmt = f"""INSERT OR REPLACE INTO scenarios (
  id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments,
  status, priority, environment, rule_id, created_at, updated_at
) VALUES (
  '{esc(sc["id"])}',
  '{esc(sc["key"])}',
  '{esc(sc["engine_category"])}',
  '{esc(sc["governance_event"])}',
  '{esc(sc["trigger"])}',
  '{esc(sc["audience"])}',
  '{esc(sc["communication_objective"])}',
  '{esc(sc["desired_outcome"])}',
  '{esc(sc["push_subject"])}',
  '{esc(sc["push_body"])}',
  '{esc(sc["email_subject"])}',
  '{esc(sc["email_body"])}',
  '{esc(sc["in_app_experience"])}',
  '{esc(sc["cta"])}',
  '{esc(sc["comments"])}',
  '{esc(sc["status"])}',
  '{esc(sc["priority"])}',
  '{esc(sc["environment"])}',
  '{esc(sc["rule_id"])}',
  datetime('now'),
  datetime('now')
);"""
    statements.append(stmt)
    scenario_stmts.append(stmt)

statements.append("\n-- 4. Insert or Replace into production_notifications table")
for sc in scenarios_data:
    prod_id = f"prod-{sc['rule_id'].lower()}"
    prod_key = f"PROD-{sc['key']}"
    stmt_prod = f"""INSERT OR REPLACE INTO production_notifications (
  id, original_scenario_id, key, engine_category, governance_event, trigger, audience,
  communication_objective, desired_outcome, push_subject, push_body,
  email_subject, email_body, in_app_experience, cta, comments, notes,
  status, priority, environment, rule_id, cloned_at, created_at, updated_at
) VALUES (
  '{prod_id}', '{esc(sc["id"])}', '{prod_key}', '{esc(sc["engine_category"])}', '{esc(sc["governance_event"])}',
  '{esc(sc["trigger"])}', '{esc(sc["audience"])}',
  '{esc(sc["communication_objective"])}', '{esc(sc["desired_outcome"])}',
  '{esc(sc["push_subject"])}', '{esc(sc["push_body"])}',
  '{esc(sc["email_subject"])}', '{esc(sc["email_body"])}', '{esc(sc["in_app_experience"])}',
  '{esc(sc["cta"])}',
  'Production Ready clone verified for production release.', 'Cloned from rule {esc(sc["rule_id"])}',
  'READY FOR PROD', '{esc(sc["priority"])}', 'PROD', '{esc(sc["rule_id"])}', datetime('now'), datetime('now'), datetime('now')
);"""
    statements.append(stmt_prod)

with open(OUTPUT_SQL, "w") as f:
    f.write("\n\n".join(statements) + "\n")

with open(ADD_SCENARIOS_SQL, "w") as f:
    f.write("-- Add 4 new Opportunity Engine scenarios\n" + "\n\n".join(scenario_stmts) + "\n")

print(f"Generated {OUTPUT_SQL} and {ADD_SCENARIOS_SQL} successfully.")

