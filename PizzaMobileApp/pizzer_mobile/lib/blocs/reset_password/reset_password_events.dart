import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class LoadResetPasswordEvent extends ResetPasswordEvent {
  LoadResetPasswordEvent();
  @override
  List get props => [];
}

class EmailChangedEvent extends ResetPasswordEvent {
  final String? email;
  EmailChangedEvent(this.email);
  @override
  List get props => [email];
}

class ResetPasswordSubmittedEvent extends ResetPasswordEvent {
  final String? email;
  ResetPasswordSubmittedEvent(this.email);
  @override
  List get props => [email];
}
