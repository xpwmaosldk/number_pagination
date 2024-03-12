import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_pagination/number_pagination.dart';

void main() {
  testWidgets('NumberPagination renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberPagination(
            onPageChanged: (page) {},
            pageTotal: 100,
            threshold: 10,
          ),
        ),
      ),
    );

    // Verify that the first page is shown initially
    expect(find.text('1'), findsOneWidget);

    // Tap on the next button
    await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
    await tester.pump();

    // Verify that the threshold.
    expect(find.text('10'), findsOneWidget);

    // Tap on the last page button
    await tester.tap(find.byIcon(Icons.last_page));
    await tester.pump();

    // Verify that the last page is shown
    expect(find.text('100'), findsOneWidget);
  });
}
