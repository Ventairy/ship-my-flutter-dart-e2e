# SMF E2E fixture

This disposable repository exercises the public SMF Dart package and GitHub
Action against a real hosted repository.

It intentionally has no `release-candidate` or `ship` job. The workflow tests
configuration discovery, CLI commands, the reusable Dart API, the typed
`before_create_pr` hook, release-branch updates, and release-PR creation without
building, uploading, or submitting anything to Apple.

The fixture pins immutable sources:

- SMF core `7fa60bfff690b78a9e049e0c277ca8a12358e91b`;
- SMF Action `8971b68a66ae0ecc05d3d0f059a4b3b5c9126379`.

The Flutter-app-shaped project keeps its only configuration at
`smf/config.yaml`. Both the CLI and Action discover it automatically from the
repository root. The config omits `build_command`, `ipa_output_path`,
`bundle_id`, and `enabled` to exercise the normal defaults.

The typed hook at `smf/hooks/before_create_pr.dart` writes `smf/hook-result.txt`
on the release branch. SMF commits that hook output to the release PR, proving
the default `commitChanges == true` behavior.

The organization fixes the default workflow token to read-only. The hosted
manual workflow therefore verifies the composite Action's setup and no-op path,
while the release-PR mutation is exercised from the same built Action adapter
using a local authenticated GitHub session. No token is stored in this
repository, and no Apple or release-signing credentials belong here.
