# **Ponos Handbook: Technical Guide**

*Part 3 of the Ponos Handbook*

---

## **Technical Architecture**

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

## **Dev Environment**

### **Environment includes**

* asdf (Elixir, Erlang, Node)
* Phoenix CLI
* PostgreSQL
* Typesense server
* Git repo initialized

### **Verification commands**

```bash
asdf current
elixir --version
mix phx.new --version
systemctl status postgresql
systemctl status typesense
curl http://localhost:8108/health
mix ecto.create
mix phx.server
```

### **Dev Workflow**

* Work happens on feature branches.
* PRs must pass `mix test` and `mix format` at a minimum before merging.
* Staging deploys from `main` only.

---

## **Project Structure**

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

## **Domain Model**

### **User**

* email
* full_name
* is_recruiter (distinguishes job posters/recruiters from regular users)
* role_type (future expansion for "Company" vs "Agency" users)
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

## **Testing Philosophy**

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

### **CI Expectations**

* `mix test`, `mix format`, and potentially `mix credo` must pass in the pipeline.

---

## **API Boundary**

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

## **Operational Standards**

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

## **Deployment Expectations**

### **Staging (v0.1)**

* Fly.io or Render
* Pg + Typesense hosted

### **Production (post-beta)**

* Container-based deploy
* Possibly GCP Cloud Run or AWS ECS
* CDN for static assets
* Managed Typesense cluster

---

## **Data Retention & Privacy**

* Job seeker data removable on request
* Profiles deletable
* Companies removable
* Application events aggregated
* Backups encrypted in transit and at rest
