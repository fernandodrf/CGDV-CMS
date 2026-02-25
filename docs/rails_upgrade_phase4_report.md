# Rails Upgrade Phase 4 Report

Generated at: 2026-02-25 14:14:01 UTC
Git revision: eb2483f
Branch: codex/phase4-rails71

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

### Remaining warnings after three Rails 7.1 defaults batches + serialize compat shim (current state)
- `Rails.application.secrets` deprecation (legacy secrets API/file still present)
- `DeprecatedConstantAccessor...` deprecation from a dependency (gem source still to identify)

## 6) Phase 4 status summary (kickoff checkpoint)
- [x] Rails upgraded from `7.0.10` to `7.1.6`.
- [x] App boots under Rails 7.1 / Ruby 3.2.6.
- [x] `rails app:update` executed and reviewed in non-destructive mode.
- [x] Rails 7.1 defaults initializer generated and retained for gradual rollout.
- [x] Full local RSpec suite green on Rails 7.1 after `rspec-rails` compatibility upgrade.
- [x] Easy app-owned Rails 7.1 deprecations cleaned up (`fixture_paths`, deprecated no-op Active Storage config, deprecated `disable_to_s_conversion` knob).
- [x] First low-risk Rails 7.1 defaults subset enabled and validated (`raise_on_invalid_cache_expiration_time`, `query_log_tags_format`, `precompile_filter_parameters`, `debug_exception_log_level`).
- [x] Second low-risk Rails 7.1 defaults subset enabled and validated (`sqlite3_adapter_strict_strings_by_default`, `allow_deprecated_singular_associations_name`, `raise_on_assign_to_attr_readonly`, `generate_secure_token_on`).
- [x] Third Rails 7.1 defaults subset enabled and validated (`default_headers`, `allow_deprecated_parameters_hash_equality`, `use_big_decimal_serializer`, `belongs_to_required_validates_foreign_key`, `dom_testing_default_html_version`).
- [x] `slow_your_roles` / `serialize` positional-argument deprecation removed via app-side ActiveRecord serialize compatibility shim.
- [ ] Many Rails 7.1 defaults (`new_framework_defaults_7_1.rb`) remain unevaluated/commented (serialization/message-format/transaction/callback/sanitizer-impacting items).
- [ ] `Rails.application.secrets` deprecation remains.
- [ ] Dependency-origin `DeprecatedConstantAccessor...` deprecation remains (source TBD).

## 7) Recommended next actions
1. Continue staged Rails 7.1 defaults in small batches; defer message/caching/serializer format toggles until rollback strategy is decided (`config.load_defaults` is still `6.1`).
2. Migrate off `Rails.application.secrets` (remove `config/secrets.yml` usage or replace with credentials/env-only flow).
3. Identify the gem emitting `DeprecatedConstantAccessor...` and decide whether to upgrade, patch, or accept temporarily.
4. Decide whether the ActiveRecord `serialize` compatibility shim should remain as a temporary Rails 7.1 bridge or be replaced by a gem upgrade/fork.
