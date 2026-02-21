import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:echomind_flutter_app/app/app.dart';
import 'package:echomind_flutter_app/app/app_routes.dart';

String _routeSlug(String route) {
  final cleaned = route.replaceAll('/', '').trim();
  return cleaned.isEmpty ? 'home' : cleaned;
}

Future<void> _goToRoute(WidgetTester tester, String route) async {
  final navigator = rootNavigatorKey.currentState;
  if (navigator == null) {
    throw StateError('Navigator is not ready.');
  }

  navigator.pushNamedAndRemoveUntil(route, (r) => false);
  await tester.pumpAndSettle(const Duration(milliseconds: 700));
  await Future<void>.delayed(const Duration(milliseconds: 200));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture all pages on emulator', (tester) async {
    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();

    await binding.convertFlutterSurfaceToImage();

    const orderedRoutes = <String>[
      AppRoutes.home,
      AppRoutes.community,
      AppRoutes.globalKnowledge,
      AppRoutes.globalModel,
      AppRoutes.globalExam,
      AppRoutes.memory,
      AppRoutes.profile,
      AppRoutes.uploadHistory,
      AppRoutes.questionAggregate,
      AppRoutes.questionDetail,
      AppRoutes.aiDiagnosis,
      AppRoutes.modelDetail,
      AppRoutes.modelTraining,
      AppRoutes.knowledgeDetail,
      AppRoutes.knowledgeLearning,
      AppRoutes.flashcardReview,
      AppRoutes.predictionCenter,
      AppRoutes.weeklyReview,
      AppRoutes.uploadMenu,
      AppRoutes.registerStrategy,
    ];

    for (var i = 0; i < orderedRoutes.length; i++) {
      final route = orderedRoutes[i];
      await _goToRoute(tester, route);
      final name = '${(i + 1).toString().padLeft(2, '0')}_${_routeSlug(route)}';
      await binding.takeScreenshot(name);
    }
  });
}
