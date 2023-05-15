import 'package:pizzer_mobile/blocs/courier_unaccepted_orders/courier_unaccepted_orders_events.dart';
import 'package:pizzer_mobile/blocs/courier_unaccepted_orders/courier_unaccepted_orders_states.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class CourierUnacceptedOrdersBloc
    extends Bloc<CourierUnacceptedOrdersEvent, CourierUnacceptedOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;
  String? message = "";

  CourierUnacceptedOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(CourierUnacceptedOrdersLoadingState()) {
    on<LoadCourierUnacceptedOrdersEvent>((event, emit) async {
      emit(CourierUnacceptedOrdersLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders = await _orderRepository.getUnacceptedCourierOrders();
        if (orders.isEmpty) {
          emit(NoUnacceptedOrderState(event.token));
        } else {
          final activeOrders =
              await _orderRepository.getCourierActiveOrders(userInfo.id);
          if (activeOrders.length == 3)
            emit(CourierHaveOrderLoadedState(orders, event.token));
          else
            emit(CourierUnacceptedOrdersLoadedState(orders, event.token));
        }
      } catch (e) {
        emit(CourierUnacceptedOrdersErrorState());
      }
    });

    on<LoadChosenOrderEvent>(((event, emit) async {
      emit(ChosenOrderLoadingState(event.orderId, event.token));
      try {
        message = "";
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders = await _orderRepository.getUnacceptedCourierOrders();
        final activeOrders =
            await _orderRepository.getCourierActiveOrders(userInfo.id);
        if (allOrders.isNotEmpty) {
          final listOrders = await _orderRepository.getAllOrders();
          final singleOrder =
              listOrders.firstWhere((element) => element.id == event.orderId);
          if (singleOrder.statusId == 3 && singleOrder.courierId == null) {
            if (activeOrders.length == 3)
              emit(CourierHaveOrderChosenLoadedState(singleOrder, event.token));
            else {
              emit(ChosenOrderLoadedState(singleOrder, event.token));
            }
          } else {
            message = "Данный заказ забрал другой работник или он был отменён!";
            if (activeOrders.length == 3) {
              allOrders
                  .removeWhere(((element) => element.id == singleOrder.id));
              emit(CourierHaveOrderLoadedState(allOrders, event.token));
            } else {
              allOrders
                  .removeWhere(((element) => element.id == singleOrder.id));
              emit(CourierUnacceptedOrdersLoadedState(allOrders, event.token));
            }
          }
        } else {
          emit(NoUnacceptedOrderState(event.token));
        }
      } catch (e) {
        emit(CourierUnacceptedOrdersErrorState());
      }
    }));

    on<AcceptOrderByCourierEvent>(((event, emit) async {
      emit(CourierUnacceptedOrdersLoadingState());
      try {
        message = "";
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders = await _orderRepository.getUnacceptedCourierOrders();
        if (allOrders.isNotEmpty) {
          final listOrders = await _orderRepository.getAllOrders();
          final singleOrder =
              listOrders.firstWhere((element) => element.id == event.orderId);
          if (singleOrder.statusId == 3 && singleOrder.courierId == null) {
            bool check = await _orderRepository.courierAcceptOrder(
                userInfo.id, event.orderId);
            if (check == true) {
              allOrders
                  .removeWhere(((element) => element.id == singleOrder.id));
              final activeOrders =
                  await _orderRepository.getCourierActiveOrders(userInfo.id);
              if (allOrders.isNotEmpty) {
                if (activeOrders.length == 3) {
                  emit(CourierHaveOrderLoadedState(allOrders, event.token));
                } else
                  emit(CourierUnacceptedOrdersLoadedState(
                      allOrders, event.token));
              } else
                emit(NoUnacceptedOrderState(event.token));
            } else
              emit(CourierUnacceptedOrdersErrorState());
          } else {
            message = "Данный заказ забрал другой курьер!";
            allOrders.remove(singleOrder);
            emit(CourierUnacceptedOrdersLoadedState(allOrders, event.token));
          }
        } else {
          emit(NoUnacceptedOrderState(event.token));
        }
      } catch (e) {
        emit(CourierUnacceptedOrdersErrorState());
      }
    }));
  }
}
