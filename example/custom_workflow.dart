import 'dart:convert';
import 'dart:io';

import 'package:smf_engine/android.dart';
import 'package:smf_engine/apple.dart';
import 'package:smf_engine/smf_engine.dart';

Future<void> main() async {
  final paths = SmfPaths.resolve(Directory.current.path);
  await RepositoryValidator.validate(paths.directory);
  final config = await SmfState.config(paths.directory);
  final manifest = await SmfState.manifest(paths.directory);
  final targets = <ReleaseTargetDto>[
    ReleaseTargetDto(
      platform: ReleasePlatform.ios,
      version: manifest.platforms.ios.version,
    ),
    ReleaseTargetDto(
      platform: ReleasePlatform.android,
      version: manifest.platforms.android.version,
    ),
  ];
  print(
    jsonEncode(<String, Object?>{
      'source': 'hosted-dart-api',
      'app_id': config.appId,
      'targets': targets.map((target) => target.toJson()).toList(),
      'apple_ship_targets': AppleShipTarget.values
          .map((target) => target.name)
          .toList(),
      'google_play_ship_targets': GooglePlayShipTarget.values
          .map((target) => target.name)
          .toList(),
      'apple_projects': <AppleProject>[],
      'android_projects': <AndroidProject>[],
    }),
  );
}
