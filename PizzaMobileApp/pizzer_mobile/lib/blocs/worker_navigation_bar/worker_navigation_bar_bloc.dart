import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/worker_navigation_bar/worker_navigation_bar_events.dart';
import 'package:pizzer_mobile/blocs/worker_navigation_bar/worker_navigation_bar_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerNavigationBarBloc
    extends Bloc<WorkerNavigationBarEvents, WorkerNavigationBarState> {
  int currentIndex;
  WorkerNavigationBarBloc(this.currentIndex)
      : super(UnacceptedOrdersPageLoadedState()) {
    on<PageTapped>((event, emit) async {
      if (event.index == 0) {
        currentIndex = event.index;
        emit(UnacceptedOrdersPageLoadedState());
      } else if (event.index == 1) {
        currentIndex = event.index;
        emit(AcceptedOrderPageLoadedState());
      } else if (event.index == 2) {
        currentIndex = event.index;
        emit(WorkerProfilePageOrderLoadedState());
      }
    });
  }
}
