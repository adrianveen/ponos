This is the “Ponos Handbook.”
You can commit it as:

```
/docs/PONOS_OVERVIEW.md
```

It is intentionally comprehensive, but organized for clarity and future maintainers.

---

# **Ponos Handbook**

*A complete blueprint for contributors, engineers, designers, and collaborators*

---

## **Summary**

Ponos is a high-performance job search and professional profile platform designed as a modern alternative to LinkedIn, intentionally rejecting the clutter, dark patterns, and engagement-driven incentives of conventional platforms. The goal is a structured, deterministic, transparent job ecosystem where:

* Profiles read like clean, standardized resumes
* Job postings adhere to strict formatting and seniority rules
* Search is instant, honest, and predictable
* Job seekers never pay
* Recruiters pay only for analytics—not visibility
* UX is optimized for laptops and high-speed professional workflows
* No gamified social features exist (no likes, no endorsements)
* Mental health and fairness are first-class priorities

This handbook contains:

* Product motivation
* UI/UX decisions
* Formatting rules
* Seniority logic
* Filter definitions
* Full technical architecture
* Dev environment
* Folder structure
* Testing + CI philosophy
* Deployment expectations
* GTM strategy
* v1 and non-v1 features

Reading this document fully gives any newcomer a complete understanding of the Ponos system from vision → architecture → operations.

---

# **Table of Contents**

1. [Motivation](#motivation)
2. [Core Principles](#core-principles)
3. [High-Level Product](#high-level-product)
4. [UI/UX Foundations](#uiux-foundations)
5. [Job Posting Rules](#job-posting-rules)
6. [Profile Rules](#profile-rules)
7. [Skills Model & Anti-Gaming](#skills-model--anti-gaming)
8. [Search & Filters Specification](#search--filters-specification)
9. [Seniority Mapping](#seniority-mapping)
10. [Apply Flow & Analytics](#apply-flow--analytics)
11. [Authentication Model](#authentication-model)
12. [Technical Architecture](#technical-architecture)
13. [Dev Environment](#dev-environment)
14. [Project Structure](#project-structure)
15. [Domain Model](#domain-model)
16. [Testing Philosophy](#testing-philosophy)
17. [API Boundary](#api-boundary)
18. [Operational Standards](#operational-standards)
19. [Deployment Expectations](#deployment-expectations)
20. [Data Retention & Privacy](#data-retention--privacy)
21. [v1 Exclusions](#v1-exclusions)
22. [Roadmap: 0 → 1](#roadmap-0--1)
23. [GTM Strategy](#gtm-strategy)
24. [Appendix](#appendix)

---

# **Motivation**

The job market suffers from opaque search algorithms, inconsistent profiles, bloated job descriptions, misleading analytics, and harmful social dynamics. Job seekers face anxiety loops, paywalls, and endless noise. Recruiters face spam, bot applications, and poor-quality filtering.

Ponos fixes this by supplying:

* Structured job posts
* Structured professional profiles
* Instant, deterministic searching
* Transparent analytics
* A healthier, lower-pressure alternative to LinkedIn
* A desktop-first, professional-grade experience
* Zero dark patterns

Ponos is engineered for clarity and fairness, not clicks.

---

# **Core Principles**

### **1. Performance First**

Everything must feel instantaneous: search, filtering, loading, transitions. Use LiveView + Typesense for true low-latency UX.

### **2. Structure Over Chaos**

Structured data enables deterministic matching. Job posts and profiles enforce formatting.

### **3. No Gamified Social Layer**

No likes, endorsements, reactions, engagement metrics, or follower pressure.

### **4. Healthier Defaults**

We intentionally avoid mental-health-damaging UX patterns.

### **5. Transparency**

Real application counts, real analytics, real seniority logic.

### **6. Fairness & Anti-Gaming**

The system must resist keyword stuffing, excessive skill padding, and deceptive formatting.

---

# **High-Level Product**

### **v1 Includes**

* **Professional profiles** (structured, resume-like)
* **Job postings** with strict formats
* **Job search with instant filtering**
* **Apply flow with analytics confirmation**
* **Recruiter/company accounts**
* **Google/Apple/Microsoft SSO**
* **Laptop-first UX**

### **Networking (feed, posts, messaging) is explicitly NOT part of v1.**

---

# **UI/UX Foundations**

### **1. Laptop-first design**

* Optimized for 1080p–1440p desktops
* Multi-pane layouts encouraged
* No mobile-first restrictions early on

### **2. Job Search Layout**

**Core pattern:**

```
+----------------------+------------------------+
|   Job Results List   |     Job Details Pane   |
|   (scrollable)       | (updates on selection) |
+----------------------+------------------------+
```

* Clicking a job updates details pane instantly
* Second click opens full job page with deep analytics

### **3. Formatting Buttons**

* Paste-in → auto-formatted bullets
* Preview before saving

---

# **Job Posting Rules**

### **Required Sections**

* About the Role (short paragraph)
* Responsibilities (bullets)
* Qualifications (bullets)
* Compensation (structured)
* Locations (structured)
* Remote classification

### **Formatting Rules**

* No single giant text blob allowed
* Bullets enforced where appropriate
* No custom HTML or text styling

### **Remote Classification**

* Fully Remote
* Remote National
* Remote International
* Remote by Time Zone
* On-Site
* Hybrid

### **Seniority Enforcement**

Strict rule:
If job poster’s seniority doesn’t match experience → override in real time.

Example:

* Job lists “Junior” but requires 5 years → override to “Senior” immediately.

---

# **Profile Rules**

### **Sections**

* About (word-capped, no essay)
* Experience (bullets only)
* Projects (bullets only)
* Skills (canonical + custom)

### **Formatting**

* Bullets enforced
* No inline formatting
* No giant paragraphs

### **Anti-gaming expectations**

* Caps on number of skills
* Normalization to avoid duplicates

---

# **Skills Model & Anti-Gaming**

### **Two categories**

1. **Canonical skills**
   Ex: Python, SQL, AWS, JavaScript
2. **Custom skills**
   For edge cases & niche tech

### **Normalization**

* Case normalization (`python` → `Python`)
* Deduplication

### **Anti-gaming constraints**

* Caps:

  * ~20 canonical
  * ~10 custom
* Reject repeated or spammy entries
* Limit bullet length and count per section

---

# **Search & Filters Specification**

### **Search Engine**

Typesense faceted search.

### **Filters**

**Posting Date**

* 1–24 hour slider
* 24 hours
* 3 days
* 1 week
* 2 weeks
* 1 month
* No limit

**Applicant Count**

* Up to 10
* Up to 20
* Up to 30 …
* Up to 200
* No limit

**Location**

* Multi-select cities
* Multi-select countries
* Distance from a given point (0–100 km or 60 miles)

**Company**
Multi-select

**Remote Type**
Matches remote classifications above.

### **Update Behavior**

* Initial query can be “search button”
* All filter changes trigger instant live updates

---

# **Seniority Mapping**

### **Explicit v1 Mapping**

| Years Required | Seniority        |
| -------------- | ---------------- |
| 0              | Intern / Entry   |
| 0–1            | Junior           |
| 2–4            | Intermediate     |
| 5–7            | Senior           |
| 8+             | Lead / Principal |

Rules:

* Seniority is always required
* If mismatched → system overrides instantly
* Poster sees real-time correction

---

# **Apply Flow & Analytics**

### **Apply Flow**

Two-step process to maintain analytic integrity:

1. User clicks **Apply** → opens external job link OR internal application interface
2. After returning, system asks:
   **“Did you actually apply?”** (Yes / No)

### **Analytics Provided to Job Seekers**

* True applicant count (exact number)
* Trends over time
* Applications per day

### **Analytics for Recruiters**

* Application timeline
* Engagement histories
* No paywall for visibility

---

# **Authentication Model**

### **Primary (v1)**

* Google
* Apple
* Microsoft

### **Secondary (optional in future)**

* GitHub (developer-heavy roles)

### **Fallback**

* Passwordless email login
* No password storage

### **Security**

* Bot-resistant signups
* Provider token refresh stored in `AuthProvider` table

---

# **Technical Architecture**

### **Backend**

* Elixir
* Phoenix
* LiveView
* Ecto + Postgres

### **Search**

* Typesense (local in dev, cloud in prod)

### **Frontend**

* Server-driven LiveView
* Minimal client JS

### **Pattern**

All domain logic lives in **contexts**.
Controllers/LiveViews never contain business rules.

---

# **Dev Environment**

### **Environment includes**

* asdf (Elixir, Erlang, Node)
* Phoenix CLI
* PostgreSQL
* Typesense server
* Git repo initialized

### **Verification commands**

```
asdf current
elixir --version
mix phx.new --version
systemctl status postgresql
systemctl status typesense
curl http://localhost:8108/health
mix ecto.create
mix phx.server
```

---

# **Project Structure**

```
lib/
  ponos/
    accounts/
    profiles/
    jobs/
    orgs/
    search/
    auth/
  ponos_web/
    live/
    components/
    controllers/
config/
priv/
  repo/
    migrations/
```

---

# **Domain Model**

### **User**

* email
* full_name
* is_recruiter
* confirmed_at

### **AuthProvider**

* provider
* provider_uid
* tokens

### **Profile**

* headline
* about
* location
* bullets for experience & projects
* skills (join tables)

### **Company**

* basic company info

### **JobPosting**

* standardized fields
* sections
* bullets
* salary
* min_years_experience → seniority_level

### **JobApplication (later)**

* for apply-click analytics

---

# **Testing Philosophy**

### **Must be tested**

* Context functions
* Seniority mapping
* Formatting logic
* Skill normalization
* Search indexing

### **Lightly tested**

* LiveView interactions (smoke tests)

### **Test Tools**

* ExUnit
* SQL Sandbox
* Factories via test-support module

---

# **API Boundary**

Reserved for post-v1:

```
/api/v1/jobs
/api/v1/companies
/api/v1/profiles
```

* JSON only
* Rate-limited
* No sessions

---

# **Operational Standards**

### **Error Handling**

* Use tagged tuples (`{:ok, ...}`, `{:error, ...}`)
* Only raise for programmer errors

### **Logging**

* Structured JSON in prod
* Human-readable in dev

### **Rate Limiting**

* PlugAttack or equivalent
* Global + per-user thresholds
* Special throttles for search endpoint

---

# **Deployment Expectations**

### **Staging (v0.1)**

* Fly.io or Render
* Pg + Typesense hosted

### **Production (post-beta)**

* Container-based deploy
* Possibly GCP Cloud Run or AWS ECS
* CDN for static assets
* Managed Typesense cluster

---

# **Data Retention & Privacy**

* Job seeker data removable on request
* Profiles deletable
* Companies removable
* Application events aggregated
* Backups encrypted in transit and at rest

---

# **v1 Exclusions**

To prevent scope creep, v1 explicitly **does not include**:

* Messaging
* Social feed
* Likes, endorsements, follower counts
* AI résumé generation
* AI job rewriting
* Recruiter team tools
* Notifications beyond essentials
* Resume uploads (future roadmap)
* Company verification flows
* Mobile-first layout

---

# **Roadmap: 0 → 1**

### **Phase 0 — Foundations**

* Dev environment
* Base contexts & schemas
* SSO skeleton
* Typesense service

### **Phase 1 — Profiles MVP**

* Structured editor
* Skills normalization
* Bullet formatting
* Preview page

### **Phase 2 — Job Posting MVP**

* Structured posting
* Seniority override
* Live formatting
* CRUD flows

### **Phase 3 — Job Search MVP**

* Instant filtering
* All filters working
* Results list + details pane
* Full job page

### **Phase 4 — Apply Flow + Analytics**

* Apply + confirmation
* Applicant counts
* Timeline charts
* Recruiter analytics basics

### **Phase 5 — Beta**

* Error handling
* Load tests
* Deploy to staging
* Public beta launch

---

# **GTM Strategy**

### **Target Users**

* Job seekers
* Startup recruiters
* SMEs posting tech roles

### **Differentiators**

* Real analytics
* Structured postings
* Deterministic search
* Cleanest professional profiles
* Zero vanity metrics
* Healthy UX design

### **Launch Strategy**

* Initial seed market: Canada + US remote
* Manually onboard early companies
* Offer free recruiter analytics early on

### **Long-term Monetization**

* Recruiter analytics
* Talent funnel tools
* Premium company insights

Job seekers stay free forever.

---

# **Appendix**

Additional documentation (if needed):

* Database ERD
* Typesense schemas
* UI wireframes
* Config examples

---

# **End of Ponos Handbook**


