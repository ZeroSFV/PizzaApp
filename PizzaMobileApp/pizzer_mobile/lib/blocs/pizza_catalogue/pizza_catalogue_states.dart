import 'package:flutter_bloc/flutter_bloc.dart';
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

class LoadingFilteredPizzaCatalogueState extends PizzaCatalogueState {
  @override
  List<Object?> get props => [];
}

class FilteredPizzaCatalogueLoadedState extends PizzaCatalogueState {
  final List<PizzaModel> filteredPizzas;
  FilteredPizzaCatalogueLoadedState(this.filteredPizzas);
  @override
  List<Object?> get props => [filteredPizzas];
}

class FilteredPizzaCatalogueErrorState extends PizzaCatalogueState {
  final String error;
  FilteredPizzaCatalogueErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class PizzaCatalogueErrorState extends PizzaCatalogueState {
  final String error;
  PizzaCatalogueErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ChosenPizzaLoadingState extends PizzaCatalogueState {
  final String? name;
  ChosenPizzaLoadingState(this.name);
  @override
  List<Object?> get props => [name];
}

class ChosenBigPizzaLoadedState extends PizzaCatalogueState {
  final PizzaModel bigPizzaWithName;
  ChosenBigPizzaLoadedState(this.bigPizzaWithName);
  @override
  List<Object?> get props => [bigPizzaWithName];
}

class ChosenMediumPizzaLoadedState extends PizzaCatalogueState {
  final PizzaModel mediumPizzaWithName;
  ChosenMediumPizzaLoadedState(this.mediumPizzaWithName);
  @override
  List<Object?> get props => [mediumPizzaWithName];
}

class ChosenPizzaErrorState extends PizzaCatalogueState {
  final String error;
  ChosenPizzaErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class LoadedFiltersState extends PizzaCatalogueState {
  final String? value;
  LoadedFiltersState(this.value);
  @override
  List<Object?> get props => [value];
}
