import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FiltersEvent extends Equatable {
  const FiltersEvent();
}

class ValueChangedEvent extends FiltersEvent {
  final String value;

  ValueChangedEvent(this.value);
  @override
  List get props => [value];
}

class LoadFiltersPageEvent extends FiltersEvent {
  final String value;

  LoadFiltersPageEvent(this.value);
  @override
  List get props => [value];
}
