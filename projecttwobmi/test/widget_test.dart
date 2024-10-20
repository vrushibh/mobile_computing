import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart'; // Adjust based on your project structure

void main() {
  testWidgets('BMI calculation displays correct result', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(BMICalculator());

    // Enter age, height, and weight
    await tester.enterText(find.byType(TextField).first, '25'); // Age
    await tester.enterText(find.byType(TextField).at(1), '175'); // Height in cm
    await tester.enterText(find.byType(TextField).last, '70'); // Weight in kg

    // Tap the Calculate button
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump(); // Trigger a frame

    // Verify that the BMI result is displayed
    expect(find.textContaining('Your BMI is:'), findsOneWidget);
  });
}
