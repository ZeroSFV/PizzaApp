import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PaymentTypeState extends Equatable {}

class LoadingPaymentTypeState extends PaymentTypeState {
  LoadingPaymentTypeState();

  @override
  List<Object?> get props => [];
}

class CashPaymentState extends PaymentTypeState {
  String? change;
  String? paymentType;
  CashPaymentState(this.change, this.paymentType);

  @override
  List<Object?> get props => [change, paymentType];
}

class CardPaymentState extends PaymentTypeState {
  String? paymentType;
  CardPaymentState(this.paymentType);

  @override
  List<Object?> get props => [paymentType];
}
