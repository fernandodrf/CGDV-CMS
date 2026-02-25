# Rails Upgrade Phase 3 Report

Generated at: 2026-02-25 12:35:00 UTC
Git revision: 75ffd2c
Branch: codex/create-upgrade-plan-for-rails

Use this report to track Phase 3 from `docs/rails_upgrade_plan.md`:
- Rails `6.1.x -> 7.0.x` framework upgrade
- Rails 7 `app:update` review (manual/no-overwrite mode)
- Rails 7 defaults initializer staging
- Local regression validation and deprecation inventory

## 1) Starting baseline (from Phase 2)
- Ruby baseline: `3.2.6`
- Bundler baseline: `2.6.9`
- Starting Rails version (lockfile): `6.1.7.10`
- Latest pre-Phase-3 full suite: `538 examples, 0 failures, 79 pending` (`rspec_phase2_rails61_stabilized.json`)
- Phase 2 stabilization already enabled a low-risk subset of 6.1 defaults:
  - `active_job.retry_jitter = 0.15`
  - `active_job.skip_after_callbacks_if_terminated = true`
  - `action_view.preload_links_header = true`

## 2) Phase 3 dependency upgrade execution

### First attempt and correction
- Initial `Gemfile` change used `gem 'rails', '~> 7.0'`.
- Bundler resolved to Rails `7.2.3` because `~> 7.0` permits any `7.x` release.
- Constraint was tightened to `gem 'rails', '~> 7.0.8'` to keep Phase 3 scoped to Rails 7.0.

### Key compatibility blocker encountered
- `rails-i18n ~> 6.0.0` blocked any Rails 7 resolution.
- Fix: bump `rails-i18n` to `~> 7.0`.

### Commands executed
```bash
rvm use 3.2.6 do bundle update rails
rvm use 3.2.6 do bundle update rails rails-i18n
rvm use 3.2.6 do bundle update rails railties activesupport actionpack actionview \
  activerecord activemodel activejob actionmailer actioncable actiontext \
  actionmailbox activestorage rails-i18n
```

### Result
- Rails resolved to `7.0.10` (`Gemfile.lock`)
- `rails-i18n` resolved to `7.0.10`
- Notable transitive changes included (non-exhaustive):
  - Rails components -> `7.0.10`
  - `psych` -> `5.3.1`
  - `stringio` -> `3.2.0`
  - `rdoc` -> `7.2.0`
- Bundler also changed `slow_your_roles` to `2.0.2` during resolution (from `2.0.4`)

## 3) Boot/runtime validation (Rails 7.0)

### Commands executed
```bash
rvm use 3.2.6 do bundle exec rails -v
rvm use 3.2.6 do bundle exec rake about
```

### Result
- Boot and task loading succeeded:
  - `Rails 7.0.10`

### Deprecations observed initially (non-blocking)
- `Non-URL-safe CSRF tokens are deprecated. Use 6.1 defaults or above.`
- `Using legacy connection handling is deprecated. Please set legacy_connection_handling to false.`

Interpretation:
- These warnings align with deferred 6.1 defaults still commented in `config/initializers/new_framework_defaults_6_1.rb`.
- They are not Rails 7 upgrade blockers, but they should be addressed before treating Phase 3 as fully stabilized.

### Follow-up deprecation cleanup progress
- Moved the following settings into `config/application.rb` (earlier boot timing than initializers):
  - `config.action_controller.urlsafe_csrf_tokens = true`
  - `config.active_record.legacy_connection_handling = false`
- Result after rerun:
  - Legacy connection handling deprecation no longer appears.
  - URL-safe CSRF behavior is enabled, but Rails 7 still emits a deprecator warning on explicit assignment to `urlsafe_csrf_tokens=` while `config.load_defaults` remains `< 6.1`.
- Practical implication:
  - Functional/security behavior is improved now.
  - Fully eliminating this warning likely requires advancing the defaults strategy (or otherwise tolerating the explicit-assignment warning temporarily).

## 4) `app:update` review (Rails 7, safe/manual mode)

### Command executed
```bash
yes n | rvm use 3.2.6 do bundle exec rails app:update
```

### Review approach
- Answered `n` to overwrite prompts to preserve app-specific configuration.
- Allowed Rails to generate new 7.0 upgrade artifacts only.

### New files generated and kept
- `config/initializers/new_framework_defaults_7_0.rb`
- `db/migrate/20260225121458_remove_not_null_on_active_storage_blobs_checksum.active_storage.rb`

### Additional generated changes reviewed
- `db/schema.rb`
  - Wrapper syntax changed from `ActiveRecord::Schema.define(...)` to `ActiveRecord::Schema[6.1].define(...)`
  - No schema structure/table changes were introduced by this diff

### Defaults strategy for Rails 7
- `config/application.rb` still uses `config.load_defaults 6.0`
- `new_framework_defaults_6_1.rb` contains a small enabled subset plus deferred high-impact toggles
- `new_framework_defaults_7_0.rb` is present with all toggles commented
- Recommendation: keep staging defaults through the two initializer files, then move `config.load_defaults` later after explicit validation

## 5) Local regression validation (Rails 7.0)

### Full suite baseline after dependency upgrade
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_initial.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Full suite after `app:update` artifacts
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_after_app_update.json
```

Result:
- `538 examples, 0 failures, 79 pending`

Notes:
- The local Chrome driver override remains necessary for stable JS/system specs in this environment.

### Full suite after early-boot deprecation settings
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_deprecations_cleared.json
```

Result:
- `538 examples, 0 failures, 79 pending`

Console warning status:
- Legacy connection handling deprecation: cleared
- CSRF warning: persists in updated form (`URL-safe CSRF tokens are now the default...`) because Rails 7 deprecates explicit assignment while `load_defaults` is still `6.0`

### First Rails 7 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_0.rb`:
- `Rails.application.config.action_view.apply_stylesheet_media_default = false`
- `Rails.application.config.action_mailer.smtp_timeout = 5`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_subset.json
```

Result:
- `538 examples, 0 failures, 79 pending`
- CSRF explicit-assignment deprecator warning still present (expected with current staged defaults strategy)

## 6) Phase 3 status summary (current branch)
- [x] Rails upgraded from `6.1.7.10` to `7.0.10`.
- [x] `rails-i18n` upgraded to a Rails 7-compatible version (`7.0.10`).
- [x] App boots under Rails 7.0 / Ruby 3.2.6.
- [x] `rails app:update` executed and reviewed in non-destructive mode.
- [x] Rails 7 defaults initializer generated and retained for gradual rollout.
- [x] Rails 7 Active Storage checksum migration captured.
- [x] Full local RSpec suite green on Rails 7.0 (`538 examples, 0 failures, 79 pending`) before and after `app:update`.
- [x] Deferred 6.1 defaults causing Rails 7 deprecations were explicitly enabled/validated in `config/application.rb` (`urlsafe_csrf_tokens`, `legacy_connection_handling`).
- [x] First low-risk Rails 7 defaults subset enabled and validated (`apply_stylesheet_media_default`, `smtp_timeout`).
- [ ] One CSRF deprecator warning remains due explicit assignment while `config.load_defaults` is still `6.0`.
- [ ] Most Rails 7 defaults (`new_framework_defaults_7_0.rb`) remain unevaluated/commented (small low-risk subset enabled).
- [ ] Active Storage migrations (6.1 + 7.0) still need execution/verification against real data.

## 7) Recommended next actions
1. Decide whether to tolerate the remaining CSRF explicit-assignment deprecator warning until a later defaults bump, or advance part of the defaults strategy to eliminate it.
2. Continue reviewing `new_framework_defaults_7_0.rb` and enable additional flags in small batches (keep request/redirect/cookie/cache-impacting options for later explicit verification).
3. Run the pending Active Storage migrations against a real local DB copy and verify upload/variant flows manually.
4. After selected Rails 7 defaults are validated, decide whether to continue to Phase 4 (Rails 7.1) or spend a short stabilization cycle on Rails 7.0 first.
