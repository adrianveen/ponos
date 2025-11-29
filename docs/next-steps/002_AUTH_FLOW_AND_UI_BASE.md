# Day 2 Plan: Authentication Flow & Base UI

**Recap:** Day 1 established the core backend data models (Accounts, Profiles, Companies, Jobs) with verified database schemas and associations.

**Status:** Pending
**Date:** 2025-11-30
**Objective:** Implement a working Google OAuth authentication flow, session management, and the primary application layout (Navigation/Footer).

---

## **1. Dependencies & Configuration**

We need to pull in the authentication libraries and configure them.

### **1.1. Add Dependencies**
*   Add `ueberauth` and `ueberauth_google` to `mix.exs`.
*   Run `mix deps.get`.

### **1.2. Configure Ueberauth**
*   Update `config/config.exs` to setup the Ueberauth provider (Google).
*   **Note:** We will use dummy environment variables for local development or set up a basic Google Cloud credential if available.

---

## **2. Authentication Logic**

Bridging the `Accounts` context with the Web layer.

### **2.1. Auth Controller**
*   Create `lib/ponos_web/controllers/auth_controller.ex`.
*   Implement `request/2` (redirects to Google).
*   Implement `callback/2` (handles return payload).
*   **Logic:**
    *   Find or Create User based on `email` from Google.
    *   Create/Update `AuthProvider` record.
    *   Put `user_id` in session.

### **2.2. Session Plugs (The Glue)**
*   Create `lib/ponos_web/plugs/auth_plug.ex` (or `user_auth.ex`).
*   **Function:** `fetch_current_user/2`
    *   Reads `user_id` from session.
    *   Loads `User` struct.
    *   Assigns to `conn.assigns[:current_user]`.
*   Update `router.ex` to add this plug to the `:browser` pipeline.

---

## **3. Core UI & Layouts**

Replacing the default Phoenix landing page with our application shell.

### **3.1. Root Layout**
*   File: `lib/ponos_web/components/layouts/root.html.heex`
*   **Task:** Clean up default styles, ensure font imports are correct.

### **3.2. App Layout (Navbar)**
*   File: `lib/ponos_web/components/layouts/app.html.heex`
*   **Task:** Implement a responsive Navbar using standard DaisyUI components.
*   **States:**
    *   **Guest:** Show "Sign In" button.
    *   **Logged In:** Show User Avatar + Dropdown (Profile, Settings, Logout).

### **3.3. Logout Flow**
*   Add `DELETE /auth/logout` route.
*   Clear session and redirect to home.

---

## **Execution Checklist**

- [ ] **Install Deps:** Add `ueberauth_google` and run `mix deps.get`.
- [ ] **Config:** Setup Ueberauth in `config.exs`.
- [ ] **Auth Routes:** Add `/auth/:provider` routes in `router.ex`.
- [ ] **Auth Controller:** Implement the callback logic to upsert Users.
- [ ] **Auth Plug:** Write the `fetch_current_user` plug and add to pipeline.
- [ ] **Navbar UI:** Build the visual header with conditional rendering for `current_user`.
- [ ] **Verify Login:** successfully log in with a Google account (or mock).
- [ ] **Commit:** "feat: Implement Auth flow and Core Layout"
