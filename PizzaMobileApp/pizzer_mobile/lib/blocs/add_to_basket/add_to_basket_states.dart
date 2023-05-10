import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AddToBasketState extends Equatable {}

class LoadPizzaState extends AddToBasketState {
  //int? userBonuses;

  LoadPizzaState();

  @override
  List<Object?> get props => [];
}

class PizzaInBasketState extends AddToBasketState {
  int? pizzaAmount;

  PizzaInBasketState(this.pizzaAmount);

  @override
  List<Object?> get props => [pizzaAmount];
}

class PizzaNotInBasketState extends AddToBasketState {
  PizzaNotInBasketState();

  @override
  List<Object?> get props => [];
}

class AddToBasketErrorState extends AddToBasketState {
  String? error;
  AddToBasketErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
