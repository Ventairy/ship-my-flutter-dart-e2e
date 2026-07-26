import 'dart:convert';

import 'package:ship_my_flutter/ship_my_flutter.dart';

Future<void> main() async {
  const root = '.';
  await validateRepository(root);
  final manifest = await loadManifest(root);
  final plan = await createReleasePlan(root, manifest, Platform.ios);
  print(
    jsonEncode(<String, Object?>{'source': 'dart-api', 'plan': plan?.toJson()}),
  );
}
