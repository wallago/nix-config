---
name: release
description: Cut a release for this repo with git-cliff. Use when the user asks to release, bump a version, or update the CHANGELOG.
disable-model-invocation: true
---

Release flow:

1. `git cliff --unreleased` to preview the entries.
2. Pick the version from the commit types (feat -> minor, fix -> patch).
3. `git cliff --tag vX.Y.Z -o CHANGELOG.md`
4. Commit as `chore(release): vX.Y.Z`, then `git tag vX.Y.Z`.
5. Never hand-edit CHANGELOG.md — it is generated.
