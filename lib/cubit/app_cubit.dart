import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remoute_config_test/constants/cubit_states.dart';
import 'package:remoute_config_test/constants/json_routh.dart';
import 'package:remoute_config_test/local_storage/local_storage.dart';
import 'package:remoute_config_test/methods/calculate_calories.dart';
import 'package:remoute_config_test/methods/check_device.dart';
import 'package:remoute_config_test/methods/read_data_from_json.dart';
import 'package:remoute_config_test/models/recomemded_dishes_model.dart';
import 'package:remoute_config_test/remote_config_services/firevase_remote_config_keys.dart';
import 'package:remoute_config_test/remote_config_services/remote_config_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState()) {
    startApp();
  }

  startApp() async {
    // Проверяем локально сохраненную сылку
    if (await _checkLocalSevedLink() == true) {
      final result = await Connectivity().checkConnectivity();
      // если девайс не подключен к интернету показываем экран ошибки интернет соединения
      if (result == ConnectivityResult.none) {
        emit(state.copyWith(isNeedToShowInternetErroreScreen: true));
      } else {
        emit(state.copyWith(isNeedToShowWebViewScreen: true, urlLink: state.urlLink));
      }
    } else {
      // Если в локальном хранилище нету ссылки обращаемся к Firebase
      _getLinkFromFirebase();
      // Проверяем девайс, это эмулятор?, это смартфон от гугл, если нет то сохраняем ссылку локально и показываем вебвью
      if (await checkDevice() == false) {
        LocalStorage().storeLink('link', state.urlLink);

        emit(state.copyWith(state: CubitState.loading, isNeedToShowWebViewScreen: true));
      } else {
        // если нет то показываем экран заглушку
        emit(state.copyWith(isNeedToShowDummyScreen: true, isLoading: false));
      }
    }
  }

  Future<bool> _checkLocalSevedLink() async {
    var savedLink = await LocalStorage().getLink('link');

    if (savedLink != null) {
      emit(state.copyWith(urlLink: savedLink));
      return true;
    }

    return false;
  }

  _getLinkFromFirebase() {
    var jsonFromRemoteConfig = RomoteConfigServices().getString(FirebaseRemoteConfigKeys.urlLink);
    String urlLinkFromRemoteConfig = json.decode(jsonFromRemoteConfig)['link'];

    emit(state.copyWith(urlLink: urlLinkFromRemoteConfig));
  }

  calculateCaloriesToDayPart(double weight, double height, double age) async {
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

    emit(
      state.copyWith(
        recomendedBreakfastDishes: filtratedDishesToBreakfast,
        recomendedLunchDishes: filtratedDishesToLunch,
        recomendedSupperDishes: filtratedDishesToSupper,
        totalCaloriesScore: totalValue,
        breakfastCalories: caloriesValueToBreakfast,
        lunchCalories: caloriesValueToLunch,
        supperCalories: caloriesValueToSupper,
        isCalculated: true,
      ),
    );
  }
}
