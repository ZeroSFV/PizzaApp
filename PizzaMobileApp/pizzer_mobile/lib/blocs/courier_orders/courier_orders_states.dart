import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CourierOrdersState extends Equatable {}

class CourierOrderLoadingState extends CourierOrdersState {
  @override
  List<Object?> get props => [];
}

class CourierOrdersLoadedState extends CourierOrdersState {
  final List<OrderModel> orders;
  CourierOrdersLoadedState(this.orders);
  @override
  List<Object?> get props => [orders];
}

class CourierNoOrdersState extends CourierOrdersState {
  CourierNoOrdersState();
  @override
  List<Object?> get props => [];
}

class CourierOrdersErrorState extends CourierOrdersState {
  final String error;
  CourierOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ChosenOrderLoadingState extends CourierOrdersState {
  final String? token;
  final int? orderId;
  ChosenOrderLoadingState(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}

class ChosenOrderLoadedState extends CourierOrdersState {
  final OrderModel singleOrder;
  ChosenOrderLoadedState(this.singleOrder);
  @override
  List<Object?> get props => [singleOrder];
}
