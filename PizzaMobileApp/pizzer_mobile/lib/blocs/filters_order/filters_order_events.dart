import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FiltersOrderEvent extends Equatable {
  const FiltersOrderEvent();
}

class ValueChangedEvent extends FiltersOrderEvent {
  final String value;

  ValueChangedEvent(this.value);
  @override
  List get props => [value];
}

class LoadFiltersPageOrderEvent extends FiltersOrderEvent {
  final String value;

  LoadFiltersPageOrderEvent(this.value);
  @override
  List get props => [value];
}
