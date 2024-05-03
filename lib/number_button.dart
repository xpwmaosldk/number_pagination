import 'package:flutter/material.dart';
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
  @override
  void initState() {
    debugPrint('${widget.number} init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: widget.number == widget.pageService.currentPage
                ? widget.colorPrimary
                : null,
            elevation: widget.buttonElevation,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.buttonRadius),
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size(48, 48),
            foregroundColor: widget.number == widget.pageService.currentPage
                ? widget.colorSub
                : widget.colorPrimary,
            backgroundColor: widget.number == widget.pageService.currentPage
                ? widget.colorPrimary
                : widget.colorSub,
          ),
          onPressed: () {
            widget.onSelect(widget.number);
          },
          child: Text(
            '${widget.number}',
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              color: widget.number == widget.pageService.currentPage
                  ? widget.colorSub
                  : widget.colorPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
