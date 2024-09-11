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
    this.minimumSize,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.selectedButtonColor,
    this.unSelectedButtonColor, {
    super.key,
  });

  final int number;
  final double buttonElevation;
  final double buttonRadius;
  final double fontSize;
  final String fontFamily;
  final Function(BuildContext, int) onSelect;
  final Size minimumSize;
  final Color selectedTextColor;
  final Color unSelectedTextColor;
  final Color selectedButtonColor;
  final Color unSelectedButtonColor;

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
            minimumSize: minimumSize,
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
            ),
          ),
        ),
      ),
    );
  }
}
