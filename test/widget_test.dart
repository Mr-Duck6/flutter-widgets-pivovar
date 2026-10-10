import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets_pivovar/widgets/custom_button.dart';

void main() {
  group('CustomButton Widget Tests', () {
    testWidgets('should render text correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomButton(text: 'Click Me'),
          ),
        ),
      );

      // Assert
      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var isPressed = false;

      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Click Me',
              onPressed: () {
                isPressed = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      // Assert
      expect(isPressed, isTrue);
    });

    testWidgets('should show loading state', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Click Me',
              isLoading: true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Click Me'), findsNothing);
    });
  });
}