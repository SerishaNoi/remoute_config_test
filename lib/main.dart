import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remoute_config_test/cubit/app_cubit.dart';
import 'package:remoute_config_test/remote_config_services/remote_config_services.dart';
import 'package:remoute_config_test/screens/dummy_screen.dart/dummy_screen.dart';
import 'package:remoute_config_test/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remoute_config_test/screens/internet_errore_screen/internet_errore_screen.dart';
import 'package:remoute_config_test/screens/web_view_screen.dart/web_view_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await RomoteConfigServices().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AppCubit(),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            getCurrentScreen() {
              if (state.isNeedToShowWebViewScreen) {
                return WebViewScreen(urlLink: state.urlLink);
              }
              if (state.isNeedToShowInternetErroreScreen) {
                return const InternerErroreScreen();
              }
              if (state.isNeedToShowDummyScreen) {
                return const DummyScreen();
              }
            }

            return Container(child: getCurrentScreen());
          },
        ),
      ),
    );
  }
}
