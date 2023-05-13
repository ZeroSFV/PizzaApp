import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/filters_order/filters_order_events.dart';
import 'package:pizzer_mobile/blocs/filters_order/filters_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersOrderBloc extends Bloc<FiltersOrderEvent, FiltersOrderState> {
  String value;
  FiltersOrderBloc(this.value) : super(LoadingFiltersPageOrderState(value)) {
    on<ValueChangedEvent>((event, emit) async {
      value = event.value;
      emit(LoadFiltersPageOrderState(event.value));
    });

    on<LoadFiltersPageOrderEvent>((event, emit) async {
      value = event.value;
      emit(LoadFiltersPageOrderState(event.value));
    });
  }
}
