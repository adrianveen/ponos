# **Ponos Handbook: Product Specifications**

*Part 2 of the Ponos Handbook*

---

## **High-Level Product**

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

## **UI/UX Foundations**

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

## **Job Posting Rules**

> **Strategic Note:** We intentionally enforce stricter formatting in v1, with the plan to relax these constraints later if needed—not the other way around. It is easier to loosen the reins than tighten them.

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

## **Profile Rules**

> **Strategic Note:** Similar to job postings, we enforce strict profile structures in v1.

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

### **Future Constraint: Resume Parsing**

While v1 does **not** include resume parsing, the underlying schema and profile structure must be designed to ingest and auto-structure PDF resumes in the future. We must not design ourselves into a corner that prevents this.

---

## **Skills Model & Anti-Gaming**

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

## **Search & Filters Specification**

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

## **Seniority Mapping**

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

## **Apply Flow & Analytics**

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

## **Authentication Model**

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

## **v1 Exclusions**

To prevent scope creep, v1 explicitly **does not include**:

* Messaging
* Social feed
* Likes, endorsements, follower counts
* AI résumé generation
* AI job rewriting
* Recruiter team tools
* Notifications beyond essentials
* Resume uploads (future roadmap - but schema must support eventual parsing)
* Company verification flows
* Mobile-first layout
