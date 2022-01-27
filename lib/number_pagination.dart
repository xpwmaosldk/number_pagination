library number_pagination;

import 'package:flutter/material.dart';

class NumberPagination extends StatefulWidget {
  final Function(int) onNumberChange;
  final int pageTotal;
  final int pageInit;
  final int threshold;
  final Color colorPrimary;
  final Color colorSub;
  final Widget? controlButton;
  final Widget? iconToFirst;
  final Widget? iconPrevious;
  final Widget? iconNext;
  final Widget? iconToLast;

  NumberPagination({
    required this.onNumberChange,
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
  });

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  late int rangeStart;
  late int rangeEnd;
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

    _rangeSet();

    super.initState();
  }

  Widget _defaultControlButton(Widget icon) {
    return AbsorbPointer(
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(5.0),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size(48, 48)),
          foregroundColor: MaterialStateProperty.all(widget.colorPrimary),
          backgroundColor: MaterialStateProperty.all(widget.colorSub),
        ),
        onPressed: () {},
        child: icon,
      ),
    );
  }

  void changePage(int page) {
    if (page <= 0) page = 1;

    if (page > widget.pageTotal) page = widget.pageTotal;

    setState(() {
      currentPage = page;
      _rangeSet();
      widget.onNumberChange(currentPage);
    });
  }

  void _rangeSet() {
    rangeStart = currentPage % widget.threshold == 0
        ? currentPage - widget.threshold
        : (currentPage ~/ widget.threshold) * widget.threshold;

    rangeEnd = rangeStart + widget.threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => changePage(0),
            child: Stack(
              children: [
                if (widget.controlButton != null) ...[widget.controlButton!, iconToFirst] else
                  _defaultControlButton(iconToFirst),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          InkWell(
            onTap: () => changePage(--currentPage),
            child: Stack(
              children: [
                if (widget.controlButton != null) ...[widget.controlButton!, iconPrevious] else
                  _defaultControlButton(iconPrevious),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ...List.generate(
            rangeEnd <= widget.pageTotal ? widget.threshold : widget.pageTotal % widget.threshold,
            (index) => Flexible(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => changePage(index + 1 + rangeStart),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: (currentPage - 1) % widget.threshold == index ? widget.colorPrimary : widget.colorSub,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '${index + 1 + rangeStart}',
                    style: TextStyle(
                      color: (currentPage - 1) % widget.threshold == index ? widget.colorSub : widget.colorPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => changePage(++currentPage),
            child: Stack(
              children: [
                if (widget.controlButton != null) ...[widget.controlButton!, iconNext] else
                  _defaultControlButton(iconNext),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          InkWell(
            onTap: () => changePage(widget.pageTotal),
            child: Stack(
              children: [
                if (widget.controlButton != null) ...[widget.controlButton!, iconToLast] else
                  _defaultControlButton(iconToLast),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
