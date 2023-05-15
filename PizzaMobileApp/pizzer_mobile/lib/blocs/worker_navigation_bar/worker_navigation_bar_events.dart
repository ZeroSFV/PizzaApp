import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkerNavigationBarEvents extends Equatable {
  const WorkerNavigationBarEvents();
}

class PageTapped extends WorkerNavigationBarEvents {
  final int index;

  PageTapped(this.index);
  @override
  List get props => [index];
}
