# Rails Upgrade Phase 4 Report

Generated at: 2026-02-25 15:28:41 UTC
Git revision: 04a7c88
Branch: master (post-merge PR #39)

Use this report to track Phase 4 from `docs/rails_upgrade_plan.md`:
- Rails `7.0.x -> 7.1.x` framework upgrade
- Rails 7.1 `app:update` review (manual/no-overwrite mode)
- Rails 7.1 defaults initializer staging
- Local regression validation and warning/deprecation inventory

## 1) Starting baseline (from Phase 3)
- Ruby baseline: `3.2.6`
- Bundler baseline: `2.6.9`
- Starting Rails version (lockfile): `7.0.10`
- `config.load_defaults`: `6.1` (advanced in Phase 3 after validating 6.1 defaults)
- Latest pre-Phase-4 full suite: `538 examples, 0 failures, 79 pending` (Rails 7.0 baseline)

## 2) Phase 4 dependency upgrade execution

### Gemfile changes
- `gem 'rails', '~> 7.0.8'` -> `gem 'rails', '~> 7.1.0'`
- `rails-i18n` constraint unchanged (`~> 7.0`), and bundler kept it on `7.0.10`

### Commands executed
```bash
rvm use 3.2.6 do bundle update rails rails-i18n
```

### Result
- Rails resolved to `7.1.6` (`Gemfile.lock`)
- `rails-i18n` remained `7.0.10`
- First boot checks succeeded:
  - `rvm use 3.2.6 do bundle exec rails -v` -> `Rails 7.1.6`
  - `rvm use 3.2.6 do bundle exec rails about`

### First compatibility blocker encountered
- Full suite after only the Rails bump failed with:
  - `538 examples, 25 failures, 57 pending` (`rspec_phase4_rails71_initial.json`)
- All 25 failures shared the same root cause in controller specs:
  - `TypeError` from `RSpec::Rails::ViewRendering::EmptyTemplateResolver::ResolverDecorator ... is not a valid path`
- Root cause:
  - `rspec-rails 4.1.2` is too old for Rails 7.1 controller/view rendering integration.

### Fix for Rails 7.1 test compatibility
- Updated `rspec-rails` in `Gemfile`:
  - `~> 4` -> `~> 6.1`
- Executed:
```bash
rvm use 3.2.6 do bundle update rspec-rails
```
- Result:
  - `rspec-rails` resolved to `6.1.5`
  - Targeted controller specs that previously failed passed on rerun

## 3) Boot/runtime validation and deprecation inventory (Rails 7.1)

### Initial warnings observed under Rails 7.1
- `DeprecatedConstantAccessor.deprecate_constant without a deprecator is deprecated`
- `Rails.application.secrets` deprecated in favor of credentials
- `config.active_storage.replace_on_assign_to_many` deprecated and has no effect
- `serialize` positional class argument deprecation (`serialize :roles, type: Array`)
- Rails 7.1 RSpec deprecation: singular `fixture_path` -> `fixture_paths`

### Easy deprecation cleanup applied in app code/spec setup
- `spec/rails_helper.rb`
  - `config.fixture_path = ...` -> `config.fixture_paths = [ ... ]`
- `config/application.rb`
  - removed deprecated `config.active_support.disable_to_s_conversion = true`
- `config/initializers/new_framework_defaults_6_0.rb`
  - commented deprecated/no-op `active_storage.replace_on_assign_to_many = true`

### Remaining warnings after cleanup (before Rails 7.1 defaults staging)
- `Rails.application.secrets` deprecation (legacy secrets API/file still present)
- `serialize` positional argument deprecation from the `slow_your_roles` path in `User`
- `DeprecatedConstantAccessor...` deprecation from a dependency (gem source still to identify)

## 4) `app:update` review (Rails 7.1, safe/manual mode)

### Command executed
```bash
yes n | rvm use 3.2.6 do bundle exec rails app:update
```

### Review approach
- Answered `n` to overwrite prompts to preserve app-specific configuration.
- Allowed Rails to generate new 7.1 upgrade artifacts only.

### New files generated and kept
- `config/initializers/new_framework_defaults_7_1.rb`

### Additional generator activity reviewed
- `rails active_storage:update` ran automatically at the end of `app:update`.
- In this pass, no new tracked Active Storage artifacts were generated.

### Defaults strategy for Rails 7.1 (current)
- `config.load_defaults` remains `6.1`
- Rails 7.0 defaults are mostly enabled explicitly via `new_framework_defaults_7_0.rb` and `config/application.rb`
- `new_framework_defaults_7_1.rb` is generated with all toggles commented
- Recommendation:
  - continue staged defaults (small batches) on this branch before any `load_defaults` bump to `7.0`/`7.1`

## 5) Local regression validation (Rails 7.1)

### Initial full suite after Rails bump (before `rspec-rails` upgrade)
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_initial.json
```

Result:
- `538 examples, 25 failures, 57 pending`
- 25/25 failures due the same `rspec-rails` controller spec view-rendering incompatibility

### Full suite after `rspec-rails` upgrade
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_after_rspec_rails.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Full suite after easy deprecation cleanup
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_after_easy_deprecations.json
```

Result:
- `538 examples, 0 failures, 79 pending`
- Warning noise reduced (fixture path / deprecated no-op config removed)

### First Rails 7.1 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_1.rb`:
- `Rails.application.config.active_support.raise_on_invalid_cache_expiration_time = true`
- `Rails.application.config.active_record.query_log_tags_format = :sqlcommenter`
- `Rails.application.config.precompile_filter_parameters = true`
- `Rails.application.config.action_dispatch.debug_exception_log_level = :error`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_defaults_batch1.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Second Rails 7.1 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_1.rb`:
- `Rails.application.config.active_record.sqlite3_adapter_strict_strings_by_default = true` (no-op on PostgreSQL)
- `Rails.application.config.active_record.allow_deprecated_singular_associations_name = false`
- `Rails.application.config.active_record.raise_on_assign_to_attr_readonly = true`
- `Rails.application.config.active_record.generate_secure_token_on = :initialize`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_defaults_batch2.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Third Rails 7.1 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_1.rb`:
- `Rails.application.config.action_dispatch.default_headers = {...}` (7.1 header set without `X-Download-Options`)
- `Rails.application.config.action_controller.allow_deprecated_parameters_hash_equality = false`
- `Rails.application.config.active_job.use_big_decimal_serializer = true`
- `Rails.application.config.active_record.belongs_to_required_validates_foreign_key = false`
- `Rails.application.config.dom_testing_default_html_version = :html5`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_defaults_batch3.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### `serialize` positional-argument compatibility shim (slow_your_roles deprecation cleanup)
Issue:
- `slow_your_roles` calls `serialize :roles, Array`, which is deprecated in Rails 7.1 in favor of the keyword form.

Fix:
- Added `config/initializers/active_record_serialize_positional_compat.rb` to translate legacy positional class arguments to `serialize` into `type:` keyword arguments for Rails 7.1.
- This avoids patching the installed gem directly while keeping app behavior unchanged.

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_after_serialize_compat.json
```

Result:
- `538 examples, 0 failures, 79 pending`
- The `serialize :roles, type: Array` deprecation message no longer appears in suite output

### `Rails.application.secrets` deprecation cleanup
Observed behavior:
- The deprecation persisted after deleting `config/secrets.yml` alone, indicating another boot path was still touching the legacy secrets fallback.

Root cause and fixes applied:
- `config/initializers/devise.rb` used `Rails.application.secret_key_base` as a fallback for `config.secret_key`.
  - On Rails 7.1, this can trigger the deprecated `Rails.application.secrets` fallback during initialization if no env var is present yet.
- Changes made:
  - removed `config/secrets.yml`
  - removed deprecated `config.read_encrypted_secrets = true` from `config/environments/production.rb`
  - set explicit `config.secret_key_base` in `config/environments/test.rb`
  - updated `config/initializers/devise.rb` to prefer `DEVISE_SECRET_KEY` / `SECRET_KEY_BASE` / credentials and avoid `Rails.application.secret_key_base`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_after_ci_and_devise_fix.json
```

Result:
- `538 examples, 0 failures, 79 pending`
- `Rails.application.secrets` deprecation no longer appeared in suite output

### Fourth Rails 7.1 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_7_1.rb`:
- `Rails.application.config.active_record.run_commit_callbacks_on_first_saved_instances_in_transaction = false`
- `Rails.application.config.active_record.before_committed_on_all_records = true`
- `Rails.application.config.active_record.default_column_serializer = nil`
- `Rails.application.config.active_record.run_after_transaction_callbacks_in_order_defined = true`
- `Rails.application.config.active_record.commit_transaction_on_non_local_return = true`
- `Rails.application.config.action_view.sanitizer_vendor = Rails::HTML::Sanitizer.best_supported_vendor`
- `Rails.application.config.action_text.sanitizer_vendor = Rails::HTML::Sanitizer.best_supported_vendor`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle exec rspec -f j -o rspec_phase4_rails71_defaults_batch4.json
```

Result:
- `538 examples, 0 failures, 79 pending`

### Devise patch upgrade (dependency-origin deprecation cleanup)
Reason:
- `DeprecatedConstantAccessor.deprecate_constant without a deprecator is deprecated` warning was traced to `devise 4.8.1`.

Executed:
```bash
rvm use 3.2.6 do bundle _2.6.9_ update devise
```

Resolved versions:
- `devise 4.8.1 -> 4.9.4`
- `responders 3.0.1 -> 3.2.0`
- `bcrypt 3.1.18 -> 3.1.21`

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle _2.6.9_ exec rspec -f j -o rspec_phase4_rails71_after_devise49.json > rspec_phase4_rails71_after_devise49.log 2>&1
```

Result:
- `538 examples, 0 failures, 79 pending`
- No `DEPRECATION WARNING` lines were present in `rspec_phase4_rails71_after_devise49.log`

### `config.add_autoload_paths_to_load_path = false` enabled and validated
Change:
- Added `config.add_autoload_paths_to_load_path = false` in `config/application.rb` (Rails 7.1 recommended setting configured outside the defaults initializer).

Validation command:
```bash
rvm use 3.2.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle _2.6.9_ exec rspec -f j -o rspec_phase4_rails71_autoload_paths_off.json > rspec_phase4_rails71_autoload_paths_off.log 2>&1
```

Result:
- `538 examples, 0 failures, 79 pending`
- No deprecation warnings appeared in `rspec_phase4_rails71_autoload_paths_off.log`

### Remaining warnings after four Rails 7.1 defaults batches + deprecation cleanups (current state)
- No app-owned or dependency-origin deprecation warnings remained in the latest local suite log.
- Non-deprecation warnings may still appear from external tooling/runtime (outside the Rails upgrade scope).

### CI workflow optimization (GitHub Actions minutes)
Problem:
- CI was running twice for feature branch updates with open PRs (`push` + `pull_request`), consuming extra GitHub Actions minutes.

Change:
- Updated `.github/workflows/ci.yml` so:
  - `push` runs only on `master` / `main`
  - `pull_request` runs for PR validation to `master` / `main`
- Result:
  - feature branch pushes with open PRs run one CI job path (`pull_request`) instead of two

### CI validation evidence for Phase 4 closeout (PR #39)
- PR `#39` (`codex/phase4-rails71-batch4` -> `master`) merged on `2026-02-25 15:27:30 UTC`.
- GitHub Actions check:
  - Workflow: `CI`
  - Job: `rspec`
  - Conclusion: `SUCCESS`
  - Completed: `2026-02-25 15:23:49 UTC`
  - URL: `https://github.com/fernandodrf/CGDV-CMS/actions/runs/22403330103/job/64855935612`

## 6) Phase 4 status summary (current checkpoint)
- [x] Rails upgraded from `7.0.10` to `7.1.6`.
- [x] App boots under Rails 7.1 / Ruby 3.2.6.
- [x] `rails app:update` executed and reviewed in non-destructive mode.
- [x] Rails 7.1 defaults initializer generated and retained for gradual rollout.
- [x] Full local RSpec suite green on Rails 7.1 after `rspec-rails` compatibility upgrade.
- [x] Easy app-owned Rails 7.1 deprecations cleaned up (`fixture_paths`, deprecated no-op Active Storage config, deprecated `disable_to_s_conversion` knob).
- [x] First low-risk Rails 7.1 defaults subset enabled and validated (`raise_on_invalid_cache_expiration_time`, `query_log_tags_format`, `precompile_filter_parameters`, `debug_exception_log_level`).
- [x] Second low-risk Rails 7.1 defaults subset enabled and validated (`sqlite3_adapter_strict_strings_by_default`, `allow_deprecated_singular_associations_name`, `raise_on_assign_to_attr_readonly`, `generate_secure_token_on`).
- [x] Third Rails 7.1 defaults subset enabled and validated (`default_headers`, `allow_deprecated_parameters_hash_equality`, `use_big_decimal_serializer`, `belongs_to_required_validates_foreign_key`, `dom_testing_default_html_version`).
- [x] Fourth Rails 7.1 defaults subset enabled and validated (transaction callback/order behavior, `default_column_serializer`, non-local transaction return semantics, HTML5 sanitizer vendors).
- [x] `slow_your_roles` / `serialize` positional-argument deprecation removed via app-side ActiveRecord serialize compatibility shim.
- [x] `Rails.application.secrets` deprecation removed (legacy secrets file/settings removed; Devise secret key fallback updated).
- [x] Dependency-origin `DeprecatedConstantAccessor...` deprecation removed by upgrading `devise` to `4.9.4`.
- [x] All non-rollout-sensitive Rails 7.1 defaults in `new_framework_defaults_7_1.rb` reviewed/enabled and validated locally.
- [x] Rails 7.1 recommended `config.add_autoload_paths_to_load_path = false` enabled and validated in `config/application.rb`.
- [x] GitHub Actions CI validation passed on the Phase 4 merge PR (`#39`) after trigger optimization.
- [ ] Rollout-sensitive serializer/cache format defaults remain intentionally deferred (`active_support.message_serializer`, `use_message_serializer_for_metadata`, `active_record.marshalling_format_version`) while `config.load_defaults` remains `6.1`.

## 7) Phase 4 closeout decision
- Phase 4 is complete on `Rails 7.1.6` / `Ruby 3.2.6`.
- Local full suite is green (`538 examples, 0 failures, 79 pending`) with no Rails deprecation warnings in the latest captured logs.
- CI is green on the Phase 4 merge PR (`#39`).
- Deferred items are rollout-sensitive serializer/cache format changes and any future `config.load_defaults` advancement; these are tracked intentionally and should be handled as a separate rollout-focused step.

## 8) Recommended next actions
1. Start Phase 5 by deciding whether Rails 8.x is needed now, or hold/stabilize on Rails 7.1.6.
2. If staying on 7.1 for now, consider a dedicated follow-up for rollout-sensitive serializer/cache format settings and a planned `config.load_defaults` advancement.
3. Decide whether the ActiveRecord `serialize` compatibility shim should remain as a temporary Rails 7.1 bridge or be replaced by a gem upgrade/fork.
