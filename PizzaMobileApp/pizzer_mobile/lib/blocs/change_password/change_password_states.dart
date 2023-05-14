import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ChangePasswordState extends Equatable {}

class LoadedNoAllowedChangePasswordState extends ChangePasswordState {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;
  LoadedNoAllowedChangePasswordState(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);

  @override
  List<Object?> get props => [token, oldPassword, newPassword, repeatPassword];
}

class LoadedAllowedChangePasswordState extends ChangePasswordState {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;
  LoadedAllowedChangePasswordState(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);

  @override
  List<Object?> get props => [token, oldPassword, newPassword, repeatPassword];
}

class IncorrectRepeatChangePasswordState extends ChangePasswordState {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;
  IncorrectRepeatChangePasswordState(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);

  @override
  List<Object?> get props => [token, oldPassword, newPassword, repeatPassword];
}

class IncorrectOldPasswordState extends ChangePasswordState {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;
  IncorrectOldPasswordState(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);

  @override
  List<Object?> get props => [token, oldPassword, newPassword, repeatPassword];
}

class IncorrectNewPasswordState extends ChangePasswordState {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;
  IncorrectNewPasswordState(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);

  @override
  List<Object?> get props => [token, oldPassword, newPassword, repeatPassword];
}

class ChangePasswordLoadingState extends ChangePasswordState {
  ChangePasswordLoadingState();
  @override
  List<Object?> get props => [];
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String? error;
  ChangePasswordErrorState(this.error);
  @override
  List<Object?> get props => [];
}
