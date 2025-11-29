# Additional Specs
---

## 1. Resume uploads + future parsing constraint

We explicitly said earlier:

* No resume uploads in v1
* But we **must not** design ourselves into a corner so we can later:

  * accept PDF resumes
  * parse them
  * map them into our structured profile format

The handbook has:

* `v1 Exclusions`: “Resume uploads (future roadmap)”

But it doesn’t explicitly say:

> “Our schema and profile structure are intentionally designed so we can ingest and auto-structure resumes later.”

That’s a small but real design constraint that could be made explicit in a “Future: Resume Parsing” line under either **Profile Rules** or **Future Extensions**.

---

## 2. Recruiters vs job posters distinction

We talked about:

* **Job posters** (someone at a company posting roles)
* **Recruiters** (in-house or agency) with slightly different needs and analytics

The handbook mostly treats them as one blob under “recruiters/companies” and “recruiter analytics.”

Nothing is wrong, but if you want full fidelity with our earlier chat, we could add:

* A line in **Domain Model** acknowledging:

  * `is_recruiter` or `role_type` on `User`
  * potential future separation of “Company users” vs “Agency users”
* A line in **GTM** that distinguishes:

  * Companies posting directly
  * Agencies using it for multiple client companies

Right now it’s implied but not explicit.

---

## 3. “About page cites mental health research”

You mentioned:

> “We can cite studies in the about page and think of ways to combat [social media harms] later on.”

The handbook correctly captures the *mental health motivation* and our avoidance of social metrics, but it doesn’t explicitly say:

> “The marketing/About page will explicitly reference research about social media and mental health.”

That’s more content/marketing than product, but if you care about keeping that commitment, it could be a one-liner in **Motivation** or **GTM Strategy**.

---

## 4. Dev workflow / CI expectations (only partially surfaced)

This one is more “my suggestion” than “your prior requirement,” but to be accurate:

* I mentioned earlier:

  * feature branches → PR → CI → staging
  * `mix test`, `mix format`, maybe `mix credo` as a default pipeline

The handbook talks about testing philosophy but not:

* branching strategy
* CI expectations
* basic “what must pass before merging”

We didn’t deeply design that together, so it’s not a “you said X and it’s missing,” but it *is* something I raised and then didn’t fully integrate.

If you want this, we’d add a tiny section like:

> **Dev Workflow**
>
> * Work happens on feature branches
> * PRs must pass `mix test` and `mix format` at minimum
> * Staging deploys from `main` only

---

## 5. Very minor: “easier to loosen than tighten” constraint

You explicitly said:

> “Require it for now. From a business standpoint, it is easier to loosen the reins than tighten them…”

The handbook captures the *effect* (strict profile and job formatting in v1), but we don’t explicitly label this as a strategy.

If you want that philosophy recorded, it could be a one-liner in **Job Posting Rules** / **Profile Rules**:

> “We intentionally enforce stricter formatting in v1, with the plan to relax these constraints later if needed—not the other way around.”

---

### Summary

So relative to everything we actually discussed, the handbook is missing only a few explicit points:

1. **Future resume parsing** as a design constraint, not just “excluded from v1.”
2. **Explicit recruiter vs job-poster distinction** in the domain model and GTM.
3. **About page referencing mental health research** (tiny but you did mention it).
4. **Concrete dev workflow / CI expectations** (raised once, not fully integrated).
5. **Explicit note that v1 is intentionally strict and can be relaxed later.**

Everything else from our prior planning is either clearly present or reasonably implied.

