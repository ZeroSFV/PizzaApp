import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ClientBasketEvent extends Equatable {
  const ClientBasketEvent();
}

class LoadClientBasketEvent extends ClientBasketEvent {
  final String? token;

  LoadClientBasketEvent(this.token);
  @override
  List<Object?> get props => [];
}

class AddToBasketEvent extends ClientBasketEvent {
  final String? token;
  final int? selectedIndex;

  AddToBasketEvent(this.token, this.selectedIndex);
  @override
  List<Object?> get props => [];
}

class DecreaseBasketEvent extends ClientBasketEvent {
  final String? token;
  final int? selectedIndex;

  DecreaseBasketEvent(this.token, this.selectedIndex);
  @override
  List<Object?> get props => [];
}
