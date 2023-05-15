import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CourierUnacceptedOrdersState extends Equatable {}

class CourierUnacceptedOrdersLoadingState extends CourierUnacceptedOrdersState {
  @override
  List<Object?> get props => [];
}

class CourierUnacceptedOrdersLoadedState extends CourierUnacceptedOrdersState {
  final String? token;
  final List<OrderModel> orders;
  CourierUnacceptedOrdersLoadedState(this.orders, this.token);
  @override
  List<Object?> get props => [orders, token];
}

class NoUnacceptedOrderState extends CourierUnacceptedOrdersState {
  final String? token;
  NoUnacceptedOrderState(this.token);
  @override
  List<Object?> get props => [token];
}

class CourierHaveOrderLoadedState extends CourierUnacceptedOrdersState {
  final String? token;
  final List<OrderModel> orders;
  CourierHaveOrderLoadedState(this.orders, this.token);
  @override
  List<Object?> get props => [orders, token];
}

class CourierUnacceptedOrdersErrorState extends CourierUnacceptedOrdersState {
  CourierUnacceptedOrdersErrorState();
  @override
  List<Object?> get props => [];
}

class CourierAcceptedOrderSuccessfullyState
    extends CourierUnacceptedOrdersState {
  final String? token;

  CourierAcceptedOrderSuccessfullyState(this.token);
  @override
  List<Object?> get props => [token];
}

class ChosenOrderLoadingState extends CourierUnacceptedOrdersState {
  final int? orderId;
  final String? token;

  ChosenOrderLoadingState(this.orderId, this.token);
  @override
  List<Object?> get props => [orderId, token];
}

class CourierHaveOrderChosenLoadedState extends CourierUnacceptedOrdersState {
  final String? token;
  final OrderModel singleOrder;
  CourierHaveOrderChosenLoadedState(this.singleOrder, this.token);
  @override
  List<Object?> get props => [singleOrder, token];
}

class ChosenOrderLoadedState extends CourierUnacceptedOrdersState {
  final String? token;
  final OrderModel singleOrder;
  ChosenOrderLoadedState(this.singleOrder, this.token);
  @override
  List<Object?> get props => [singleOrder, token];
}
