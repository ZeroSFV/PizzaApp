import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/order_model.dart';

@immutable
abstract class WorkerAcceptedOrdersEvent extends Equatable {
  const WorkerAcceptedOrdersEvent();
}

class LoadWorkerAcceptedOrdersEvent extends WorkerAcceptedOrdersEvent {
  String? token;
  LoadWorkerAcceptedOrdersEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class ToNextStatusOrderEvent extends WorkerAcceptedOrdersEvent {
  final String? token;
  final OrderModel order;
  ToNextStatusOrderEvent(this.token, this.order);
  @override
  List<Object?> get props => [token, order];
}
