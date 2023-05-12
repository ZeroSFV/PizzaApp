import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_states.dart';
import 'package:pizzer_mobile/models/basket_model.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ClientBasketEvent extends Equatable {
  const ClientBasketEvent();
}

class LoadClientBasketEvent extends ClientBasketEvent {
  final String? token;

  LoadClientBasketEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class AddToBasketEvent extends ClientBasketEvent {
  final String? token;
  final int? selectedIndex;

  AddToBasketEvent(this.token, this.selectedIndex);
  @override
  List<Object?> get props => [selectedIndex];
}

class AppliedBonusesEvent extends ClientBasketEvent {
  final List<BasketModel> baskets;
  final UserInfoModel user;
  final int basketPrice;

  AppliedBonusesEvent(this.baskets, this.user, this.basketPrice);
  @override
  List<Object?> get props => [baskets, user, basketPrice];
}

class DisbandedBonusesEvent extends ClientBasketEvent {
  final List<BasketModel> baskets;
  final UserInfoModel user;
  final int basketPrice;

  DisbandedBonusesEvent(this.baskets, this.user, this.basketPrice);
  @override
  List<Object?> get props => [baskets, user, basketPrice];
}

class DecreaseBasketEvent extends ClientBasketEvent {
  final String? token;
  final int? selectedIndex;

  DecreaseBasketEvent(this.token, this.selectedIndex);
  @override
  List<Object?> get props => [token, selectedIndex];
}
