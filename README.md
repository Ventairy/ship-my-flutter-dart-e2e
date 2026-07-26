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
`db35d160e9d6f53061e8193479a0083593f0d3b0` and Action commit
`28fb0cf9f8230a8122abd06d72fc7db85172b19b`. These immutable references make
the verified pair reproducible without implying that pub.dev or the floating
`v1` Action tag has been published.

The fixture uses schema-v2 snake_case YAML and deliberately omits
`build_command` and `artifact_path`, exercising their standard Flutter
defaults. Its hosted workflow does not install Flutter: only the non-Apple
`plan` phase runs, proving that the Action's isolated Dart runtime does not
impose a Flutter SDK on planning jobs.
