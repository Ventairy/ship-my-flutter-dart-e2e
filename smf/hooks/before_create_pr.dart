import 'dart:io';

import 'package:smf_hooks/smf_hooks.dart';

final class RecordBeforeCreatePrHook extends SmfHook {
  @override
  Future<void> run(covariant SmfBeforeCreatePrContext context) async {
    final secret = context.secrets['E2E_HOOK_SECRET'];
    if (secret == null || secret.length < 8) {
      throw StateError('The configured E2E hook secret is unavailable.');
    }
    await File('smf/hook-result.txt').writeAsString(
      'planned_ios_version=${context.release.ios?.nextVersion}\n'
      'hook_secret_available=true\n',
    );
  }
}

Future<void> main() async {
  await runSmfHook(RecordBeforeCreatePrHook());
}
