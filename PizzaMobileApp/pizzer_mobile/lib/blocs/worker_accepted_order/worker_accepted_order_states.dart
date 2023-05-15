import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerAcceptedOrdersState extends Equatable {}

class WorkerAcceptedOrdersLoadingState extends WorkerAcceptedOrdersState {
  @override
  List<Object?> get props => [];
}

class WorkerAcceptedOrdersLoadedState extends WorkerAcceptedOrdersState {
  final String? token;
  final OrderModel order;
  WorkerAcceptedOrdersLoadedState(this.order, this.token);
  @override
  List<Object?> get props => [order, token];
}

class NoAcceptedOrderState extends WorkerAcceptedOrdersState {
  final String? token;
  NoAcceptedOrderState(this.token);
  @override
  List<Object?> get props => [token];
}

class WorkerAcceptedOrdersErrorState extends WorkerAcceptedOrdersState {
  final String error;
  WorkerAcceptedOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
