import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_pagination/number_pagination.dart';

void main() {
  // Testing the rendering and functionality of the NumberPagination widget
  testWidgets('NumberPagination renders correctly',
      (WidgetTester tester) async {
    // Variable to track the current page number
    int currentPage = 1;

    // Build and render an app containing the NumberPagination widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          // Scaffold containing the NumberPagination widget as its body
          body: NumberPagination(
            onPageChanged: (page) {
              // Callback called when the page changes, updates currentPage
              currentPage = page;
            },
            pageTotal: 100, // Total number of pages
            threshold:
                11, // Maximum number of page buttons to show in the pagination
            pageInit: 1, // Initial page number
            autoSetState:
                true, // Whether to automatically update the widget state
          ),
        ),
      ),
    );

    // Verify the threshold value, checking if "11" is rendered correctly
    expect(find.text('11'), findsOneWidget);

    // Verify that the first page is correctly displayed initially
    expect(find.text('1'), findsOneWidget);

    // Tap the next page button and verify that the current page updates to 2
    await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
    await tester.pump();
    expect(currentPage, 2);

    // Tap the "3" page button and verify that the current page updates to 3
    await tester.tap(find.text('3'));
    await tester.pump();
    expect(currentPage, 3);

    // Tap the last page button and verify that the last page is correctly displayed
    await tester.tap(find.byIcon(Icons.last_page));
    await tester.pump();
    expect(find.text('100'), findsOneWidget);
  });
}
