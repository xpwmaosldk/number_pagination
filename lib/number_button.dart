import 'package:flutter/material.dart';

import 'number_pagination.dart';
import 'page_number_provider.dart';

class NumberButton extends StatefulWidget {
  const NumberButton(
    this.number,
    this.buttonElevation,
    this.buttonRadius,
    this.colorPrimary,
    this.colorSub,
    this.fontSize,
    this.fontFamily,
    this.pageService,
    this.onSelect,
  );

  final int number;
  final double buttonElevation;
  final double buttonRadius;
  final Color colorPrimary;
  final Color colorSub;
  final double fontSize;
  final String fontFamily;
  final Function(int) onSelect;
  final NumberPageService pageService;

  @override
  State<NumberButton> createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  late bool selected;
  late Function() listener;
  @override
  void initState() {
    selected = widget.number == widget.pageService.currentPage;

    listener = () {
      bool newSelected = widget.number == widget.pageService.currentPage;
      bool prevSelected = widget.number == widget.pageService.previousPage;

      if (newSelected != prevSelected) {
        debugPrint('${widget.number} update');
        setState(() {
          selected = newSelected;
        });
      }
    };

    widget.pageService.addListener(listener);

    debugPrint('${widget.number} init');
    super.initState();
  }

  @override
  void dispose() {
    widget.pageService.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: selected ? widget.colorPrimary : null,
            elevation: widget.buttonElevation,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.buttonRadius),
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size(48, 48),
            foregroundColor: selected ? widget.colorSub : widget.colorPrimary,
            backgroundColor: selected ? widget.colorPrimary : widget.colorSub,
          ),
          onPressed: () {
            if (!selected) {
              setState(() {
                selected = true;
              });
              widget.onSelect(widget.number);
            }
          },
          child: Text(
            '${widget.number}',
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              color: selected ? widget.colorSub : widget.colorPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
