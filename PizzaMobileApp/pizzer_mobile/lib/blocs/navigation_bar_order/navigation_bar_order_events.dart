import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavigationBarOrderEvent extends Equatable {
  const NavigationBarOrderEvent();
}

class PageTapped extends NavigationBarOrderEvent {
  final int index;

  PageTapped(this.index);
  @override
  List get props => [index];
}
