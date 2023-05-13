import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:async';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();
}

class SignInSubmittedEvent extends AppEvent {
  SignInSubmittedEvent();
  @override
  List get props => [];
}

class RegistrationSubmittedEvent extends AppEvent {
  RegistrationSubmittedEvent();
  @override
  List get props => [];
}

class ApprovingUserEvent extends AppEvent {
  ApprovingUserEvent();
  @override
  List get props => [];
}

class ClientCreatedOrderEvent extends AppEvent {
  String token;
  String address;
  String phoneNumber;
  String payingType;
  String? change;
  int? usedBonuses;
  int givenBonuses;
  String? comment;

  ClientCreatedOrderEvent(
      this.token,
      this.address,
      this.phoneNumber,
      this.payingType,
      this.change,
      this.usedBonuses,
      this.givenBonuses,
      this.comment);
  @override
  List get props => [
        token,
        address,
        phoneNumber,
        payingType,
        change,
        usedBonuses,
        givenBonuses,
        comment
      ];
}

class CheckIfOrderFinishedEvent extends AppEvent {
  String? token;
  Timer timer;
  CheckIfOrderFinishedEvent(this.token, this.timer);
  @override
  List get props => [token, timer];
}

class ClientReturnedToOrderingEvent extends AppEvent {
  String? token;
  ClientReturnedToOrderingEvent(this.token);
  @override
  List get props => [];
}
