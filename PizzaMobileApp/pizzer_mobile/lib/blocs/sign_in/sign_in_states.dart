import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignInState extends Equatable {}

class LoadedNoAllowedSignInState extends SignInState {
  final String? email;
  final String? password;
  LoadedNoAllowedSignInState(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LoadedAllowedSignInState extends SignInState {
  final String? email;
  final String? password;
  LoadedAllowedSignInState(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class IncorrectEmailPasswordState extends SignInState {
  final String? email;
  final String? password;
  IncorrectEmailPasswordState(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignInSuccessState extends SignInState {
  final String? token;
  SignInSuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class LoadingSignInState extends SignInState {
  LoadingSignInState();

  @override
  List<Object?> get props => [];
}

class SignInErrorState extends SignInState {
  final String? error;
  SignInErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
