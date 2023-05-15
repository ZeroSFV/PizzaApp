import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CourierUnacceptedOrdersEvent extends Equatable {
  const CourierUnacceptedOrdersEvent();
}

class LoadCourierUnacceptedOrdersEvent extends CourierUnacceptedOrdersEvent {
  String? token;
  LoadCourierUnacceptedOrdersEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class LoadChosenOrderEvent extends CourierUnacceptedOrdersEvent {
  final String? token;
  final int? orderId;
  LoadChosenOrderEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}

class AcceptOrderByCourierEvent extends CourierUnacceptedOrdersEvent {
  final String? token;
  final int? orderId;
  AcceptOrderByCourierEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}
