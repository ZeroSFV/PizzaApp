import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerNavigationBarState extends Equatable {}

class CurrentIndexChanged extends WorkerNavigationBarState {
  final int currentIndex;

  CurrentIndexChanged(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class UnacceptedOrdersPageLoadedState extends WorkerNavigationBarState {
  UnacceptedOrdersPageLoadedState();

  @override
  List<Object?> get props => [];
}

class AcceptedOrderPageLoadedState extends WorkerNavigationBarState {
  AcceptedOrderPageLoadedState();

  @override
  List<Object?> get props => [];
}

class WorkerProfilePageOrderLoadedState extends WorkerNavigationBarState {
  WorkerProfilePageOrderLoadedState();

  @override
  List<Object?> get props => [];
}
