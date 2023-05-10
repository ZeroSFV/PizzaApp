import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/basket_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ClientBasketState extends Equatable {}

class ClientBasketLoadingState extends ClientBasketState {
  @override
  List<Object?> get props => [];
}

class ClientBasketLoadedState extends ClientBasketState {
  final List<BasketModel> baskets;
  final UserInfoModel user;
  final double basketPrice;
  ClientBasketLoadedState(this.baskets, this.user, this.basketPrice);
  @override
  List<Object?> get props => [baskets, user, basketPrice];
}

class ClientBasketErrorState extends ClientBasketState {
  final String error;
  ClientBasketErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ClientBasketEmptyState extends ClientBasketState {
  @override
  List<Object?> get props => [];
}
