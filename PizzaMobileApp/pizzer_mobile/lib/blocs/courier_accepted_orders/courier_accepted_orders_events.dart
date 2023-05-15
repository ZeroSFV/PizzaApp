import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/order_model.dart';

@immutable
abstract class CourierAcceptedOrdersEvent extends Equatable {
  const CourierAcceptedOrdersEvent();
}

class LoadCourierAcceptedOrdersEvent extends CourierAcceptedOrdersEvent {
  String? token;
  LoadCourierAcceptedOrdersEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class ToNextStatusOrderEvent extends CourierAcceptedOrdersEvent {
  final String? token;
  final OrderModel order;
  final List<OrderModel> orders;
  ToNextStatusOrderEvent(this.token, this.order, this.orders);
  @override
  List<Object?> get props => [token, order, orders];
}

class LoadChosenOrderEvent extends CourierAcceptedOrdersEvent {
  final String? token;
  final int? orderId;
  LoadChosenOrderEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}
