import 'package:flutter/material.dart';

class CaloriesTextSpan extends StatelessWidget {
  final String calories;
  final String titleText;

  const CaloriesTextSpan({
    super.key,
    required this.calories,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: titleText,
            style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
          TextSpan(
            text: calories,
            style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
