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
`8bfae2b2ee6aa513d698c8865918f9d17f3fd06f` and Action commit
`87b50a81dab2b8df0aefb848768fc2ab94b312b7`. These immutable references make
the verified pair reproducible without implying that pub.dev or the floating
`v1` Action tag has been published.
