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

class EmailIsNotAllowedState extends RegistrationState {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  EmailIsNotAllowedState(
      this.email, this.name, this.phone, this.password, this.repeatPassword);

  @override
  List<Object?> get props => [email, name, phone, password, repeatPassword];
}

class RegistrationSuccessState extends RegistrationState {
  RegistrationSuccessState();

  @override
  List<Object?> get props => [];
}

class LoadingRegistrationState extends RegistrationState {
  LoadingRegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationErrorState extends RegistrationState {
  final String? error;
  RegistrationErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
