import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class LoadSignInEvent extends SignInEvent {
  LoadSignInEvent();
  @override
  List get props => [];
}

class EmailChangedEvent extends SignInEvent {
  final String? email;
  final String? password;
  EmailChangedEvent(this.email, this.password);
  @override
  List get props => [email, password];
}

class PasswordChangedEvent extends SignInEvent {
  final String? email;
  final String? password;
  PasswordChangedEvent(this.email, this.password);
  @override
  List get props => [email, password];
}

class SignInSubmittedEvent extends SignInEvent {
  final String? email;
  final String? password;
  SignInSubmittedEvent(this.email, this.password);
  @override
  List get props => [email, password];
}
