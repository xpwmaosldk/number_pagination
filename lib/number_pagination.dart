library number_pagination;

import 'package:flutter/material.dart';

class NumberPagination extends StatefulWidget {
  final Function(int) listner;
  final int totalPage;
  final int threshold;
  final int currentPage;
  final Color primaryColor;
  final Color subColor;

  NumberPagination({
    required this.listner,
    required this.totalPage,
    this.threshold = 10,
    this.currentPage = 1,
    this.primaryColor = Colors.black,
    this.subColor = Colors.white,
  });

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  late int currentPage;
  late int rangeStart;
  late int rangeEnd;
  late Color primaryColor;
  late Color subColor;

  @override
  void initState() {
    currentPage = widget.currentPage;
    primaryColor = widget.primaryColor;
    subColor = widget.subColor;
    _rangeSet();
    super.initState();
  }

  void changePage(int page) {
    print(page);
    if (page <= 0) page = 1;

    if (page > widget.totalPage) page = widget.totalPage;

    setState(() {
      currentPage = page;
      _rangeSet();
      widget.listner(currentPage);
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
    var buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(Size(48, 48)),
      foregroundColor: MaterialStateProperty.all(primaryColor),
      backgroundColor: MaterialStateProperty.all(subColor),
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: buttonStyle,
            onPressed: () => changePage(0),
            child: Icon(Icons.first_page),
          ),
          SizedBox(
            width: 4,
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () => changePage(--currentPage),
            child: Icon(Icons.keyboard_arrow_left),
          ),
          SizedBox(
            width: 10,
          ),
          ...List.generate(
            rangeEnd <= widget.totalPage
                ? widget.threshold
                : widget.totalPage % widget.threshold,
            (index) => Flexible(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => changePage(index + 1 + rangeStart),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: (currentPage - 1) % widget.threshold == index
                        ? primaryColor
                        : subColor,
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
                      color: (currentPage - 1) % widget.threshold == index
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () => changePage(++currentPage),
            child: Icon(Icons.keyboard_arrow_right),
          ),
          SizedBox(
            width: 4,
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () => changePage(widget.totalPage),
            child: Icon(Icons.last_page),
          ),
        ],
      ),
    );
  }
}
