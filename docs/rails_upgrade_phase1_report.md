# Rails Upgrade Phase 1 Prerequisites Report

Generated at: 2026-02-24 18:18:49 UTC
Git revision: 6ca8617
Branch: codex/create-upgrade-plan-for-rails

Use this report to track Phase 1 from `docs/rails_upgrade_plan.md`:
- Ruby upgrade path (`2.7.7 -> 3.1 -> 3.2/3.3`)
- Bundler alignment with the active Ruby
- Infra/runtime parity checks (CI/base image/deploy runtime)
- Native gem rebuild readiness

## 1) Current baseline carried forward from Phase 0
- Rails (lockfile): 6.0.6
- Repo .ruby-version: 3.1.6
- Gemfile ruby constraint: 3.1.6
- Lockfile Ruby version: ruby 3.1.6p260
- Lockfile Bundler version: 2.6.9
- Latest local Phase 0 suite evidence: 538 examples, 0 failures, 79 pending

## 2) Runtime toolchain readiness (current environment)

### Active runtime
- Ruby runtime: ruby 3.1.6p260 (2024-05-29 revision a777087be6) [x86_64-linux]
- Bundler runtime: Bundler version 2.6.9
- RubyGems runtime: 3.3.27

### Installed Bundler gem versions (active Ruby)
```text
bundler (2.6.9, default: 2.3.27, 2.1.4)
```

### Installed Rubies (RVM)
```text
ruby-3.1.6
ruby-2.7.7
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

## 7) Phase 1 status summary (current branch)
- [x] Phase 0 baseline + tests are green and documented (`538 examples, 0 failures, 79 pending`).
- [x] Phase 1 prerequisite audit created (this report + checklist).
- [x] Ruby 3.1 runtime installed in local dev environment (`ruby-3.1.6` via RVM).
- [x] Bundler upgraded/aligned for Ruby 3.1 runtime (`bundler 2.6.9`).
- [x] Repo updated to new Ruby version (`.ruby-version`, `Gemfile`, `Gemfile.lock` RUBY VERSION / BUNDLED WITH all aligned to Ruby `3.1.6` / Bundler `2.6.9`).
- [x] Native gems rebuilt under Ruby 3.x (via fresh `bundle install` in Ruby 3.1.6 gemset; no blocking build errors).
- [x] Full test suite rerun and captured under Ruby 3.x (`rspec_phase1_ruby3.json`: `538 examples, 0 failures, 79 pending`).
- [x] Infra image/CI/runtime docs updated (N/A rationale recorded: no active CI, no Docker image, app not currently deployed).

## 8) Next actions
1. Decide whether to do the optional second Ruby hop now (`3.2.x` or `3.3.x`) before any Rails upgrade work; it is recommended for smoother Rails 7+/8 phases.
2. If continuing immediately to Rails 6.1 first, start Phase 2 in a focused PR step (Rails `~> 6.1`, `bundle update rails`, `app:update`, deprecation fixes).
3. Track and clean up non-blocking warnings observed under Ruby 3.1 (`DidYouMean` dependency deprecation and Rails autoload deprecation) during the Rails 6.1/7.0 phases.
