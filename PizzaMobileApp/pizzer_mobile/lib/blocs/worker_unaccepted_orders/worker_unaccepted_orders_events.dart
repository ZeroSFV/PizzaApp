import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerUnacceptedOrdersEvent extends Equatable {
  const WorkerUnacceptedOrdersEvent();
}

class LoadWorkerUnacceptedOrdersEvent extends WorkerUnacceptedOrdersEvent {
  String? token;
  LoadWorkerUnacceptedOrdersEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class LoadChosenOrderEvent extends WorkerUnacceptedOrdersEvent {
  final String? token;
  final int? orderId;
  LoadChosenOrderEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}

class AcceptOrderByWorkerEvent extends WorkerUnacceptedOrdersEvent {
  final String? token;
  final int? orderId;
  AcceptOrderByWorkerEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}
