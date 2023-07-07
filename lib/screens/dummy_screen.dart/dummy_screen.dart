import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remoute_config_test/cubit/dummy_cubit/cubit/dummy_cubit.dart';
import 'package:remoute_config_test/methods/calculate_calories.dart';
import 'package:remoute_config_test/screens/dummy_screen.dart/widgets/recomended_dishes_box.dart';
import 'package:remoute_config_test/screens/dummy_screen.dart/widgets/styled_text_form_firld.dart';
import 'package:remoute_config_test/screens/dummy_screen.dart/widgets/test_spans_widget.dart';

const String notHaveRecomendedDishesMEsaage =
    'Sorry 🙃, we don`t have recomended dishes to this calories value';

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
            return SafeArea(
              child: Scaffold(
                body: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Gym_2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Column(
                      children: [
                        const Text(
                          'To get a sports nutrition plan, enter the data:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF36B163),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StyledTextFormField(
                          enebledBorderColor: const Color(0xFFf2c063),
                          focusedBorderColor: const Color(0xFF36B163),
                          lableColor: const Color(0xFFf2c063),
                          editedTextStyle: const Color(0xFFf2c063),
                          textEditingController: weightController,
                          lable: 'Enter your weight',
                          providedContext: context,
                          onChanged: (value) {
                            _onValueIsChanged();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StyledTextFormField(
                          enebledBorderColor: const Color(0xFFf2c063),
                          focusedBorderColor: const Color(0xFF36B163),
                          lableColor: const Color(0xFFf2c063),
                          editedTextStyle: const Color(0xFFf2c063),
                          textEditingController: heightController,
                          providedContext: context,
                          lable: 'Enter your height',
                          onChanged: (value) {
                            _onValueIsChanged();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StyledTextFormField(
                          enebledBorderColor: const Color(0xFFf2c063),
                          focusedBorderColor: const Color(0xFF36B163),
                          lableColor: const Color(0xFFf2c063),
                          editedTextStyle: const Color(0xFFf2c063),
                          textEditingController: ageController,
                          providedContext: context,
                          lable: 'Enter your age',
                          onChanged: (value) {
                            _onValueIsChanged();
                          },
                        ),
                      ],
                    ),
                  ),
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
              backgroundColor: const Color(0xff302f38),
              body: SingleChildScrollView(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Gym_2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'See what you geted:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF36B163),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StyledTextFormField(
                              enebledBorderColor: const Color(0xFFf2c063),
                              focusedBorderColor: const Color(0xFF36B163),
                              lableColor: const Color(0xFFf2c063),
                              editedTextStyle: const Color(0xFFf2c063),
                              textEditingController: weightController,
                              lable: 'Enter your weight',
                              providedContext: context,
                              onChanged: (value) {
                                _onValueIsChanged();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StyledTextFormField(
                              enebledBorderColor: const Color(0xFFf2c063),
                              focusedBorderColor: const Color(0xFF36B163),
                              lableColor: const Color(0xFFf2c063),
                              editedTextStyle: const Color(0xFFf2c063),
                              textEditingController: heightController,
                              providedContext: context,
                              lable: 'Enter your height',
                              onChanged: (value) {
                                _onValueIsChanged();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StyledTextFormField(
                              enebledBorderColor: const Color(0xFFf2c063),
                              focusedBorderColor: const Color(0xFF36B163),
                              lableColor: const Color(0xFFf2c063),
                              editedTextStyle: const Color(0xFFf2c063),
                              textEditingController: ageController,
                              providedContext: context,
                              lable: 'Enter your age',
                              onChanged: (value) {
                                _onValueIsChanged();
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CaloriesTextSpan(
                              coloriesValueColor: const Color(0xFFeda115),
                              titileColor: const Color(0xFF36B163),
                              calories: totalCaloriesScore.toString(),
                              titleText: 'Your daily norm of calories is: ',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CaloriesTextSpan(
                              coloriesValueColor: const Color(0xFFeda115),
                              titileColor: const Color(0xFF36B163),
                              calories: breakfastCalories.toString(),
                              titleText: 'Your breakfast norm of calories is: ',
                            ),
                            RecomendedDishesBox(
                              title: 'Start your day with this breakfast:',
                              recomendedDishes: recomendedBreakfastDishes.isNotEmpty
                                  ? recomendedBreakfastDishes[
                                          Random().nextInt(recomendedBreakfastDishes.length)]
                                      .dishes
                                  : notHaveRecomendedDishesMEsaage,
                            ),
                            // take a random dishes from list of breakfast dishes closure to this calories value
                            CaloriesTextSpan(
                              coloriesValueColor: const Color(0xFFeda115),
                              titileColor: const Color(0xFF36B163),
                              calories: lunchCalories.toString(),
                              titleText: 'Your lunch norm of calories is: ',
                            ),
                            RecomendedDishesBox(
                              title:
                                  'To your caloric value, you can take this dishes to Your lunch:',
                              recomendedDishes: recomendedLunchDishes.isNotEmpty
                                  ? recomendedLunchDishes[
                                          Random().nextInt(recomendedLunchDishes.length)]
                                      .dishes
                                  : notHaveRecomendedDishesMEsaage,
                            ),

                            // take a random dishes from list of lunch dishes closure to this calories value
                            CaloriesTextSpan(
                              coloriesValueColor: const Color(0xFFeda115),
                              titileColor: const Color(0xFF36B163),
                              calories: supperCalories.toString(),
                              titleText: 'Your supper norm of calories is: ',
                            ),
                            RecomendedDishesBox(
                              title: 'Don`t forget to finish your day with healthy supper:',
                              recomendedDishes: recomendedSupperDishes.isNotEmpty
                                  ? recomendedSupperDishes[
                                          Random().nextInt(recomendedSupperDishes.length)]
                                      .dishes
                                  : notHaveRecomendedDishesMEsaage,
                            ),
                            // take a random dishes from list of supper dishes closure to this calories value
                          ],
                        ),
                      ),
                    ],
                  ),
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
