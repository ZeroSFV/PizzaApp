import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/blocs/client_order/client_order_states.dart';
import 'package:pizzer_mobile/models/basket_model.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ClientOrderEvent extends Equatable {
  const ClientOrderEvent();
}

class LoadClientOrderEvent extends ClientOrderEvent {
  final String? token;

  LoadClientOrderEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class CheckIfOrderChangedStatusEvent extends ClientOrderEvent {
  final String? token;
  final int? statusId;

  CheckIfOrderChangedStatusEvent(this.token, this.statusId);
  @override
  List<Object?> get props => [token];
}

class TryCancellingOrderEvent extends ClientOrderEvent {
  final String? token;

  TryCancellingOrderEvent(this.token);
  @override
  List<Object?> get props => [token];
}
