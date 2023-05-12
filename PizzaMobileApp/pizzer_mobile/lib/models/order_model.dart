import 'dart:io';
import 'package:pizzer_mobile/models/order_lines_model.dart';

class OrderModel {
  int? id;
  DateTime? creationTime;
  DateTime? finishedTime;
  DateTime? predictedTime;
  double? price;
  String? address;
  String? phoneNumber;
  String? clientName;
  String? payingType;
  int? usedBonuses;
  int? givenBonuses;
  String? comment;
  double? change;
  int? clientId;
  int? workerId;
  String? workerName;
  int? courierId;
  String? courierName;
  String? statusName;
  int? statusId;
  List? orderLines;

  OrderModel({
    this.id,
    this.creationTime,
    this.finishedTime,
    this.predictedTime,
    this.price,
    this.address,
    this.phoneNumber,
    this.clientName,
    this.payingType,
    this.usedBonuses,
    this.givenBonuses,
    this.comment,
    this.change,
    this.clientId,
    this.workerId,
    this.workerName,
    this.courierId,
    this.courierName,
    this.statusName,
    this.statusId,
    this.orderLines,
  });

  OrderModel.fromJsonSingle(dynamic json) {
    id = json['id'];
    creationTime = DateTime.tryParse(json['creationTime']);
    if (json['finishedTime'] != null) {
      finishedTime = DateTime.tryParse(json['finishedTime']);
    }
    predictedTime = DateTime.tryParse(json['predictedTime']);
    price = json['price'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    clientName = json['clientName'];
    payingType = json['payingType'];
    if (json['usedBonuses'] != null) {
      usedBonuses = json['usedBonuses'];
    }
    givenBonuses = json['givenBonuses'];
    if (json['comment'] != null) {
      comment = json['comment'];
    }
    change = json['change'];
    clientId = json['clientId'];
    workerId = json['workerId'];
    workerName = json['workerName'];
    courierId = json['courierId'];
    courierName = json['courierName'];
    statusName = json['statusName'];
    statusId = json['statusId'];
    orderLines =
        json['orderLines'].map((e) => OrderLinesModel.fromJson(e)).toList();
  }

  // OrderModel.fromJson(dynamic json) {
  //   id = json['id'];
  //   email = json['email'];
  //   name = json['name'];
  //   role = json['role'];
  //   isApproved = json['isApproved'];
  //   phone = json['phone'];
  //   bonuses = json['bonuses'];
  //   passport = json['passport'];
  // }
}
