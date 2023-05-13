import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PizzaCatalogueOrderState extends Equatable {}

class PizzaCatalogueOrderLoadingState extends PizzaCatalogueOrderState {
  @override
  List<Object?> get props => [];
}

class PizzaCatalogueOrderLoadedState extends PizzaCatalogueOrderState {
  final List<PizzaModel> pizzas;
  PizzaCatalogueOrderLoadedState(this.pizzas);
  @override
  List<Object?> get props => [pizzas];
}

class LoadingFilteredPizzaOrderCatalogueState extends PizzaCatalogueOrderState {
  @override
  List<Object?> get props => [];
}

class FilteredPizzaCatalogueOrderLoadedState extends PizzaCatalogueOrderState {
  final List<PizzaModel> filteredPizzas;
  FilteredPizzaCatalogueOrderLoadedState(this.filteredPizzas);
  @override
  List<Object?> get props => [filteredPizzas];
}

class FilteredPizzaCatalogueOrderErrorState extends PizzaCatalogueOrderState {
  final String error;
  FilteredPizzaCatalogueOrderErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class PizzaCatalogueOrderErrorState extends PizzaCatalogueOrderState {
  final String error;
  PizzaCatalogueOrderErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ChosenPizzaOrderLoadingState extends PizzaCatalogueOrderState {
  final String? name;
  ChosenPizzaOrderLoadingState(this.name);
  @override
  List<Object?> get props => [name];
}

class ChosenBigPizzaOrderLoadedState extends PizzaCatalogueOrderState {
  final PizzaModel bigPizzaWithName;
  ChosenBigPizzaOrderLoadedState(this.bigPizzaWithName);
  @override
  List<Object?> get props => [bigPizzaWithName];
}

class ChosenMediumPizzaOrderLoadedState extends PizzaCatalogueOrderState {
  final PizzaModel mediumPizzaWithName;
  ChosenMediumPizzaOrderLoadedState(this.mediumPizzaWithName);
  @override
  List<Object?> get props => [mediumPizzaWithName];
}

class ChosenPizzaOrderErrorState extends PizzaCatalogueOrderState {
  final String error;
  ChosenPizzaOrderErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class LoadedFiltersOrderState extends PizzaCatalogueOrderState {
  final String? value;
  LoadedFiltersOrderState(this.value);
  @override
  List<Object?> get props => [value];
}
