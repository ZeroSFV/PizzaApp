import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FiltersState extends Equatable {}

class CurrentValueChanged extends FiltersState {
  final String value;

  CurrentValueChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class LoadFiltersPageState extends FiltersState {
  final String value;

  LoadFiltersPageState(this.value);

  @override
  List<Object?> get props => [value];
}

class LoadingFiltersPageState extends FiltersState {
  final String value;

  LoadingFiltersPageState(this.value);

  @override
  List<Object?> get props => [value];
}
