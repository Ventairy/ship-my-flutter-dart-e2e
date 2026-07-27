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
`5129a9830e3b478acbc32276d8158b886e4781af` and Action commit
`06c2b4ab09e875b72cffd79498ec74814647b89a`. These immutable references make
the verified pair reproducible without implying that pub.dev or the floating
`v1` Action tag has been published.

The fixture uses schema-v2 snake_case YAML, includes `.fvmrc`, and deliberately
omits `build_command` and `ipa_output_path`. Its reusable Dart API check proves
that the default resolves to `fvm flutter build ipa --release`. The hosted
workflow does not install Flutter: only the non-Apple `plan` phase runs,
proving that the Action's isolated Dart runtime does not impose a Flutter SDK
on planning jobs.
