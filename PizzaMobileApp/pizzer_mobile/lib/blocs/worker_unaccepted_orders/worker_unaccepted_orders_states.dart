import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerUnacceptedOrdersState extends Equatable {}

class WorkerUnacceptedOrdersLoadingState extends WorkerUnacceptedOrdersState {
  @override
  List<Object?> get props => [];
}

class WorkerUnacceptedOrdersLoadedState extends WorkerUnacceptedOrdersState {
  final String? token;
  final List<OrderModel> orders;
  WorkerUnacceptedOrdersLoadedState(this.orders, this.token);
  @override
  List<Object?> get props => [orders, token];
}

class NoUnacceptedOrderState extends WorkerUnacceptedOrdersState {
  final String? token;
  NoUnacceptedOrderState(this.token);
  @override
  List<Object?> get props => [token];
}

class WorkerHaveOrderLoadedState extends WorkerUnacceptedOrdersState {
  final String? token;
  final List<OrderModel> orders;
  WorkerHaveOrderLoadedState(this.orders, this.token);
  @override
  List<Object?> get props => [orders, token];
}

class WorkerUnacceptedOrdersErrorState extends WorkerUnacceptedOrdersState {
  final String error;
  WorkerUnacceptedOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class WorkerAcceptedOrderSuccessfullyState extends WorkerUnacceptedOrdersState {
  final String? token;

  WorkerAcceptedOrderSuccessfullyState(this.token);
  @override
  List<Object?> get props => [token];
}

class ChosenOrderLoadingState extends WorkerUnacceptedOrdersState {
  final int? orderId;
  final String? token;

  ChosenOrderLoadingState(this.orderId, this.token);
  @override
  List<Object?> get props => [orderId, token];
}

class WorkerHaveOrderChosenLoadedState extends WorkerUnacceptedOrdersState {
  final String? token;
  final OrderModel singleOrder;
  WorkerHaveOrderChosenLoadedState(this.singleOrder, this.token);
  @override
  List<Object?> get props => [singleOrder, token];
}

class ChosenOrderLoadedState extends WorkerUnacceptedOrdersState {
  final String? token;
  final OrderModel singleOrder;
  ChosenOrderLoadedState(this.singleOrder, this.token);
  @override
  List<Object?> get props => [singleOrder, token];
}
