import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class LoadChangePasswordEvent extends ChangePasswordEvent {
  final String? token;

  LoadChangePasswordEvent(this.token);
  @override
  List get props => [token];
}

class OldPasswordChangedEvent extends ChangePasswordEvent {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;

  OldPasswordChangedEvent(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);
  @override
  List get props => [token, oldPassword, newPassword, repeatPassword];
}

class NewPasswordSubmittedEvent extends ChangePasswordEvent {
  final String? token;

  NewPasswordSubmittedEvent(this.token);
  @override
  List get props => [token];
}

class NewPasswordChangedEvent extends ChangePasswordEvent {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;

  NewPasswordChangedEvent(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);
  @override
  List get props => [token, oldPassword, newPassword, repeatPassword];
}

class RepeatPasswordChangedEvent extends ChangePasswordEvent {
  final String? token;
  final String? oldPassword;
  final String? newPassword;
  final String? repeatPassword;

  RepeatPasswordChangedEvent(
      this.token, this.oldPassword, this.newPassword, this.repeatPassword);
  @override
  List get props => [token, oldPassword, newPassword, repeatPassword];
}
