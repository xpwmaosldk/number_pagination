import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton(
    this.buttonElevation,
    this.buttonRadius,
    this.icon,
    this.enabled,
    this.onTap,
    this.fixedSize,
    this.backgroundColor, {
    super.key,
  });

  final double buttonElevation;
  final double buttonRadius;
  final Widget icon;
  final bool enabled;
  final Function(BuildContext) onTap;
  final Size fixedSize;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: buttonElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        fixedSize: fixedSize,
        minimumSize: fixedSize,
        overlayColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        backgroundColor: backgroundColor,
        animationDuration: Duration.zero,
      ),
      onPressed: enabled ? () => onTap(context) : null,
      child: icon,
    );
  }
}
