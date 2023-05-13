import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  final String? token;

  LoadProfileEvent(this.token);
  @override
  List get props => [token];
}

class ProfileInfoChosenEvent extends ProfileEvent {
  final String? token;

  ProfileInfoChosenEvent(this.token);
  @override
  List get props => [token];
}

class OrdersChosenEvent extends ProfileEvent {
  final String? token;

  OrdersChosenEvent(this.token);
  @override
  List get props => [token];
}

class PasswordChosenEvent extends ProfileEvent {
  final String? token;

  PasswordChosenEvent(this.token);
  @override
  List get props => [token];
}
