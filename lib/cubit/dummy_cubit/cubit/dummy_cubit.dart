import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remoute_config_test/constants/json_routh.dart';
import 'package:remoute_config_test/methods/calculate_calories.dart';
import 'package:remoute_config_test/methods/read_data_from_json.dart';
import 'package:remoute_config_test/models/recomemded_dishes_model.dart';

part 'dummy_state.dart';
part 'dummy_cubit.freezed.dart';

class DummyCubit extends Cubit<DummyState> {
  DummyCubit() : super(const DummyState.initial()) {
    print('adsasdasd');
  }

  void calculateCaloriesToDayPart({
    required double weight,
    required double height,
    required double age,
  }) async {
    var totalValue = calculateCalories(weight, height, age);

    double caloriesValueToBreakfast = totalValue * 0.3;
    double caloriesValueToLunch = totalValue * 0.35;
    double caloriesValueToSupper = totalValue * 0.25;

    List<RecomendedDishesModel> dishesToBreakfastData = await readJson(JsonRouth.breakfast);
    List<RecomendedDishesModel> dishesToLunchData = await readJson(JsonRouth.lunch);
    List<RecomendedDishesModel> dishesToSupperData = await readJson(JsonRouth.supper);

    List<RecomendedDishesModel> filtratedDishesToBreakfast = dishesToBreakfastData
        .where((element) => element.calories <= caloriesValueToBreakfast)
        .toList();

    List<RecomendedDishesModel> filtratedDishesToLunch =
        dishesToLunchData.where((element) => element.calories <= caloriesValueToLunch).toList();

    List<RecomendedDishesModel> filtratedDishesToSupper =
        dishesToSupperData.where((element) => element.calories <= caloriesValueToSupper).toList();

    emit(DummyState.calculated(
      totalValue,
      caloriesValueToBreakfast,
      caloriesValueToLunch,
      caloriesValueToSupper,
      filtratedDishesToBreakfast,
      filtratedDishesToLunch,
      filtratedDishesToSupper,
      true,
    ));
  }
}
