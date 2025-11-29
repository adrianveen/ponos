Here’s the lean checklist — no fluff, just the essential steps and a one-line description for each. This is the scaffold for the 0→1 roadmap before we start building features.

---

## **Roadmap Setup Checklist (Condensed)**

### **1. Define v1 Scope (Profiles + Job Search Only)**

Lock in the limited feature set to avoid scope creep: profiles, job posts, search.

### **2. Finalize Domain Model**

Identify core entities: User, Profile, Company, JobPosting, Skill, JobApplication.

### **3. Decide Canonical Rules (Seniority, Skills, Formatting)**

Enforce structured job posts, seniority mapping, bullet formatting, canonical skills.

### **4. Select Core Stack (Elixir/Phoenix + Postgres + Typesense)**

Commit to the performance-first architecture for realtime search and rendering.

### **5. Prepare Dev Environment**

Get Arch + Phoenix + Postgres + Typesense + Node running cleanly.

### **6. Project Initialization**

Generate Phoenix project, initialize Git repo, pin runtimes with asdf.

### **7. Create Base Contexts**

Generate contexts for Accounts (users), Profiles, Companies, Jobs.

### **8. Build Profile System (v1 minimal)**

Enforce structured fields: about, experience bullets, skills groups.

### **9. Build Job Posting System**

Enforce seniority rules, structured sections, canonical fields.

### **10. Integrate Typesense Search**

Index jobs + profiles, build fuzzy search and live filter updates.

### **11. Build Job Search UI (Left list + Right detail pane)**

Implement responsive LiveView search with instant filtering.

### **12. Add Application Counter + Analytics Basics**

Track “applied” clicks and anonymous counts; show job poster analytics.

### **13. Implement Auth (SSO-first)**

Google + Apple + Microsoft SSO with passwordless fallback using OAuth.

### **14. Add Minimal Admin Tools**

Simple admin dashboard to review jobs, manage skills, enforce consistency.

### **15. Deploy v0.1 to Staging**

Ship first staging release to validate performance and real-time search.

### **16. QA + Observability**

Logging, metrics, error reporting, load tests on search + rendering pipeline.

### **17. Release v1 Public Beta**

Profiles, jobs, search, analytics, SSO auth, Typesense-backed filtering.

---

If you want, I can transform this into the *actual* actionable engineering checklist (with commands, file structures, and Phoenix generators), or the *product* roadmap (milestones, epics, week-by-week).

