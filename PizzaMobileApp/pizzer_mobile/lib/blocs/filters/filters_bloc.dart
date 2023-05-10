import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/filters/filters_events.dart';
import 'package:pizzer_mobile/blocs/filters/filters_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  String value;
  FiltersBloc(this.value) : super(LoadingFiltersPageState(value)) {
    on<ValueChangedEvent>((event, emit) async {
      value = event.value;
      emit(LoadFiltersPageState(event.value));
    });

    on<LoadFiltersPageEvent>((event, emit) async {
      value = event.value;
      emit(LoadFiltersPageState(event.value));
    });
  }
}
