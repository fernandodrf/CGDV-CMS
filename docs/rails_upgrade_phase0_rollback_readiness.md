# Rails Upgrade Phase 0 Rollback Readiness (Template)

Use this document to complete Phase 0 rollback requirements from `docs/rails_upgrade_plan.md`.

Note: this repository does not include deployment/ops automation files (no CI/deploy config detected in-repo), so backup/restore/rollback commands and runbook links must be copied from your actual environment tooling.

## Scope
- Environment(s): `staging` / `production` / other:
- Service/app name:
- Owner (engineering): `Project maintainer` (single-maintainer project, if applicable)
- Owner (ops/platform): `Project maintainer` (if no separate ops role)
- Last updated:
- Current deployment status: `Not deployed` (Phase 0 rollback items may be marked `N/A` until deployment resumes)

## 1) Database backup procedure
- Owner:
- Runbook link:
- Command(s):
```bash
# Example
# pg_dump ...
```
- Backup location / retention:
- Preconditions:
- Validation step (how to confirm backup is usable):

## 2) Database restore drill
- Owner:
- Runbook link:
- Last successful drill date:
- Restore target environment (non-prod recommended):
- Command(s):
```bash
# Example
# psql ...
```
- Expected restore duration:
- Validation checklist after restore:
  - Application boots
  - Can sign in
  - Key tables present
  - Recent expected records visible

## 3) One-command application rollback path
- Owner:
- Deployment tooling (Capistrano/Ansible/Docker/etc.):
- Rollback command:
```bash
# Example
# deploy rollback
```
- Preconditions / permissions required:
- How to verify rollback succeeded:
- Known caveats (migrations, background jobs, asset compatibility):

## 4) Rails upgrade-specific notes
- Are backward-incompatible migrations present? `yes/no`
- If yes, rollback strategy for DB schema:
- Feature flags involved? `yes/no`
- Extra steps for assets / background workers / cron:

## 5) Sign-off
- Engineering sign-off: `N/A` for single-maintainer project (or record maintainer acknowledgement)
- QA sign-off: `N/A` for single-maintainer project
- Ops sign-off: `N/A` for single-maintainer project
