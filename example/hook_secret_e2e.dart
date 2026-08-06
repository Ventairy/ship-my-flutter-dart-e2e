import 'dart:io';

import 'package:smf_engine/smf_engine.dart';

Future<void> main() async {
  final output = File('smf/hook-result.txt');
  try {
    final didRun = await RepositoryHooks.beforeCreatePullRequest(
      workingDirectory: Directory.current.path,
      plans: const <ReleasePlanDto>[
        ReleasePlanDto(
          platform: ReleasePlatform.ios,
          currentVersion: '1.1.1',
          nextVersion: '1.2.0',
          versionBumpType: VersionBumpType.minor,
          baseCommitHash: 'e2e-base',
          endCommitHash: 'e2e-head',
          changes: <ConventionalChangeDto>[],
        ),
      ],
    );
    if (!didRun) throw StateError('The committed E2E hook did not run.');
    final observation = await output.readAsString();
    if (!observation.contains('hook_secret_available=true')) {
      throw StateError('The hook did not observe its configured secret.');
    }
  } finally {
    if (await output.exists()) await output.delete();
  }
}
