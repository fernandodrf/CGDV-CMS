# Rails Upgrade Phase 1 Prerequisites Report

Generated at: 2026-02-25 11:53:38 UTC
Git revision: 828c354
Branch: codex/create-upgrade-plan-for-rails

Use this report to track Phase 1 from `docs/rails_upgrade_plan.md`:
- Ruby upgrade path (`2.7.7 -> 3.1 -> 3.2/3.3`)
- Bundler alignment with the active Ruby
- Infra/runtime parity checks (CI/base image/deploy runtime)
- Native gem rebuild readiness

## 1) Current baseline carried forward from Phase 0
- Rails (lockfile): 6.0.6
- Repo .ruby-version: 3.2.6
- Gemfile ruby constraint: 3.2.6
- Lockfile Ruby version: ruby 3.2.6p234
- Lockfile Bundler version: 2.6.9
- Latest local Phase 0 suite evidence: 538 examples, 0 failures, 79 pending

## 2) Runtime toolchain readiness (current environment)

### Active runtime
- Ruby runtime: ruby 3.2.6 (2024-10-30 revision 63aeb018eb) [x86_64-linux]
- Bundler runtime: Bundler version 2.6.9
- RubyGems runtime: 3.4.19

### Installed Bundler gem versions (active Ruby)
```text
bundler (2.6.9, default: 2.4.19)
```

### Installed Rubies (RVM)
```text
ruby-3.1.6
ruby-3.3.6
ruby-2.7.7
ruby-3.2.6
```

### Ruby 3.x executables on PATH
- ruby3.1: no
- ruby3.2: no
- ruby3.3: no

## 3) Infra/runtime parity inventory
- .travis.yml: present
- Legacy Travis Ruby: 2.7.1
- Legacy Travis PostgreSQL: 9.5
- GitHub Actions workflows dir: missing
- Docker files: none found
- Deploy configs under `config/`: none found

### Detected Docker-related files
```text
none found
```

### Detected deploy config files
```text
none found
```

## 4) Native gem rebuild inventory (Ruby/OS sensitive)
```text
bootsnap 1.15.0
ffi 1.15.5
msgpack 1.6.0
nio4r 2.5.8
nokogiri 1.13.10
pg 1.4.5
puma 5.6.5
sassc 2.4.0
websocket-driver 0.7.5
```

Notes:
- These gems should be explicitly rebuilt/reinstalled and smoke-tested after switching to Ruby 3.x.
- Common failure modes: OpenSSL/libpq/libxml2 ABI differences, compilation flags, old binary cache artifacts.

## 5) High-risk compatibility hotspots (Phase 1 -> Rails 6.1/7.x path)
```text
coffee-rails 5.0.0
devise 4.8.1
jquery-rails 4.5.0
jquery-ui-rails 6.0.1
nested_form 0.3.2
rails-i18n 6.0.0
rails-jquery-autocomplete 1.0.5
ransack 3.1.0
rspec-rails 4.1.2
spring 2.1.1
turbolinks 5.2.1
webdrivers 5.0.0
```

Phase 1 focus guidance:
- Keep Rails pinned at 6.0.6 during Ruby upgrade; do not mix Ruby and Rails major changes in one step.
- Upgrade Bundler after the Ruby switch, then regenerate the lockfile under that Ruby/Bundler pair.
- Re-run full RSpec under the new Ruby before attempting Rails 6.1.

## 6) Phase 1 executable command checklist (when Ruby 3.x is installed)
```bash
# Example RVM path (choose exact target, e.g. 3.1.6 or 3.2.4)
rvm install 3.1.6
rvm use 3.1.6 --default
gem install bundler

# Align repo version files (after deciding exact version)
# edit .ruby-version
bundle update --bundler
bundle install

# Rebuild native gems and validate
bundle pristine pg nokogiri nio4r msgpack || true
bundle exec rspec -f j -o rspec_phase1_ruby3.json
```

### Executed on 2026-02-24 (this branch)
- `rvm install 3.1.6` completed successfully (compiled from source on Ubuntu 24.04; no binary Ruby was available).
- `rvm use 3.1.6 do gem install bundler` installed `bundler 2.6.9`.
- `rvm use 3.1.6 do bundle install` completed successfully and rebuilt gems in the Ruby 3.1.6 gemset (including native gems such as `pg`, `nio4r`, `msgpack`, `puma`, `sassc`).
- Repo Ruby version declarations were aligned to `3.1.6`:
  - `.ruby-version` -> `3.1.6`
  - `Gemfile` -> `ruby '3.1.6'`
  - `Gemfile.lock` -> `RUBY VERSION ruby 3.1.6p260`
- Bundler lockfile metadata was aligned with `rvm use 3.1.6 do bundle _2.6.9_ update --bundler` and `bundle _2.6.9_ update --ruby`:
  - `Gemfile.lock` `BUNDLED WITH` -> `2.6.9`
- App boot validation under Ruby 3.1.6:
  - `bundle exec rails -v` -> `Rails 6.0.6`
  - `bundle exec rake -T` -> succeeded (task list printed)
- Full test suite validation under Ruby 3.1.6 / Bundler 2.6.9:
  - Command: `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase1_ruby3.json`
  - Result: `538 examples, 0 failures, 79 pending`
  - Non-blocking warnings observed: Rails autoload deprecation during initialization; `DidYouMean::SPELL_CHECKERS.merge!` deprecation from older dependencies.

### Executed on 2026-02-25 (Ruby 3.2.6 switch + Ruby 3.3.6 trial)
- Installed additional runtimes with RVM: `ruby-3.2.6` and `ruby-3.3.6` (binary installs on Ubuntu 24.04).
- Installed `bundler 2.6.9` into both `ruby-3.2.6` and `ruby-3.3.6` gemsets.
- Advanced the repo baseline from `3.1.6` to `3.2.6`:
  - `.ruby-version` -> `3.2.6`
  - `Gemfile` -> `ruby '3.2.6'`
  - `Gemfile.lock` -> `RUBY VERSION ruby 3.2.6p234`
- Validation under Ruby 3.2.6 / Bundler 2.6.9:
  - `bundle install` -> passed
  - `bundle _2.6.9_ update --ruby` -> passed
  - `bundle exec rails -v` -> `Rails 6.0.6`
  - `bundle exec rake -T` -> passed
  - Full suite (`rspec_phase1_ruby326_switch.json`) -> `538 examples, 0 failures, 79 pending`
- Ruby 3.2-specific regression handling:
  - A flaky JS/system spec (`spec/system/users_spec.rb:76`) intermittently failed in full-suite runs.
  - The scenario was hardened by waiting for confirmed sign-in state and retrying the first `visit users_path` once.
  - Post-fix validation: targeted rerun passed repeatedly and the full suite passed under `Ruby 3.2.6`.
- Ruby 3.3.6 trial result:
  - `bundle install` failed before app boot due a native extension compile failure for `stringio 3.0.2`
  - Observed dependency chain: `sdoc -> rdoc 6.4.0 -> psych 4.0.4 -> stringio`
  - Conclusion: `Ruby 3.3.6` is not yet viable with the current lockfile/dependency set.

## 7) Phase 1 status summary (current branch)
- [x] Phase 0 baseline + tests are green and documented (`538 examples, 0 failures, 79 pending`).
- [x] Phase 1 prerequisite audit created (this report + checklist).
- [x] Ruby 3.1, 3.2, and 3.3 runtimes installed locally via RVM (`ruby-3.1.6`, `ruby-3.2.6`, `ruby-3.3.6`).
- [x] Bundler upgraded/aligned for Ruby 3.x runtimes (`bundler 2.6.9` installed for `3.1.6`, `3.2.6`, and `3.3.6`).
- [x] Repo updated to new Ruby baseline (`.ruby-version`, `Gemfile`, `Gemfile.lock` aligned to Ruby `3.2.6` / Bundler `2.6.9`).
- [x] Native gems rebuilt under Ruby 3.x (fresh `bundle install` succeeded in the Ruby `3.2.6` gemset; no blocking build errors on `3.2.6`).
- [x] Full test suite rerun and captured under Ruby 3.x (`rspec_phase1_ruby326_switch.json`: `538 examples, 0 failures, 79 pending` under `Ruby 3.2.6`).
- [x] Ruby 3.2 full-suite flake addressed (`spec/system/users_spec.rb` delete-user JS scenario stabilized).
- [ ] Ruby 3.3 compatibility validation (blocked by `stringio 3.0.2` native extension build failure through `psych`/`rdoc`/`sdoc`).
- [x] Infra image/CI/runtime docs updated (N/A rationale recorded: no active CI, no Docker image, app not currently deployed).

## 8) Next actions
1. Start Phase 2 (Rails 6.1 upgrade) from the now-validated `Ruby 3.2.6` / `Bundler 2.6.9` baseline.
2. Keep the `Ruby 3.3.6` trial blocker tracked for a later pass (likely requires updating the `sdoc` / `rdoc` / `psych` / `stringio` dependency chain).
3. Track and clean up non-blocking warnings observed under Ruby 3.x (Rails autoload deprecation, plus older dependency deprecations) during the Rails 6.1/7.0 phases.
