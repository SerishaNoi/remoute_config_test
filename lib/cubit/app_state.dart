part of 'app_cubit.dart';

class AppState {
  final double totalCaloriesScore;
  final double breakfastCalories;
  final double lunchCalories;
  final double supperCalories;
  final List<RecomendedDishesModel> recomendedBreakfastDishes;
  final List<RecomendedDishesModel> recomendedLunchDishes;
  final List<RecomendedDishesModel> recomendedSupperDishes;
  final CubitState state;
  final bool isLoading;
  final bool isCalculated;
  final bool isNeedToShowInternetErroreScreen;
  final bool isNeedToShowDummyScreen;
  final bool isNeedToShowWebViewScreen;
  final String urlLink;
  final String erroreMessage;

  AppState({
    this.totalCaloriesScore = 0,
    this.breakfastCalories = 0,
    this.lunchCalories = 0,
    this.supperCalories = 0,
    this.recomendedBreakfastDishes = const [],
    this.recomendedLunchDishes = const [],
    this.recomendedSupperDishes = const [],
    this.state = CubitState.initial,
    this.isLoading = false,
    this.isCalculated = false,
    this.isNeedToShowInternetErroreScreen = false,
    this.isNeedToShowDummyScreen = false,
    this.isNeedToShowWebViewScreen = false,
    this.erroreMessage = '',
    this.urlLink = '',
  });

  List<Object> get props => [
        totalCaloriesScore,
        breakfastCalories,
        lunchCalories,
        supperCalories,
        recomendedBreakfastDishes,
        recomendedLunchDishes,
        recomendedSupperDishes,
        state,
        isLoading,
        isCalculated,
        isNeedToShowInternetErroreScreen,
        isNeedToShowDummyScreen,
        isNeedToShowWebViewScreen,
        urlLink,
        erroreMessage,
      ];

  AppState copyWith({
    final double? totalCaloriesScore,
    final double? breakfastCalories,
    final double? lunchCalories,
    final double? supperCalories,
    final List<RecomendedDishesModel>? recomendedBreakfastDishes,
    final List<RecomendedDishesModel>? recomendedLunchDishes,
    final List<RecomendedDishesModel>? recomendedSupperDishes,
    final CubitState? state,
    final bool? isLoading,
    final bool? isCalculated,
    final bool? isNeedToShowInternetErroreScreen,
    final bool? isNeedToShowDummyScreen,
    final bool? isNeedToShowWebViewScreen,
    final String? urlLink,
    final String? erroreMessage,
  }) {
    return AppState(
      totalCaloriesScore: totalCaloriesScore ?? this.totalCaloriesScore,
      breakfastCalories: breakfastCalories ?? this.breakfastCalories,
      lunchCalories: lunchCalories ?? this.lunchCalories,
      supperCalories: supperCalories ?? this.supperCalories,
      recomendedBreakfastDishes: recomendedBreakfastDishes ?? this.recomendedBreakfastDishes,
      recomendedLunchDishes: recomendedLunchDishes ?? this.recomendedLunchDishes,
      recomendedSupperDishes: recomendedSupperDishes ?? this.recomendedSupperDishes,
      state: state ?? this.state,
      isLoading: isLoading ?? this.isLoading,
      isCalculated: isCalculated ?? this.isCalculated,
      isNeedToShowInternetErroreScreen:
          isNeedToShowInternetErroreScreen ?? this.isNeedToShowInternetErroreScreen,
      isNeedToShowDummyScreen: isNeedToShowDummyScreen ?? this.isNeedToShowDummyScreen,
      isNeedToShowWebViewScreen: isNeedToShowWebViewScreen ?? this.isNeedToShowWebViewScreen,
      urlLink: urlLink ?? this.urlLink,
      erroreMessage: erroreMessage ?? this.erroreMessage,
    );
  }
}
