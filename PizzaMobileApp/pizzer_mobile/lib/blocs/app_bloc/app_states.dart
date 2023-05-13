import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppState extends Equatable {}

class SignInState extends AppState {
  SignInState();

  @override
  List<Object?> get props => [];
}

class SignInErrorState extends AppState {
  SignInErrorState();

  @override
  List<Object?> get props => [];
}

class RegistrationState extends AppState {
  RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationValidationLengthErrorState extends AppState {
  RegistrationValidationLengthErrorState();

  @override
  List<Object?> get props => [];
}

class RegistrationValidationMailErrorState extends AppState {
  RegistrationValidationMailErrorState();

  @override
  List<Object?> get props => [];
}

class RegistrationErrorState extends AppState {
  RegistrationErrorState();

  @override
  List<Object?> get props => [];
}

class ClientNotApprovedState extends AppState {
  ClientNotApprovedState();

  @override
  List<Object?> get props => [];
}

class ClientNoOrderState extends AppState {
  String? token;
  ClientNoOrderState(this.token);

  @override
  List<Object?> get props => [token];
}

class ClientActiveOrderState extends AppState {
  String? token;
  ClientActiveOrderState(this.token);

  @override
  List<Object?> get props => [token];
}

class WorkerState extends AppState {
  WorkerState();

  @override
  List<Object?> get props => [];
}

class CourierState extends AppState {
  CourierState();

  @override
  List<Object?> get props => [];
}

class AdminState extends AppState {
  AdminState();

  @override
  List<Object?> get props => [];
}

class ServerErrorState extends AppState {
  String? error;
  ServerErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class ShowUserFinishOrderState extends AppState {
  String? token;
  ShowUserFinishOrderState(this.token);

  @override
  List<Object?> get props => [token];
}
