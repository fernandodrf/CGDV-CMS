# Rails Upgrade Phase 4 Checklist

Use this checklist to complete Phase 4 ("Rails 7.1 upgrade") from `docs/rails_upgrade_plan.md`.

## A) Dependency bump and resolution
- [x] Update `Gemfile` Rails pin to the Rails 7.1 patch line (`~> 7.1.0`).
- [x] Run `bundle update rails rails-i18n` under the Phase 1 Ruby baseline (`Ruby 3.2.6` / `Bundler 2.6.9`).
- [x] Confirm `Gemfile.lock` resolves to Rails `7.1.6`.
- [x] Upgrade `rspec-rails` to a Rails 7.1-compatible version (`~> 6.1`) after detecting controller spec incompatibilities.

## B) Boot/runtime validation
- [x] Validate `bundle exec rails -v` under Rails 7.1 (`Rails 7.1.6`).
- [x] Validate `bundle exec rails about` under Rails 7.1 (replaces the old `rake about` check used in earlier phases).
- [x] Record first-pass deprecations/warnings from boot/test output.
- [x] Remove easy app-owned deprecations discovered during the first Rails 7.1 suite run:
  - deprecated `RSpec` singular `fixture_path` -> `fixture_paths`
  - deprecated `config.active_support.disable_to_s_conversion`
  - deprecated/no-op `active_storage.replace_on_assign_to_many`

## C) Framework update task + defaults
- [x] Run `bin/rails app:update` and review prompts manually (executed with `yes n` to avoid overwriting app-specific configs).
- [x] Add `config/initializers/new_framework_defaults_7_1.rb` (generated; toggles initially commented).
- [x] Record whether `rails active_storage:update` produced new tracked artifacts (none in this pass).
- [x] Enable and validate a first low-risk Rails 7.1 defaults subset:
  - `active_support.raise_on_invalid_cache_expiration_time = true`
  - `active_record.query_log_tags_format = :sqlcommenter`
  - `precompile_filter_parameters = true`
  - `action_dispatch.debug_exception_log_level = :error`
- [x] Enable and validate a second low-risk Rails 7.1 defaults subset:
  - `active_record.sqlite3_adapter_strict_strings_by_default = true` (no-op on PostgreSQL)
  - `active_record.allow_deprecated_singular_associations_name = false`
  - `active_record.raise_on_assign_to_attr_readonly = true`
  - `active_record.generate_secure_token_on = :initialize` (no `has_secure_token` usage in this app)
- [x] Enable and validate a third Rails 7.1 defaults subset:
  - `action_dispatch.default_headers` (7.1 header set without `X-Download-Options`)
  - `action_controller.allow_deprecated_parameters_hash_equality = false`
  - `active_job.use_big_decimal_serializer = true`
  - `active_record.belongs_to_required_validates_foreign_key = false`
  - `dom_testing_default_html_version = :html5`
- [ ] Continue reviewing and selectively enabling remaining `new_framework_defaults_7_1.rb` toggles in small batches.
- [ ] Decide whether/when to advance `config.load_defaults` from `6.1` to `7.0` and then `7.1` (or keep explicit staged defaults).

## D) Validation
- [x] Run full RSpec suite immediately after the Rails 7.1 dependency bump (captured initial failures).
- [x] Re-run full RSpec suite after `rspec-rails` compatibility upgrade.
- [x] Re-run full RSpec suite after easy deprecation cleanup.
- [x] Re-run full RSpec suite after the first Rails 7.1 defaults subset is enabled.
- [x] Re-run full RSpec suite after the second Rails 7.1 defaults subset is enabled.
- [x] Re-run full RSpec suite after the third Rails 7.1 defaults subset is enabled.
- [x] Re-run full RSpec suite after adding the legacy `serialize` positional-argument compatibility shim.
- [x] Record local test evidence in `docs/rails_upgrade_phase4_report.md`.

## E) Remaining deprecations / follow-up
- [ ] `Rails.application.secrets` deprecation (migrate fully off legacy secrets API / file).
- [x] `slow_your_roles` / `serialize` positional-argument deprecation in `User` model path (handled via app-side ActiveRecord serialize compatibility shim).
- [ ] `DeprecatedConstantAccessor.deprecate_constant without a deprecator` warning (identify gem source and patch/upgrade or accept).
- [ ] Re-run CI on the Rails 7.1 branch and review failures/warnings.

## Notes (2026-02-25)
- Rails 7.1 upgrade became test-green after bumping `rspec-rails` from `4.1.2` to `6.1.5`.
- First full-suite result after Rails bump (before `rspec-rails` upgrade): `538 examples, 25 failures, 57 pending` (all failures shared the same controller spec view-rendering resolver incompatibility).
- Latest local full-suite result:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase4_rails71_after_serialize_compat.json`
  - Result: `538 examples, 0 failures, 79 pending`
- Rails 7.1 defaults currently enabled in `config/initializers/new_framework_defaults_7_1.rb`:
  - `active_support.raise_on_invalid_cache_expiration_time = true`
  - `active_record.query_log_tags_format = :sqlcommenter`
  - `precompile_filter_parameters = true`
  - `action_dispatch.debug_exception_log_level = :error`
  - `active_record.sqlite3_adapter_strict_strings_by_default = true`
  - `active_record.allow_deprecated_singular_associations_name = false`
  - `active_record.raise_on_assign_to_attr_readonly = true`
  - `active_record.generate_secure_token_on = :initialize`
  - `action_dispatch.default_headers` (7.1 header set without `X-Download-Options`)
  - `action_controller.allow_deprecated_parameters_hash_equality = false`
  - `active_job.use_big_decimal_serializer = true`
  - `active_record.belongs_to_required_validates_foreign_key = false`
  - `dom_testing_default_html_version = :html5`
- Local deprecation compatibility shim added:
  - `config/initializers/active_record_serialize_positional_compat.rb` (translates legacy `serialize :column, Array` calls to keyword form for Rails 7.1)
- `config.load_defaults` remains `6.1` from Phase 3; Rails 7.1 defaults are partially staged, not globally enabled.
