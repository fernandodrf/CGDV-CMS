#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_PATH="$ROOT_DIR/docs/rails_upgrade_phase0_report.md"

cd "$ROOT_DIR"

timestamp="$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
git_sha="$(git rev-parse --short HEAD)"

ruby_version_runtime="$(ruby -v 2>&1 || true)"
bundler_version_runtime="$(bundle -v 2>&1 || true)"
rails_runtime="$(bundle exec rails -v 2>&1 || true)"

ruby_version_repo="$(cat .ruby-version 2>/dev/null || echo 'not set')"
rails_gemfile="$(ruby -ne 'if $_ =~ /gem\s+["\x27]rails["\x27],\s*["\x27]([^"\x27]+)["\x27]/; puts $1; exit; end' Gemfile 2>/dev/null || echo 'not found')"
rails_lock="$(ruby -ne 'if $_ =~ /^\s{4}rails \(([^)]+)\)/; puts $1; exit; end' Gemfile.lock 2>/dev/null || echo 'not found')"

missing_gems="$(bundle check 2>&1 || true)"
outdated_output="$(bundle outdated 2>&1 || true)"

{
  echo "# Rails Upgrade Phase 0 Audit Report"
  echo
  echo "Generated at: $timestamp"
  echo "Git revision: $git_sha"
  echo
  echo "## 1) Baseline inventory"
  echo
  echo "### Repo-declared versions"
  echo "- .ruby-version: $ruby_version_repo"
  echo "- Rails (Gemfile constraint): $rails_gemfile"
  echo "- Rails (Gemfile.lock resolved): $rails_lock"
  echo
  echo "### Runtime environment"
  echo "- Ruby runtime: $ruby_version_runtime"
  echo "- Bundler runtime: $bundler_version_runtime"
  echo "- Rails runtime: $rails_runtime"
  echo
  echo "## 2) Dependency tree health"
  echo
  echo "### bundle check"
  echo '```text'
  echo "$missing_gems"
  echo '```'
  echo
  echo "### bundle outdated"
  echo '```text'
  echo "$outdated_output"
  echo '```'
  echo
  echo "## 3) Phase 0 status summary"
  echo "- [x] Baseline inventory captured."
  echo "- [ ] Dependency tree snapshot complete (bundle list/bundle outdated) in a fully provisioned Ruby/Bundler environment."
  echo "- [ ] CI test execution confirmed (bundle exec rspec)."
  echo "- [ ] Smoke test coverage audited for critical workflows."
  echo "- [ ] Backup/restore and one-command rollback documented."
  echo
  echo "## 4) Next actions"
  echo "1. Run bundle install in the target Ruby version declared for this phase."
  echo "2. Re-run this script to collect successful rails -v, bundle list, and bundle outdated outputs."
  echo "3. Execute bundle exec rspec and attach result to this report."
  echo "4. Fill out docs/rails_upgrade_phase0_checklist.md with owners and links."
} > "$REPORT_PATH"

echo "Wrote $REPORT_PATH"
