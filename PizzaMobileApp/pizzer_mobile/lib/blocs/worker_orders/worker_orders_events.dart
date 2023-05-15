import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerOrderEvent extends Equatable {
  const WorkerOrderEvent();
}

class LoadWorkerOrderEvent extends WorkerOrderEvent {
  String? token;
  LoadWorkerOrderEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class LoadChosenOrderEvent extends WorkerOrderEvent {
  final String? token;
  final int? orderId;

  LoadChosenOrderEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}
