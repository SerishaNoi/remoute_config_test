import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:remoute_config_test/models/recomemded_dishes_model.dart';

Future<List<RecomendedDishesModel>> readJson(String key) async {
  final String response = await rootBundle.loadString(key);

  final List<RecomendedDishesModel> data = List<RecomendedDishesModel>.from(
    json.decode(response).map(
          (x) => RecomendedDishesModel.fromJson(x),
        ),
  );

  return data;
}
