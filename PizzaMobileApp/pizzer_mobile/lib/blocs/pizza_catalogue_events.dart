import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PizzaCatalogueEvent extends Equatable {
  const PizzaCatalogueEvent();
}

class LoadPizzaCatalogueEvent extends PizzaCatalogueEvent {
  @override
  List<Object?> get props => [];
}

class LoadChosenPizzaEvent extends PizzaCatalogueEvent {
  final String? name;

  LoadChosenPizzaEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class LoadChosenMediumPizzaEvent extends PizzaCatalogueEvent {
  final String? name;

  LoadChosenMediumPizzaEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class LoadChosenBigPizzaEvent extends PizzaCatalogueEvent {
  final String? name;

  LoadChosenBigPizzaEvent(this.name);
  @override
  List<Object?> get props => [name];
}
