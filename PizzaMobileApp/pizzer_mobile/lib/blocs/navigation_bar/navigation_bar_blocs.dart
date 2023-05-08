import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_events.dart';
import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  int currentIndex;
  NavigationBarBloc(this.currentIndex) : super(CataloguePageLoadedState()) {
    on<PageTapped>((event, emit) async {
      if (event.index == 0) {
        currentIndex = event.index;
        emit(CataloguePageLoadedState());
      } else if (event.index == 1) {
        currentIndex = event.index;
        emit(BasketPageLoadedState(20));
      } else if (event.index == 2) {
        currentIndex = event.index;
        emit(ProfilePageLoadedState(40));
      }
    });
  }
}
