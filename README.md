# ship-my-flutter Dart E2E fixture

This disposable repository exercises the public Dart CLI and the thin GitHub
Action adapter against a real hosted repository.

It intentionally does not run the `release-candidate` or `ship` phases. No
Apple credentials belong here.

The Ventairy organization locks the default workflow token to read-only, so the
fixture exercised `github-token`, the documented GitHub App or narrowly scoped
PAT fallback. The temporary test credential was deleted after validation; a
future release-PR creation test must supply a new least-privilege secret.

Verified artifacts:

- [iOS 1.1.0 release PR](https://github.com/Ventairy/ship-my-flutter-dart-e2e/pull/1)
- [iOS v1.1.0 GitHub Release](https://github.com/Ventairy/ship-my-flutter-dart-e2e/releases/tag/ios-v1.1.0)

The current hosted non-Apple gate pins core commit
`0fbabbde78343185e7936575021ebabff6377c8a` and Action commit
`1fa5a0b7c4c814b47b9ecdd49ed45ec782e15a95`. These immutable references make
the verified pair reproducible without implying that pub.dev or the floating
`v1` Action tag has been published.

The fixture uses schema-v1 snake_case YAML, includes `.fvmrc`, and deliberately
omits `build_command` and `ipa_output_path`. Its reusable Dart API check proves
that the default resolves to `fvm flutter build ipa --release`. The hosted
workflow does not install Flutter: only the non-Apple `pull-request` phase runs,
proving that the Action's isolated Dart runtime does not impose a Flutter SDK
on pull-request jobs.
