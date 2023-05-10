import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavigationBarState extends Equatable {}

class CurrentIndexChanged extends NavigationBarState {
  final int currentIndex;

  CurrentIndexChanged(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class CataloguePageLoadedState extends NavigationBarState {
  CataloguePageLoadedState();

  @override
  List<Object?> get props => [];
}

class BasketPageLoadedState extends NavigationBarState {
  final int number;

  BasketPageLoadedState(this.number);

  @override
  List<Object?> get props => [];
}

class OrderPageLoadedState extends NavigationBarState {
  final int number;

  OrderPageLoadedState(this.number);

  @override
  List<Object?> get props => [];
}

class ProfilePageLoadedState extends NavigationBarState {
  final int number;

  ProfilePageLoadedState(this.number);

  @override
  List<Object?> get props => [];
}
