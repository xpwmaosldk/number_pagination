library number_pagination;

import 'package:flutter/material.dart';

class NumberPagination extends StatefulWidget {
  /// Creates a NumberPagination widget.
  const NumberPagination({
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
  });

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

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  static const double buttonSpacing = 4.0;
  static const double groupSpacing = 10.0;
  late int currentPage;

  @override
  void initState() {
    currentPage = widget.pageInit;
    super.initState();
  }

  void _changePage(int targetPage) {
    int newPage = targetPage.clamp(1, widget.pageTotal);

    if (currentPage != newPage) {
      setState(() {
        currentPage = newPage;
        widget.onPageChanged(currentPage);
      });
    }
  }

  Widget _buildPageNumbers(int rangeStart, int rangeEnd) {
    return Flexible(
      fit: FlexFit.loose,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          rangeEnd <= widget.pageTotal
              ? widget.threshold
              : widget.pageTotal % widget.threshold,
          (index) => Flexible(
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: widget.buttonElevation,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.buttonRadius),
                  ),
                  padding: EdgeInsets.zero,
                  minimumSize: Size(48, 48),
                  foregroundColor: (currentPage - 1) % widget.threshold == index
                      ? widget.colorSub
                      : widget.colorPrimary,
                  backgroundColor: (currentPage - 1) % widget.threshold == index
                      ? widget.colorPrimary
                      : widget.colorSub,
                ),
                onPressed: () => _changePage(index + 1 + rangeStart),
                child: Text(
                  '${index + 1 + rangeStart}',
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontFamily: widget.fontFamily,
                    color: (currentPage - 1) % widget.threshold == index
                        ? widget.colorSub
                        : widget.colorPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(Widget icon, bool enabled, VoidCallback? onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: widget.buttonElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.buttonRadius),
        ),
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        minimumSize: Size(48, 48),
        foregroundColor: enabled ? widget.colorPrimary : Colors.grey,
        backgroundColor: widget.colorSub,
        disabledForegroundColor: widget.colorPrimary,
        disabledBackgroundColor: widget.colorSub,
      ),
      onPressed: enabled ? onTap : null,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rangeStart = currentPage % widget.threshold == 0
        ? currentPage - widget.threshold
        : (currentPage ~/ widget.threshold) * widget.threshold;

    final rangeEnd = rangeStart + widget.threshold;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildControlButton(
            widget.iconToFirst,
            currentPage != 1,
            () => _changePage(1),
          ),
          SizedBox(width: buttonSpacing),
          _buildControlButton(
            widget.iconPrevious,
            currentPage != 1,
            () => _changePage(currentPage - 1),
          ),
          SizedBox(width: groupSpacing),
          _buildPageNumbers(rangeStart, rangeEnd),
          SizedBox(width: groupSpacing),
          _buildControlButton(
            widget.iconNext,
            currentPage != widget.pageTotal,
            () => _changePage(currentPage + 1),
          ),
          SizedBox(width: buttonSpacing),
          _buildControlButton(
            widget.iconToLast,
            currentPage != widget.pageTotal,
            () => _changePage(widget.pageTotal),
          ),
        ],
      ),
    );
  }
}
