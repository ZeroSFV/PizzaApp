import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/navigation_bar_order/navigation_bar_order_events.dart';
import 'package:pizzer_mobile/blocs/navigation_bar_order/navigation_bar_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBarOrderBloc
    extends Bloc<NavigationBarOrderEvent, NavigationBarOrderState> {
  int currentIndex;
  NavigationBarOrderBloc(this.currentIndex) : super(OrderPageLoadedState()) {
    on<PageTapped>((event, emit) async {
      if (event.index == 0) {
        currentIndex = event.index;
        emit(CataloguePageOrderLoadedState());
      } else if (event.index == 1) {
        currentIndex = event.index;
        emit(OrderPageLoadedState());
      } else if (event.index == 2) {
        currentIndex = event.index;
        emit(ProfilePageOrderLoadedState(40));
      }
    });
  }
}
