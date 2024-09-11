import 'package:flutter/material.dart';
import 'number_page_container.dart';

class NumberButton extends StatelessWidget {
  const NumberButton(
    this.number,
    this.buttonElevation,
    this.buttonRadius,
    this.fontSize,
    this.fontFamily,
    this.onSelect,
    this.fixedSize,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.selectedButtonColor,
    this.unSelectedButtonColor,
    this.selectedNumberFontWeight, {
    super.key,
  });

  final int number;
  final double buttonElevation;
  final double buttonRadius;
  final double fontSize;
  final String fontFamily;
  final Function(BuildContext, int) onSelect;
  final Size fixedSize;
  final Color selectedTextColor;
  final Color unSelectedTextColor;
  final Color selectedButtonColor;
  final Color unSelectedButtonColor;
  final FontWeight selectedNumberFontWeight;

  @override
  Widget build(BuildContext context) {
    final selected = number == NumberPageContainer.of(context).currentPage;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: buttonElevation,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            padding: EdgeInsets.zero,
            fixedSize: fixedSize,
            minimumSize: fixedSize,
            overlayColor: Colors.transparent,
            backgroundColor:
                selected ? selectedButtonColor : unSelectedButtonColor,
          ),
          onPressed: () {
            onSelect(context, number);
          },
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: fontFamily,
              color: selected ? selectedTextColor : unSelectedTextColor,
              fontWeight: selected ? selectedNumberFontWeight : null,
            ),
          ),
        ),
      ),
    );
  }
}
