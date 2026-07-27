# SMF E2E fixture

This disposable repository exercises the public SMF Dart package and GitHub
Action against a real hosted repository.

It intentionally has no `release-candidate` or `ship` job. The workflow tests
configuration discovery, CLI commands, the reusable Dart API, the typed
`before_create_pr` hook, release-branch updates, and release-PR creation without
building, uploading, or submitting anything to Apple.

The fixture pins immutable sources:

- SMF core `cf826cb13267a4795b036b28c4168e4c56c34287`;
- SMF Action `988c687004c9ef9304d4b4fcb45c7d3c8446a24c`.

The Flutter-app-shaped project keeps its only configuration at
`smf/config.yaml`. Both the CLI and Action discover it automatically from the
repository root. The config omits `build_command`, `ipa_output_path`,
`bundle_id`, and `enabled` to exercise the normal defaults.

The typed hook at `smf/hooks/before_create_pr.dart` writes `smf/hook-result.txt`
on the release branch. SMF commits that hook output to the release PR, proving
the default `commitChanges == true` behavior.

Verified hosted artifacts:

- [non-Apple composite Action run](https://github.com/Ventairy/smf-e2e/actions/runs/30236365149);
- [iOS 1.2.0 release PR](https://github.com/Ventairy/smf-e2e/pull/3).

PR #3 was opened on `smf/ios`. A later `fix(ios)` commit refreshed the same PR
and retained version 1.2.0 because the existing `feat(ios)` already selected
the higher minor bump.

The organization fixes the default workflow token to read-only. The hosted
manual workflow therefore verifies the composite Action's setup and no-op path,
while the release-PR mutation is exercised from the same built Action adapter
using a local authenticated GitHub session. No token is stored in this
repository, and no Apple or release-signing credentials belong here.
