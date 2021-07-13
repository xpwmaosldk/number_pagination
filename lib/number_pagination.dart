library number_pagination;

import 'package:flutter/material.dart';

class NumberPagination extends StatefulWidget {
  final Function(int) listner;
  final int totalPage;
  final int size;
  final int currentPage;
  final Color primaryColor;
  final Color subColor;

  NumberPagination({
    required this.listner,
    required this.totalPage,
    this.size = 10,
    this.currentPage = 0,
    this.primaryColor = Colors.black,
    this.subColor = Colors.white,
  });

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  int currentPage = 0;
  int rangeStart = 0;
  int rangeEnd = 0;
  Color primaryColor = Colors.black;
  Color subColor = Colors.white;

  @override
  void initState() {
    currentPage = widget.currentPage - 1;
    rangeStart = (widget.currentPage ~/ widget.size) * widget.size;
    rangeEnd = rangeStart + widget.size;
    primaryColor = widget.primaryColor;
    subColor = widget.subColor;
    super.initState();
  }

  void changePage(int page) {
    if (page < 0) page = 0;

    if (page > widget.totalPage - 1) page = widget.totalPage - 1;

    setState(() {
      currentPage = page;
      rangeStart = (currentPage ~/ widget.size) * widget.size;
      rangeEnd = rangeStart + widget.size;
      widget.listner(currentPage);
    });
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
            rangeEnd < widget.totalPage
                ? widget.size
                : widget.totalPage % widget.size,
            (index) => Flexible(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => changePage(index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: currentPage % widget.size == index
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
                      color: currentPage % widget.size == index
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
