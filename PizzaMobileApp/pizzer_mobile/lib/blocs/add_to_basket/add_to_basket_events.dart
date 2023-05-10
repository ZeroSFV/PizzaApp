import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AddToBasketEvent extends Equatable {
  const AddToBasketEvent();
}

class LoadPizzaEvent extends AddToBasketEvent {
  String? token;
  int? pizzaId;
  LoadPizzaEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}

class CreateBasketEvent extends AddToBasketEvent {
  String? token;
  int? pizzaId;
  CreateBasketEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}

class AddPizzaEvent extends AddToBasketEvent {
  String? token;
  int? pizzaId;
  AddPizzaEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}

class DecreasePizzaEvent extends AddToBasketEvent {
  String? token;
  int? pizzaId;
  DecreasePizzaEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}
