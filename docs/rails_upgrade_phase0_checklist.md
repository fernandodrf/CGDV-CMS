# Rails Upgrade Phase 0 Checklist

Use this checklist to complete Phase 0 from `docs/rails_upgrade_plan.md`.

## A) Baseline inventory
- [x] Collect runtime version output (`ruby -v`, `bundle -v`, `bundle exec rails -v`) or record missing toolchain state.
- [x] Record repo-declared versions from `.ruby-version`, `Gemfile`, and `Gemfile.lock`.
- [x] Save results in `docs/rails_upgrade_phase0_report.md`.

## B) Dependency snapshot
- [x] Run `bundle install` in the project runtime and verify `bundle check` passes.
- [x] Capture `bundle list` output.
- [x] Capture `bundle outdated` output (successful rerun captured in `out.txt`; exit code `1` expected because gems are outdated).
- [x] Identify current blockers (see `docs/rails_upgrade_phase0_report.md`).
- [x] Assign owners for dependency blockers (single-maintainer project; blockers assigned to project maintainer in `docs/rails_upgrade_phase0_report.md`).

## C) Validation safety net
- [x] Run `bundle exec rspec` in CI and store build link. (N/A: no CI configured as of 2026-02-24)
- [x] Run `bundle exec rspec` locally and record result/failure mode (see report; latest full rerun in `rspec_phase0_after_smoke.json` shows `538 examples, 0 failures, 79 pending`).
- [x] Confirm current coverage status for: auth, patient CRUD, reports, file uploads, admin workflows (static audit recorded in report).
- [x] Create missing smoke/system specs where required (added patient edit/update, patient attachment upload, and activity-report create/read smoke specs; targeted rerun passes: `18 examples, 0 failures, 4 pending`).

## D) Rollback readiness
- [x] Document DB backup procedure (owner/link): `docs/rails_upgrade_phase0_rollback_readiness.md` (N/A: app is not currently deployed; no active environment/runbook as of 2026-02-24)
- [x] Document DB restore drill (owner/link): `docs/rails_upgrade_phase0_rollback_readiness.md` (N/A: app is not currently deployed; no active environment/runbook as of 2026-02-24)
- [x] Document one-command deploy rollback path (owner/link): `docs/rails_upgrade_phase0_rollback_readiness.md` (N/A: app is not currently deployed; no deployment tooling/runbook in use as of 2026-02-24)

## E) Sign-off
- [x] Engineering sign-off (N/A: single-maintainer project as of 2026-02-24)
- [x] QA sign-off (N/A: single-maintainer project as of 2026-02-24)
- [x] Ops sign-off (N/A: single-maintainer project as of 2026-02-24)

## Notes (2026-02-23)
- Local runtime is now available (`ruby 2.7.7`, `bundler 2.1.4`, `rails 6.0.6`) and dependency snapshot commands can run.
- `bundle outdated` currently fails to fetch from `http://rubygems.org`; treat this as an environment/source configuration blocker until re-run succeeds.
- Local `bundle exec rspec` run reaches the suite but fails with `PG::ConnectionBad` on `/var/run/postgresql/.s.PGSQL.5432` (PostgreSQL/socket access unavailable in this sandboxed environment).
- Static spec audit indicates strongest current smoke coverage in `spec/system/users_spec.rb` and `spec/system/patients_spec.rb`.
- Highest-priority smoke gaps for upgrade safety: activity report workflow, file uploads (attachments), and patient edit/update path.

## Notes (2026-02-24)
- User-provided local RSpec JSON (`rspec20260224.json`) shows the suite largely passes: `535 examples, 4 failures, 79 pending`.
- Two failures are `OpenSSL::SSL::SSLError` from `webdrivers` attempting Chromedriver HTTPS metadata download (local certificate verification issue).
- Remaining failures are data/setup related in patient system specs (`"México"` select option missing; `CatalogoDerechohabiente` lookup nil).
- After test-driver and spec fixes, rerun with `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o testnow.json` passed with `535 examples, 0 failures, 79 pending`.
- `Gemfile` source was updated from `http://rubygems.org` to `https://rubygems.org`; re-run `bundle outdated` and refresh the Phase 0 audit report so the dependency snapshot reflects the new source.
- Added rollback-readiness template: `docs/rails_upgrade_phase0_rollback_readiness.md`.
- `bundle outdated` was rerun successfully against `https://rubygems.org`; full output captured in `out.txt` (Bundler exits `1` when outdated gems are found).
- CI RSpec checklist item is marked `N/A` because no CI is configured for this project as of 2026-02-24.
- Added a dependency blocker-owner tracking table in `docs/rails_upgrade_phase0_report.md` with `TBD` owner placeholders to support assignment follow-up.
- Added missing smoke/system specs for Phase 0 gaps: `spec/system/activity_reports_spec.rb` (report create/read), `spec/system/patients_spec.rb` patient edit/update flow, and patient attachment upload flow.
- Changed spec files were syntax-checked first (`ruby -c`), and are now also validated by targeted and full RSpec reruns from this session.
- Targeted rerun of new smoke specs now passes from this session: `spec/system/activity_reports_spec.rb` + `spec/system/patients_spec.rb` => `18 examples, 0 failures, 4 pending` (`testnow.json`).
- Full suite rerun after smoke-spec additions passes from this session: `538 examples, 0 failures, 79 pending` (`rspec_phase0_after_smoke.json`).
- Project is single-maintainer (no separate Eng/QA/Ops functions), so checklist sign-off rows are marked `N/A` and dependency blocker owners are assigned to the project maintainer.
- Rollback-readiness checklist items are marked `N/A` for now because the app is not currently deployed anywhere (security/maintenance pause); deployment backup/restore/rollback runbooks must be defined before any future staging/production rollout.
