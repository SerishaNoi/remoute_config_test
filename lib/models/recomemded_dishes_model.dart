class RecomendedDishesModel {
  final int calories;
  final String dishes;

  RecomendedDishesModel({
    required this.calories,
    required this.dishes,
  });

  factory RecomendedDishesModel.fromJson(Map<String, dynamic> json) {
    return RecomendedDishesModel(calories: json["calories"], dishes: json["name"]);
  }
}
