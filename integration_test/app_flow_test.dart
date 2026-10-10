import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_widgets_pivovar/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End App Flow', () {
    testWidgets('Counter increment and product interaction flow', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsWidgets);

      final incrementButton = find.text('+');
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      expect(find.text('Смартфон'), findsOneWidget);

      final cartIcon = find.byIcon(Icons.add_shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon.first);
        await tester.pumpAndSettle();
      }
    });
  });
}
