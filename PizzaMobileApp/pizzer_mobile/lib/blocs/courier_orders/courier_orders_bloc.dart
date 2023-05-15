import 'package:pizzer_mobile/blocs/courier_orders/courier_orders_events.dart';
import 'package:pizzer_mobile/blocs/courier_orders/courier_orders_states.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class CourierOrdersBloc extends Bloc<CourierOrderEvent, CourierOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;

  CourierOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(CourierOrderLoadingState()) {
    on<LoadCourierOrderEvent>((event, emit) async {
      emit(CourierOrderLoadingState());
      try {
        final courierInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders =
            await _orderRepository.getCourierAllOrder(courierInfo.id);
        if (orders.isNotEmpty)
          emit(CourierOrdersLoadedState(orders));
        else
          emit(CourierNoOrdersState());
      } catch (e) {
        emit(CourierOrdersErrorState(e.toString()));
      }
    });

    on<LoadChosenOrderEvent>(((event, emit) async {
      emit(ChosenOrderLoadingState(event.token, event.orderId));
      try {
        final courierInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders =
            await _orderRepository.getCourierAllOrder(courierInfo.id);
        if (allOrders.isNotEmpty) {
          final singleOrder =
              allOrders.firstWhere((element) => element.id == event.orderId);
          emit(ChosenOrderLoadedState(singleOrder));
        } else
          emit(CourierNoOrdersState());
      } catch (e) {
        emit(CourierOrdersErrorState(e.toString()));
      }
    }));
  }
}
