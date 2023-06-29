import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remoute_config_test/cubit/app_cubit.dart';
import 'package:remoute_config_test/methods/calculate_calories.dart';
import 'package:remoute_config_test/screens/dummy_screen.dart/widgets/recomended_dishes_box.dart';
import 'package:remoute_config_test/screens/dummy_screen.dart/widgets/test_spans_widget.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  Timer? _debounce;
  bool isValuesEdited = false;
  late final TextEditingController weightController;
  late final TextEditingController heightController;
  late final TextEditingController ageController;

  @override
  void initState() {
    weightController = TextEditingController();
    heightController = TextEditingController();
    ageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _checkAndStartCalculate() {
    isValuesEdited = controllersValueChecker(weightController, heightController, ageController);
    isValuesEdited
        ? AppCubit().calculateCaloriesToDayPart(
            double.parse(weightController.text),
            double.parse(heightController.text),
            double.parse(ageController.text),
          )
        : null;
  }

  _onValueIsChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _checkAndStartCalculate();
    });
  }

  @override
  Widget build(BuildContext _) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        state.isCalculated;
      },
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your weight',
                          ),
                          controller: weightController,
                          onChanged: (value) {
                            _onValueIsChanged();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your height',
                          ),
                          controller: heightController,
                          onChanged: (value) {
                            _onValueIsChanged();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your age',
                          ),
                          controller: ageController,
                          onChanged: (value) {
                            _onValueIsChanged();
                          },
                        ),
                      ],
                    ),
                  ),
                  state.isCalculated
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CaloriesTextSpan(
                                calories: state.totalCaloriesScore.toString(),
                                titleText: 'Your daily norm of calories is: ',
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CaloriesTextSpan(
                                calories: state.breakfastCalories.toString(),
                                titleText: 'Your breakfast norm of calories is: ',
                              ),
                              // RecomendedDishesBox(
                              //   title: 'Start your day with this breakfast:',
                              //   recomendedDishes: state
                              //       .recomendedBreakfastDishes[
                              //           Random().nextInt(state.recomendedBreakfastDishes.length)]
                              //       .dishes,
                              // ),
                              // take a random dishes from list of breakfast dishes closure to this calories value
                              CaloriesTextSpan(
                                calories: state.lunchCalories.toString(),
                                titleText: 'Your lunch norm of calories is: ',
                              ),
                              // RecomendedDishesBox(
                              //   title:
                              //       'To your caloric value, you can take this dishes to Your lunch:',
                              //   recomendedDishes: state
                              //       .recomendedLunchDishes[
                              //           Random().nextInt(state.recomendedLunchDishes.length)]
                              //       .dishes,
                              // ),
                              // take a random dishes from list of lunch dishes closure to this calories value
                              CaloriesTextSpan(
                                calories: state.supperCalories.toString(),
                                titleText: 'Your supper norm of calories is: ',
                              ),
                              // RecomendedDishesBox(
                              //   title: 'Don`t forget to finish your day with healthy supper:',
                              //   recomendedDishes: state
                              //       .recomendedSupperDishes[
                              //           Random().nextInt(state.recomendedSupperDishes.length)]
                              //       .dishes,
                              // ),
                              // take a random dishes from list of supper dishes closure to this calories value
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
