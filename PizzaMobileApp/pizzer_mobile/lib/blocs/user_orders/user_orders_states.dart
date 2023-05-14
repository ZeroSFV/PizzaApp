import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserOrdersState extends Equatable {}

class UserOrderLoadingState extends UserOrdersState {
  @override
  List<Object?> get props => [];
}

class UserOrdersLoadedState extends UserOrdersState {
  final List<OrderModel> orders;
  UserOrdersLoadedState(this.orders);
  @override
  List<Object?> get props => [orders];
}

class UserNoOrdersState extends UserOrdersState {
  UserNoOrdersState();
  @override
  List<Object?> get props => [];
}

class UserOrdersErrorState extends UserOrdersState {
  final String error;
  UserOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ChosenOrderLoadingState extends UserOrdersState {
  final String? token;
  final int? orderId;
  ChosenOrderLoadingState(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}

class ChosenOrderLoadedState extends UserOrdersState {
  final OrderModel singleOrder;
  ChosenOrderLoadedState(this.singleOrder);
  @override
  List<Object?> get props => [singleOrder];
}
