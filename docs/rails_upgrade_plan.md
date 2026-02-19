# Rails Upgrade Plan (CGDV-CMS)

## Current baseline
- Rails is pinned to `6.0.6` in `Gemfile` and `Gemfile.lock`.
- Ruby is pinned to `2.7.7` in `.ruby-version`.
- The app uses several gems that can constrain Rails upgrades: `rails-i18n ~> 6.0.0`, `devise ~> 4.8`, `cancancan`, `kaminari`, `ransack`, `carrierwave`, `coffee-rails`, `turbolinks`, and `rails-jquery-autocomplete`.

## Target
Upgrade to the latest stable Rails major release using **incremental major upgrades**:
1. `6.0.x` → latest `6.1.x`
2. `6.1.x` → latest `7.0.x`
3. `7.0.x` → latest `7.1.x`
4. `7.1.x` → latest `8.x` (if required by product policy and gem compatibility)

> Why incremental: skipping major versions in one jump usually creates large, hard-to-debug dependency and framework-default changes.

## Phase 0 — Inventory and safety net (1–2 days)
1. Freeze the current baseline:
   - Record `ruby -v`, `bundle -v`, `rails -v`, database version, and deployment image.
   - Snapshot full dependency tree: `bundle list` and `bundle outdated`.
2. Strengthen automated validation before changing versions:
   - Ensure test suite is runnable in CI (`bundle exec rspec`).
   - Add smoke tests for critical paths not currently covered (authentication, patient CRUD, reports, file uploads, admin workflows).
3. Add rollback readiness:
   - Confirm database backup/restore procedure.
   - Document one-command rollback path in deployment tooling.

## Phase 1 — Prerequisites for modern Rails (1–2 days)
1. Upgrade Ruby first (in a dedicated PR), because Rails 7+ and 8 require newer Rubies:
   - Recommended stepping path: `2.7.7` → `3.1` → `3.2/3.3`.
2. Upgrade Bundler to a version matching the target Ruby.
3. Update infra images (Docker/base VM) and CI runner to the same Ruby + OS libraries.
4. Rebuild native gems (`pg`, `nokogiri`, etc.) and run full tests.

## Phase 2 — Rails 6.1 upgrade (2–4 days)
1. Bump Rails to `~> 6.1`.
2. Run `bundle update rails` and resolve dependency constraints.
3. Run framework task:
   - `bin/rails app:update` (review each diff manually; do not auto-accept everything).
4. Enable defaults gradually:
   - Add/adjust `config/initializers/new_framework_defaults_6_1.rb`.
5. Validate and fix deprecations from logs and tests.
6. Deploy to staging and run regression checklist.

## Phase 3 — Rails 7.0 upgrade (3–5 days)
1. Bump Rails to `~> 7.0`.
2. Replace or modernize legacy frontend dependencies as needed:
   - Evaluate `turbolinks` → `turbo-rails`.
   - Verify compatibility of `coffee-rails`, `jquery-rails`, and `rails-jquery-autocomplete`.
3. Add/adjust `new_framework_defaults_7_0.rb` and enable flags incrementally.
4. Re-run full test suite, static checks, and staging UAT.

## Phase 4 — Rails 7.1 upgrade (2–4 days)
1. Bump Rails to `~> 7.1`.
2. Run `bin/rails app:update` and adopt config changes.
3. Review autoloading/zeitwerk and initialization warnings.
4. Resolve deprecations with zero-warning policy in CI.

## Phase 5 — Rails 8.x decision + execution (3–6 days)
1. Confirm business need for 8.x now vs. stabilizing at 7.1 first.
2. If proceeding:
   - Ensure Ruby version and all critical gems support Rails 8.
   - Execute upgrade similarly (small PRs, defaults toggled in steps, staged rollout).
3. If blocked by gem ecosystem, hold on latest 7.1 patch and track blockers.

## High-risk compatibility items to evaluate early
1. `rails-i18n ~> 6.0.0` likely must be upgraded for Rails 7/8.
2. `rails-jquery-autocomplete` may be stale for modern Rails.
3. `nested_form` is legacy and may need replacement.
4. `spring` and old dev tooling are often removed/simplified in newer Rails workflows.
5. Asset pipeline strategy (`sprockets` + coffee + jquery) should be explicitly chosen for Rails 7/8.

## Delivery strategy (recommended)
- Use one PR per major step (Ruby, Rails 6.1, Rails 7.0, Rails 7.1, Rails 8.x optional).
- Each PR should include:
  - Gem/version changes
  - Config/default changes
  - Deprecation fixes
  - Test updates
  - Upgrade notes in `CHANGELOG`/`docs`
- Deploy each step to staging and production separately with rollback window.

## Acceptance criteria per phase
- Green CI (tests + linting if available).
- No new Rails deprecation warnings in test/staging logs.
- Completed manual smoke checklist.
- Successful production deployment with monitoring stable for 24h.

## Suggested first execution PR
1. Create PR: "Prep for Rails upgrade: Ruby 3.2 baseline + dependency audit".
2. Scope:
   - Update `.ruby-version`.
   - Update CI/deploy images.
   - Make test suite green under new Ruby.
   - Generate a dependency compatibility report for Rails 6.1/7.0.
