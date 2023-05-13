import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ClientOrderState extends Equatable {}

class ClientOrderLoadingState extends ClientOrderState {
  @override
  List<Object?> get props => [];
}

class ClientOrderLoadedState extends ClientOrderState {
  final OrderModel order;
  final UserInfoModel user;
  final bool orderCanBeCancelled;
  ClientOrderLoadedState(this.order, this.user, this.orderCanBeCancelled);
  @override
  List<Object?> get props => [order, user];
}

class ClientOrderFinishedState extends ClientOrderState {
  final String? token;
  ClientOrderFinishedState(this.token);
  @override
  List<Object?> get props => [token];
}

class ClientOrderCancelledState extends ClientOrderState {
  final String? token;
  ClientOrderCancelledState(this.token);
  @override
  List<Object?> get props => [token];
}

class ClientOrderErrorState extends ClientOrderState {
  final String error;
  ClientOrderErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
