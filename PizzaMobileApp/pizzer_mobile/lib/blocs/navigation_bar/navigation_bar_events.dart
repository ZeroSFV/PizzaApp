import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();
}

class PageTapped extends NavigationBarEvent {
  final int index;

  PageTapped(this.index);
  @override
  List get props => [];
}
