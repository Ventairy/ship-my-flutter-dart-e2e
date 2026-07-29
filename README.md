# SMF E2E fixture

This disposable repository exercises the public SMF packages and GitHub Action
against a real hosted repository.

It intentionally has no `release-candidate` or `ship` job. The workflow tests
configuration discovery, CLI commands, the reusable Dart API, the typed
`before_create_pr` hook, release-branch updates, and release-PR creation without
building, uploading, or submitting anything to Apple.

The fixture pins immutable releases:

- hosted `smf_cli`, `smf_engine`, and `smf_hooks` packages at `1.0.0`;
- SMF Action commit `e4be464b4a8a9b4f0104851650f3a4d271cba048`.

The Flutter-app-shaped project keeps its only configuration at
`smf/config.yaml`. Both the CLI and Action discover it automatically from the
repository root. The config omits `build_command`, `ipa_output_path`,
`bundle_id`, and `enabled` to exercise the normal defaults.

The typed hook at `smf/hooks/before_create_pr.dart` writes `smf/hook-result.txt`
on the release branch. SMF commits that hook output to the release PR, proving
the default `commitChanges == true` behavior.

The hosted workflow validates the exact hosted Dart dependency graph, the
public CLI, iOS and Android library entrypoints, the hook protocol, project
resolution, and a real authenticated update of the single iOS release PR. It
also asserts the phase-specific Action output contract.

The repository stores no Apple, Google Play, or signing credentials. Candidate
upload and shipping therefore remain external acceptance gates rather than
fixture behavior.
