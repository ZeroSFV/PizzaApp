import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AddToBasketMediumEvent extends Equatable {
  const AddToBasketMediumEvent();
}

class LoadMediumPizzaEvent extends AddToBasketMediumEvent {
  String? token;
  int? pizzaId;
  LoadMediumPizzaEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}

class CreateMediumBasketEvent extends AddToBasketMediumEvent {
  String? token;
  int? pizzaId;
  CreateMediumBasketEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}

class AddMediumPizzaEvent extends AddToBasketMediumEvent {
  String? token;
  int? pizzaId;
  AddMediumPizzaEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}

class DecreaseMediumPizzaEvent extends AddToBasketMediumEvent {
  String? token;
  int? pizzaId;
  DecreaseMediumPizzaEvent(this.token, this.pizzaId);
  @override
  List get props => [token, pizzaId];
}
