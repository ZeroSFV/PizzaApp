import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavigationBarOrderState extends Equatable {}

class CurrentIndexChanged extends NavigationBarOrderState {
  final int currentIndex;

  CurrentIndexChanged(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class CataloguePageOrderLoadedState extends NavigationBarOrderState {
  CataloguePageOrderLoadedState();

  @override
  List<Object?> get props => [];
}

class OrderPageLoadedState extends NavigationBarOrderState {
  OrderPageLoadedState();

  @override
  List<Object?> get props => [];
}

class ProfilePageOrderLoadedState extends NavigationBarOrderState {
  final int number;

  ProfilePageOrderLoadedState(this.number);

  @override
  List<Object?> get props => [];
}
