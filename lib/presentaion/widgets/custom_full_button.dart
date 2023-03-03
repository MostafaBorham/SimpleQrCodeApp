import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    Key? key,
    required this.width,
    required this.verticalPadding,
    required this.borderRadius,
    required this.textStyle,
    required this.fontWeight,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.elevation,
    this.onPressed,
    this.borderColor = Colors.black38,
  }) : super(key: key);
  final double verticalPadding;
  final double borderRadius;
  final double width;
  final TextStyle textStyle;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final String text;
  final double elevation;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              elevation: elevation,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(color: borderColor)),
              textStyle: textStyle.copyWith(
                fontWeight: fontWeight,
              )),
          child: AutoSizeText(text)),
    );
  }
}
