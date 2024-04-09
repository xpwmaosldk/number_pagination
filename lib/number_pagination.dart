library number_pagination;

import 'package:flutter/material.dart';
import 'package:number_pagination/number_button.dart';

import 'control_button.dart';
import 'page_number_provider.dart';

class NumberPagination extends StatelessWidget {
  /// Creates a NumberPagination
  NumberPagination({
    required this.onPageChanged,
    required this.pageTotal,
    this.threshold = 10,
    this.pageInit = 1,
    this.colorPrimary = Colors.black,
    this.colorSub = Colors.white,
    this.controlButton,
    this.iconToFirst = const Icon(Icons.first_page),
    this.iconPrevious = const Icon(Icons.keyboard_arrow_left),
    this.iconNext = const Icon(Icons.keyboard_arrow_right),
    this.iconToLast = const Icon(Icons.last_page),
    this.fontSize = 15,
    this.fontFamily,
    this.buttonElevation = 5,
    this.buttonRadius = 10,
    this.buttonSpacing = 4.0,
    this.groupSpacing = 10.0,
  }) {
    pageNumberProvider = PageNumberProvider(this.pageInit);
  }

  ///Trigger when page changed
  final Function(int) onPageChanged;

  ///End of numbers.
  final int pageTotal;

  ///Page number to be displayed first, default is 1.
  final int pageInit;

  ///Numbers to show at once. default is 10.
  final int threshold;

  ///Color of numbers. default is black.
  final Color colorPrimary;

  ///Color of background. default is white.
  final Color colorSub;

  ///to First, to Previous, to next, to Last Button UI.
  final Widget? controlButton;

  ///The icon of button to first.
  final Widget iconToFirst;

  ///The icon of button to previous.
  final Widget iconPrevious;

  ///The icon of button to next.
  final Widget iconNext;

  ///The icon of button to last.
  final Widget iconToLast;

  ///The size of numbers. default is 15.
  final double fontSize;

  ///The fontFamily of numbers.
  final String? fontFamily;

  ///The elevation of the buttons.
  final double buttonElevation;

  ///The Radius of the buttons.
  final double buttonRadius;

  // Spacing between buttons, default is 4.0
  final double buttonSpacing;

  // Spacing between button groups, default is 10.0
  final double groupSpacing;

  late final PageNumberProvider pageNumberProvider;

  @override
  Widget build(BuildContext context) {
    debugPrint('_NumberPagination build');
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListenableBuilder(
            listenable: pageNumberProvider,
            builder: (context, child) {
              var currentPageNumber = pageNumberProvider.currentPageNumber;
              return currentPageNumber == 1 || child == null
                  ? Row(
                      children: [
                        ControlButton(
                          buttonElevation,
                          buttonRadius,
                          colorPrimary,
                          colorSub,
                          iconToFirst,
                          currentPageNumber != 1,
                          () => _changePage(1),
                        ),
                        SizedBox(width: buttonSpacing),
                        ControlButton(
                          buttonElevation,
                          buttonRadius,
                          colorPrimary,
                          colorSub,
                          iconPrevious,
                          currentPageNumber != 1,
                          () => _changePage(currentPageNumber - 1),
                        ),
                      ],
                    )
                  : child;
            },
          ),
          SizedBox(width: groupSpacing),
          ListenableBuilder(
              listenable: pageNumberProvider,
              builder: (context, child) {
                var previuosPage = pageNumberProvider.previousPageNumber;
                final previousRagneStart = previuosPage % threshold == 0
                    ? previuosPage - threshold
                    : (previuosPage ~/ threshold) * threshold;

                var currentPage = pageNumberProvider.currentPageNumber;

                final rangeStart = currentPage % threshold == 0
                    ? currentPage - threshold
                    : (currentPage ~/ threshold) * threshold;

                final rangeEnd = rangeStart + threshold;

                debugPrint('$rangeStart : $previousRagneStart');

                return rangeStart != previousRagneStart || child == null
                    ? Flexible(
                        fit: FlexFit.loose,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          for (var i = rangeStart; i < rangeEnd; i++)
                            NumberButton(
                              i + 1,
                              buttonElevation,
                              buttonRadius,
                              colorPrimary,
                              colorSub,
                              fontSize,
                              fontFamily ?? '',
                              pageNumberProvider,
                              (number) {
                                pageNumberProvider.currentPageNumber = number;
                              },
                            )
                        ]),
                      )
                    : child;
              }),
          SizedBox(width: groupSpacing),
          ListenableBuilder(
            listenable: pageNumberProvider,
            builder: (context, child) {
              var currentPageNumber = pageNumberProvider.currentPageNumber;
              return currentPageNumber == 1 || child == null
                  ? Row(
                      children: [
                        ControlButton(
                          buttonElevation,
                          buttonRadius,
                          colorPrimary,
                          colorSub,
                          iconNext,
                          currentPageNumber != pageTotal,
                          () => _changePage(currentPageNumber + 1),
                        ),
                        SizedBox(width: buttonSpacing),
                        ControlButton(
                          buttonElevation,
                          buttonRadius,
                          colorPrimary,
                          colorSub,
                          iconToLast,
                          currentPageNumber != pageTotal,
                          () => _changePage(pageTotal),
                        ),
                      ],
                    )
                  : child;
            },
          ),
        ],
      ),
    );
  }

  void _changePage(int targetPage) {
    int newPage = targetPage.clamp(1, pageTotal);
    int currentPage = pageNumberProvider.currentPageNumber;

    if (currentPage != newPage) {
      pageNumberProvider.currentPageNumber = newPage;
      onPageChanged(currentPage);
    }
  }
}
