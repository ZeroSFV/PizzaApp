import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class LoadRegistrationEvent extends RegistrationEvent {
  LoadRegistrationEvent();
  @override
  List get props => [];
}

class EmailChangedEvent extends RegistrationEvent {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  EmailChangedEvent(
      this.email, this.name, this.phone, this.password, this.repeatPassword);
  @override
  List get props => [email, name, phone, password, repeatPassword];
}

class NameChangedEvent extends RegistrationEvent {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  NameChangedEvent(
      this.email, this.name, this.phone, this.password, this.repeatPassword);
  @override
  List get props => [email, name, phone, password, repeatPassword];
}

class PhoneChangedEvent extends RegistrationEvent {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  PhoneChangedEvent(
      this.email, this.name, this.phone, this.password, this.repeatPassword);
  @override
  List get props => [email, name, phone, password, repeatPassword];
}

class PasswordChangedEvent extends RegistrationEvent {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  PasswordChangedEvent(
      this.email, this.name, this.phone, this.password, this.repeatPassword);
  @override
  List get props => [email, name, phone, password, repeatPassword];
}

class RepeatPasswordChangedEvent extends RegistrationEvent {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  RepeatPasswordChangedEvent(
      this.email, this.name, this.phone, this.password, this.repeatPassword);
  @override
  List get props => [email, name, phone, password, repeatPassword];
}

class RegistrationSubmittedEvent extends RegistrationEvent {
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final String? repeatPassword;
  RegistrationSubmittedEvent(
      this.email, this.name, this.phone, this.password, this.repeatPassword);
  @override
  List get props => [email, name, phone, password, repeatPassword];
}
