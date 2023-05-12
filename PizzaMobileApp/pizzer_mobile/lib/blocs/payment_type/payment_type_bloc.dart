import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/payment_type/payment_type_events.dart';
import 'package:pizzer_mobile/blocs/payment_type/payment_type_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentTypeBloc extends Bloc<PaymentTypeEvent, PaymentTypeState> {
  String? change = "";
  String? paymentType = "";
  PaymentTypeBloc() : super(CashPaymentState("Наличными", "")) {
    on<CardChosenEvent>((event, emit) async {
      change = "";
      paymentType = "Картой";
      emit(CardPaymentState(paymentType));
    });

    on<CashChosenEvent>((event, emit) async {
      change = "";
      paymentType = "Наличными";
      emit(CashPaymentState(change, paymentType));
    });

    on<ChangeChangedEvent>((event, emit) async {
      change = event.changeValue;
      paymentType = "Наличными";
      emit(CashPaymentState(change, paymentType));
    });

    on<ChangeSubmittedEvent>((event, emit) async {
      if (int.parse(event.changeFinal.toString()) < (event.basketPrice as int))
        change = "";
      else
        change = event.changeFinal;
      paymentType = "Наличными";
      emit(CashPaymentState(change, paymentType));
    });
  }
}
