import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/order_model.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileInfoChosenState extends ProfileState {
  final String? token;
  ProfileInfoChosenState(this.token);

  @override
  List<Object?> get props => [token];
}

class UserOrderState extends ProfileState {
  final String? token;
  UserOrderState(this.token);

  @override
  List<Object?> get props => [token];
}

class ChangePasswordState extends ProfileState {
  final String? token;
  ChangePasswordState(this.token);

  @override
  List<Object?> get props => [token];
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState();
  @override
  List<Object?> get props => [];
}

class ProfileErrorState extends ProfileState {
  final String? error;
  ProfileErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
