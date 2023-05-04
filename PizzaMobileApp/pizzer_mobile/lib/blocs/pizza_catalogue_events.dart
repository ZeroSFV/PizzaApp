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
