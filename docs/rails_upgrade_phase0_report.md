# Rails Upgrade Phase 0 Audit Report

Generated at: 2026-02-23 20:39:10 UTC
Git revision: 9301f66

## 1) Baseline inventory

### Repo-declared versions
- .ruby-version: 2.7.7
- Rails (Gemfile constraint): ~> 6.0.6
- Rails (Gemfile.lock resolved): 6.0.6
- Gem source (Gemfile): https://rubygems.org (updated after initial audit capture; re-run audit to refresh `bundle outdated` section)

### Runtime environment
- Ruby runtime: ruby 2.7.7p221 (2022-11-24 revision 168ec2b1e5) [x86_64-linux]
- Bundler runtime: Bundler version 2.1.4
- Rails runtime: Rails 6.0.6

### CI baseline (from .travis.yml)
- CI Ruby: 2.7.1
- CI PostgreSQL: 9.5
- CI command: bundle exec rspec

## 2) Dependency tree health

### bundle install
```text
bundle install completed successfully in local Ruby 2.7.7 / Bundler 2.1.4 runtime (no gem changes required; existing bundle reused).
```

### bundle check
```text
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
The Gemfile's dependencies are satisfied
```

### bundle list
```text
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Gems included by the bundle:
  * actioncable (6.0.6)
  * actionmailbox (6.0.6)
  * actionmailer (6.0.6)
  * actionpack (6.0.6)
  * actiontext (6.0.6)
  * actionview (6.0.6)
  * activejob (6.0.6)
  * activemodel (6.0.6)
  * activerecord (6.0.6)
  * activestorage (6.0.6)
  * activesupport (6.0.6)
  * addressable (2.8.0)
  * annotate (3.2.0)
  * bcrypt (3.1.18)
  * bindex (0.8.1)
  * bootsnap (1.15.0)
  * builder (3.2.4)
  * byebug (11.1.3)
  * cancancan (3.4.0)
  * capybara (3.37.1)
  * capybara-email (3.0.2)
  * carrierwave (2.1.1)
  * childprocess (4.1.0)
  * coffee-rails (5.0.0)
  * coffee-script (2.4.1)
  * coffee-script-source (1.12.2)
  * concurrent-ruby (1.1.10)
  * crass (1.0.6)
  * date (3.3.1)
  * devise (4.8.1)
  * devise-i18n (1.10.2)
  * diff-lcs (1.5.0)
  * docile (1.4.0)
  * erubi (1.11.0)
  * execjs (2.8.1)
  * factory_bot (6.2.1)
  * factory_bot_rails (6.2.0)
  * faker (2.21.0)
  * ffi (1.15.5)
  * globalid (1.0.0)
  * i18n (1.12.0)
  * image_processing (1.12.2)
  * jbuilder (2.11.5)
  * jquery-rails (4.5.0)
  * jquery-ui-rails (6.0.1)
  * kaminari (1.2.2)
  * kaminari-actionview (1.2.2)
  * kaminari-activerecord (1.2.2)
  * kaminari-core (1.2.2)
  * launchy (2.5.0)
  * listen (3.7.1)
  * loofah (2.19.1)
  * mail (2.8.0)
  * marcel (1.0.2)
  * matrix (0.4.2)
  * method_source (1.0.0)
  * mimemagic (0.4.3)
  * mini_magick (4.11.0)
  * mini_mime (1.1.2)
  * mini_portile2 (2.8.0)
  * minitest (5.16.3)
  * msgpack (1.6.0)
  * nested_form (0.3.2)
  * net-imap (0.3.2)
  * net-pop (0.1.2)
  * net-protocol (0.2.1)
  * net-smtp (0.3.3)
  * nio4r (2.5.8)
  * nokogiri (1.13.10)
  * orm_adapter (0.5.0)
  * pg (1.4.5)
  * psych (4.0.4)
  * public_suffix (4.0.7)
  * puma (5.6.5)
  * racc (1.6.1)
  * rack (2.2.4)
  * rack-accept (0.4.5)
  * rack-test (2.0.2)
  * rails (6.0.6)
  * rails-controller-testing (1.0.5)
  * rails-dom-testing (2.0.3)
  * rails-html-sanitizer (1.4.4)
  * rails-i18n (6.0.0)
  * rails-jquery-autocomplete (1.0.5)
  * railties (6.0.6)
  * rake (13.0.6)
  * ransack (3.1.0)
  * rb-fsevent (0.11.1)
  * rb-inotify (0.10.1)
  * rdoc (6.4.0)
  * regexp_parser (2.5.0)
  * responders (3.0.1)
  * rexml (3.2.5)
  * rspec-core (3.11.0)
  * rspec-expectations (3.11.0)
  * rspec-mocks (3.11.1)
  * rspec-rails (4.1.2)
  * rspec-support (3.11.0)
  * ruby-vips (2.1.4)
  * rubyzip (2.3.2)
  * sass-rails (6.0.0)
  * sassc (2.4.0)
  * sassc-rails (2.1.2)
  * sdoc (1.1.0)
  * selenium-webdriver (4.3.0)
  * shoulda-matchers (5.1.0)
  * simplecov (0.21.2)
  * simplecov-html (0.12.3)
  * simplecov_json_formatter (0.1.4)
  * slow_your_roles (2.0.4)
  * spring (2.1.1)
  * spring-commands-rspec (1.0.4)
  * spring-watcher-listen (2.0.1)
  * sprockets (4.1.1)
  * sprockets-rails (3.4.2)
  * ssrf_filter (1.0.7)
  * stringio (3.0.2)
  * thor (1.2.1)
  * thread_safe (0.3.6)
  * tilt (2.0.11)
  * timeout (0.3.1)
  * turbolinks (5.2.1)
  * turbolinks-source (5.2.0)
  * turnout (2.5.0)
  * tzinfo (1.2.10)
  * uglifier (4.2.0)
  * warden (1.2.9)
  * web-console (4.2.0)
  * webdrivers (5.0.0)
  * websocket (1.2.9)
  * websocket-driver (0.7.5)
  * websocket-extensions (0.1.5)
  * xpath (3.2.0)
  * zeitwerk (2.6.6)
Use `bundle info` to print more detailed information about a gem
```

### bundle outdated
```text
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Fetching source index from http://rubygems.org/

Retrying fetcher due to error (2/4): Bundler::HTTPError Could not fetch specs from http://rubygems.org/

Retrying fetcher due to error (3/4): Bundler::HTTPError Could not fetch specs from http://rubygems.org/

Retrying fetcher due to error (4/4): Bundler::HTTPError Could not fetch specs from http://rubygems.org/

Could not fetch specs from http://rubygems.org/
```

### bundle outdated (successful rerun after HTTPS source change; captured in `out.txt`)
- Command: `bundle outdated > out.txt` (exit code `1` is expected when outdated gems are present)
- Result: successful metadata fetch from `https://rubygems.org`; outdated list captured in `out.txt`
- Snapshot highlights (highest relevance to planned Rails upgrade path):
  - Rails stack is far behind: `rails`/`railties`/`activesupport` etc. at `6.0.6` vs newest `8.1.2`
  - `rails-i18n` (`6.0.0` -> `8.1.0`) is a likely upgrade gate for Rails 7/8 phases
  - `rspec-rails` (`4.1.2` -> `8.0.3`) is significantly behind and may require stepwise upgrades
  - `devise` (`4.8.1` -> `5.0.2`) and `ransack` (`3.1.0` -> `4.4.1`) likely need compatibility review during Rails upgrades
  - Legacy frontend/test tooling remains old: `jquery-ui-rails`, `turbolinks`, `spring`, `webdrivers`, `selenium-webdriver`
  - Native/runtime-sensitive gems to watch during Ruby upgrades: `pg`, `nokogiri`, `puma`, `bootsnap`

### Dependency blocker-owner tracking (Phase 0 placeholder table)

| Blocker / review area | Why it matters | Suggested phase | Owner |
| --- | --- | --- | --- |
| Rails core stack (`rails`, `railties`, `activesupport`, etc.) | Primary upgrade path and compatibility driver for all app/framework behavior | Phase 1+ | Project maintainer |
| `rails-i18n` | Often version-gated against Rails major/minor versions | Phase 1+ | Project maintainer |
| Auth stack (`devise`, `warden`) | Login/session flows are critical and commonly impacted by framework upgrades | Phase 1+ | Project maintainer |
| Search/filtering (`ransack`) | Query params/forms/admin listing behavior may break on upgrades | Phase 1+ | Project maintainer |
| Test stack (`rspec-rails`, `capybara`, `selenium-webdriver`, `webdrivers`) | Needed to keep validation suite runnable through upgrade steps | Phase 1+ | Project maintainer |
| Frontend legacy tooling (`turbolinks`, `jquery-ui-rails`, `spring`) | Compatibility/deprecation cleanup risk during Rails upgrades | Phase 1+ | Project maintainer |
| Native/runtime-sensitive gems (`pg`, `nokogiri`, `puma`, `bootsnap`) | Ruby/OS upgrades can require binary rebuilds or version coordination | Phase 1+ | Project maintainer |

## 3) Validation safety net inventory (static)

### System specs present
```text
spec/system/activity_reports_spec.rb
spec/system/notes_spec.rb
spec/system/patients_spec.rb
spec/system/users_spec.rb
spec/system/volunteers_spec.rb
```

### Critical workflow smoke coverage audit (static review)
- Authentication: `spec/system/users_spec.rb` covers landing page, sign-in success/failure, and password recovery flow (password recovery spec has known FIXME comments).
- Patient CRUD: `spec/system/patients_spec.rb` covers patient index navigation, create flow, read flow, delete visibility/permissions, and now includes a patient edit/update smoke example for main patient information.
- Reports (activity reports): `spec/system/activity_reports_spec.rb` added for create/read smoke coverage (service-social role creates a report and verifies the show/index flow).
- File uploads: patient attachment upload smoke coverage added in `spec/system/patients_spec.rb` (creates a patient attachment via the nested attachment form and verifies it appears in the patient file).
- Admin workflows: `spec/system/users_spec.rb` includes admin user creation/deletion and role-based access checks. Explicit admin smoke for report/file-upload management remains missing.
- Other smoke coverage present: `spec/system/notes_spec.rb` and `spec/system/volunteers_spec.rb`.

### Smoke gap closure (implemented and validated on 2026-02-24)
- `spec/system/activity_reports_spec.rb`: adds report create/read smoke flow for a user with `ss` role.
- `spec/system/patients_spec.rb`: replaces the `xdescribe "Existing patient file"` placeholder with a patient main-info edit/update smoke test.
- `spec/system/patients_spec.rb`: adds patient attachment upload smoke coverage using the nested attachments form.
- Validation status (updated): changed spec files passed `ruby -c` syntax checks, targeted rerun passed (`18 examples, 0 failures, 4 pending` in `testnow.json`), and a subsequent full-suite rerun passed (`538 examples, 0 failures, 79 pending` in `rspec_phase0_after_smoke.json`).

### Historical blockers observed during initial sandbox audit capture
- Local RSpec execution fails before application tests can run due PostgreSQL socket access being denied (`PG::ConnectionBad` on `/var/run/postgresql/.s.PGSQL.5432`).
- At the time of this audit capture, `Gemfile` pointed to `http://rubygems.org` (not HTTPS), which increased the chance of fetch/proxy issues during upgrade work.

## 4) Validation execution (local runtime)

### bundle exec rspec (sandboxed shell attempt on 2026-02-23)
- Command: `bundle exec rspec`
- Result: failed in sandbox before app-level validation
- Summary: `535 examples, 478 failures, 57 pending`
- Primary blocker observed: `PG::ConnectionBad` (`Operation not permitted`) connecting to local PostgreSQL socket `/var/run/postgresql/.s.PGSQL.5432`
- Evidence log captured at `/tmp/phase0_rspec.log` during that session

### bundle exec rspec (user local run captured in `rspec20260224.json` on 2026-02-24)
- Result: mostly passing, with a small number of failures
- Summary: `535 examples, 4 failures, 79 pending`
- Failed examples:
  - `./spec/system/notes_spec.rb:18` — `OpenSSL::SSL::SSLError` (`webdrivers`/Chromedriver HTTPS fetch certificate verification failure)
  - `./spec/system/users_spec.rb:76` — `OpenSSL::SSL::SSLError` (`webdrivers`/Chromedriver HTTPS fetch certificate verification failure)
  - `./spec/system/patients_spec.rb:173` — `Capybara::ElementNotFound` (missing `"México"` option in country select)
  - `./spec/system/patients_spec.rb:191` — `NoMethodError` (`undefined method 'seguro' for nil:NilClass`, likely missing seeded catalog data)
- SSL failure root cause (from JSON backtrace): `webdrivers-5.0.0` attempting to fetch Chromedriver metadata over HTTPS and failing local certificate verification.

### bundle exec rspec (user local rerun with Chrome override in `testnow.json` on 2026-02-24)
- Command: `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o testnow.json`
- Result: passed (with pending examples)
- Summary: `535 examples, 0 failures, 79 pending`
- Notes:
  - JS/system specs were run with Chrome (`selenium_chrome_headless`) by setting `CHROMEDRIVER_PATH`, which avoided `webdrivers` SSL failures from Firefox/geckodriver auto-download.
  - Non-blocking warnings observed during run: Ruby `net-protocol` constant redefinition warnings and Rails 6 autoload deprecation warning for ActionText helpers during initialization.

### bundle exec rspec (targeted rerun for new smoke specs in `testnow.json` on 2026-02-24)
- Command: `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec spec/system/activity_reports_spec.rb spec/system/patients_spec.rb -f j -o testnow.json`
- Result: passed (with pending examples inherited from `spec/system/patients_spec.rb`)
- Summary: `18 examples, 0 failures, 4 pending`
- Notes:
  - Initial targeted attempt surfaced a `Capybara::Ambiguous` failure in the new activity report spec due duplicate "Regresar a Reportes de Actividades" links on the show page.
  - Spec was patched to use `match: :first` for that back-link click, and the rerun passed.

### bundle exec rspec (full-suite rerun after smoke-spec additions in `rspec_phase0_after_smoke.json` on 2026-02-24)
- Command: `CHROMEDRIVER_PATH="$(command -v chromedriver)" bundle exec rspec -f j -o rspec_phase0_after_smoke.json`
- Result: passed (with pending examples)
- Summary: `538 examples, 0 failures, 79 pending`
- Notes:
  - Example count increased from `535` to `538` because three new smoke specs were added in Phase 0 (activity report create/read, patient edit/update, patient attachment upload).
  - Non-blocking warnings remain: Ruby `net-protocol` constant redefinition warnings and Rails autoload deprecation warning for ActionText helpers during initialization.

### Post-audit repo updates on this branch (2026-02-24)
- `Gemfile` source changed to `https://rubygems.org` (Phase 0 dependency hygiene improvement).
- `spec/support/capybara.rb` updated so `CHROMEDRIVER_PATH=...` forces Chrome headless for JS system specs and avoids Firefox/geckodriver `webdrivers` SSL download failures.
- `spec/system/patients_spec.rb` updated to avoid brittle assumptions about country options and seeded `CatalogoDerechohabiente` data.
- `spec/system/patients_spec.rb` updated to add patient edit/update and patient attachment upload smoke coverage.
- `spec/system/activity_reports_spec.rb` added to cover activity report create/read smoke flow.
- `spec/system/activity_reports_spec.rb` adjusted to disambiguate duplicate back-links on the show page (`match: :first`) after targeted rerun feedback.
- Rollback-readiness template added at `docs/rails_upgrade_phase0_rollback_readiness.md`.

## 5) Phase 0 status summary
- [x] Baseline inventory captured.
- [x] Dependency tree snapshot complete (bundle list + `bundle outdated` captured; see `out.txt` and report summary).
- [x] CI test execution confirmed (N/A: no CI configured as of 2026-02-24).
- [x] Smoke test coverage audited for critical workflows (static spec inventory + gap review).
- [x] Missing smoke spec gaps for reports, file uploads, and patient edit/update were implemented and validated (targeted rerun: `18 examples, 0 failures, 4 pending`).
- [x] Local test suite execution captured and rerun successfully (`rspec_phase0_after_smoke.json`: `538 examples, 0 failures, 79 pending`).
- [x] Dependency blocker ownership assigned (single-maintainer project; all Phase 1+ compatibility reviews assigned to project maintainer).
- [x] Eng/QA/Ops sign-offs are not required for this project structure (single-maintainer project as of 2026-02-24).
- [x] Backup/restore and one-command rollback documented (N/A for current project state: app is not deployed anywhere as of 2026-02-24; no active deployment runbooks/tooling).

## 6) Next actions
1. Capture/decide whether to track the non-blocking local warnings (Ruby `net-protocol` and Rails autoload deprecation) as separate cleanup tasks before upgrade phases.
2. If/when deployment resumes, replace the current `N/A` rollback entries with real backup/restore/rollback runbooks before any staging or production upgrade work.
