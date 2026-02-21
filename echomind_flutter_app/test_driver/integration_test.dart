import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final outDir = Directory('artifacts/emulator-screenshots');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  await integrationDriver(
    onScreenshot:
        (
          String screenshotName,
          List<int> screenshotBytes, [
          Map<String, Object?>? args,
        ]) async {
          final file = File('${outDir.path}/$screenshotName.png');
          await file.writeAsBytes(screenshotBytes);
          return true;
        },
  );
}
