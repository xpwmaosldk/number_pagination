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
    this.autoSetState = false,
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

  ///Make sure setState is called automatically. default is false.
  final bool autoSetState;

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
      currentPage = newPage;
      widget.onPageChanged(currentPage);
      if (widget.autoSetState) setState(() {});
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
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _changePage(index + 1 + rangeStart),
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: (currentPage - 1) % widget.threshold == index
                      ? widget.colorPrimary
                      : widget.colorSub,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
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

  Widget _buildControlButton(Widget icon, VoidCallback? onTap) {
    return widget.controlButton ??
        AbsorbPointer(
          absorbing: onTap == null,
          child: TextButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(5.0),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size(48, 48)),
              foregroundColor: MaterialStateProperty.all(widget.colorPrimary),
              backgroundColor: MaterialStateProperty.all(widget.colorSub),
            ),
            onPressed: onTap,
            child: icon,
          ),
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
            currentPage == 1 ? null : () => _changePage(1),
          ),
          SizedBox(width: buttonSpacing),
          _buildControlButton(
            widget.iconPrevious,
            currentPage == 1 ? null : () => _changePage(currentPage - 1),
          ),
          SizedBox(width: groupSpacing),
          _buildPageNumbers(rangeStart, rangeEnd),
          SizedBox(width: groupSpacing),
          _buildControlButton(
            widget.iconNext,
            currentPage == widget.pageTotal
                ? null
                : () => _changePage(currentPage + 1),
          ),
          SizedBox(width: buttonSpacing),
          _buildControlButton(
            widget.iconToLast,
            currentPage == widget.pageTotal
                ? null
                : () => _changePage(widget.pageTotal),
          ),
        ],
      ),
    );
  }
}
