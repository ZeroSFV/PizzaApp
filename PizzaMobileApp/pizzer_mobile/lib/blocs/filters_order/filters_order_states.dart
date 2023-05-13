import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FiltersOrderState extends Equatable {}

class CurrentValueChanged extends FiltersOrderState {
  final String value;

  CurrentValueChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class LoadFiltersPageOrderState extends FiltersOrderState {
  final String value;

  LoadFiltersPageOrderState(this.value);

  @override
  List<Object?> get props => [value];
}

class LoadingFiltersPageOrderState extends FiltersOrderState {
  final String value;

  LoadingFiltersPageOrderState(this.value);

  @override
  List<Object?> get props => [value];
}
