# Day 1 Plan: Base Contexts & Domain Modeling

**Status:** Pending
**Date:** 2025-11-28
**Objective:** Implement the core database schemas and Phoenix contexts defined in the `PONOS_OVERVIEW.md` Domain Model.

---

## **Context 1: Accounts**

The `Accounts` context manages user identity and authentication.

### **1.1. Schema: User**
*   **Table:** `users`
*   **Fields:**
    *   `email` (string, unique, required)
    *   `full_name` (string, required)
    *   `is_recruiter` (boolean, default: false)
    *   `role_type` (string, nullable - for future "Company" vs "Agency" distinction)
    *   `confirmed_at` (naive_datetime, nullable)
*   **Associations:**
    *   `has_one :profile`
    *   `has_many :auth_providers`

### **1.2. Schema: AuthProvider**
*   **Table:** `auth_providers`
*   **Fields:**
    *   `provider` (string, required - e.g., "google", "github")
    *   `uid` (string, required)
    *   `token` (text, encrypted if possible, or just stored for refresh)
    *   `user_id` (references `users`)
*   **Indexes:**
    *   Unique index on `[:provider, :uid]`

---

## **Context 2: Profiles**

The `Profiles` context manages the professional identity of a job seeker.

### **2.1. Schema: Profile**
*   **Table:** `profiles`
*   **Fields:**
    *   `user_id` (references `users`, unique, required)
    *   `headline` (string)
    *   `about` (text, word-capped)
    *   `location` (string)
    *   `experience_bullets` (array of map/jsonb - structured data)
    *   `project_bullets` (array of map/jsonb - structured data)
    *   `resume_url` (string, nullable - future proofing)

### **2.2. Schema: Skill**
*   **Table:** `skills`
*   **Fields:**
    *   `name` (string, unique case-insensitive)
    *   `category` (string - "canonical" or "custom")
    *   `is_canonical` (boolean)

### **2.3. Schema: ProfileSkill**
*   **Table:** `profile_skills` (Join table)
*   **Fields:**
    *   `profile_id` (references `profiles`)
    *   `skill_id` (references `skills`)

---

## **Context 3: Companies**

The `Companies` context manages organizational data.

### **3.1. Schema: Company**
*   **Table:** `companies`
*   **Fields:**
    *   `name` (string, required)
    *   `slug` (string, unique)
    *   `logo_url` (string)
    *   `website` (string)
    *   `description` (text)

---

## **Context 4: Jobs**

The `Jobs` context manages job listings.

### **4.1. Schema: JobPosting**
*   **Table:** `job_postings`
*   **Fields:**
    *   `company_id` (references `companies`)
    *   `poster_user_id` (references `users`)
    *   `title` (string, required)
    *   `status` (enum/string: "draft", "open", "closed")
    *   `seniority_level` (string/enum: "intern", "junior", "intermediate", "senior", "lead")
    *   `employment_type` (string: "full_time", "contract", etc.)
    *   `remote_type` (string: "remote", "hybrid", "onsite")
    *   `location` (string/jsonb)
    *   `salary_min` (integer)
    *   `salary_max` (integer)
    *   `currency` (string, default "USD")
    *   `description_body` (text - or structured jsonb sections if strictly enforced)
    *   `responsibilities` (array of strings/jsonb)
    *   `qualifications` (array of strings/jsonb)

---

## **Execution Checklist**

- [X] **Generate Accounts Context:** `mix phx.gen.context Accounts User users ...`
- [X] **Generate AuthProvider:** `mix phx.gen.schema Accounts.AuthProvider auth_providers ...`
- [X] **Generate Companies Context:** `mix phx.gen.context Companies Company companies ...`
- [X] **Generate Profiles Context:** `mix phx.gen.context Profiles Profile profiles ...`
- [X] **Generate Jobs Context:** `mix phx.gen.context Jobs JobPosting job_postings ...`
- [X] **Review Migrations:** Ensure strict constraints (non-nulls, indexes).
- [X] **Run Migrations:** `mix ecto.migrate`.
- [X] **Verify Schemas:** Check `belongs_to` / `has_many` relationships in `.ex` files.
- [X] **Commit:** "feat: Implement base domain contexts"

---
