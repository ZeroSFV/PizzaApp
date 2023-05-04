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
}
