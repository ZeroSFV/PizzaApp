import 'package:pizzer_mobile/blocs/courier_accepted_orders/courier_accepted_orders_events.dart';
import 'package:pizzer_mobile/blocs/courier_accepted_orders/courier_accepted_orders_states.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class CourierAcceptedOrdersBloc
    extends Bloc<CourierAcceptedOrdersEvent, CourierAcceptedOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;

  CourierAcceptedOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(CourierAcceptedOrdersLoadingState()) {
    on<LoadCourierAcceptedOrdersEvent>((event, emit) async {
      emit(CourierAcceptedOrdersLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders =
            await _orderRepository.getCourierActiveOrders(userInfo.id);
        if (orders.isEmpty) {
          emit(NoAcceptedOrderState(event.token));
        } else {
          emit(CourierAcceptedOrdersLoadedState(orders, event.token));
        }
      } catch (e) {
        emit(CourierAcceptedOrdersErrorState(e.toString()));
      }
    });

    on<LoadChosenOrderEvent>(((event, emit) async {
      emit(ChosenOrderLoadingState(event.orderId, event.token));
      try {
        final courierInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders =
            await _orderRepository.getCourierActiveOrders(courierInfo.id);
        if (allOrders.isNotEmpty) {
          final singleOrder =
              allOrders.firstWhere((element) => element.id == event.orderId);
          emit(ChosenOrderLoadedState(allOrders, singleOrder, event.token));
        } else
          emit(NoAcceptedOrderState(event.token));
      } catch (e) {
        emit(CourierAcceptedOrdersErrorState(e.toString()));
      }
    }));

    on<ToNextStatusOrderEvent>((event, emit) async {
      try {
        _orderRepository.toNextStatus(event.order.id);
        emit(CourierAcceptedOrdersLoadingState());
        event.orders.removeWhere(((element) => element.id == event.order.id));
        if (event.orders.isEmpty)
          emit(NoAcceptedOrderState(event.token));
        else {
          emit(CourierAcceptedOrdersLoadedState(event.orders, event.token));
        }
      } catch (e) {
        emit(CourierAcceptedOrdersErrorState(e.toString()));
      }
    });
  }
}
