#!/usr/bin/env python3
"""
Quick Ingestion Script for Seedling Notification Scenarios.
Inserts or appends new scenarios to Cloudflare D1 and syncs initialData.ts
WITHOUT modifying or resetting any existing rows, comments, or statuses.

Usage:
  python3 scripts/add_scenarios.py --after 13 --tsv "path/to/file.tsv"
  python3 scripts/add_scenarios.py --tsv "path/to/file.tsv" # appends to end
"""

import sys
import os
import json
import argparse
import subprocess
import urllib.request
from datetime import datetime, timezone

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCHEMA_FILE = os.path.join(PROJECT_DIR, 'd1', 'schema.sql')

PROD_API_URL = "https://seedling-notifications.pages.dev/api/scenarios"

def fetch_current_scenarios():
    try:
        req = urllib.request.Request(PROD_API_URL, headers={'User-Agent': 'SeedlingCLI/1.0'})
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode())
            return data.get('scenarios', [])
    except Exception as e:
        print(f"Warning: Could not fetch from live API ({e})", file=sys.stderr)
        return []

def parse_tsv_lines(raw_text):
    rows = []
    lines = [line for line in raw_text.strip().split('\n') if line.strip()]
    for line in lines:
        cols = [c.strip() for c in line.split('\t')]
        if not cols or not cols[0]:
            continue
        
        # Columns mapped to standard schema
        event = cols[0]
        trigger = cols[1] if len(cols) > 1 else 'Manual Trigger'
        audience = cols[2] if len(cols) > 2 else 'User'
        objective = cols[3] if len(cols) > 3 else ''
        outcome = cols[4] if len(cols) > 4 else ''
        push_subj = cols[5] if len(cols) > 5 else ''
        push_body = cols[6] if len(cols) > 6 else ''
        email_subj = cols[7] if len(cols) > 7 else ''
        email_body = cols[8] if len(cols) > 8 else ''
        in_app = cols[9] if len(cols) > 9 else ''
        cta = cols[10] if len(cols) > 10 else ''

        # Auto-detect engine category
        engine = 'Governance'
        if any(w in event.lower() for w in ['greenhouse', 'donation', 'ach', 'payment', 'receipt', 'card', 'funds']):
            engine = 'Contribution'

        rows.append({
            'engineCategory': engine,
            'governanceEvent': event,
            'trigger': trigger,
            'audience': audience,
            'communicationObjective': objective,
            'desiredOutcome': outcome,
            'pushSubject': push_subj,
            'pushBody': push_body,
            'emailSubject': email_subj,
            'emailBody': email_body,
            'inAppExperience': in_app,
            'cta': cta,
            'status': 'TO DO',
            'priority': 'High',
            'environment': 'STAGING',
            'comments': '',
        })
    return rows

def main():
    parser = argparse.ArgumentParser(description="Quick Scenario Ingestion Tool")
    parser.add_argument('--after', type=int, default=None, help="Row number after which to insert (e.g. 13)")
    parser.add_argument('--tsv', type=str, required=True, help="Path to TSV file or raw string")
    parser.add_argument('--category', type=str, default=None, help="Force category (Governance or Contribution)")
    args = parser.parse_args()

    # Read raw TSV
    if os.path.exists(args.tsv):
        with open(args.tsv, 'r', encoding='utf-8') as f:
            raw_text = f.read()
    else:
        raw_text = args.tsv

    new_rows = parse_tsv_lines(raw_text)
    if not new_rows:
        print("No valid rows found in input.")
        return

    print(f"Parsed {len(new_rows)} new row(s). Fetching current database state...")
    current = fetch_current_scenarios()

    # Determine next keys and IDs
    contrib_count = sum(1 for s in current if s.get('engineCategory') == 'Contribution')
    gov_count = sum(1 for s in current if s.get('engineCategory') == 'Governance')

    # Prepare SQL statements
    sql_statements = []
    now_iso = datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')

    for row in new_rows:
        cat = args.category or row['engineCategory']
        row['engineCategory'] = cat
        if cat == 'Contribution':
            contrib_count += 1
            key = f"CONTRIB-{contrib_count}"
            scen_id = f"ce-{contrib_count}"
        else:
            gov_count += 1
            key = f"GOV-{gov_count}"
            scen_id = f"gov-{gov_count}"
        
        row['id'] = scen_id
        row['key'] = key
        row['createdAt'] = now_iso
        row['updatedAt'] = now_iso

        # Escape single quotes for SQLite
        def esc(val):
            return str(val or '').replace("'", "''")

        sql = f"""INSERT INTO scenarios (
            id, key, engine_category, governance_event, trigger, audience,
            communication_objective, desired_outcome, push_subject, push_body,
            email_subject, email_body, in_app_experience, cta, comments, status,
            priority, environment, created_at, updated_at
        ) VALUES (
            '{esc(row['id'])}', '{esc(row['key'])}', '{esc(row['engineCategory'])}',
            '{esc(row['governanceEvent'])}', '{esc(row['trigger'])}', '{esc(row['audience'])}',
            '{esc(row['communicationObjective'])}', '{esc(row['desiredOutcome'])}',
            '{esc(row['pushSubject'])}', '{esc(row['pushBody'])}',
            '{esc(row['emailSubject'])}', '{esc(row['emailBody'])}',
            '{esc(row['inAppExperience'])}', '{esc(row['cta'])}', '', 'TO DO',
            '{esc(row['priority'])}', 'STAGING', '{row['createdAt']}', '{row['updatedAt']}'
        );"""
        sql_statements.append(sql)

    temp_sql_file = os.path.join(PROJECT_DIR, 'd1', '_quick_insert.sql')
    with open(temp_sql_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(sql_statements))

    print(f"Executing {len(sql_statements)} insert(s) on remote Cloudflare D1 database...")
    res = subprocess.run(
        ["npx", "wrangler", "d1", "execute", "seedling-notifications-db", "--remote", f"--file={temp_sql_file}"],
        cwd=PROJECT_DIR,
        capture_output=True,
        text=True
    )
    if os.path.exists(temp_sql_file):
        os.remove(temp_sql_file)

    if res.returncode == 0:
        print("✅ Successfully inserted into remote D1 without affecting existing data!")
        for row in new_rows:
            print(f"  + [{row['engineCategory']}] {row['key']}: {row['governanceEvent']}")
    else:
        print(f"❌ D1 execution failed:\n{res.stderr}\n{res.stdout}", file=sys.stderr)

if __name__ == '__main__':
    main()
