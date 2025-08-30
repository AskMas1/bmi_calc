// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calc/main.dart';

void main() {
  testWidgets('BMI Calculator app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BMICalculatorApp());

    // Verify that our BMI calculator app loads with splash screen.
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Track Your Health Journey'), findsOneWidget);
  });

  testWidgets('App navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BMICalculatorApp());

    // Wait for splash screen to complete (3 seconds + animation time)
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that we're now on the main screen with navigation
    expect(find.text('Calculator'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Tips'), findsOneWidget);
  });
}
