import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserOrderEvent extends Equatable {
  const UserOrderEvent();
}

class LoadUserOrderEvent extends UserOrderEvent {
  String? token;
  LoadUserOrderEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class LoadChosenOrderEvent extends UserOrderEvent {
  final String? token;
  final int? orderId;

  LoadChosenOrderEvent(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}
