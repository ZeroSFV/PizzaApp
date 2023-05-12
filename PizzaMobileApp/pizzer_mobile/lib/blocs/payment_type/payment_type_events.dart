import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PaymentTypeEvent extends Equatable {
  const PaymentTypeEvent();
}

class CashChosenEvent extends PaymentTypeEvent {
  CashChosenEvent();
  @override
  List get props => [];
}

class CardChosenEvent extends PaymentTypeEvent {
  CardChosenEvent();
  @override
  List get props => [];
}

class ChangeChangedEvent extends PaymentTypeEvent {
  final String? changeValue;
  ChangeChangedEvent(this.changeValue);
  @override
  List get props => [changeValue];
}

class ChangeSubmittedEvent extends PaymentTypeEvent {
  final String? changeFinal;
  final double? basketPrice;
  ChangeSubmittedEvent(this.changeFinal, this.basketPrice);
  @override
  List get props => [changeFinal, basketPrice];
}
