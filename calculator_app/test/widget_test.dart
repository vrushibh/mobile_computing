import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/main.dart';

void main() {
  testWidgets('Calculator performs basic operations', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the initial state (should be empty).
    expect(find.text(''), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Input a calculation: 3 + 5
    await tester.tap(find.text('3'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('='));

    // Verify the result is displayed.
    expect(find.text('8'), findsOneWidget);

    // Clear the input
    await tester.tap(find.text('C'));

    // Verify the calculator is reset
    expect(find.text(''), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}
