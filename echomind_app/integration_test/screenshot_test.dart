import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:echomind_app/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final outputDir = r'D:\AI\AI+high school homework\EchoMind-AI_Error_Tracker\docs\第二阶段_html转flutter\截图验证\phase1_tabs';

  setUp(() {
    final dir = Directory(outputDir);
    if (!dir.existsSync()) dir.createSync(recursive: true);
  });

  Future<void> screenshot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    final bytes = await binding.takeScreenshot(name);
    File('$outputDir/$name.png').writeAsBytesSync(bytes);
  }

  testWidgets('Screenshot all 5 tabs', (tester) async {
    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();

    // Tab 0: Home (default)
    await screenshot(tester, '01_home');

    // Tab 1: Global Knowledge
    await tester.tap(find.text('全局'));
    await screenshot(tester, '02_global_knowledge');

    // Tab 2: Memory
    await tester.tap(find.text('记忆'));
    await screenshot(tester, '03_memory');

    // Tab 3: Community
    await tester.tap(find.text('社区'));
    await screenshot(tester, '04_community');

    // Tab 4: Profile
    await tester.tap(find.text('我的'));
    await screenshot(tester, '05_profile');
  });
}
