import 'package:flutter/material.dart';

double calculateCalories(double weight, double height, double age) {
  final double calculatedCalories = (10 * weight) + (6.25 * height) - (5 * age) + 5;

  return calculatedCalories;
}

bool controllersValueChecker(
  TextEditingController weightController,
  TextEditingController heightController,
  TextEditingController ageController,
) {
  if (weightController.value.text.isNotEmpty &&
      heightController.value.text.isNotEmpty &&
      ageController.value.text.isNotEmpty) {
    return true;
  }
  return false;
}
