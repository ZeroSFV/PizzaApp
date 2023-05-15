import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CourierAcceptedOrdersState extends Equatable {}

class CourierAcceptedOrdersLoadingState extends CourierAcceptedOrdersState {
  @override
  List<Object?> get props => [];
}

class CourierAcceptedOrdersLoadedState extends CourierAcceptedOrdersState {
  final String? token;
  final List<OrderModel> order;
  CourierAcceptedOrdersLoadedState(this.order, this.token);
  @override
  List<Object?> get props => [order, token];
}

class NoAcceptedOrderState extends CourierAcceptedOrdersState {
  final String? token;
  NoAcceptedOrderState(this.token);
  @override
  List<Object?> get props => [token];
}

class ChosenOrderLoadingState extends CourierAcceptedOrdersState {
  final int? orderId;
  final String? token;

  ChosenOrderLoadingState(this.orderId, this.token);
  @override
  List<Object?> get props => [orderId, token];
}

class ChosenOrderLoadedState extends CourierAcceptedOrdersState {
  List<OrderModel> orders;
  final OrderModel order;
  final String? token;

  ChosenOrderLoadedState(this.orders, this.order, this.token);
  @override
  List<Object?> get props => [order, token];
}

class CourierAcceptedOrdersErrorState extends CourierAcceptedOrdersState {
  final String error;
  CourierAcceptedOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
