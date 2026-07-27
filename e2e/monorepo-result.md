# SMF monorepo E2E

Target branch: `e2e/monorepo-20260727`

This fixture initializes two nested Android apps with independent SMF state:

- `apps/customer`, baseline `1.0.0`, including
  `packages/shared_models/**` in `release_trigger_paths`;
- `apps/driver`, baseline `2.0.0`, observing only its own app directory.

The generated workflows are retained under `e2e/generated-workflows/` as
initialization evidence. They are not installed under `.github/workflows/`
because the public `Ventairy/smf-action@v1` tag is not available yet.

Hosted orchestration results:

- shared-path `feat(android)` commit `5209620` created customer PR #4 for
  Android `1.1.0`;
- the same commit returned `noop` for driver;
- driver-only `fix(android)` commit `93f8433` created driver PR #5 for Android
  `2.0.1`;
- refreshing customer after the driver commit reused PR #4 at `1.1.0` and did
  not add the driver commit to its changelog;
- PR #4 changes only `apps/customer/smf/manifest.json` and
  `apps/customer/smf/changelog.json`;
- PR #5 changes only `apps/driver/smf/manifest.json` and
  `apps/driver/smf/changelog.json`.

No store build, upload, promotion, or release is performed by this fixture.
