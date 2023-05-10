import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BonusesState extends Equatable {}

class BonusesAppliedState extends BonusesState {
  int? userBonuses;

  BonusesAppliedState(this.userBonuses);

  @override
  List<Object?> get props => [userBonuses];
}

class BonusesDeletedState extends BonusesState {
  BonusesDeletedState();

  @override
  List<Object?> get props => [];
}

class NoBonusesState extends BonusesState {
  NoBonusesState();

  @override
  List<Object?> get props => [];
}
