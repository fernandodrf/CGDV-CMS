#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_PATH="$ROOT_DIR/docs/rails_upgrade_phase0_report.md"

cd "$ROOT_DIR"

timestamp="$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
git_sha="$(git rev-parse --short HEAD)"

run_or_missing() {
  local cmd_name="$1"
  shift
  if command -v "$cmd_name" >/dev/null 2>&1; then
    "$@" 2>&1 || true
  else
    echo "$cmd_name: command not found"
  fi
}

ruby_version_runtime="$(run_or_missing ruby ruby -v)"
bundler_version_runtime="$(run_or_missing bundle bundle -v)"

if command -v bundle >/dev/null 2>&1; then
  rails_runtime="$(bundle exec rails -v 2>&1 || true)"
  missing_gems="$(bundle check 2>&1 || true)"
  bundle_list_output="$(bundle list 2>&1 || true)"
  outdated_output="$(bundle outdated 2>&1 || true)"
else
  rails_runtime="bundle: command not found"
  missing_gems="bundle: command not found"
  bundle_list_output="bundle: command not found"
  outdated_output="bundle: command not found"
fi

ruby_version_repo="$(cat .ruby-version 2>/dev/null || echo 'not set')"
rails_gemfile="$(awk '
  /gem[[:space:]]+["\047]rails["\047]/ {
    if (match($0, /["\047]~?>[^"\047]*["\047]/)) {
      val = substr($0, RSTART + 1, RLENGTH - 2)
      print val
      exit
    }
  }
' Gemfile 2>/dev/null || true)"
rails_gemfile="${rails_gemfile:-not found}"
rails_lock="$(awk '
  /^[[:space:]]{4}rails \(/ {
    line = $0
    sub(/^[[:space:]]*rails \(/, "", line)
    sub(/\).*/, "", line)
    print line
    exit
  }
' Gemfile.lock 2>/dev/null || true)"
rails_lock="${rails_lock:-not found}"
gem_source="$(awk '/^source / {gsub(/["\x27]/, "", $2); print $2; exit}' Gemfile 2>/dev/null || echo 'not found')"
travis_ruby="$(awk '/^rvm:/{flag=1; next} flag && /^[[:space:]]*-[[:space:]]/ {gsub(/^[[:space:]]*-[[:space:]]*/, ""); print; exit}' .travis.yml 2>/dev/null || echo 'not found')"
travis_postgres="$(awk -F'"' '/postgresql:/ {print $2; exit}' .travis.yml 2>/dev/null || echo 'not found')"

spec_system_files="$(find spec/system -type f -name '*_spec.rb' 2>/dev/null | sort || true)"

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
  echo "- Gem source (Gemfile): $gem_source"
  echo
  echo "### Runtime environment"
  echo "- Ruby runtime: $ruby_version_runtime"
  echo "- Bundler runtime: $bundler_version_runtime"
  echo "- Rails runtime: $rails_runtime"
  echo
  echo "### CI baseline (from .travis.yml)"
  echo "- CI Ruby: $travis_ruby"
  echo "- CI PostgreSQL: $travis_postgres"
  echo "- CI command: bundle exec rspec"
  echo
  echo "## 2) Dependency tree health"
  echo
  echo "### bundle check"
  echo '```text'
  echo "$missing_gems"
  echo '```'
  echo
  echo "### bundle list"
  echo '```text'
  echo "$bundle_list_output"
  echo '```'
  echo
  echo "### bundle outdated"
  echo '```text'
  echo "$outdated_output"
  echo '```'
  echo
  echo "## 3) Validation safety net inventory (static)"
  echo
  echo "### System specs present"
  echo '```text'
  echo "$spec_system_files"
  echo '```'
  echo
  echo "### Critical workflow smoke coverage audit (static review)"
  echo "- Authentication: present in \`spec/system/users_spec.rb\` (landing page, sign-in success/failure, password recovery flow with known FIXME notes)."
  echo "- Patient CRUD: present in \`spec/system/patients_spec.rb\` (index/create/show and role/delete visibility). Patient edit/update smoke coverage is still missing (\`xdescribe \\\"Existing patient file\\\"\`)."
  echo "- Reports (activity reports): no dedicated system/controller smoke coverage found; only model coverage plus commented activity report navigation checks in \`spec/system/users_spec.rb\`."
  echo "- File uploads: no end-to-end upload smoke coverage found; \`spec/models/attachment_spec.rb\` covers validations, and \`spec/system/patients_spec.rb\` has pending attachment creation coverage."
  echo "- Admin workflows: strong coverage in \`spec/system/users_spec.rb\` for admin user management and role-based access; report/file-upload admin smoke paths remain gaps."
  echo
  echo "### Current blockers (from this environment)"
  echo "- \`bundle outdated\` may fail to fetch from \`http://rubygems.org\` depending on network policy/proxy access."
  echo "- CI-style test execution requires PostgreSQL access and seeded test DB; local sandboxed runs may fail with \`PG::ConnectionBad\`."
  echo
  echo "## 4) Phase 0 status summary"
  echo "- [x] Baseline inventory captured."
  echo "- [ ] Dependency tree snapshot complete (bundle list/bundle outdated) in a fully provisioned Ruby/Bundler environment."
  echo "- [ ] CI test execution confirmed (bundle exec rspec)."
  echo "- [x] Smoke test coverage audited for critical workflows (static spec inventory + gap review)."
  echo "- [ ] Backup/restore and one-command rollback documented."
  echo
  echo "## 5) Next actions"
  echo "1. Run bundle install in the target Ruby version declared for this phase (if not already done in the current environment)."
  echo "2. Re-run this script to collect successful rails -v, bundle list, and bundle outdated outputs (or capture bundle outdated fetch failure as a blocker)."
  echo "3. Execute bundle exec rspec in CI/provisioned dev image and attach result to this report."
  echo "4. Fill out docs/rails_upgrade_phase0_checklist.md with owners/links for dependency, test, and rollback blockers."
} > "$REPORT_PATH"

echo "Wrote $REPORT_PATH"
