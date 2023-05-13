import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PizzaCatalogueOrderEvent extends Equatable {
  const PizzaCatalogueOrderEvent();
}

class LoadPizzaCatalogueOrderEvent extends PizzaCatalogueOrderEvent {
  @override
  List<Object?> get props => [];
}

class LoadChosenPizzaOrderEvent extends PizzaCatalogueOrderEvent {
  final String? name;

  LoadChosenPizzaOrderEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class LoadChosenMediumPizzaOrderEvent extends PizzaCatalogueOrderEvent {
  final String? name;

  LoadChosenMediumPizzaOrderEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class LoadChosenBigPizzaOrderEvent extends PizzaCatalogueOrderEvent {
  final String? name;

  LoadChosenBigPizzaOrderEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class LoadFiltersOrderEvent extends PizzaCatalogueOrderEvent {
  final String? value;

  LoadFiltersOrderEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class LoadFilteredPizzaCatalogueOrderEvent extends PizzaCatalogueOrderEvent {
  final String? value;

  LoadFilteredPizzaCatalogueOrderEvent(this.value);
  @override
  List<Object?> get props => [value];
}
