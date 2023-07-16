import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remoute_config_test/constants/cubit_states.dart';
import 'package:remoute_config_test/local_storage/local_storage.dart';
import 'package:remoute_config_test/methods/check_device.dart';
import 'package:remoute_config_test/models/recomemded_dishes_model.dart';
import 'package:remoute_config_test/remote_config_services/remote_config_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState()) {
    startApp();
  }

  startApp() async {
    final result = await Connectivity().checkConnectivity();
    // если девайс не подключен к интернету показываем экран ошибки интернет соединения
    if (result == ConnectivityResult.none) {
      emit(state.copyWith(isNeedToShowInternetErroreScreen: true));
    } else {
      // Проверяем локально сохраненную сылку
      if (await _checkLocalSevedLink() == true) {
        emit(state.copyWith(isNeedToShowWebViewScreen: true, urlLink: state.urlLink));
      } else {
        // Если в локальном хранилище нету ссылки обращаемся к Firebase
        // _getLinkFromFirebase();
        var jsonFromRemoteConfig = RomoteConfigServices().getString('url');

        if (jsonFromRemoteConfig.isEmpty || jsonFromRemoteConfig == "") {
          emit(state.copyWith(isNeedToShowDummyScreen: true, isLoading: false));
        } else {
          emit(state.copyWith(urlLink: jsonFromRemoteConfig));
          // Проверяем девайс, это эмулятор?, это смартфон от гугл?, если нет то сохраняем ссылку локально и показываем вебвью
          if (await checkDevice() == false) {
            LocalStorage().storeLink('link', state.urlLink);

            emit(state.copyWith(state: CubitState.loading, isNeedToShowWebViewScreen: true));
          } else {
            // если нет то показываем экран заглушку
            emit(state.copyWith(isNeedToShowDummyScreen: true, isLoading: false));
          }
        }
      }
    }
  }

  Future<bool> _checkLocalSevedLink() async {
    var savedLink = await LocalStorage().getLink('link');

    if (savedLink != null && savedLink != "") {
      emit(state.copyWith(urlLink: savedLink));
      return true;
    }

    return false;
  }

  // _getLinkFromFirebase() {
  //   var jsonFromRemoteConfig = RomoteConfigServices().getString('url');

  //   if (jsonFromRemoteConfig.isEmpty || jsonFromRemoteConfig == "") {
  //     emit(state.copyWith(isNeedToShowDummyScreen: true, isLoading: false));
  //   } else {
  //     emit(state.copyWith(urlLink: jsonFromRemoteConfig));
  //   }
  // }
}
