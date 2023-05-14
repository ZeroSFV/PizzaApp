import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ResetPasswordState extends Equatable {}

class LoadedNoAllowedResetPasswordState extends ResetPasswordState {
  final String? email;
  LoadedNoAllowedResetPasswordState(this.email);

  @override
  List<Object?> get props => [email];
}

class LoadedAllowedResetPasswordState extends ResetPasswordState {
  final String? email;
  LoadedAllowedResetPasswordState(this.email);

  @override
  List<Object?> get props => [email];
}

class IncorrectEmailState extends ResetPasswordState {
  final String? email;
  IncorrectEmailState(this.email);

  @override
  List<Object?> get props => [email];
}

class ResetPasswordSuccessState extends ResetPasswordState {
  ResetPasswordSuccessState();

  @override
  List<Object?> get props => [];
}

class LoadingResetPasswordState extends ResetPasswordState {
  LoadingResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordErrorState extends ResetPasswordState {
  final String? error;
  ResetPasswordErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
