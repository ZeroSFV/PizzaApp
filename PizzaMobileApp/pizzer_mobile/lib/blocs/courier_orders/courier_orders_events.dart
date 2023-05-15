import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CourierOrderEvent extends Equatable {
  const CourierOrderEvent();
}

class LoadCourierOrderEvent extends CourierOrderEvent {
  String? token;
  LoadCourierOrderEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class LoadChosenOrderEvent extends CourierOrderEvent {
  final String? token;
  final int? orderId;

  LoadChosenOrderEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}
