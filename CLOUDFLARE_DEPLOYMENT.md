# ☁️ Cloudflare Free Production Deployment Guide

This application is built for **100% Free Cloudflare Infrastructure**:
- **Hosting:** Cloudflare Pages (Free - Unlimited bandwidth & requests)
- **Database:** Cloudflare D1 Serverless SQL Database (Free - 5 Million reads/mo, 100k writes/day, 5 GB storage)
- **API Backend:** Cloudflare Pages Functions / Workers (Free - 100,000 invocations/day)

---

## Quick Step-by-Step Deployment (5 Minutes)

### Step 1: Log in to Cloudflare CLI
Run the following command in your terminal:
```bash
npx wrangler login
```
*(This opens a browser window to authenticate your free Cloudflare account).*

---

### Step 2: Create the Free Cloudflare D1 Database
Create the database on Cloudflare's global edge network:
```bash
npx wrangler d1 create seedling-notifications-db
```

The terminal will output something like:
```text
✅ Successfully created DB 'seedling-notifications-db'
[[d1_databases]]
binding = "DB"
database_name = "seedling-notifications-db"
database_id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
```

---

### Step 3: Paste Your Database ID into `wrangler.json`
Open [`wrangler.json`](./wrangler.json) and replace `"xxxx-xxxx-xxxx-replace-with-d1-id"` with your actual `database_id`:
```json
{
  "$schema": "node_modules/wrangler/config-schema.json",
  "name": "seedling-notifications",
  "pages_build_output_dir": "./dist",
  "compatibility_date": "2025-03-01",
  "compatibility_flags": ["nodejs_compat"],
  "d1_databases": [
    {
      "binding": "DB",
      "database_name": "seedling-notifications-db",
      "database_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
    }
  ]
}
```

---

### Step 4: Run the SQL Schema & Seed Migration to Cloudflare D1
Execute the SQL schema to initialize the table and populate all 20 Governance & Contribution scenarios:
```bash
npx wrangler d1 execute seedling-notifications-db --remote --file=./d1/schema.sql
```

---

### Step 5: Build and Deploy to Cloudflare Pages
Deploy the frontend and serverless API with one single command:
```bash
npm run deploy
```
*(Or run `npm run build && npx wrangler pages deploy dist --project-name=seedling-notifications`)*

Wrangler will upload your assets and output your live production URL:
```text
✨ Deployment complete! Take a peek over at:
👉 https://seedling-notifications.pages.dev
```

---

## Local Full-Stack Development with D1 Emulation

You can test the entire full-stack app locally with Cloudflare D1 emulated on your machine:

1. **Initialize local D1 database:**
   ```bash
   npm run db:init:local
   ```
2. **Run local Cloudflare Pages + Functions + D1 stack:**
   ```bash
   npm run pages:dev
   ```
3. Open `http://localhost:8788/` to see the live app running on local Cloudflare edge!

---

## API Endpoints Reference

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/scenarios` | Fetch all scenarios from Cloudflare D1 (with auto-seeding if empty) |
| `POST` | `/api/scenarios` | Insert a new scenario row |
| `PUT` | `/api/scenarios/:id` | Dynamically update any field or status of a scenario |
| `DELETE`| `/api/scenarios/:id` | Delete a scenario from D1 |
| `POST` | `/api/scenarios/bulk` | Bulk import scenarios from Excel `.xlsx` or clipboard paste |
| `POST` | `/api/init` | Bootstrap / initialize D1 database schema |
