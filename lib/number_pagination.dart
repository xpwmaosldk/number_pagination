import 'package:flutter/material.dart';

import 'src/control_button.dart';
import 'src/number_button.dart';
import 'src/number_page_container.dart';
import 'src/page_number_provider.dart';

/// A customizable pagination widget that displays page numbers and navigation controls.
///
/// This widget allows users to navigate through pages using numbered buttons
/// and control buttons (first, previous, next, last). It's highly customizable
/// in terms of appearance and behavior.
class NumberPagination extends StatelessWidget {
  /// Creates a NumberPagination widget.
  const NumberPagination({
    super.key,
    required this.onPageChanged,
    required this.totalPages,
    this.visiblePagesCount = 10,
    this.currentPage = 1,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.white,
    this.fontSize = 15,
    this.fontFamily,
    this.buttonElevation = 5,
    this.buttonRadius = 10,
    this.firstPageIcon = const Icon(Icons.first_page),
    this.previousPageIcon = const Icon(Icons.keyboard_arrow_left),
    this.nextPageIcon = const Icon(Icons.keyboard_arrow_right),
    this.lastPageIcon = const Icon(Icons.last_page),
    this.navigationButtonSpacing = 4.0,
    this.sectionSpacing = 10.0,
    this.controlButtonSize = const Size(48, 48),
    this.numberButtonSize = const Size(48, 48),
    this.betweenNumberButtonSpacing = 3,
  });

  /// Callback function triggered when the page changes.
  final Function(int) onPageChanged;

  /// Total number of pages available.
  final int totalPages;

  /// Currently displayed page number.
  final int currentPage;

  /// Number of page buttons to display at once.
  final int visiblePagesCount;

  /// Color of the active page number and icons.
  final Color activeColor;

  /// Background color for the inactive buttons.
  final Color inactiveColor;

  /// Font size for the page numbers.
  final double fontSize;

  /// Font family for the page numbers.
  final String? fontFamily;

  /// Elevation of the buttons.
  final double buttonElevation;

  /// Radius of the buttons.
  final double buttonRadius;

  /// Icon for the "first page" button.
  final Widget firstPageIcon;

  /// Icon for the "previous page" button.
  final Widget previousPageIcon;

  /// Icon for the "next page" button.
  final Widget nextPageIcon;

  /// Icon for the "last page" button.
  final Widget lastPageIcon;

  /// Spacing between navigation buttons.
  final double navigationButtonSpacing;

  /// Spacing between navigation buttons and page number buttons.
  final double sectionSpacing;

  /// Size of the control buttons.
  final Size controlButtonSize;

  /// Size of the number buttons.
  final Size numberButtonSize;

  /// Spacing between individual number buttons.
  final double betweenNumberButtonSpacing;

  @override
  Widget build(BuildContext context) {
    final pageService = NumberPageService(currentPage);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: NumberPageContainer(
        pageService: pageService,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButtons(pageService),
            SizedBox(width: sectionSpacing),
            _buildPageNumbers(pageService),
            SizedBox(width: sectionSpacing),
            _buildNavigationButtons(pageService, isForward: true),
          ],
        ),
      ),
    );
  }

  /// Builds the navigation buttons (first/previous or next/last).
  Widget _buildNavigationButtons(NumberPageService pageService,
      {bool isForward = false}) {
    return ListenableBuilder(
      listenable: pageService,
      builder: (_, __) => Row(
        children: [
          ControlButton(
            buttonElevation,
            buttonRadius,
            activeColor,
            inactiveColor,
            isForward ? nextPageIcon : firstPageIcon,
            isForward
                ? pageService.currentPage != totalPages
                : pageService.currentPage != 1,
            (c) => _changePage(c, isForward ? pageService.currentPage + 1 : 1),
            controlButtonSize,
          ),
          SizedBox(width: navigationButtonSpacing),
          ControlButton(
            buttonElevation,
            buttonRadius,
            activeColor,
            inactiveColor,
            isForward ? lastPageIcon : previousPageIcon,
            isForward
                ? pageService.currentPage != totalPages
                : pageService.currentPage != 1,
            (c) => _changePage(
                c, isForward ? totalPages : pageService.currentPage - 1),
            controlButtonSize,
          ),
        ],
      ),
    );
  }

  /// Builds the page number buttons.
  Widget _buildPageNumbers(NumberPageService pageService) {
    return Flexible(
      child: ListenableBuilder(
        listenable: pageService,
        builder: (context, child) {
          final currentPage = pageService.currentPage;
          final rangeStart = _calculateRangeStart(currentPage);
          final rangeEnd = _calculateRangeEnd(rangeStart);

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = rangeStart; i < rangeEnd; i++) ...[
                NumberButton(
                  i + 1,
                  buttonElevation,
                  buttonRadius,
                  activeColor,
                  inactiveColor,
                  fontSize,
                  fontFamily ?? '',
                  (c, number) => _changePage(c, number),
                  numberButtonSize,
                ),
                if (i != rangeEnd - 1)
                  SizedBox(
                    width: betweenNumberButtonSpacing,
                  ),
              ],
            ],
          );
        },
      ),
    );
  }

  /// Calculates the start of the range for page numbers to display.
  int _calculateRangeStart(int currentPage) {
    return currentPage % visiblePagesCount == 0
        ? currentPage - visiblePagesCount
        : (currentPage ~/ visiblePagesCount) * visiblePagesCount;
  }

  /// Calculates the end of the range for page numbers to display.
  int _calculateRangeEnd(int rangeStart) {
    return rangeStart + visiblePagesCount > totalPages
        ? totalPages
        : rangeStart + visiblePagesCount;
  }

  /// Changes the current page and notifies the listener.
  void _changePage(BuildContext context, int targetPage) {
    final int newPage = targetPage.clamp(1, totalPages);

    if (NumberPageContainer.of(context).currentPage != newPage) {
      NumberPageContainer.of(context).currentPage = newPage;
      onPageChanged(newPage);
    }
  }
}
