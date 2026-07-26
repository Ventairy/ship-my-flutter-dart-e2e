# ship-my-flutter Dart E2E fixture

This disposable repository exercises the public Dart CLI and the thin GitHub
Action adapter against a real hosted repository.

It intentionally does not run the TestFlight candidate or App Store promotion
phases. No Apple credentials belong here.

The Ventairy organization locks the default workflow token to read-only, so the
fixture exercised `github-token`, the documented GitHub App or narrowly scoped
PAT fallback. The temporary test credential was deleted after validation; a
future release-PR creation test must supply a new least-privilege secret.

Verified artifacts:

- [iOS 1.1.0 release PR](https://github.com/Ventairy/ship-my-flutter-dart-e2e/pull/1)
- [iOS v1.1.0 GitHub Release](https://github.com/Ventairy/ship-my-flutter-dart-e2e/releases/tag/ios-v1.1.0)

The current hosted non-Apple gate pins core commit
`920de25adc4f6241d7147ae9d7964d7a0bde1b44` and Action commit
`a4d46a556363b332a3a9699a2f0a03a30160d927`. These immutable references make
the verified pair reproducible without implying that pub.dev or the floating
`v1` Action tag has been published.

The fixture uses schema-v2 snake_case YAML and a shell-string
`build_command`. Its hosted workflow does not install Flutter: only the
non-Apple `plan` phase runs, proving that the Action's isolated Dart runtime
does not impose a Flutter SDK on planning jobs.
