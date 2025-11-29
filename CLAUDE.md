# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ponos is a high-performance job search and professional profile platform built as a modern alternative to LinkedIn. The platform focuses on structured data, deterministic search, transparency, and mental health-friendly UX design.

**Core Philosophy:**
- Performance-first: instant search, filtering, and page transitions
- Structured over chaos: enforce formatted job posts and profiles
- No gamification: no likes, endorsements, or social metrics
- Healthier defaults: avoid anxiety-inducing patterns
- Fairness: resist keyword stuffing and gaming
- Transparency: real application counts and analytics

**Technology Stack:**
- Elixir + Phoenix + LiveView for real-time server-driven UI
- PostgreSQL for relational data
- Typesense for instant faceted search (local in dev, cloud in prod)
- Bandit web server
- Tailwind CSS v4 for styling

**Mental Health First:** The marketing/About page will explicitly reference research about social media and mental health harms, underscoring our commitment to healthier digital interactions.

## Essential Commands

### Development
```bash
# Initial setup (install deps, setup DB, build assets)
mix setup

# Start server
mix phx.server

# Start with interactive shell
iex -S mix phx.server

# Access at http://localhost:4000
```

### Database
```bash
# Create database
mix ecto.create

# Run migrations
mix ecto.migrate

# Reset database (drop, create, migrate, seed)
mix ecto.reset

# Generate new migration
mix ecto.gen.migration migration_name_using_underscores
```

### Testing
```bash
# Run all tests
mix test

# Run specific test file
mix test test/my_test.exs

# Run previously failed tests
mix test --failed
```

### Code Quality
```bash
# Pre-commit checks (compile with warnings as errors, format, test)
mix precommit

# Format code
mix format

# Get dependencies
mix deps.get

# Clean unused dependencies
mix deps.unlock --unused
```

### Assets
```bash
# Install asset dependencies
mix assets.setup

# Build assets
mix assets.build

# Build for production deployment
mix assets.deploy
```

### Environment Verification
```bash
# Verify asdf versions
asdf current

# Check Elixir version
elixir --version

# Check Phoenix version
mix phx.new --version

# Verify PostgreSQL is running
systemctl status postgresql

# Verify Typesense is running (if installed locally)
systemctl status typesense

# Check Typesense health
curl http://localhost:8108/health
```

## Architecture Overview

### Domain-Driven Design

All business logic lives in **contexts** under `lib/ponos/`. Controllers and LiveViews never contain business rules—they only orchestrate context calls and manage presentation.

**Planned Core Contexts:**
- `Ponos.Accounts` - User authentication and management
- `Ponos.Profiles` - Structured professional profiles (bullet formatting, skills)
- `Ponos.Jobs` - Job postings with seniority enforcement and structured sections
- `Ponos.Orgs` - Company/organization management
- `Ponos.Search` - Typesense integration for instant filtering
- `Ponos.Auth` - OAuth providers (Google, Apple, Microsoft)

### Seniority Mapping Logic

Job postings enforce strict seniority based on years of experience:
- 0 years → Intern/Entry
- 0-1 years → Junior
- 2-4 years → Intermediate
- 5-7 years → Senior
- 8+ years → Lead/Principal

**The system auto-corrects mismatched seniority in real-time.** If a poster selects "Junior" but requires 5 years, it overrides to "Senior" automatically.

### Profile Anti-Gaming Constraints

> **Strategic Note:** Similar to job postings, we enforce strict profile structures in v1.

To prevent keyword stuffing and maintain quality:
- Bullet-formatted experience and projects (no giant paragraphs)
- Word-capped "About" section
- Skills capped at ~20 canonical + ~10 custom
- Case normalization and deduplication (`python` → `Python`)
- No inline formatting allowed
- Reject repeated or spammy entries
- Limit bullet length and count per section

**Future Constraint:** While v1 does not include resume parsing, the underlying schema and profile structure must be designed to ingest and auto-structure PDF resumes in the future. We must not design ourselves into a corner that prevents this.

### Job Posting Strictness

> **Strategic Note:** We intentionally enforce stricter formatting in v1, with the plan to relax these constraints later if needed—not the other way around. It is easier to loosen the reins than tighten them.

Enforce structured sections with auto-formatting:
- About the Role (short paragraph)
- Responsibilities (bullets)
- Qualifications (bullets)
- Compensation (structured)
- Remote classification (Fully Remote, Remote National, Remote International, Remote by Time Zone, Hybrid, On-Site)
- No custom HTML or text styling
- No single giant text blob allowed

**Formatting Features:**
- Paste-in → auto-formatted bullets
- Preview before saving
- Real-time seniority correction

### Search Architecture

Uses **Typesense** for instant faceted search with filters:
- **Posting date**: 1-24 hour slider, 24h, 3d, 1w, 2w, 1m, no limit
- **Applicant count**: Up to 10, 20, 30...200, no limit
- **Location**: Multi-select cities/countries, distance radius
- **Company**: Multi-select
- **Remote type**: Matches remote classifications
- **Seniority**: Based on years required

All filter changes trigger instant live updates via LiveView.

### Application Analytics Flow

Two-step process to maintain integrity:
1. User clicks "Apply" → opens external link or internal form
2. System asks: "Did you actually apply?" (Yes/No)

Analytics provided:
- Exact applicant counts (no estimates)
- Application trends over time
- Timeline charts for recruiters

## v1 Scope (MVP)

**Included:**
- Professional profiles (structured, resume-like)
- Job postings with strict formatting
- Instant job search with filters
- Application flow + analytics
- Recruiter/company accounts
- Google/Apple/Microsoft SSO
- Laptop-first UX

**Explicitly excluded from v1:**
- Messaging
- Social feed
- Likes/endorsements/follower counts
- AI resume generation or job rewriting
- Resume uploads (future: design schema to support PDF parsing later)
- Mobile-first layout
- Recruiter team collaboration tools

## Code Style & Guidelines

### Phoenix v1.8 Specifics

- **Always** begin LiveView templates with `<Layouts.app flash={@flash} ...>` wrapping all content
- `Layouts` module is aliased globally via `ponos_web.ex`
- **Never** call `<.flash_group>` outside of `layouts.ex`
- Use `<.icon name="hero-x-mark" class="w-5 h-5"/>` for Heroicons
- Use `<.input>` component from `core_components.ex` for form inputs
- No `Phoenix.View` needed (deprecated in Phoenix 1.8)

### LiveView Guidelines

- Use `<.link navigate={href}>` and `<.link patch={href}>` instead of deprecated `live_redirect`/`live_patch`
- **Avoid LiveComponents** unless strongly needed
- Use **streams** for collections instead of regular lists:
  ```elixir
  # Append
  stream(socket, :messages, [new_msg])

  # Reset/filter
  stream(socket, :messages, new_items, reset: true)

  # Delete
  stream_delete(socket, :messages, msg)
  ```

- Template must use `phx-update="stream"`:
  ```heex
  <div id="messages" phx-update="stream">
    <div :for={{id, msg} <- @streams.messages} id={id}>
      {msg.text}
    </div>
  </div>
  ```

### Forms

- **Always** use `to_form/2` in LiveView:
  ```elixir
  assign(socket, :form, to_form(changeset))
  ```

- **Always** use `<.form for={@form}>` in templates, never `<.form for={@changeset}>`
- Access fields via `@form[:field_name]`
- Give forms unique DOM IDs: `<.form for={@form} id="user-form">`

### Elixir Conventions

- Lists don't support `list[index]` syntax—use `Enum.at(list, index)` or pattern matching
- Variables are immutable but can be rebound:
  ```elixir
  # VALID
  socket =
    if connected?(socket) do
      assign(socket, :val, val)
    end

  # INVALID (rebinding inside block doesn't persist)
  if connected?(socket) do
    socket = assign(socket, :val, val)
  end
  ```

- **Never** nest multiple modules in same file (causes cyclic dependencies)
- Use `struct.field` for struct access, not `struct[:field]` (structs don't implement Access)
- Prefer standard lib `Date`, `Time`, `DateTime` modules over external deps
- Use `start_supervised!/1` in tests for process cleanup
- Avoid `Process.sleep/1` in tests—use `Process.monitor/1` instead

### HEEx Templates

- Use `~H` or `.html.heex` files, **never** `~E`
- Interpolate in attributes with `{...}`: `<div id={@id}>`
- Interpolate in bodies with `{...}` for values, `<%= %>` for blocks:
  ```heex
  <div>
    {@my_value}
    <%= if @condition do %>
      content
    <% end %>
  </div>
  ```

- Use `cond` for multiple conditions (no `else if`):
  ```heex
  <%= cond do %>
    <% condition1 -> %> ...
    <% condition2 -> %> ...
    <% true -> %> ...
  <% end %>
  ```

- Comments: `<%!-- comment --%>`
- Use list syntax for conditional classes:
  ```heex
  <a class={[
    "px-2 text-white",
    @flag && "py-5",
    if(@cond, do: "border-red", else: "border-blue")
  ]}>
  ```

### Tailwind CSS v4

- **No `tailwind.config.js` needed** with v4
- Uses new import syntax in `app.css`:
  ```css
  @import "tailwindcss" source(none);
  @source "../css";
  @source "../js";
  @source "../../lib/ponos_web";
  ```

- **Never** use `@apply` in raw CSS
- **Always** manually write Tailwind-based components (no daisyUI)
- Import vendor scripts into `app.js`/`app.css`—no external `<script src>` in layouts

### HTTP Requests

Use `:req` (Req) library for HTTP requests. **Avoid** `:httpoison`, `:tesla`, `:httpc`. Req is included by default in Phoenix apps.

## Testing Strategy

### What to Test
- Context functions (core business logic)
- Seniority mapping logic
- Formatting enforcement (bullets, profiles)
- Skill normalization and anti-gaming
- Search indexing integration

### Test Tools
- ExUnit (built-in)
- SQL Sandbox for database isolation
- `Phoenix.LiveViewTest` for LiveView interactions
- `LazyHTML` for HTML assertions (included in test env)
- Factories via test-support module

### Best Practices
- Reference element IDs from templates in tests
- Use `element/2`, `has_element?/2` instead of raw HTML matching
- Test outcomes, not implementation details
- Use `LazyHTML.filter/2` to debug selector issues
- Split test cases into small, isolated files
- LiveView interactions should be lightly tested (smoke tests)

### CI Expectations
PRs must pass before merging:
- `mix test` - All tests must pass
- `mix format` - Code must be formatted
- `mix credo` - Code quality checks (potentially)

## UI/UX Design Principles

### Layout Philosophy
- **Laptop-first**: optimized for 1080p-1440p desktops
- Multi-pane layouts (job results list + detail pane side-by-side)
- Instant feedback on all interactions
- Clean typography, balanced spacing, subtle micro-interactions

### Job Search UI Pattern
```
+----------------------+------------------------+
|   Job Results List   |   Job Details Pane     |
|   (scrollable)       | (updates on selection) |
+----------------------+------------------------+
```

- First click updates detail pane
- Second click opens full job page with analytics

### Design Execution
- Use Tailwind CSS for world-class, polished interfaces
- Implement subtle hover effects, smooth transitions
- Focus on usability, aesthetics, modern design
- Avoid engagement-driven patterns (no infinite scroll tricks, no manipulation)

## Future Design Constraints

### Resume Parsing Support
The schema and profile structure are **intentionally designed** to support future PDF resume parsing. When building profile schemas, ensure fields can be auto-populated from parsed resume data without major refactoring.

### User Types & Domain Model

**User Schema Fields:**
- `email` - User email address
- `full_name` - Full name
- `is_recruiter` - Boolean flag distinguishing recruiters from regular users
- `role_type` - Future expansion for "Company" vs "Agency" users
- `confirmed_at` - Email confirmation timestamp

The system distinguishes between:
- **Job seekers** - Professionals seeking structured, transparent roles
- **Job posters** - Direct company hires posting roles
- **Recruiters** - In-house or agency recruiters managing multiple clients (may have different analytics and tools)

**AuthProvider Schema:**
- `provider` - OAuth provider (google, apple, microsoft)
- `provider_uid` - Unique ID from provider
- `tokens` - Refresh tokens for provider

**Profile Schema:**
- `headline` - Professional headline
- `about` - Word-capped about section
- `location` - User location
- Bullets for experience & projects
- Skills (join tables for canonical + custom)

**Company Schema:**
- Basic company information
- Associated job postings

**JobPosting Schema:**
- Standardized fields and sections
- Structured bullets
- `salary` - Compensation structure
- `min_years_experience` - Maps to `seniority_level`
- Remote classification

**JobApplication Schema (later):**
- Apply-click analytics
- "Did you actually apply?" confirmation tracking

### GTM Target Markets

**Initial Seed Market:** Canada + US remote positions

**User Segments:**
1. **Job seekers** - Professionals seeking structured, transparent roles (always free)
2. **Job posters** - Direct company employees posting roles
3. **Recruiters** - Agencies managing multiple client companies

**Launch Strategy:**
- Manually onboard early companies
- Offer free recruiter analytics early on
- Focus on startup recruiters and SMEs posting tech roles

**Long-term Monetization:**
- Recruiter analytics (no paywall for visibility)
- Talent funnel tools
- Premium company insights
- **Job seekers stay free forever**

## Development Workflow

### Branching Strategy
- Work happens on feature branches
- PRs must pass `mix test` and `mix format` at a minimum before merging
- Staging deploys from `main` branch only

### Local Development
1. Create feature branch from `main`
2. Make changes and run `mix precommit` before committing
3. Open PR for review
4. After approval and CI passes, merge to `main`
5. `main` auto-deploys to staging environment

## Implementation Roadmap

### Phase 0 — Foundations
- Dev environment setup (asdf, Phoenix, PostgreSQL, Typesense)
- Base contexts & schemas
- SSO skeleton (Google, Apple, Microsoft)
- Typesense service integration

### Phase 1 — Profiles MVP
- Structured profile editor
- Skills normalization (canonical + custom)
- Bullet formatting enforcement
- Profile preview page

### Phase 2 — Job Posting MVP
- Structured job posting forms
- Seniority override logic
- Live formatting with preview
- CRUD flows for job management

### Phase 3 — Job Search MVP
- Instant filtering with Typesense
- All filters working (date, location, remote type, applicant count)
- Results list + details pane UI
- Full job page with analytics

### Phase 4 — Apply Flow + Analytics
- Apply button + confirmation flow
- Exact applicant count tracking
- Timeline charts for trends
- Recruiter analytics dashboard basics

### Phase 5 — Beta Launch
- Comprehensive error handling
- Load testing (search + rendering pipeline)
- Deploy to staging (Fly.io or Render)
- Public beta launch

## Operational Standards

### Error Handling
- Use tagged tuples (`{:ok, ...}`, `{:error, ...}`)
- Only raise for programmer errors
- Never raise for expected business logic failures

### Logging
- Structured JSON in production
- Human-readable in development
- Log important business events (job posted, user registered, etc.)

### Rate Limiting
- Use PlugAttack or equivalent
- Global + per-user thresholds
- Special throttles for search endpoint to prevent abuse

### Data Retention & Privacy
- Job seeker data removable on request
- Profiles deletable by users
- Companies removable
- Application events aggregated (anonymized where possible)
- Backups encrypted in transit and at rest

## Deployment

### Staging (v0.1)
- Platform: Fly.io or Render
- Database: Managed PostgreSQL
- Search: Managed Typesense or self-hosted

### Production (post-beta)
- Container-based deployment
- Possibly GCP Cloud Run or AWS ECS
- CDN for static assets
- Managed Typesense cluster for high availability

### API Boundary (Reserved for post-v1)
```
/api/v1/jobs
/api/v1/companies
/api/v1/profiles
```
- JSON only
- Rate-limited
- No sessions (token-based auth)

## Additional Resources

For comprehensive product vision and architecture details, see:
- `/docs/01_INTRODUCTION.md` - Project motivation and core principles
- `/docs/02_PRODUCT_SPECS.md` - Detailed product specifications
- `/docs/03_TECHNICAL_GUIDE.md` - Technical architecture and domain model
- `/docs/04_ROADMAP_AND_GTM.md` - Implementation phases and go-to-market
- `/docs/PONOS_OVERVIEW.md` - Complete product handbook (consolidated)
- `/docs/LEAN_ROADMAP.md` - 0→1 implementation checklist
- `/docs/ADDITIONAL_SPECS.md` - Future constraints and clarifications
- `/AGENTS.md` - Phoenix/Elixir/LiveView specific guidelines

## Common Pitfalls to Avoid

1. Don't use `@changeset` in templates—always assign via `to_form/2`
2. Don't use `phx-update="append"`—use streams instead
3. Don't nest modules in same file
4. Don't use map access syntax `struct[:field]` on structs
5. Don't add features beyond what's requested (avoid over-engineering)
6. Don't create helpers/abstractions for one-time operations
7. Don't add backwards-compatibility hacks—delete unused code completely
