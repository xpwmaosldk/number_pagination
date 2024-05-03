import 'package:flutter/material.dart';
import 'number_pagination.dart';

class NumberButton extends StatelessWidget {
  const NumberButton(
    this.number,
    this.buttonElevation,
    this.buttonRadius,
    this.colorPrimary,
    this.colorSub,
    this.fontSize,
    this.fontFamily,
    this.onSelect,
  );

  final int number;
  final double buttonElevation;
  final double buttonRadius;
  final Color colorPrimary;
  final Color colorSub;
  final double fontSize;
  final String fontFamily;
  final Function(BuildContext, int) onSelect;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: number == NumberPageContainer.of(context).currentPage
                ? colorPrimary
                : null,
            elevation: buttonElevation,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size(48, 48),
            foregroundColor:
                number == NumberPageContainer.of(context).currentPage
                    ? colorSub
                    : colorPrimary,
            backgroundColor:
                number == NumberPageContainer.of(context).currentPage
                    ? colorPrimary
                    : colorSub,
          ),
          onPressed: () {
            onSelect(context, number);
          },
          child: Text(
            '${number}',
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: fontFamily,
              color: number == NumberPageContainer.of(context).currentPage
                  ? colorSub
                  : colorPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
