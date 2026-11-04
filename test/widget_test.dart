import 'package:flutter_test/flutter_test.dart';

import 'package:jaiboar/main.dart';

void main() {
  testWidgets(
    'JaibaAR inicia correctamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const JaibaArApp(),
      );

      expect(
        find.byType(JaibaArApp),
        findsOneWidget,
      );
    },
  );
}