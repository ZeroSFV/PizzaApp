import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PizzaCatalogueState extends Equatable {}

class PizzaCatalogueLoadingState extends PizzaCatalogueState {
  @override
  List<Object?> get props => [];
}

class PizzaCatalogueLoadedState extends PizzaCatalogueState {
  final List<PizzaModel> pizzas;
  PizzaCatalogueLoadedState(this.pizzas);
  @override
  List<Object?> get props => [pizzas];
}

class PizzaCatalogueErrorState extends PizzaCatalogueState {
  final String error;
  PizzaCatalogueErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
