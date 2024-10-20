import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_registration_app/main.dart'; // Adjust the name accordingly


void main() {
  testWidgets('Login screen shows correct widgets', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(MyApp());

    // Verify that the login screen is displayed.
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Two text fields
    expect(find.byType(ElevatedButton), findsOneWidget); // One login button

    // Enter email and password
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Tap the login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that the HomeScreen is displayed after login
    expect(find.text('Welcome to the Home Screen!'), findsOneWidget);
  });

  testWidgets('Navigating to Registration screen', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(MyApp());

    // Tap the 'Create an account' button to navigate to Registration screen.
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete.

    // Verify that the registration screen is displayed.
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Two text fields for email and password
    expect(find.byType(ElevatedButton), findsOneWidget); // One register button
  });
}
