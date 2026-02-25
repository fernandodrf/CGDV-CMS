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
- [ ] Remove the remaining CSRF deprecator warning (Rails 7 warns on explicit `urlsafe_csrf_tokens=` assignment while `config.load_defaults` remains `< 6.1`; likely resolved when defaults strategy advances).

## C) Framework update task + defaults
- [x] Run `bin/rails app:update` and review prompts manually (executed with `yes n` to avoid overwriting app-specific configs).
- [x] Add `config/initializers/new_framework_defaults_7_0.rb` (generated; all toggles remain commented).
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

## D) Validation
- [x] Run full RSpec suite under Rails 7.0 with local Chrome driver override.
- [x] Re-run full suite after `app:update` artifact generation.
- [x] Re-run full suite after the first Rails 7 defaults subset is enabled.
- [x] Re-run full suite after the second Rails 7 defaults subset is enabled.
- [x] Record local test evidence in `docs/rails_upgrade_phase3_report.md` (`538 examples, 0 failures, 79 pending`).

## E) Deferred / follow-up items before Phase 3 sign-off
- [ ] Resolve the remaining CSRF deprecator warning while preserving the staged `config.load_defaults` strategy (or explicitly accept it until a later defaults bump).
- [ ] Review and selectively enable `new_framework_defaults_7_0.rb` toggles in small commits.
- [ ] Apply/verify Rails 6.1 + 7.0 Active Storage migrations against a real DB with existing attachments.
- [x] Staging deploy + regression checklist (N/A: app is not currently deployed).

## Notes (2026-02-25)
- Full-suite command used:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase3_rails70_after_app_update.json`
- Rails 7.0 booted and the full suite passed without gem compatibility patches beyond dependency resolution (`rails-i18n` bump) and the already-present Rails 6.1 boot workaround in `config/boot.rb`.
- `legacy_connection_handling = false` and `urlsafe_csrf_tokens = true` are applied in `config/application.rb` (earlier than initializers) for Rails 7 boot behavior.
- First Rails 7 defaults subset enabled in `config/initializers/new_framework_defaults_7_0.rb`:
  - `action_view.apply_stylesheet_media_default = false`
  - `action_mailer.smtp_timeout = 5`
- Second Rails 7 defaults subset enabled in `config/initializers/new_framework_defaults_7_0.rb`:
  - `active_support.remove_deprecated_time_with_zone_name = true`
  - `active_record.verify_foreign_keys_for_fixtures = true`
  - `active_support.use_rfc4122_namespaced_uuids = true`
- Latest validation evidence:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase3_rails70_defaults_batch2.json`
  - Result: `538 examples, 0 failures, 79 pending`
- `config.load_defaults` remains `6.0`; both `new_framework_defaults_6_1.rb` and `new_framework_defaults_7_0.rb` are used to stage behavior changes gradually.
