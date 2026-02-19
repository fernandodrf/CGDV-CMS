# Rails Upgrade Phase 0 Audit Report

Generated at: 2026-02-19 17:46:58 UTC
Git revision: dc99fb6

## 1) Baseline inventory

### Repo-declared versions
- .ruby-version: 2.7.7
- Rails (Gemfile constraint): ~> 6.0.6
- Rails (Gemfile.lock resolved): 6.0.6

### Runtime environment
- Ruby runtime: ruby 3.2.3 (2024-01-18 revision 52bb2ac0a6) [x86_64-linux]
- Bundler runtime: Bundler version 2.4.19
- Rails runtime: bundler: command not found: rails
Install missing gem executables with `bundle install`

## 2) Dependency tree health

### bundle check
```text
The following gems are missing
 * rails (6.0.6)
 * devise (4.8.1)
 * kaminari (1.2.2)
 * ransack (3.1.0)
 * cancancan (3.4.0)
 * pg (1.4.5)
 * slow_your_roles (2.0.4)
 * rails-i18n (6.0.0)
 * devise-i18n (1.10.2)
 * puma (5.6.5)
 * nested_form (0.3.2)
 * rails-jquery-autocomplete (1.0.5)
 * carrierwave (2.1.1)
 * mini_magick (4.11.0)
 * turnout (2.5.0)
 * nokogiri (1.13.10)
 * sass-rails (6.0.0)
 * uglifier (4.2.0)
 * coffee-rails (5.0.0)
 * jquery-rails (4.5.0)
 * jquery-ui-rails (6.0.1)
 * turbolinks (5.2.1)
 * jbuilder (2.11.5)
 * sdoc (1.1.0)
 * bootsnap (1.15.0)
 * rspec-rails (4.1.2)
 * factory_bot_rails (6.2.0)
 * byebug (11.1.3)
 * rails-controller-testing (1.0.5)
 * faker (2.21.0)
 * shoulda-matchers (5.1.0)
 * capybara (3.37.1)
 * capybara-email (3.0.2)
 * webdrivers (5.0.0)
 * launchy (2.5.0)
 * simplecov (0.21.2)
 * web-console (4.2.0)
 * listen (3.7.1)
 * spring (2.1.1)
 * spring-watcher-listen (2.0.1)
 * spring-commands-rspec (1.0.4)
 * annotate (3.2.0)
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
 * railties (6.0.6)
 * sprockets-rails (3.4.2)
 * bcrypt (3.1.18)
 * orm_adapter (0.5.0)
 * responders (3.0.1)
 * warden (1.2.9)
 * kaminari-actionview (1.2.2)
 * kaminari-activerecord (1.2.2)
 * kaminari-core (1.2.2)
 * i18n (1.12.0)
 * nio4r (2.5.8)
 * addressable (2.8.0)
 * image_processing (1.12.2)
 * mimemagic (0.4.3)
 * mini_mime (1.1.2)
 * ssrf_filter (1.0.7)
 * rack (2.2.4)
 * rack-accept (0.4.5)
 * tilt (2.0.11)
 * mini_portile2 (2.8.0)
 * racc (1.6.1)
 * sassc-rails (2.1.2)
 * execjs (2.8.1)
 * coffee-script (2.4.1)
 * rails-dom-testing (2.0.3)
 * thor (1.2.1)
 * turbolinks-source (5.2.0)
 * rdoc (6.4.0)
 * msgpack (1.6.0)
 * rspec-core (3.11.0)
 * rspec-expectations (3.11.0)
 * rspec-mocks (3.11.1)
 * rspec-support (3.11.0)
 * factory_bot (6.2.1)
 * rack-test (2.0.2)
 * regexp_parser (2.5.0)
 * xpath (3.2.0)
 * mail (2.8.0)
 * rubyzip (2.3.2)
 * selenium-webdriver (4.3.0)
 * docile (1.4.0)
 * simplecov-html (0.12.3)
 * simplecov_json_formatter (0.1.4)
 * bindex (0.8.1)
 * rb-fsevent (0.11.1)
 * rb-inotify (0.10.1)
 * websocket-driver (0.7.5)
 * rails-html-sanitizer (1.4.4)
 * builder (3.2.4)
 * erubi (1.11.0)
 * globalid (1.0.0)
 * marcel (1.0.2)
 * concurrent-ruby (1.1.10)
 * tzinfo (1.2.10)
 * zeitwerk (2.6.6)
 * method_source (1.0.0)
 * sprockets (4.1.1)
 * public_suffix (4.0.7)
 * ruby-vips (2.1.4)
 * sassc (2.4.0)
 * coffee-script-source (1.12.2)
 * psych (4.0.4)
 * diff-lcs (1.5.0)
 * net-imap (0.3.2)
 * net-smtp (0.3.3)
 * childprocess (4.1.0)
 * websocket (1.2.9)
 * ffi (1.15.5)
 * websocket-extensions (0.1.5)
 * loofah (2.19.1)
 * thread_safe (0.3.6)
 * stringio (3.0.2)
 * date (3.3.1)
 * crass (1.0.6)
Install missing gems with `bundle install`
```

### bundle outdated
```text
Fetching source index from http://rubygems.org/

Access token could not be authenticated for http://rubygems.org/.
Make sure it's valid and has the necessary scopes configured.
```

## 3) Phase 0 status summary
- [x] Baseline inventory captured.
- [ ] Dependency tree snapshot complete (bundle list/bundle outdated) in a fully provisioned Ruby/Bundler environment.
- [ ] CI test execution confirmed (bundle exec rspec).
- [ ] Smoke test coverage audited for critical workflows.
- [ ] Backup/restore and one-command rollback documented.

## 4) Next actions
1. Run bundle install in the target Ruby version declared for this phase.
2. Re-run this script to collect successful rails -v, bundle list, and bundle outdated outputs.
3. Execute bundle exec rspec and attach result to this report.
4. Fill out docs/rails_upgrade_phase0_checklist.md with owners and links.
