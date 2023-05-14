import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegistrationState extends Equatable {}

class LoadedNoAllowedRegistrationState extends RegistrationState {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  LoadedNoAllowedRegistrationState(
      this.email, this.name, this.phone, this.password, this.repeatPassword);

  @override
  List<Object?> get props => [email, name, phone, password, repeatPassword];
}

class LoadedAllowedRegistrationState extends RegistrationState {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  LoadedAllowedRegistrationState(
      this.email, this.name, this.phone, this.password, this.repeatPassword);

  @override
  List<Object?> get props => [email, name, phone, password, repeatPassword];
}

class IncorrectPasswordState extends RegistrationState {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  IncorrectPasswordState(
      this.email, this.name, this.phone, this.password, this.repeatPassword);

  @override
  List<Object?> get props => [email, name, phone, password, repeatPassword];
}

class IncorrectRepeatPasswordState extends RegistrationState {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  IncorrectRepeatPasswordState(
      this.email, this.name, this.phone, this.password, this.repeatPassword);

  @override
  List<Object?> get props => [email, name, phone, password, repeatPassword];
}

class RegistrationSuccessState extends RegistrationState {
  final String? token;
  RegistrationSuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class LoadingReState extends RegistrationState {
  LoadingSignInState();

  @override
  List<Object?> get props => [];
}

class SignInErrorState extends RegistrationState {
  final String? error;
  SignInErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
