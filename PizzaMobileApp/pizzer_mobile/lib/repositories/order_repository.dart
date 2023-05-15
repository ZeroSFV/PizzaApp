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
    } else if (response.statusCode == 400) {
      final responseError = jsonDecode(response.body);
      final reqResult = RequestModel.fromJson(responseError);
      bool badResult = false;
      return badResult;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<OrderModel> getUserActiveOrder(int? userId) async {
    String Url = orderUrl + '/userActiveOrder/' + userId.toString();
    Response response = await get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final orderResult = OrderModel.fromJsonSingle(result);
      return orderResult;
    } else if (response.statusCode == 400) {
      final responseError = jsonDecode(response.body);
      final reqResult = RequestModel.fromJson(responseError);
      bool badResult = false;
      return OrderModel();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<OrderModel>> getUnacceptedWorkerOrders() async {
    String Url = orderUrl + '/unacceptedWorkerOrders';
    Response response = await get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => OrderModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<OrderModel>> getAllOrders() async {
    String Url = orderUrl;
    Response response = await get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => OrderModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> workerAcceptOrder(int? workerId, int? orderId) async {
    String Url = orderUrl + '/acceptOrderByWorker';
    Response resPut = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "orderId": orderId,
          "workerId": workerId,
          "courierId": 0
        }));
    if (resPut.statusCode == 200) {
      return true;
    }
    if (resPut.statusCode != 400) {
      throw Exception(resPut.reasonPhrase);
    }
    return false;
  }

  Future<dynamic> getWorkerActiveOrder(int? workerId) async {
    String Url = orderUrl + '/workerActiveOrder/' + workerId.toString();
    Response response = await get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final orderResult = OrderModel.fromJsonSingle(result);
      return orderResult;
    } else if (response.statusCode == 400) {
      final responseError = jsonDecode(response.body);
      final reqResult = RequestModel.fromJson(responseError);
      bool badResult = false;
      return null;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<OrderModel>> getUserAllOrder(int? userId) async {
    String Url = orderUrl + '/userOrder/' + userId.toString();
    Response response = await get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => OrderModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(response.reasonPhrase);
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

  Future<void> cancelOrder(int? orderId) async {
    String Url = orderUrl + '/cancelOrder';
    Response resPost = await put(Uri.parse(Url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{"id": orderId}));
    if (resPost.statusCode != 200) {
      throw Exception(resPost.reasonPhrase);
    }
  }
}
