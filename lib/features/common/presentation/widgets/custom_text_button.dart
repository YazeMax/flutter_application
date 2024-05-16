// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.textColor = Colors.white,
    required this.lightText,
    required this.boldText,
    required this.onTap,
  });

  final String lightText;
  final String boldText;
  final Color textColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: lightText,
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            TextSpan(
              text: boldText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
