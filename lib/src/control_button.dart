import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton(
    this.buttonElevation,
    this.buttonRadius,
    this.colorPrimary,
    this.colorSub,
    this.icon,
    this.enabled,
    this.onTap,
    this.minimumSize, {
    super.key,
  });

  final double buttonElevation;
  final double buttonRadius;
  final Color colorPrimary;
  final Color colorSub;
  final Widget icon;
  final bool enabled;
  final Function(BuildContext) onTap;
  final Size minimumSize;

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
        minimumSize: minimumSize,
        foregroundColor: enabled ? colorPrimary : Colors.grey,
        backgroundColor: colorSub,
        disabledForegroundColor: colorPrimary,
        disabledBackgroundColor: colorSub,
      ),
      onPressed: enabled ? () => onTap(context) : null,
      child: icon,
    );
  }
}
