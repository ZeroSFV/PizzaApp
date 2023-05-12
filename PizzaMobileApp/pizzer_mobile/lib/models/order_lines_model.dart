import 'dart:io';

class OrderLinesModel {
  int? id;
  int? count;
  int? pizzaId;
  int? orderId;
  String? pizzaName;
  String? sizeName;
  double? pizzaPrice;

  OrderLinesModel(
      {this.id,
      this.count,
      this.pizzaId,
      this.orderId,
      this.pizzaName,
      this.sizeName,
      this.pizzaPrice});

  OrderLinesModel.fromJson(dynamic json) {
    id = json['id'];
    count = json['count'];
    pizzaId = json['pizzaId'];
    orderId = json['orderId'];
    pizzaName = json['pizzaName'];
    sizeName = json['sizeName'];
    pizzaPrice = json['pizzaPrice'];
  }
}
