# SMF E2E fixture

This disposable repository exercises the public SMF packages and GitHub Action
against a real hosted repository.

It intentionally has no `release-candidate` or `ship` job. The workflow tests
configuration discovery, CLI commands, the reusable Dart API, the typed
`before_create_pr` hook, release-branch updates, and release-PR creation without
building, uploading, or submitting anything to Apple.

This branch pins the immutable SMF feature commit
`2abbe6789dda462fd66a8269c1ed9c3690f72a3d` across `smf_cli`, `smf_engine`,
and `smf_hooks` through root dependency overrides. The publishable SMF package
manifests continue to use hosted dependencies.

The hook receives `E2E_HOOK_SECRET` through `context.secrets`, verifies that it
is available, and records only a non-secret success marker. The workflow value
comes from the repository's matching GitHub Actions secret.

The baseline fixture pins immutable releases:

- hosted `smf_cli` at `1.0.1`, `smf_engine` at `1.0.2`, and `smf_hooks` at
  `1.0.0`;
- SMF Action `v1.0.0` commit
  `bf363393ca40828693d17f2f1cc1fd4073b6c601`.

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
