# Rails Upgrade Phase 1 Checklist

Use this checklist to complete Phase 1 ("Prerequisites for modern Rails") from `docs/rails_upgrade_plan.md`.

## A) Phase 1 audit and scope
- [x] Generate/update `docs/rails_upgrade_phase1_report.md` using `scripts/rails_upgrade_phase1_audit.sh`.
- [x] Record current Ruby/Bundler/lockfile versions and carry forward the latest Phase 0 green test baseline.
- [x] Inventory Ruby/OS-sensitive gems (`pg`, `nokogiri`, `puma`, `bootsnap`, etc.).
- [x] Inventory high-risk compatibility hotspots for the upcoming Rails phases (`rails-i18n`, `devise`, `ransack`, test stack, legacy frontend gems).

## B) Ruby runtime upgrade (Phase 1 core step)
- [x] Choose the exact Ruby stepping target for this branch (first hop chosen: `3.1.6`).
- [x] Install target Ruby locally (RVM/rbenv/asdf) and verify `ruby -v` (RVM installed `ruby-3.1.6`; runtime verified).
- [x] Update `.ruby-version` to the chosen Ruby 3.1.x version (`3.1.6`).
- [x] Verify app boot commands under the new Ruby (`bundle exec rails -v`, `bundle exec rake -T` both pass under Ruby `3.1.6`).

## C) Bundler and lockfile alignment
- [x] Install/upgrade Bundler for the target Ruby and verify `bundle -v` (`bundler 2.6.9` installed for Ruby `3.1.6`).
- [x] Run `bundle update --bundler` (or equivalent) to refresh the lockfile `BUNDLED WITH` section (`2.6.9`).
- [x] Run `bundle install` under the new Ruby/Bundler pair (successful under Ruby `3.1.6`; gems rebuilt in new gemset).
- [x] Confirm `Gemfile.lock` `RUBY VERSION` matches the active Ruby (`ruby 3.1.6p260`).

## D) Native gems rebuild + validation
- [x] Rebuild/reinstall native gems under Ruby 3.x (`pg`, `nokogiri`, `nio4r`, `msgpack`, `bootsnap`, etc.) and document any compile/linker issues (completed via fresh `bundle install` in Ruby `3.1.6` gemset; no blocking compile/linker failures observed).
- [x] Run `bundle exec rspec` (or `-f j -o rspec_phase1_ruby3.json`) under Ruby 3.x and record results in the Phase 1 report (`538 examples, 0 failures, 79 pending` under Ruby `3.1.6` / Bundler `2.6.9`).
- [x] Fix Ruby 3.x-specific regressions before attempting the Rails 6.1 upgrade (no blocking Ruby 3.1 regressions observed in local suite; existing Rails autoload deprecation warning remains non-blocking and should be addressed in later Rails upgrade phases).

## E) Infra/runtime parity notes
- [x] Update CI/runtime image config to the same Ruby version as local (N/A: no active CI/runtime image configured; legacy `.travis.yml` only, project currently run locally).
- [x] Update deployment/runtime runbooks if applicable (N/A: app is not currently deployed).
- [x] Record the final Phase 1 go/no-go decision for starting the Rails 6.1 upgrade (Go for Rails `6.1` from the Ruby `3.1.6` baseline; plan a follow-up Ruby `3.2/3.3` step before Rails `7+` phases).

## Notes (2026-02-24)
- This project currently has no active CI and is not deployed; Phase 1 infra/deploy items may be marked `N/A` with rationale until those runtimes exist again.
- Ruby 3.x is not installed in the current environment yet (RVM inventory currently shows only `ruby-2.7.7`).
- Use `CHROMEDRIVER_PATH=\"$(command -v chromedriver)\"` for local JS/system spec runs to avoid webdriver SSL fetch issues observed during Phase 0.
- Phase 1 execution completed on this branch: installed `ruby-3.1.6` via RVM, installed `bundler 2.6.9`, updated `.ruby-version`/`Gemfile`/`Gemfile.lock`, and reran the full suite successfully under Ruby `3.1.6` (`rspec_phase1_ruby3.json`: `538 examples, 0 failures, 79 pending`).
- `bundle exec rails -v` and `bundle exec rake -T` both pass under Ruby `3.1.6`; observed warnings are limited to known non-blocking `DidYouMean` and Rails autoload deprecation messages.
