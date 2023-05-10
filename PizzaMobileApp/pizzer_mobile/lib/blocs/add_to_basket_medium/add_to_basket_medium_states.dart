import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AddToBasketMediumState extends Equatable {}

class LoadMediumPizzaState extends AddToBasketMediumState {
  //int? userBonuses;

  LoadMediumPizzaState();

  @override
  List<Object?> get props => [];
}

class MediumPizzaInBasketState extends AddToBasketMediumState {
  int? pizzaAmount;

  MediumPizzaInBasketState(this.pizzaAmount);

  @override
  List<Object?> get props => [pizzaAmount];
}

class MediumPizzaNotInBasketState extends AddToBasketMediumState {
  MediumPizzaNotInBasketState();

  @override
  List<Object?> get props => [];
}

class AddToBasketErrorState extends AddToBasketMediumState {
  String? error;
  AddToBasketErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
