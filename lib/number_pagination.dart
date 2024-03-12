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
    this.iconToFirst,
    this.iconPrevious,
    this.iconNext,
    this.iconToLast,
    this.fontSize = 15,
    this.fontFamily,
  });

  ///Trigger when page changed
  final Function(int) onPageChanged;

  ///End of numbers.
  final int pageTotal;

  ///Page number to be displayed first
  final int pageInit;

  ///Numbers to show at once.
  final int threshold;

  ///Color of numbers.
  final Color colorPrimary;

  ///Color of background.
  final Color colorSub;

  ///to First, to Previous, to next, to Last Button UI.
  final Widget? controlButton;

  ///The icon of button to first.
  final Widget? iconToFirst;

  ///The icon of button to previous.
  final Widget? iconPrevious;

  ///The icon of button to next.
  final Widget? iconNext;

  ///The icon of button to last.
  final Widget? iconToLast;

  ///The size of numbers.
  final double fontSize;

  ///The fontFamily of numbers.
  final String? fontFamily;

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  late int currentPage;
  late final Widget iconToFirst;
  late final Widget iconPrevious;
  late final Widget iconNext;
  late final Widget iconToLast;

  @override
  void initState() {
    this.currentPage = widget.pageInit;
    this.iconToFirst = widget.iconToFirst ?? Icon(Icons.first_page);
    this.iconPrevious = widget.iconPrevious ?? Icon(Icons.keyboard_arrow_left);
    this.iconNext = widget.iconNext ?? Icon(Icons.keyboard_arrow_right);
    this.iconToLast = widget.iconToLast ?? Icon(Icons.last_page);

    super.initState();
  }

  void _changePage(int page) {
    if (page <= 0) {
      currentPage = 1;
      return;
    }

    if (page > widget.pageTotal) {
      currentPage = widget.pageTotal;
      return;
    }

    currentPage = page;
    widget.onPageChanged(currentPage);
    setState(() {});
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
            widget.iconToFirst ?? Icon(Icons.first_page),
            currentPage == 1 ? null : () => _changePage(1),
          ),
          SizedBox(width: 4),
          _buildControlButton(
            widget.iconPrevious ?? Icon(Icons.keyboard_arrow_left),
            currentPage == 1 ? null : () => _changePage(currentPage - 1),
          ),
          SizedBox(width: 10),
          _buildPageNumbers(rangeStart, rangeEnd),
          SizedBox(width: 10),
          _buildControlButton(
            widget.iconNext ?? Icon(Icons.keyboard_arrow_right),
            currentPage == widget.pageTotal
                ? null
                : () => _changePage(currentPage + 1),
          ),
          SizedBox(width: 4),
          _buildControlButton(
            widget.iconToLast ?? Icon(Icons.last_page),
            currentPage == widget.pageTotal
                ? null
                : () => _changePage(widget.pageTotal),
          ),
        ],
      ),
    );
  }
}
