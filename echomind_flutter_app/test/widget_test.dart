import 'package:flutter_test/flutter_test.dart';

import 'package:echomind_flutter_app/app/app.dart';

void main() {
  testWidgets('App boots and shows home content', (WidgetTester tester) async {
    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();

    expect(find.text('主页'), findsWidgets);
    expect(find.text('今日学习仪表'), findsOneWidget);
  });
}
