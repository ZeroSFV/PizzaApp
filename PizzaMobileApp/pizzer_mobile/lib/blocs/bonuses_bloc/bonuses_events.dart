import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BonusesEvent extends Equatable {
  const BonusesEvent();
}

class BonusesChange extends BonusesEvent {
  final bool bonusesApplied;
  final int? userBonuses;
  final double basketPrice;

  BonusesChange(this.bonusesApplied, this.userBonuses, this.basketPrice);
  @override
  List get props => [bonusesApplied, userBonuses, basketPrice];
}
