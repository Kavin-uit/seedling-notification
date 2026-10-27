-- Production Notifications Table Schema
CREATE TABLE IF NOT EXISTS production_notifications (
  id TEXT PRIMARY KEY,
  original_scenario_id TEXT DEFAULT '',
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
  notes TEXT DEFAULT '',
  status TEXT NOT NULL DEFAULT 'READY FOR PROD',
  priority TEXT NOT NULL DEFAULT 'Medium',
  environment TEXT NOT NULL DEFAULT 'PROD',
  rule_id TEXT DEFAULT '',
  cloned_at TEXT NOT NULL DEFAULT (datetime('now')),
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_production_engine ON production_notifications(engine_category);
CREATE INDEX IF NOT EXISTS idx_production_status ON production_notifications(status);
CREATE INDEX IF NOT EXISTS idx_production_orig_scen ON production_notifications(original_scenario_id);
