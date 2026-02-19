# Rails Upgrade Phase 0 Checklist

Use this checklist to complete Phase 0 from `docs/rails_upgrade_plan.md`.

## A) Baseline inventory
- [x] Collect runtime versions (`ruby -v`, `bundle -v`, `bundle exec rails -v`).
- [x] Record repo-declared versions from `.ruby-version`, `Gemfile`, and `Gemfile.lock`.
- [x] Save results in `docs/rails_upgrade_phase0_report.md`.

## B) Dependency snapshot
- [ ] Run `bundle install` in the project runtime and verify `bundle check` passes.
- [ ] Capture `bundle list` output.
- [ ] Capture `bundle outdated` output.
- [ ] Identify blockers and assign owners.

## C) Validation safety net
- [ ] Run `bundle exec rspec` in CI and store build link.
- [ ] Confirm coverage for: auth, patient CRUD, reports, file uploads, admin workflows.
- [ ] Create missing smoke/system specs where required.

## D) Rollback readiness
- [ ] Document DB backup procedure (owner/link):
- [ ] Document DB restore drill (owner/link):
- [ ] Document one-command deploy rollback path (owner/link):

## E) Sign-off
- [ ] Engineering sign-off
- [ ] QA sign-off
- [ ] Ops sign-off
