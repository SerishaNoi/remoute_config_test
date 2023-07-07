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
          color: const Color(0xFF302f38),
          border: Border.all(
            width: 1.4,
            color: const Color(0xFF36B163),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFF36B163),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFf2c063),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                recomendedDishes,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFeda115)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
