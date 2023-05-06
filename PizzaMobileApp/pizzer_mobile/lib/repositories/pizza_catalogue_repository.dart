import 'dart:convert';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:http/http.dart';

class PizzaRepository {
  String pizzaUrlGetAll = 'http://192.168.1.38:25567/api/pizza';

  Future<List<PizzaModel>> getPizzas() async {
    Response response = await get(Uri.parse(pizzaUrlGetAll));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => PizzaModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<PizzaModel> getBigPizzaByName(String? name) async {
    Response response =
        await get(Uri.parse(pizzaUrlGetAll + '/byname/' + name.toString()));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      List<PizzaModel> pizzaModels =
          result.map((e) => PizzaModel.fromJson(e)).toList();
      return pizzaModels.firstWhere((e) => e.sizeId == 1);
      // for (int i = 0; i < pizzaModels.length; i++) {
      //   if (pizzaModels[i].sizeId == 1) {
      //     return pizzaModels[i];
      //   } else
      //     return null;
      // }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<PizzaModel> getMediumPizzaByName(String? name) async {
    Response response =
        await get(Uri.parse(pizzaUrlGetAll + '/byname/' + name.toString()));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      List<PizzaModel> pizzaModels =
          result.map((e) => PizzaModel.fromJson(e)).toList();
      return pizzaModels.firstWhere((e) => e.sizeId == 2);
      // for (int i = 0; i < pizzaModels.length; i++) {
      //   if (pizzaModels[i].sizeId == 1) {
      //     return pizzaModels[i];
      //   } else
      //     return null;
      // }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
