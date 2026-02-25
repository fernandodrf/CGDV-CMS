# Rails Upgrade Phase 5 Report

Generated at: 2026-02-25 17:08:34 UTC
Git revision: e0d00c0
Branch: codex/phase5-rails8-feasibility (working tree with uncommitted trial changes)

Use this report to track Phase 5 from `docs/rails_upgrade_plan.md`:
- Rails `7.1.x -> 8.x` decision and feasibility
- Ruby baseline advancement for Rails 8.x
- Dependency compatibility blockers and fixes
- Local regression validation and deprecation inventory

## 1) Starting baseline (post-Phase 4)
- Ruby baseline: `3.2.6`
- Bundler baseline: `2.6.9`
- Rails baseline: `7.1.6`
- Local full suite baseline (Phase 4): `538 examples, 0 failures, 79 pending`

## 2) Dependency outlook before the trial

Command executed:
```bash
rvm use 3.2.6 do bundle _2.6.9_ outdated rails rails-i18n devise kaminari ransack carrierwave rails-jquery-autocomplete nested_form slow_your_roles
```

Key results (from `out_phase5_outdated.txt`):
- `rails`: `7.1.6` -> `8.1.2`
- `rails-i18n`: `7.0.10` -> `8.1.0`
- `devise`: `4.9.4` -> `5.0.2`
- `ransack`: `3.1.0` -> `4.4.1`
- `carrierwave`: `2.1.1` -> `3.1.2`
- `slow_your_roles`: `2.0.2` -> `2.0.4`

Immediate takeaway:
- Rails 8 and rails-i18n 8 are available.
- `ransack` is clearly lagging the app’s current version and likely to be a first blocker.

## 3) Rails 8.1 / Ruby 3.3 trial execution

### Trial pin changes
- `.ruby-version`: `3.2.6` -> `3.3.6`
- `Gemfile`:
  - `ruby '3.2.6'` -> `ruby '3.3.6'`
  - `gem 'rails', '~> 7.1.0'` -> `gem 'rails', '~> 8.1.0'`
  - `gem 'rails-i18n', '~> 7.0'` -> `gem 'rails-i18n', '~> 8.0'`
  - `gem 'ransack', '~> 3.1.0'` -> `gem 'ransack', '~> 4.4'`
  - `gem 'rspec-rails', '~> 6.1'` -> `gem 'rspec-rails', '~> 8.0'`
  - `gem 'devise', '~> 4.8'` -> `gem 'devise', '~> 5.0'`
  - `gem 'carrierwave', '~> 2.1.1'` -> `gem 'carrierwave', '~> 3.1'`

### First dependency resolution command
```bash
rvm use 3.3.6 do bundle _2.6.9_ update rails rails-i18n
```

Result:
- Resolved successfully to:
  - `rails 8.1.2`
  - `rails-i18n 8.1.0`
- Ruby 3.3 native extension installs succeeded (previous early-phase `stringio` blocker no longer reproduces on the newer dependency set).

## 4) Compatibility blockers encountered and fixes applied

### Blocker 1: `ransack 3.1.0` boot failure on ActiveRecord 8.1
Observed on `rails about`:
- `cannot load such file -- polyamorous/activerecord_8.1_ruby_2/join_association`

Fix:
```bash
rvm use 3.3.6 do bundle _2.6.9_ update ransack
```
- `ransack 3.1.0 -> 4.4.1`

### Blocker 2: `jbuilder 2.11.5` boot failure on Rails 8
Observed on `rails about`:
- `cannot load such file -- active_support/basic_object`
- `cannot load such file -- active_support/proxy_object`

Fix:
```bash
rvm use 3.3.6 do bundle _2.6.9_ update jbuilder
```
- `jbuilder 2.11.5 -> 2.14.1`

### Blocker 3: app-owned `serialize` compatibility shim breaks on Rails 8 signature
Observed on first RSpec load:
- `ArgumentError: wrong number of arguments (given 2, expected 1)`
- Source: `config/initializers/active_record_serialize_positional_compat.rb`

Fix:
- Updated the shim to support both:
  - Rails 7.1 `serialize(attr, legacy_second_arg, ...)`
  - Rails 8 `serialize(attr, coder:, type:, ...)`

### Blocker 4: Rails 8 routing DSL incompatibilities in `config/routes.rb`
Observed:
- `Wrong number of arguments (expect 1, got 2)` in `ActionDispatch::Routing::Mapper#get`
- Root cause: legacy multi-argument route declarations (`get 'print', 'image'`) and old root form.

Fixes applied:
- Split multi-argument `get` calls into separate lines in `notes`, `patients`, and `volunteers` routes.
- Updated root route to `root "pages#home"`.

Effect:
- Full-suite failures dropped from `85` to `19`.

### Blocker 5: Ransack 4 explicit allowlisting breaks index/search pages
Observed in system specs:
- Runtime errors such as `Ransack needs Patient attributes explicitly allowlisted as searchable`

Fix applied (temporary broad fallback):
- Added `ransackable_attributes` and `ransackable_associations` to `ApplicationRecord`.
- This preserves current behavior during the Rails 8 upgrade and unblocks the suite.
- TODO: Replace with per-model allowlists for tighter search exposure control.

Effect:
- Full suite returned to green.

### Blocker 6: Rails 8.2 deprecations from dependencies during green-suite run
Observed after the suite was already green on Rails 8.1:
- Route DSL hash-argument deprecation emitted at `config/routes.rb:11`, but originating in Devise route helpers (`devise_for`)
- `String#mb_chars` deprecation during attachment model/controller flows, originating in `carrierwave 2.1.1` (`CarrierWave::SanitizedFile`)

Fixes applied:
- `devise 4.9.4 -> 5.0.2`
- `carrierwave 2.1.1 -> 3.1.2`

Validation:
- Full suite remained green after both upgrades.
- The Rails 8.2 deprecations above no longer appeared in the suite log.

### Rails 8 `app:update` pass (safe/no-overwrite mode)
Executed:
```bash
rvm use 3.3.6 do sh -c 'yes n | bundle _2.6.9_ exec rails app:update'
```

Result:
- Existing app-specific files were preserved (`n` on conflicts).
- New Rails 8.1 artifacts generated:
  - `config/initializers/new_framework_defaults_8_1.rb`
  - `config/ci.rb`
  - `bin/ci`, `bin/dev`
  - `public/400.html`, `public/406-unsupported-browser.html`, `public/icon.png`, `public/icon.svg`
- `new_framework_defaults_8_1.rb` is generated with toggles commented (staged rollout still pending).

### `rails active_storage:update` check
Executed:
```bash
rvm use 3.3.6 do bundle _2.6.9_ exec rails active_storage:update
```

Result:
- No new tracked Active Storage migrations or schema changes were generated on this branch.

### Rails 8.1 backend deprecation cleanup via dependency upgrades
Reason:
- After the suite was green, remaining Rails 8.2 deprecations came from dependencies:
  - Devise routing helper hash-argument warnings during `devise_for`
  - CarrierWave `String#mb_chars` warnings during attachment handling

Fixes applied:
- `devise 4.9.4 -> 5.0.2`
- `carrierwave 2.1.1 -> 3.1.2`

Validation:
- `rspec_phase5_rails81_after_devise5.json`: `538 examples, 0 failures, 79 pending`
- `rspec_phase5_rails81_after_carrierwave3.json`: `538 examples, 0 failures, 79 pending`
- Rails deprecation warnings no longer present in `rspec_phase5_rails81_after_carrierwave3.log`

### First Rails 8.1 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_8_1.rb`:
- `Rails.configuration.action_controller.escape_json_responses = false`
- `Rails.configuration.active_support.escape_js_separators_in_json = false`
- `Rails.configuration.action_view.render_tracker = :ruby`
- `Rails.configuration.action_view.remove_hidden_field_autocomplete = true`

Validation command:
```bash
rvm use 3.3.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle _2.6.9_ exec rspec -f j -o rspec_phase5_rails81_defaults81_batch1.json > rspec_phase5_rails81_defaults81_batch1.log 2>&1
```

Result:
- `538 examples, 0 failures, 79 pending`

### Second Rails 8.1 defaults subset enabled and validated
Enabled in `config/initializers/new_framework_defaults_8_1.rb`:
- `Rails.configuration.active_record.raise_on_missing_required_finder_order_columns = true`
- `Rails.configuration.action_controller.action_on_path_relative_redirect = :raise`

Validation command:
```bash
rvm use 3.3.6 do env CHROMEDRIVER_PATH="$(command -v chromedriver)" \
  bundle _2.6.9_ exec rspec -f j -o rspec_phase5_rails81_defaults81_batch2.json > rspec_phase5_rails81_defaults81_batch2.log 2>&1
```

Result:
- `538 examples, 0 failures, 79 pending`

Rails 8.1 defaults status on this branch:
- All generated toggles in `config/initializers/new_framework_defaults_8_1.rb` are enabled and locally validated.

## 5) Validation results (Rails 8.1 trial)

### Boot checks
Commands:
```bash
rvm use 3.3.6 do bundle _2.6.9_ exec rails -v
rvm use 3.3.6 do bundle _2.6.9_ exec rails about
```

Result:
- Rails boots on `Rails 8.1.2` / `Ruby 3.3.6`

### Full suite progression
1. After initial dependency bump (before compatibility fixes):
   - `rspec_phase5_rails81_after_rspec8.json` equivalent state before routes fix
   - `538 examples, 85 failures, 79 pending`
2. After routes DSL fixes:
   - `rspec_phase5_rails81_after_routes.json`
   - `538 examples, 19 failures, 79 pending`
3. After Ransack allowlist fallback:
   - `rspec_phase5_rails81_after_ransack_allowlist.json`
   - `538 examples, 0 failures, 79 pending`

## 6) Current deprecations/warnings on the Rails 8.1 trial

From `rspec_phase5_rails81_defaults81_batch2.log`:

### Rails deprecations
- No Rails deprecation warnings were present in the latest full-suite run after upgrading `devise` and `carrierwave`, and after the first Rails 8.1 defaults subset.

### Ruby 3.4 forward-compat warnings (dependency/tooling-origin)
- `observer` stdlib warning via `factory_bot`
- `mutex_m` stdlib warning via `spring`

These warnings do not currently fail the suite, but they should be tracked if the project later targets Ruby 3.4.

## 7) Phase 5 status summary (technical checkpoint)
- [x] Rails 8.x upgrade is technically feasible for this app (not blocked by dependency resolution).
- [x] Ruby `3.3.6` is viable with the current app after dependency refresh.
- [x] Local full suite is green on Rails `8.1.2` / Ruby `3.3.6`.
- [x] Core blockers identified and patched (`ransack`, `jbuilder`, routes DSL, app `serialize` shim, Ransack allowlisting, Devise/CarrierWave Rails 8.2 deprecations).
- [x] `bin/rails app:update` executed in safe/no-overwrite mode; Rails 8.1 artifacts generated.
- [x] Rails 8.2 deprecation cleanup completed for the current local suite path.
- [x] First Rails 8.1 defaults subset enabled and validated locally.
- [x] Second Rails 8.1 defaults subset enabled and validated locally.
- [x] All generated Rails 8.1 defaults in `config/initializers/new_framework_defaults_8_1.rb` enabled and validated locally.
- [x] Temporary Ransack 4 allowlist fallback explicitly accepted for this backend-first checkpoint (per-model tightening deferred).
- [x] `annotate` downgrade reviewed and accepted as a temporary dev-tool compromise (`annotate 3.2.0` would not resolve on this Rails 8.1 lockfile).
- [ ] CI validation on a Rails 8 branch still pending.

## 8) Recommended next actions
1. Review and stage the Rails 8.1 `app:update` generated artifacts (`config/ci.rb`, `bin/ci`, `bin/dev`, `public/*`, `new_framework_defaults_8_1.rb`) intentionally.
2. Re-run GitHub Actions CI on this branch once network access/auth is available from the working session.
3. Optionally replace the broad `ApplicationRecord` Ransack allowlist with per-model allowlists as a follow-up hardening pass.
4. Consider a follow-up cleanup for Ruby 3.4 stdlib warnings (`factory_bot` / `spring`) if you plan to move beyond Ruby 3.3 soon.
