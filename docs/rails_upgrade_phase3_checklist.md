# Rails Upgrade Phase 3 Checklist

Use this checklist to complete Phase 3 ("Rails 7.0 upgrade") from `docs/rails_upgrade_plan.md`.

## A) Dependency bump and resolution
- [x] Update `Gemfile` Rails pin to the Rails 7.0 patch line (`~> 7.0.8`).
- [x] Update `rails-i18n` constraint for Rails 7 compatibility (`~> 7.0`).
- [x] Run `bundle update rails rails-i18n` under the Phase 1 Ruby baseline (`Ruby 3.2.6` / `Bundler 2.6.9`).
- [x] Keep the upgrade on Rails `7.0.x` (corrected a first resolution that jumped to Rails `7.2.x` when the constraint was temporarily `~> 7.0`).
- [x] Confirm `Gemfile.lock` resolves to Rails `7.0.10`.

## B) Boot/runtime validation
- [x] Validate `bundle exec rails -v` under Rails 7.0 (`Rails 7.0.10`).
- [x] Validate `bundle exec rake about` under Rails 7.0.
- [x] Record visible deprecations from boot/test output (initially non-URL-safe CSRF tokens and legacy connection handling from deferred 6.1 defaults).
- [x] Enable `legacy_connection_handling = false` in `config/application.rb` and verify the Rails 7 deprecation is cleared.
- [x] Enable URL-safe CSRF token behavior in `config/application.rb` and validate the suite.
- [x] Remove the remaining CSRF deprecator warning by validating 6.1 defaults and advancing `config.load_defaults` to `6.1` (explicit `urlsafe_csrf_tokens` assignment removed).

## C) Framework update task + defaults
- [x] Run `bin/rails app:update` and review prompts manually (executed with `yes n` to avoid overwriting app-specific configs).
- [x] Add `config/initializers/new_framework_defaults_7_0.rb` (generated) and stage toggles incrementally with validation.
- [x] Capture generated Rails 7 Active Storage migration:
  - `db/migrate/20260225121458_remove_not_null_on_active_storage_blobs_checksum.active_storage.rb`
- [x] Review incidental generated changes (`db/schema.rb` wrapper syntax updated to `ActiveRecord::Schema[6.1]` by `app:update`).
- [x] Enable and validate a low-risk subset of Rails 7 defaults:
  - `action_view.apply_stylesheet_media_default = false`
  - `action_mailer.smtp_timeout = 5`
- [x] Enable and validate a second low-risk Rails 7 defaults subset:
  - `active_support.remove_deprecated_time_with_zone_name = true`
  - `active_record.verify_foreign_keys_for_fixtures = true`
  - `active_support.use_rfc4122_namespaced_uuids = true`
- [x] Enable and validate a third Rails 7 defaults subset (request/association semantics, security hardening):
  - `active_record.automatic_scope_inversing = true`
  - `action_dispatch.return_only_request_media_type_on_content_type = false`
  - `action_controller.raise_on_open_redirects = true`
- [x] Enable and validate all remaining Rails 6.1 defaults in `config/initializers/new_framework_defaults_6_1.rb`, then advance `config.load_defaults` to `6.1`.
- [x] Enable and validate a fourth Rails 7 defaults subset (view/test/security/db behavior):
  - `action_view.button_to_generates_button_tag = true`
  - `active_support.executor_around_test_case = true`
  - `active_record.partial_inserts = false`
  - `action_dispatch.default_headers = {...}`
  - `active_storage.multiple_file_field_include_hidden = true`
- [x] Enable and validate a fifth Rails 7 defaults subset (cache/signing rollout-sensitive defaults; acceptable now because app is not deployed):
  - `active_support.key_generator_hash_digest_class = OpenSSL::Digest::SHA256`
  - `active_support.hash_digest_class = OpenSSL::Digest::SHA256`
  - `config.active_support.cache_format_version = 7.0` (in `config/application.rb`)
- [x] Enable and validate a sixth Rails 7 defaults subset:
  - `active_storage.video_preview_arguments = ...`
  - `config.active_support.disable_to_s_conversion = true` (in `config/application.rb`)
- [x] Review remaining Rails 7 defaults and document explicit defers / already-configured equivalents.

## D) Validation
- [x] Run full RSpec suite under Rails 7.0 with local Chrome driver override.
- [x] Re-run full suite after `app:update` artifact generation.
- [x] Re-run full suite after the first Rails 7 defaults subset is enabled.
- [x] Re-run full suite after the second Rails 7 defaults subset is enabled.
- [x] Re-run full suite after the third Rails 7 defaults subset is enabled.
- [x] Re-run full suite after staging all remaining Rails 6.1 defaults.
- [x] Re-run full suite after advancing `config.load_defaults` to `6.1`.
- [x] Re-run full suite after the fourth Rails 7 defaults subset is enabled.
- [x] Re-run full suite after the fifth Rails 7 defaults subset is enabled.
- [x] Re-run full suite after the sixth Rails 7 defaults subset is enabled.
- [x] Run targeted attachment smoke spec after local Active Storage migration verification.
- [x] Record local test evidence in `docs/rails_upgrade_phase3_report.md` (`538 examples, 0 failures, 79 pending`).

## E) Deferred / follow-up items before Phase 3 sign-off
- [x] Resolve the remaining CSRF deprecator warning while preserving the staged defaults strategy (`config.load_defaults` advanced to `6.1` after validating the 6.1 defaults).
- [x] Review and selectively enable `new_framework_defaults_7_0.rb` toggles in small commits (remaining items are explicit defers / already-configured equivalents).
- [x] Apply/verify Rails 6.1 + 7.0 Active Storage migrations locally (`development` + `test`) and rerun attachment smoke spec; deployed dataset verification is N/A because the app is not deployed.
- [x] Staging deploy + regression checklist (N/A: app is not currently deployed).

## Notes (2026-02-25)
- Full-suite command used:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase3_rails70_after_app_update.json`
- Rails 7.0 booted and the full suite passed without gem compatibility patches beyond dependency resolution (`rails-i18n` bump) and the already-present Rails 6.1 boot workaround in `config/boot.rb`.
- `config.load_defaults` was advanced from `6.0` to `6.1` after validating all staged 6.1 defaults; the temporary explicit `urlsafe_csrf_tokens` / `legacy_connection_handling` settings in `config/application.rb` were removed.
- First Rails 7 defaults subset enabled in `config/initializers/new_framework_defaults_7_0.rb`:
  - `action_view.apply_stylesheet_media_default = false`
  - `action_mailer.smtp_timeout = 5`
- Second Rails 7 defaults subset enabled in `config/initializers/new_framework_defaults_7_0.rb`:
  - `active_support.remove_deprecated_time_with_zone_name = true`
  - `active_record.verify_foreign_keys_for_fixtures = true`
  - `active_support.use_rfc4122_namespaced_uuids = true`
- Third Rails 7 defaults subset enabled in `config/initializers/new_framework_defaults_7_0.rb`:
  - `active_record.automatic_scope_inversing = true`
  - `action_dispatch.return_only_request_media_type_on_content_type = false`
  - `action_controller.raise_on_open_redirects = true`
- Fourth Rails 7 defaults subset enabled in `config/initializers/new_framework_defaults_7_0.rb`:
  - `action_view.button_to_generates_button_tag = true`
  - `active_support.executor_around_test_case = true`
  - `active_record.partial_inserts = false`
  - `action_dispatch.default_headers = {...}`
  - `active_storage.multiple_file_field_include_hidden = true`
- Fifth Rails 7 defaults subset enabled:
  - `active_support.key_generator_hash_digest_class = OpenSSL::Digest::SHA256`
  - `active_support.hash_digest_class = OpenSSL::Digest::SHA256`
  - `config.active_support.cache_format_version = 7.0` (`config/application.rb`)
- Sixth Rails 7 defaults subset enabled:
  - `active_storage.video_preview_arguments = ...`
  - `config.active_support.disable_to_s_conversion = true` (`config/application.rb`)
- Remaining Rails 7 defaults intentionally deferred / already covered:
  - `active_storage.variant_processor = :vips` (deferred: requires image pipeline/gem/runtime validation)
  - `action_controller.wrap_parameters_by_default = true` (already effectively enabled via `config/initializers/wrap_parameters.rb`)
  - `cookies_serializer` options (already explicitly `:json` in `config/initializers/cookies_serializer.rb`)
- Latest validation evidence:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch6.json`
  - Result: `538 examples, 0 failures, 79 pending`
- Local Active Storage migration verification:
  - `bundle exec rails db:migrate` (development) applied the 3 pending Active Storage upgrade migrations
  - `RAILS_ENV=test bundle exec rails db:migrate` applied the same 3 migrations
  - `bundle exec rspec spec/system/patients_spec.rb:224 -f j -o rspec_phase3_active_storage_smoke.json` -> `1 example, 0 failures`
- `config.load_defaults` now uses `6.1`; Rails 7 defaults continue to be staged via `new_framework_defaults_7_0.rb`.
