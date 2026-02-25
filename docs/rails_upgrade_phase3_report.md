# Rails Upgrade Phase 3 Report

Generated at: 2026-02-25 13:36:28 UTC
Git revision: 98eb258
Branch: codex/phase3-defaults-batch2

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

### Final deprecation cleanup (Phase 3 continuation)
- Enabled and validated the remaining Rails 6.1 defaults in `config/initializers/new_framework_defaults_6_1.rb`.
- Advanced `config.load_defaults` from `6.0` to `6.1` in `config/application.rb`.
- Removed the temporary explicit `urlsafe_csrf_tokens` and `legacy_connection_handling` assignments from `config/application.rb`.
- Result after rerun:
  - Rails 7 boot/tests no longer emit the URL-safe CSRF deprecator warning.
  - Rails 7 boot/tests remain green on the full suite.

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
- `config/application.rb` now uses `config.load_defaults 6.1`
- `new_framework_defaults_6_1.rb` was fully enabled and validated before the `load_defaults 6.1` change
- `new_framework_defaults_7_0.rb` was generated with all toggles commented, then enabled incrementally in small validated batches
- Recommendation: continue staging the remaining Rails 7-specific defaults through `new_framework_defaults_7_0.rb`, then move `config.load_defaults` to `7.0` later after explicit validation (if desired in a later phase)

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

### Second Rails 7 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_0.rb`:
- `Rails.application.config.active_support.remove_deprecated_time_with_zone_name = true`
- `Rails.application.config.active_record.verify_foreign_keys_for_fixtures = true`
- `Rails.application.config.active_support.use_rfc4122_namespaced_uuids = true`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch2.json
```

Result:
- `538 examples, 0 failures, 79 pending`
- CSRF explicit-assignment deprecator warning still present (expected with current staged defaults strategy)

### Third Rails 7 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_0.rb`:
- `Rails.application.config.active_record.automatic_scope_inversing = true`
- `Rails.application.config.action_dispatch.return_only_request_media_type_on_content_type = false`
- `Rails.application.config.action_controller.raise_on_open_redirects = true`

Validation commands:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch3a.json
```

Result (`batch3a`, before open redirect hardening):
- `538 examples, 0 failures, 79 pending`

```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch3b.json
```

Result (`batch3b`, with `raise_on_open_redirects = true`):
- `538 examples, 0 failures, 79 pending`
- No open redirect violations were surfaced by the current test suite
- CSRF explicit-assignment deprecator warning still present (expected with current staged defaults strategy)

### All remaining Rails 6.1 defaults staged and validated
Enabled in `config/initializers/new_framework_defaults_6_1.rb` (continuation pass):
- `active_record.has_many_inversing = true`
- `active_storage.track_variants = true`
- `action_dispatch.cookies_same_site_protection = :lax`
- `ActiveSupport.utc_to_local_returns_utc_offset_times = true`
- `action_dispatch.ssl_default_redirect_status = 308`
- `action_view.form_with_generates_remote_forms = false`
- `active_storage.queues.analysis = nil`
- `active_storage.queues.purge = nil`
- `action_mailbox.queues.incineration = nil`
- `action_mailbox.queues.routing = nil`
- `action_mailer.deliver_later_queue_name = nil`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_all_61_defaults_staged.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### `config.load_defaults 6.1` transition and CSRF warning removal
Changes made:
- `config/application.rb`: `config.load_defaults 6.0 -> 6.1`
- Removed temporary explicit assignments for:
  - `config.action_controller.urlsafe_csrf_tokens = true`
  - `config.active_record.legacy_connection_handling = false`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_load_defaults_61.json
```

Result:
- `538 examples, 0 failures, 79 pending`
- URL-safe CSRF deprecator warning no longer observed in the suite output

### Fourth Rails 7 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_0.rb`:
- `Rails.application.config.action_view.button_to_generates_button_tag = true`
- `Rails.application.config.active_support.executor_around_test_case = true`
- `Rails.application.config.active_record.partial_inserts = false`
- `Rails.application.config.action_dispatch.default_headers = {...}`
- `Rails.application.config.active_storage.multiple_file_field_include_hidden = true`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch4.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Fifth Rails 7 defaults subset enabled and validated (rollout-sensitive defaults)
Enabled:
- `Rails.application.config.active_support.key_generator_hash_digest_class = OpenSSL::Digest::SHA256`
- `Rails.application.config.active_support.hash_digest_class = OpenSSL::Digest::SHA256`
- `config.active_support.cache_format_version = 7.0` (`config/application.rb`)

Rationale:
- The app is not currently deployed, so cache/cookie/signing format rollout concerns are significantly lower and can be validated locally now.

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch5.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Sixth Rails 7 defaults subset enabled and validated
Enabled:
- `Rails.application.config.active_storage.video_preview_arguments = ...`
- `config.active_support.disable_to_s_conversion = true` (`config/application.rb`)

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch6.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Local Active Storage migration verification (development + test)
Commands executed:
```bash
rvm use 3.2.6 do bundle exec rails db:migrate
rvm use 3.2.6 do env RAILS_ENV=test bundle exec rails db:migrate
rvm use 3.2.6 do bundle exec rails db:migrate:status
rvm use 3.2.6 do env RAILS_ENV=test bundle exec rails db:migrate:status
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec spec/system/patients_spec.rb:224 -f j -o rspec_phase3_active_storage_smoke.json
```

Result:
- Development DB: 3 Active Storage upgrade migrations applied (`20260225120516`, `20260225120517`, `20260225121458`)
- Test DB: same 3 Active Storage upgrade migrations applied
- Targeted attachment smoke spec passed: `1 example, 0 failures`
- `db/schema.rb` regenerated under Rails 7 and now reflects schema version `2026_02_25_121458` plus Rails 7 schema formatting changes (including timestamp precision annotations)

## 6) Phase 3 status summary (current branch)
- [x] Rails upgraded from `6.1.7.10` to `7.0.10`.
- [x] `rails-i18n` upgraded to a Rails 7-compatible version (`7.0.10`).
- [x] App boots under Rails 7.0 / Ruby 3.2.6.
- [x] `rails app:update` executed and reviewed in non-destructive mode.
- [x] Rails 7 defaults initializer generated and retained for gradual rollout.
- [x] Rails 7 Active Storage checksum migration captured.
- [x] Full local RSpec suite green on Rails 7.0 (`538 examples, 0 failures, 79 pending`) before and after `app:update`.
- [x] Remaining Rails 6.1 defaults were enabled/validated and `config.load_defaults` was advanced to `6.1` (temporary explicit `urlsafe_csrf_tokens` / `legacy_connection_handling` workaround removed).
- [x] First low-risk Rails 7 defaults subset enabled and validated (`apply_stylesheet_media_default`, `smtp_timeout`).
- [x] Second low-risk Rails 7 defaults subset enabled and validated (`remove_deprecated_time_with_zone_name`, `verify_foreign_keys_for_fixtures`, `use_rfc4122_namespaced_uuids`).
- [x] Third Rails 7 defaults subset enabled and validated (`automatic_scope_inversing`, `return_only_request_media_type_on_content_type`, `raise_on_open_redirects`).
- [x] Fourth Rails 7 defaults subset enabled and validated (`button_to_generates_button_tag`, `executor_around_test_case`, `partial_inserts`, `default_headers`, `multiple_file_field_include_hidden`).
- [x] Fifth Rails 7 rollout-sensitive defaults subset enabled and validated (`key_generator_hash_digest_class`, `hash_digest_class`, `cache_format_version = 7.0`).
- [x] Sixth Rails 7 defaults subset enabled and validated (`video_preview_arguments`, `disable_to_s_conversion`).
- [x] URL-safe CSRF deprecator warning cleared by advancing `config.load_defaults` to `6.1`.
- [x] Rails 6.1 + 7.0 Active Storage migrations applied/verified locally in `development` and `test`; attachment smoke spec rerun passed.
- [x] `new_framework_defaults_7_0.rb` reviewed end-to-end; remaining items are explicit defers / already-configured equivalents:
  - `active_storage.variant_processor = :vips` (deferred: requires image pipeline/gem/runtime validation)
  - `action_controller.wrap_parameters_by_default = true` (already effectively enabled via `config/initializers/wrap_parameters.rb`)
  - `cookies_serializer` defaults (`config/initializers/cookies_serializer.rb` already sets `:json`)
- [ ] `config.load_defaults 7.0` is still deferred (Rails 7 defaults are applied explicitly via staging instead).

## 7) Recommended next actions
1. Decide whether to keep Phase 3 as "complete with explicit staged defaults" (`config.load_defaults 6.1`) or do an additional pass to move `config.load_defaults` to `7.0`.
2. If pursuing `config.load_defaults 7.0`, treat `active_storage.variant_processor = :vips` as a separate effort (gems/runtime/image processing validation).
3. Continue to Phase 4 (Rails 7.1) from this green Rails 7.0 / Ruby 3.2.6 baseline.
