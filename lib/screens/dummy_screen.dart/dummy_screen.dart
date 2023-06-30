import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remoute_config_test/cubit/dummy_cubit/cubit/dummy_cubit.dart';
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
        ? context.read<DummyCubit>().calculateCaloriesToDayPart(
              weight: double.parse(weightController.text),
              height: double.parse(heightController.text),
              age: double.parse(ageController.text),
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
    return BlocBuilder<DummyCubit, DummyState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your weight',
                      ),
                      controller: weightController,
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      onChanged: (value) {
                        _onValueIsChanged();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          calculated: (
            totalCaloriesScore,
            breakfastCalories,
            lunchCalories,
            supperCalories,
            recomendedBreakfastDishes,
            recomendedLunchDishes,
            recomendedSupperDishes,
            isCalculated,
          ) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    /*   isCalculated
                      ?  */
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CaloriesTextSpan(
                            calories: totalCaloriesScore.toString(),
                            titleText: 'Your daily norm of calories is: ',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CaloriesTextSpan(
                            calories: breakfastCalories.toString(),
                            titleText: 'Your breakfast norm of calories is: ',
                          ),
                          RecomendedDishesBox(
                            title: 'Start your day with this breakfast:',
                            recomendedDishes: recomendedBreakfastDishes[
                                    Random().nextInt(recomendedBreakfastDishes.length)]
                                .dishes,
                          ),
                          // take a random dishes from list of breakfast dishes closure to this calories value
                          CaloriesTextSpan(
                            calories: lunchCalories.toString(),
                            titleText: 'Your lunch norm of calories is: ',
                          ),
                          RecomendedDishesBox(
                            title: 'To your caloric value, you can take this dishes to Your lunch:',
                            recomendedDishes: recomendedLunchDishes[
                                    Random().nextInt(recomendedLunchDishes.length)]
                                .dishes,
                          ),
                          // take a random dishes from list of lunch dishes closure to this calories value
                          CaloriesTextSpan(
                            calories: supperCalories.toString(),
                            titleText: 'Your supper norm of calories is: ',
                          ),
                          RecomendedDishesBox(
                            title: 'Don`t forget to finish your day with healthy supper:',
                            recomendedDishes: recomendedSupperDishes[
                                    Random().nextInt(recomendedSupperDishes.length)]
                                .dishes,
                          ),
                          // take a random dishes from list of supper dishes closure to this calories value
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
