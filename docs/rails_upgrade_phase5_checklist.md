# Rails Upgrade Phase 5 Checklist

Use this checklist to complete Phase 5 ("Rails 8.x decision + execution") from `docs/rails_upgrade_plan.md`.

## A) Decision and prerequisites
- [x] Re-evaluate Ruby baseline for Rails 8.x (`Ruby 3.3.6` trial on current app).
- [x] Capture updated dependency outlook (`bundle outdated`) for Rails 8.x planning.
- [x] Confirm Rails 8.x can resolve under a supported Ruby (`rails 8.1.2` resolved on `Ruby 3.3.6`).
- [x] Confirm critical gem blockers are identifiable and patchable (Ransack/Jbuilder/rspec-rails).

## B) Phase 5 trial baseline (technical feasibility)
- [x] Switch trial branch pins to `Ruby 3.3.6`.
- [x] Switch trial branch Rails pin to Rails `8.1.x`.
- [x] Upgrade `rails-i18n` to `8.x`.
- [x] Upgrade `rspec-rails` to Rails 8-compatible line (`~> 8.0`).
- [x] Upgrade `ransack` to Rails 8-compatible line (`~> 4.4`).
- [x] Upgrade `jbuilder` (Gemfile allowed update; lockfile bumped to `2.14.1`).
- [x] Upgrade `devise` to Rails 8-friendlier line (`~> 5.0`) to remove Rails 8.2 route DSL deprecations emitted by Devise internals.
- [x] Upgrade `carrierwave` to `~> 3.1` to remove `String#mb_chars` Rails 8.2 deprecations from attachment handling.

## C) Compatibility fixes found during trial
- [x] Fix app boot blocker: `ransack 3.1.0` incompatible with ActiveRecord `8.1`.
- [x] Fix app boot blocker: `jbuilder 2.11.5` incompatible with removed ActiveSupport files in Rails 8.
- [x] Fix app-owned Rails 8 test blocker: `active_record_serialize_positional_compat` shim must support Rails 8 `serialize` signature.
- [x] Fix Rails 8 routing DSL breakage in `config/routes.rb` (legacy multi-argument `get`, `root ... via:`).
- [x] Add temporary app-wide Ransack 4 allowlist fallback in `ApplicationRecord` to preserve current search behavior during upgrade.
- [x] Fix residual Rails 8.2 routes deprecation warning by upgrading `devise` (warning originated inside Devise routing helpers).
- [x] Fix residual Rails 8.2 `String#mb_chars` deprecation warning by upgrading `carrierwave` (warning originated in `CarrierWave::SanitizedFile`).

## D) Validation
- [x] `bundle exec rails -v` under Rails 8 trial (`Rails 8.1.2`)
- [x] `bundle exec rails about` under Rails 8 trial (`Ruby 3.3.6` / Rails boots)
- [x] Run full RSpec suite after initial Rails 8 dependency bump (captured failures)
- [x] Re-run full RSpec suite after Rails 8 compatibility fixes
- [x] Reach a green local suite on Rails 8 trial branch (`538 examples, 0 failures, 79 pending`)
- [x] Re-run full RSpec suite after `devise 5.0.2` + `carrierwave 3.1.2` cleanup pass
- [x] Re-run full RSpec suite after first Rails 8.1 defaults subset is enabled
- [x] Re-run full RSpec suite after second Rails 8.1 defaults subset is enabled

## E) Remaining follow-up (before declaring Phase 5 complete)
- [x] Run `bin/rails app:update` for Rails 8.x and review diffs manually (executed with `yes n` no-overwrite mode; generated new Rails 8.1 artifacts).
- [x] Generate/review Rails 8 framework defaults files (`new_framework_defaults_8_0.rb`, `8_1` if generated) and stage toggles (generated `config/initializers/new_framework_defaults_8_1.rb`; toggles still commented for staged rollout).
- [x] Clean Rails 8.2 deprecations currently visible in suite output (`devise` routing helper hash-arg deprecation and `carrierwave` `mb_chars` deprecation no longer appear).
- [x] Continue reviewing and selectively enabling Rails 8.1 defaults in `config/initializers/new_framework_defaults_8_1.rb` in small batches (all generated 8.1 toggles enabled/validated on this branch).
- [x] Decide whether to keep the broad Ransack allowlist fallback or replace with per-model allowlists (decision for this backend-first checkpoint: keep temporary app-wide fallback, tighten later in a follow-up).
- [x] Review lockfile-only unexpected changes (e.g. `annotate` downgrade) and pin/upgrade intentionally (accepted temporary `annotate 2.6.5`; Bundler would not resolve `3.2.0` on this Rails 8.1 lockfile).
- [ ] Re-run GitHub Actions CI on the Rails 8 branch.

## Notes (2026-02-25)
- Rails `8.1.2` + Ruby `3.3.6` is technically viable for this app with a small patch set; the suite is green locally.
- First full-suite Rails 8 run after dependency bump (before fixes): `538 examples, 85 failures, 79 pending`
- After routes DSL fix: `538 examples, 19 failures, 79 pending`
- Latest local full-suite result:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase5_rails81_defaults81_batch2.json`
  - Result: `538 examples, 0 failures, 79 pending`
- Safe `rails app:update` (no-overwrite mode) generated Rails 8.1 artifacts:
  - `config/initializers/new_framework_defaults_8_1.rb`
  - `config/ci.rb`
  - `bin/ci`, `bin/dev`
  - `public/400.html`, `public/406-unsupported-browser.html`, `public/icon.png`, `public/icon.svg`
- `rails active_storage:update` was executed on the Rails 8.1 branch and produced no new tracked migrations/artifacts.
- Rails 8.2 deprecation cleanup via dependency upgrades:
  - `devise 4.9.4 -> 5.0.2` (removes routing helper hash-arg deprecation emitted at `devise_for`)
  - `carrierwave 2.1.1 -> 3.1.2` (removes `String#mb_chars` deprecation from `CarrierWave::SanitizedFile`)
- First Rails 8.1 defaults subset enabled in `config/initializers/new_framework_defaults_8_1.rb` and validated:
  - `action_controller.escape_json_responses = false`
  - `active_support.escape_js_separators_in_json = false`
  - `action_view.render_tracker = :ruby`
  - `action_view.remove_hidden_field_autocomplete = true`
- Second Rails 8.1 defaults subset enabled and validated:
  - `active_record.raise_on_missing_required_finder_order_columns = true`
  - `action_controller.action_on_path_relative_redirect = :raise`
- All generated Rails 8.1 defaults toggles in `config/initializers/new_framework_defaults_8_1.rb` are enabled on this branch.
- Ransack 4 allowlist decision for this checkpoint:
  - keep the temporary `ApplicationRecord` fallback to preserve current search behavior and unblock backend upgrade work
  - tighten to per-model allowlists in a dedicated follow-up before/after merge
- `annotate` lockfile note:
  - `bundle outdated` shows `annotate 3.2.0`, but Bundler keeps `2.6.5` on this Rails 8.1 lockfile (upgrade did not resolve)
  - accepted as a non-runtime dev-tool compromise for this checkpoint
