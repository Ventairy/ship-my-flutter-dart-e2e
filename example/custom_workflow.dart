import 'dart:convert';

import 'package:smf/smf.dart';

Future<void> main() async {
  const root = '.';
  await validateRepository(root);
  final manifest = await loadManifest(root);
  final plan = await createReleasePlan(root, manifest, Platform.ios);
  final buildCommand = await resolveIosBuildCommand(root);
  if (buildCommand != 'fvm flutter build ipa --release') {
    throw StateError('Expected FVM auto-detection, got $buildCommand');
  }
  print(
    jsonEncode(<String, Object?>{
      'source': 'dart-api',
      'buildCommand': buildCommand,
      'plan': plan?.toJson(),
    }),
  );
}
