import 'dart:io';

import 'package:smf_hooks/smf_hooks.dart';

final class RecordBeforeCreatePrHook extends SmfHook {
  @override
  Future<void> run(covariant SmfBeforeCreatePrContext context) async {
    await File('smf/hook-result.txt').writeAsString(
      'planned_ios_version=${context.release.ios?.nextVersion}\n',
    );
  }
}

Future<void> main() async {
  await runSmfHook(RecordBeforeCreatePrHook());
}
