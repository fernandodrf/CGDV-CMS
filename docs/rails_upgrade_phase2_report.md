# Rails Upgrade Phase 2 Report

Generated at: 2026-02-25 12:10:00 UTC
Git revision: 4a77884
Branch: codex/create-upgrade-plan-for-rails

Use this report to track Phase 2 from `docs/rails_upgrade_plan.md`:
- Rails `6.0.x -> 6.1.x` framework upgrade
- `app:update` review (manual/no-overwrite mode)
- 6.1 defaults initializer staging
- Local regression validation

## 1) Starting baseline (from Phase 1)
- Ruby baseline: `3.2.6`
- Bundler baseline: `2.6.9`
- Starting Rails version (lockfile): `6.0.6`
- Latest pre-Phase-2 full suite: `538 examples, 0 failures, 79 pending` (`rspec_phase1_ruby326_switch.json`)

## 2) Phase 2 dependency upgrade execution

### Commands executed
```bash
rvm use 3.2.6 do bundle update rails
```

### Result
- Rails resolved to `6.1.7.10` (`Gemfile.lock`)
- `Gemfile` Rails pin updated to `gem 'rails', '~> 6.1'`
- Transitive upgrades included (not exhaustive):
  - `activesupport`, `activerecord`, `actionpack`, `railties`, etc. -> `6.1.7.10`
  - `tzinfo` -> `2.0.6`
  - `sprockets-rails` -> `3.5.2`
  - `rack` -> `2.2.22`
  - `nokogiri` -> `1.19.1`
  - `concurrent-ruby` -> `1.3.6`

## 3) Boot/runtime compatibility issue and fix

### Observed failure after the Rails 6.1 bump
- `bundle exec rails -v` and `bundle exec rake -T` initially failed with:
  - `NameError: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger`

### Cause (inference from the stack trace)
- Rails `6.1.7.10` (ActiveSupport) was loaded before Ruby's stdlib `logger` constant was initialized.
- The failure surfaced after `concurrent-ruby` was upgraded to `1.3.6` during the Rails 6.1 bundle update.

### Fix applied
- Added early `require 'logger'` in `config/boot.rb` before Rails/ActiveSupport boot:
  - `config/boot.rb`

### Post-fix boot validation
- `rvm use 3.2.6 do bundle exec rails -v` -> `Rails 6.1.7.10`
- `rvm use 3.2.6 do bundle exec rake about` -> passed

## 4) `app:update` review (safe/manual mode)

### Command executed
```bash
yes n | rvm use 3.2.6 do bundle exec rails app:update
```

### Review approach
- Answered `n` to overwrite prompts so existing app-specific config files were preserved.
- This allowed Rails to generate new files relevant to 6.1 without auto-merging config changes.

### New files generated and kept
- `config/initializers/new_framework_defaults_6_1.rb`
- `config/initializers/permissions_policy.rb`
- `db/migrate/20260225120516_add_service_name_to_active_storage_blobs.active_storage.rb`
- `db/migrate/20260225120517_create_active_storage_variant_records.active_storage.rb`

### Additional changes from `app:update`
- Rails bin scripts had executable bits normalized (`bin/bundle`, `bin/rails`, `bin/rake`, `bin/rspec`, `bin/setup`, `bin/spring`, `bin/update`, `bin/yarn`).
- No binstub content changes were introduced (mode-only changes).

### Defaults strategy for this branch (initial)
- `config/application.rb` remains at `config.load_defaults 6.0`.
- `config/initializers/new_framework_defaults_6_1.rb` is present with all toggles commented out.
- Recommendation: enable 6.1 defaults one at a time in follow-up commits before Phase 3 (Rails 7.0).

## 5) Local regression validation (Rails 6.1)

### Boot/task smoke checks
```bash
rvm use 3.2.6 do bundle exec rails -v
rvm use 3.2.6 do bundle exec rake about
```

Result:
- Boot and task loading succeeded under Rails `6.1.7.10` / Ruby `3.2.6`

### Full test suite
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase2_rails61_after_app_update.json
```

Result:
- `538 examples, 0 failures, 79 pending`

Notes:
- System specs continue to use the local Chrome driver override to avoid webdriver SSL metadata download issues.

## 6) Phase 2 stabilization pass (short follow-up before Phase 3)

### 6.1 defaults enabled in the stabilization pass
Enabled only low-risk/default-alignment options in `config/initializers/new_framework_defaults_6_1.rb`:
- `Rails.application.config.active_job.retry_jitter = 0.15`
- `Rails.application.config.active_job.skip_after_callbacks_if_terminated = true`
- `Rails.application.config.action_view.preload_links_header = true`

Deferred (still commented) due compatibility/behavior risk:
- cookie SameSite protection
- Active Storage variant tracking
- form submission behavior and other request/cookie/cache-impacting defaults

Follow-up during Phase 3 (Rails 7.0):
- `urlsafe_csrf_tokens` and `legacy_connection_handling = false` were moved into `config/application.rb` so they apply early during boot.
- This cleared the Rails 7 legacy connection handling deprecation and enabled URL-safe CSRF behavior before controller initialization.
- Rails still emits one CSRF-related deprecator warning when explicitly assigning the now-default value; this is tied to explicit assignment while `config.load_defaults` remains `6.0`.

### Validation after stabilization toggles
```bash
rvm use 3.2.6 do bundle exec rails -v
rvm use 3.2.6 do bundle exec rake about
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase2_rails61_stabilized.json
```

Result:
- `538 examples, 0 failures, 79 pending`

## 7) Phase 2 status summary (current branch)
- [x] Rails upgraded from `6.0.6` to `6.1.7.10`.
- [x] App boots under Rails 6.1 / Ruby 3.2.6 after applying the early `logger` preload workaround.
- [x] `rails app:update` executed and reviewed in non-destructive mode (`yes n` to overwrite prompts).
- [x] 6.1 defaults initializer generated and retained for gradual rollout.
- [x] Rails-generated Active Storage upgrade migrations captured.
- [x] Full local RSpec suite green on Rails 6.1 (`538 examples, 0 failures, 79 pending`).
- [x] Short stabilization pass completed with a low-risk subset of 6.1 defaults enabled and validated.
- [x] Staging deploy validation marked N/A (app is not currently deployed).
- [ ] Active Storage migrations applied/verified against a real database with existing data.
- [ ] Remaining `new_framework_defaults_6_1.rb` toggles evaluated and enabled incrementally (high-risk items deferred).

## 8) Recommended next actions
1. In Phase 3, use Rails 7 deprecation output to prioritize which deferred 6.1 defaults to enable next (notably URL-safe CSRF tokens and new connection handling).
2. Run the Active Storage 6.1 migrations against a real local DB copy and verify attachments/variants behavior.
3. Continue enabling deferred 6.1 defaults in small commits while holding a green Rails 7.0 test baseline.
