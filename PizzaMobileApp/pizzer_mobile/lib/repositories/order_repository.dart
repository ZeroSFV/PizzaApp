import 'dart:convert';
import 'package:pizzer_mobile/models/make_order_model.dart';
import 'package:http/http.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/request_model.dart';

class OrderRepository {
  String orderUrl = 'http://192.168.1.38:25567/api/order';

  Future<bool> checkActiveOrder(int? userId) async {
    String Url = orderUrl + '/userActiveOrder/' + userId.toString();
    bool respResult;
    Response response = await get(Uri.parse(Url));

    if (response.statusCode == 200) {
      respResult = true;
      final result = jsonDecode(response.body);
      final orderResult = OrderModel.fromJsonSingle(result);
      return respResult;
    } else {
      final responseError = jsonDecode(response.body);
      final reqResult = RequestModel.fromJson(responseError);
      bool badResult = false;
      return badResult;
    }
  }

  Future<void> makeOrder(MakeOrderModel makeOrderModel) async {
    String Url = orderUrl + '/makeOrder';
    Response resPost = await post(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "clientId": makeOrderModel.clientId,
          "address": makeOrderModel.address,
          "phoneNumber": makeOrderModel.phoneNumber,
          "clientName": makeOrderModel.clientName,
          "payingType": makeOrderModel.payingType,
          "predictedTime": makeOrderModel.predictedTime,
          "change": makeOrderModel.change,
          "usedBonuses": makeOrderModel.usedBonuses,
          "givenBonuses": makeOrderModel.givenBonuses,
          "comment": makeOrderModel.comment
        }));
    if (resPost.statusCode != 200) {
      throw Exception(resPost.reasonPhrase);
    }
  }
}
