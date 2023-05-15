import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerOrdersState extends Equatable {}

class WorkerOrderLoadingState extends WorkerOrdersState {
  @override
  List<Object?> get props => [];
}

class WorkerOrdersLoadedState extends WorkerOrdersState {
  final List<OrderModel> orders;
  WorkerOrdersLoadedState(this.orders);
  @override
  List<Object?> get props => [orders];
}

class WorkerNoOrdersState extends WorkerOrdersState {
  WorkerNoOrdersState();
  @override
  List<Object?> get props => [];
}

class WorkerOrdersErrorState extends WorkerOrdersState {
  final String error;
  WorkerOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ChosenOrderLoadingState extends WorkerOrdersState {
  final String? token;
  final int? orderId;
  ChosenOrderLoadingState(this.token, this.orderId);
  @override
  List<Object?> get props => [token, orderId];
}

class ChosenOrderLoadedState extends WorkerOrdersState {
  final OrderModel singleOrder;
  ChosenOrderLoadedState(this.singleOrder);
  @override
  List<Object?> get props => [singleOrder];
}
