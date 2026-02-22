import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:echomind_app/main.dart';

void main() {
  final outputDir = r'D:\AI\AI+high school homework\EchoMind-AI_Error_Tracker\docs\第二阶段_html转flutter\截图验证\phase1_tabs';

  setUp(() {
    final dir = Directory(outputDir);
    if (!dir.existsSync()) dir.createSync(recursive: true);
  });

  testWidgets('Screenshot Home tab', (tester) async {
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$outputDir/01_home.png'),
    );
  });

  testWidgets('Screenshot GlobalKnowledge tab', (tester) async {
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('全局'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$outputDir/02_global_knowledge.png'),
    );
  });

  testWidgets('Screenshot Memory tab', (tester) async {
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('记忆'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$outputDir/03_memory.png'),
    );
  });

  testWidgets('Screenshot Community tab', (tester) async {
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('社区'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$outputDir/04_community.png'),
    );
  });

  testWidgets('Screenshot Profile tab', (tester) async {
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$outputDir/05_profile.png'),
    );
  });
}
