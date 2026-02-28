import 'package:flutter/material.dart';

class CustomRichTextButton extends StatelessWidget {
  const CustomRichTextButton({
    super.key,
    required this.onPressed,
    required this.additionalText,
    required this.buttonText,
    this.textAlign = TextAlign.center,
    this.additionalTextStyle,
    this.buttonTextStyle,
  });

  final VoidCallback onPressed;
  final String additionalText;
  final String buttonText;
  final TextAlign textAlign;
  final TextStyle? additionalTextStyle;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      child: RichText(
        textAlign: textAlign,
        text: TextSpan(
          children: [
            TextSpan(
              text: additionalText,
              style: additionalTextStyle,
            ),
            TextSpan(
              text: buttonText,
              style: buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
