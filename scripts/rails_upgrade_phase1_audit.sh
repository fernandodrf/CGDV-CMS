#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_PATH="$ROOT_DIR/docs/rails_upgrade_phase1_report.md"

cd "$ROOT_DIR"

timestamp="$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
git_sha="$(git rev-parse --short HEAD)"
branch_name="$(git rev-parse --abbrev-ref HEAD)"

run_or_missing() {
  local cmd_name="$1"
  shift
  if command -v "$cmd_name" >/dev/null 2>&1; then
    "$@" 2>&1 || true
  else
    echo "$cmd_name: command not found"
  fi
}

file_or_missing() {
  local path="$1"
  if [[ -f "$path" ]]; then
    echo "present"
  else
    echo "missing"
  fi
}

ruby_runtime="$(run_or_missing ruby ruby -v)"
bundler_runtime="$(run_or_missing bundle bundle -v)"
gem_runtime="$(run_or_missing gem gem -v)"
bundler_gems="$(run_or_missing gem gem list '^bundler$' -a)"
rvm_rubies="$(run_or_missing rvm rvm list strings)"

ruby_version_repo="$(cat .ruby-version 2>/dev/null || echo 'not set')"
gemfile_ruby_constraint="$(awk '
  /^ruby[[:space:]]/ {
    line = $0
    sub(/^ruby[[:space:]]+["\047]/, "", line)
    sub(/["\047].*/, "", line)
    print line
    exit
  }
' Gemfile 2>/dev/null || true)"
gemfile_ruby_constraint="${gemfile_ruby_constraint:-not found}"
lockfile_ruby="$(awk '
  /^RUBY VERSION$/ { getline; gsub(/^[[:space:]]+/, "", $0); print; exit }
' Gemfile.lock 2>/dev/null || true)"
lockfile_ruby="${lockfile_ruby:-not found}"
lockfile_bundler="$(awk '
  /^BUNDLED WITH$/ { getline; gsub(/^[[:space:]]+/, "", $0); print; exit }
' Gemfile.lock 2>/dev/null || true)"
lockfile_bundler="${lockfile_bundler:-not found}"
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

travis_present="$(file_or_missing .travis.yml)"
travis_ruby="$(awk '/^rvm:/{flag=1; next} flag && /^[[:space:]]*-[[:space:]]/ {gsub(/^[[:space:]]*-[[:space:]]*/, ""); print; exit}' .travis.yml 2>/dev/null || echo 'not found')"
travis_postgres="$(awk -F'"' '/postgresql:/ {print $2; exit}' .travis.yml 2>/dev/null || echo 'not found')"

docker_files="$(find . -maxdepth 2 \( -name 'Dockerfile*' -o -name 'docker-compose*' \) -type f | sort || true)"
docker_files="${docker_files:-none found}"
github_actions_dir="missing"
[[ -d .github/workflows ]] && github_actions_dir="present"
deploy_configs="$(find config -maxdepth 2 -type f \( -name 'deploy*' -o -name '*.cap' \) 2>/dev/null | sort || true)"
deploy_configs="${deploy_configs:-none found}"
docker_files_status="present"
deploy_configs_status="present"
[[ "$docker_files" == "none found" ]] && docker_files_status="none found"
[[ "$deploy_configs" == "none found" ]] && deploy_configs_status="none found"

native_gem_inventory="$(awk '
  BEGIN {
    split("pg nokogiri puma bootsnap ffi nio4r sassc msgpack websocket-driver", gems, " ")
    for (i in gems) wanted[gems[i]] = 1
  }
  /^[[:space:]]{4}[a-zA-Z0-9_.-]+ \(/ {
    name = $1
    ver = $2
    gsub(/[()]/, "", ver)
    if (wanted[name]) print name " " ver
  }
' Gemfile.lock 2>/dev/null | sort || true)"
native_gem_inventory="${native_gem_inventory:-none found}"

legacy_gem_inventory="$(awk '
  BEGIN {
    split("rails-i18n devise ransack turbolinks spring rails-jquery-autocomplete nested_form coffee-rails jquery-rails jquery-ui-rails webdrivers rspec-rails", gems, " ")
    for (i in gems) wanted[gems[i]] = 1
  }
  /^[[:space:]]{4}[a-zA-Z0-9_.-]+ \(/ {
    name = $1
    ver = $2
    gsub(/[()]/, "", ver)
    if (wanted[name]) print name " " ver
  }
' Gemfile.lock 2>/dev/null | sort || true)"
legacy_gem_inventory="${legacy_gem_inventory:-none found}"

phase0_suite_summary="not found"
if [[ -f rspec_phase0_after_smoke.json ]]; then
  if command -v jq >/dev/null 2>&1; then
    phase0_suite_summary="$(jq -r '.summary_line' rspec_phase0_after_smoke.json 2>/dev/null || echo 'failed to parse rspec_phase0_after_smoke.json')"
  else
    phase0_suite_summary="rspec_phase0_after_smoke.json present (install jq to parse summary automatically)"
  fi
fi

ruby31_available="no"
ruby32_available="no"
ruby33_available="no"
command -v ruby3.1 >/dev/null 2>&1 && ruby31_available="yes ($(ruby3.1 -v 2>&1 || true))"
command -v ruby3.2 >/dev/null 2>&1 && ruby32_available="yes ($(ruby3.2 -v 2>&1 || true))"
command -v ruby3.3 >/dev/null 2>&1 && ruby33_available="yes ($(ruby3.3 -v 2>&1 || true))"

{
  echo "# Rails Upgrade Phase 1 Prerequisites Report"
  echo
  echo "Generated at: $timestamp"
  echo "Git revision: $git_sha"
  echo "Branch: $branch_name"
  echo
  echo "Use this report to track Phase 1 from \`docs/rails_upgrade_plan.md\`:"
  echo "- Ruby upgrade path (\`2.7.7 -> 3.1 -> 3.2/3.3\`)"
  echo "- Bundler alignment with the active Ruby"
  echo "- Infra/runtime parity checks (CI/base image/deploy runtime)"
  echo "- Native gem rebuild readiness"
  echo
  echo "## 1) Current baseline carried forward from Phase 0"
  echo "- Rails (lockfile): $rails_lock"
  echo "- Repo .ruby-version: $ruby_version_repo"
  echo "- Gemfile ruby constraint: $gemfile_ruby_constraint"
  echo "- Lockfile Ruby version: $lockfile_ruby"
  echo "- Lockfile Bundler version: $lockfile_bundler"
  echo "- Latest local Phase 0 suite evidence: $phase0_suite_summary"
  echo
  echo "## 2) Runtime toolchain readiness (current environment)"
  echo
  echo "### Active runtime"
  echo "- Ruby runtime: $ruby_runtime"
  echo "- Bundler runtime: $bundler_runtime"
  echo "- RubyGems runtime: $gem_runtime"
  echo
  echo "### Installed Bundler gem versions (active Ruby)"
  echo '```text'
  echo "$bundler_gems"
  echo '```'
  echo
  echo "### Installed Rubies (RVM)"
  echo '```text'
  echo "$rvm_rubies"
  echo '```'
  echo
  echo "### Ruby 3.x executables on PATH"
  echo "- ruby3.1: $ruby31_available"
  echo "- ruby3.2: $ruby32_available"
  echo "- ruby3.3: $ruby33_available"
  echo
  echo "## 3) Infra/runtime parity inventory"
  echo "- .travis.yml: $travis_present"
  echo "- Legacy Travis Ruby: $travis_ruby"
  echo "- Legacy Travis PostgreSQL: $travis_postgres"
  echo "- GitHub Actions workflows dir: $github_actions_dir"
  echo "- Docker files: $docker_files_status"
  echo "- Deploy configs under \`config/\`: $deploy_configs_status"
  echo
  echo "### Detected Docker-related files"
  echo '```text'
  echo "$docker_files"
  echo '```'
  echo
  echo "### Detected deploy config files"
  echo '```text'
  echo "$deploy_configs"
  echo '```'
  echo
  echo "## 4) Native gem rebuild inventory (Ruby/OS sensitive)"
  echo '```text'
  echo "$native_gem_inventory"
  echo '```'
  echo
  echo "Notes:"
  echo "- These gems should be explicitly rebuilt/reinstalled and smoke-tested after switching to Ruby 3.x."
  echo "- Common failure modes: OpenSSL/libpq/libxml2 ABI differences, compilation flags, old binary cache artifacts."
  echo
  echo "## 5) High-risk compatibility hotspots (Phase 1 -> Rails 6.1/7.x path)"
  echo '```text'
  echo "$legacy_gem_inventory"
  echo '```'
  echo
  echo "Phase 1 focus guidance:"
  echo "- Keep Rails pinned at 6.0.6 during Ruby upgrade; do not mix Ruby and Rails major changes in one step."
  echo "- Upgrade Bundler after the Ruby switch, then regenerate the lockfile under that Ruby/Bundler pair."
  echo "- Re-run full RSpec under the new Ruby before attempting Rails 6.1."
  echo
  echo "## 6) Phase 1 executable command checklist (when Ruby 3.x is installed)"
  echo '```bash'
  echo "# Example RVM path (choose exact target, e.g. 3.1.6 or 3.2.4)"
  echo "rvm install 3.1.6"
  echo "rvm use 3.1.6 --default"
  echo "gem install bundler"
  echo
  echo "# Align repo version files (after deciding exact version)"
  echo "# edit .ruby-version"
  echo "bundle update --bundler"
  echo "bundle install"
  echo
  echo "# Rebuild native gems and validate"
  echo "bundle pristine pg nokogiri nio4r msgpack || true"
  echo "bundle exec rspec -f j -o rspec_phase1_ruby3.json"
  echo '```'
  echo
  echo "## 7) Phase 1 status summary (current branch)"
  echo "- [x] Phase 0 baseline + tests are green and documented (\`538 examples, 0 failures, 79 pending\`)."
  echo "- [x] Phase 1 prerequisite audit created (this report + checklist)."
  echo "- [ ] Ruby 3.1 runtime installed in local dev environment."
  echo "- [ ] Bundler upgraded/aligned for Ruby 3.1 runtime."
  echo "- [ ] Repo updated to new Ruby version (\`.ruby-version\`, \`Gemfile.lock\` RUBY VERSION / BUNDLED WITH)."
  echo "- [ ] Native gems rebuilt under Ruby 3.x."
  echo "- [ ] Full test suite rerun and captured under Ruby 3.x."
  echo "- [ ] Infra image/CI/runtime docs updated (or marked N/A with rationale)."
  echo
  echo "## 8) Next actions"
  echo "1. Install Ruby 3.1.x locally (RVM) and rerun this audit script to confirm runtime/toolchain detection changes."
  echo "2. Switch the repo to Ruby 3.1.x in \`.ruby-version\` and regenerate \`Gemfile.lock\` under the new Bundler."
  echo "3. Run full RSpec under Ruby 3.1.x and record results in this report/checklist."
  echo "4. Repeat the process for the next Ruby target (3.2.x or 3.3.x) before starting the Rails 6.1 upgrade."
} > "$REPORT_PATH"

echo "Wrote $REPORT_PATH"
