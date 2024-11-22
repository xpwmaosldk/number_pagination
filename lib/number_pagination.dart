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
    required this.currentPage,
    this.visiblePagesCount = 10,
    this.fontSize = 15,
    this.fontFamily,
    this.buttonElevation = 5,
    this.buttonRadius = 0,
    this.firstPageIcon = const Icon(Icons.first_page),
    this.previousPageIcon = const Icon(Icons.keyboard_arrow_left),
    this.nextPageIcon = const Icon(Icons.keyboard_arrow_right),
    this.lastPageIcon = const Icon(Icons.last_page),
    this.navigationButtonSpacing = 4.0,
    this.sectionSpacing = 10.0,
    this.controlButtonSize = const Size(48, 48),
    this.numberButtonSize = const Size(48, 48),
    this.betweenNumberButtonSpacing = 3,
    this.selectedNumberColor = Colors.white,
    this.unSelectedNumberColor = Colors.black,
    this.selectedButtonColor = Colors.black,
    this.unSelectedButtonColor = Colors.white,
    this.controlButtonColor = Colors.white,
    this.selectedNumberFontWeight = FontWeight.w600,
    this.buttonSelectedBorderColor,
    this.buttonUnSelectedBorderColor,
    this.enableInteraction = true,
  });

  /// Callback function triggered when the page changes.
  final Function(int) onPageChanged;

  /// Total number of pages available.
  final int totalPages;

  /// Currently displayed page number.
  final int currentPage;

  /// Number of page buttons to display at once.
  final int visiblePagesCount;

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

  /// The color of the text for the selected page button.
  final Color selectedNumberColor;

  /// The color of the text for unselected page buttons.
  final Color unSelectedNumberColor;

  /// The background color of the selected page button.
  final Color selectedButtonColor;

  /// The color of the selected page button border.
  final Color? buttonSelectedBorderColor;

  /// The color of the unselected page button border.
  final Color? buttonUnSelectedBorderColor;

  /// The background color of unselected page buttons.
  final Color unSelectedButtonColor;

  /// The background color of control buttons.
  final Color controlButtonColor;

  /// The font weight of the selected page number.
  final FontWeight selectedNumberFontWeight;

  /// The enableInteraction controls whether hover and click effects are enabled for buttons, enhancing user interaction with visual feedback.
  /// default is true.
  final bool enableInteraction;

  @override
  Widget build(BuildContext context) {
    final pageService = NumberPageService(currentPage);

    return NumberPageContainer(
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
            isForward ? nextPageIcon : firstPageIcon,
            isForward
                ? pageService.currentPage != totalPages
                : pageService.currentPage != 1,
            (c) => _changePage(c, isForward ? pageService.currentPage + 1 : 1),
            controlButtonSize,
            controlButtonColor,
            enableInteraction,
          ),
          SizedBox(width: navigationButtonSpacing),
          ControlButton(
            buttonElevation,
            buttonRadius,
            isForward ? lastPageIcon : previousPageIcon,
            isForward
                ? pageService.currentPage != totalPages
                : pageService.currentPage != 1,
            (c) => _changePage(
                c, isForward ? totalPages : pageService.currentPage - 1),
            controlButtonSize,
            controlButtonColor,
            enableInteraction,
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
                  number: i + 1,
                  buttonElevation: buttonElevation,
                  buttonRadius: buttonRadius,
                  fontSize: fontSize,
                  fontFamily: fontFamily ?? '',
                  onSelect: (c, number) => _changePage(c, number),
                  fixedSize: numberButtonSize,
                  selectedTextColor: selectedNumberColor,
                  unSelectedTextColor: unSelectedNumberColor,
                  selectedButtonColor: selectedButtonColor,
                  unSelectedButtonColor: unSelectedButtonColor,
                  selectedNumberFontWeight: selectedNumberFontWeight,
                  buttonSelectedBorderColor: buttonSelectedBorderColor,
                  buttonUnSelectedBorderColor: buttonUnSelectedBorderColor,
                  enableInteraction: enableInteraction,
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
