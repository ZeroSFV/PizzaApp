import 'dart:convert';
import 'package:pizzer_mobile/models/basket_model.dart';
import 'package:http/http.dart';

class BasketRepository {
  String basketUrl = 'http://192.168.1.38:25567/api/basket';

  Future<List<BasketModel>> getBasketsOfUser(int? userId) async {
    Response response =
        await get(Uri.parse(basketUrl + '/userBaskets/' + userId.toString()));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => BasketModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateBasket(BasketModel basketModel) async {
    String Url = basketUrl + '/updateBasket';
    Response resPut = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "id": basketModel.id,
          "amount": basketModel.amount,
          "price": basketModel.price,
          "userId": basketModel.userId,
          "pizzaId": basketModel.pizzaId,
          "pizzaName": basketModel.pizzaName,
          "sizeName": basketModel.sizeName
        }));
    if (resPut.statusCode != 200) {
      throw Exception(resPut.reasonPhrase);
    }
  }

  Future<void> deleteBasket(int? basketId) async {
    String Url = basketUrl + '/deleteBasket/' + basketId.toString();
    Response resDelete = await delete(
      Uri.parse(Url),
      headers: {"content-type": "application/json"},
    );
    if (resDelete.statusCode != 200) {
      throw Exception(resDelete.reasonPhrase);
    }
  }
}
