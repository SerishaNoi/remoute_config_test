import 'package:flutter/material.dart';

class CaloriesTextSpan extends StatelessWidget {
  final String calories;
  final String titleText;
  final Color titileColor;
  final Color coloriesValueColor;

  const CaloriesTextSpan({
    super.key,
    required this.calories,
    required this.titleText,
    required this.titileColor,
    required this.coloriesValueColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: titleText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: titileColor),
          ),
          TextSpan(
            text: calories,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: coloriesValueColor),
          ),
        ],
      ),
    );
  }
}
