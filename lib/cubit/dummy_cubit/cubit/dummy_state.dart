part of 'dummy_cubit.dart';

@freezed
class DummyState with _$DummyState {
  const factory DummyState.initial() = _Initial;
  const factory DummyState.loading() = _Loading;
  const factory DummyState.calculated(
    double totalCaloriesScore,
    double breakfastCalories,
    double lunchCalories,
    double supperCalories,
    List<RecomendedDishesModel> recomendedBreakfastDishes,
    List<RecomendedDishesModel> recomendedLunchDishes,
    List<RecomendedDishesModel> recomendedSupperDishes,
    bool isCalculated,
  ) = _Calculated;
  const factory DummyState.error(String message) = _Error;

  // final double totalCaloriesScore;
  // final double breakfastCalories;
  // final double lunchCalories;
  // final double supperCalories;
  // final List<RecomendedDishesModel> recomendedBreakfastDishes;
  // final List<RecomendedDishesModel> recomendedLunchDishes;
  // final List<RecomendedDishesModel> recomendedSupperDishes;
  // final CubitState state;
  // final bool isCalculated;

  // DummyState({
  //   this.totalCaloriesScore = 0,
  //   this.breakfastCalories = 0,
  //   this.lunchCalories = 0,
  //   this.supperCalories = 0,
  //   this.recomendedBreakfastDishes = const [],
  //   this.recomendedLunchDishes = const [],
  //   this.recomendedSupperDishes = const [],
  //   this.state = CubitState.initial,
  //   this.isCalculated = false,
  // });
}
