import 'package:flutter/material.dart';

class RecomendedDishesBox extends StatelessWidget {
  final String title;
  final String recomendedDishes;

  const RecomendedDishesBox({
    super.key,
    required this.title,
    required this.recomendedDishes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                recomendedDishes,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
