import 'package:flutter/material.dart';
import 'number_page_container.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({
    required this.number,
    required this.buttonElevation,
    required this.buttonRadius,
    required this.fontSize,
    required this.fontFamily,
    required this.onSelect,
    required this.fixedSize,
    required this.selectedTextColor,
    required this.unSelectedTextColor,
    required this.selectedButtonColor,
    required this.unSelectedButtonColor,
    required this.selectedNumberFontWeight,
    this.buttonSelectedBorderColor,
    this.buttonUnSelectedBorderColor,
    this.enableInteraction = true,
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
  final Color? buttonSelectedBorderColor;
  final Color? buttonUnSelectedBorderColor;
  final FontWeight selectedNumberFontWeight;
  final bool enableInteraction;

  @override
  Widget build(BuildContext context) {
    final selected = number == NumberPageContainer.of(context).currentPage;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: enableInteraction
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: buttonElevation,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: (buttonSelectedBorderColor != null ||
                            buttonUnSelectedBorderColor != null)
                        ? BorderSide(
                            color: selected
                                ? buttonSelectedBorderColor ??
                                    const Color(0xFF000000)
                                : buttonUnSelectedBorderColor ??
                                    const Color(0xFF000000),
                          )
                        : BorderSide.none,
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
              )
            : TextButton(
                style: TextButton.styleFrom(
                  elevation: buttonElevation,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: (buttonSelectedBorderColor != null ||
                            buttonUnSelectedBorderColor != null)
                        ? BorderSide(
                            color: selected
                                ? buttonSelectedBorderColor ??
                                    const Color(0xFF000000)
                                : buttonUnSelectedBorderColor ??
                                    const Color(0xFF000000),
                          )
                        : BorderSide.none,
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
