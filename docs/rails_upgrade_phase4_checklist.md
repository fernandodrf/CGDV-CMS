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
- [x] Add `config/initializers/new_framework_defaults_7_1.rb` (generated; toggles remain commented).
- [x] Record whether `rails active_storage:update` produced new tracked artifacts (none in this pass).
- [ ] Review and selectively enable `new_framework_defaults_7_1.rb` toggles in small batches.
- [ ] Decide whether/when to advance `config.load_defaults` from `6.1` to `7.0` and then `7.1` (or keep explicit staged defaults).

## D) Validation
- [x] Run full RSpec suite immediately after the Rails 7.1 dependency bump (captured initial failures).
- [x] Re-run full RSpec suite after `rspec-rails` compatibility upgrade.
- [x] Re-run full RSpec suite after easy deprecation cleanup.
- [x] Record local test evidence in `docs/rails_upgrade_phase4_report.md`.

## E) Remaining deprecations / follow-up
- [ ] `Rails.application.secrets` deprecation (migrate fully off legacy secrets API / file).
- [ ] `slow_your_roles` / `serialize` positional-argument deprecation in `User` model path.
- [ ] `DeprecatedConstantAccessor.deprecate_constant without a deprecator` warning (identify gem source and patch/upgrade or accept).
- [ ] Re-run CI on the Rails 7.1 branch and review failures/warnings.

## Notes (2026-02-25)
- Rails 7.1 upgrade became test-green after bumping `rspec-rails` from `4.1.2` to `6.1.5`.
- First full-suite result after Rails bump (before `rspec-rails` upgrade): `538 examples, 25 failures, 57 pending` (all failures shared the same controller spec view-rendering resolver incompatibility).
- Latest local full-suite result in this Phase 4 kickoff pass:
  - `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase4_rails71_after_easy_deprecations.json`
  - Result: `538 examples, 0 failures, 79 pending`
- `config.load_defaults` remains `6.1` from Phase 3; Rails 7.1 defaults are not enabled yet.
