import 'package:pizzer_mobile/blocs/worker_unaccepted_orders/worker_unaccepted_orders_events.dart';
import 'package:pizzer_mobile/blocs/worker_unaccepted_orders/worker_unaccepted_orders_states.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class WorkerUnacceptedOrdersBloc
    extends Bloc<WorkerUnacceptedOrdersEvent, WorkerUnacceptedOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;
  String? message = "";

  WorkerUnacceptedOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(WorkerUnacceptedOrdersLoadingState()) {
    on<LoadWorkerUnacceptedOrdersEvent>((event, emit) async {
      emit(WorkerUnacceptedOrdersLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders = await _orderRepository.getUnacceptedWorkerOrders();
        if (orders.isEmpty) {
          emit(NoUnacceptedOrderState(event.token));
        } else {
          final activeOrder =
              await _orderRepository.getWorkerActiveOrder(userInfo.id);
          if (activeOrder != null)
            emit(WorkerHaveOrderLoadedState(orders, event.token));
          else
            emit(WorkerUnacceptedOrdersLoadedState(orders, event.token));
        }
      } catch (e) {
        emit(WorkerUnacceptedOrdersErrorState(e.toString()));
      }
    });

    on<LoadChosenOrderEvent>(((event, emit) async {
      emit(ChosenOrderLoadingState(event.orderId, event.token));
      try {
        message = "";
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders = await _orderRepository.getUnacceptedWorkerOrders();
        final activeOrder =
            await _orderRepository.getWorkerActiveOrder(userInfo.id);
        if (allOrders.isNotEmpty) {
          final listOrders = await _orderRepository.getAllOrders();
          final singleOrder =
              listOrders.firstWhere((element) => element.id == event.orderId);
          if (singleOrder.statusId == 1 && singleOrder.workerId == null) {
            if (activeOrder != null)
              emit(WorkerHaveOrderChosenLoadedState(singleOrder, event.token));
            else {
              emit(ChosenOrderLoadedState(singleOrder, event.token));
            }
          } else {
            message = "Данный заказ забрал другой работник или он был отменён!";
            if (activeOrder != null)
              emit(WorkerHaveOrderLoadedState(allOrders, event.token));
            else
              emit(WorkerUnacceptedOrdersLoadedState(allOrders, event.token));
          }
        } else {
          emit(NoUnacceptedOrderState(event.token));
        }
      } catch (e) {
        emit(WorkerUnacceptedOrdersErrorState(e.toString()));
      }
    }));

    on<AcceptOrderByWorkerEvent>(((event, emit) async {
      emit(WorkerUnacceptedOrdersLoadingState());
      try {
        message = "";
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders = await _orderRepository.getUnacceptedWorkerOrders();
        if (allOrders.isNotEmpty) {
          final listOrders = await _orderRepository.getAllOrders();
          final singleOrder =
              listOrders.firstWhere((element) => element.id == event.orderId);
          if (singleOrder.statusId == 1 && singleOrder.workerId == null) {
            bool check = await _orderRepository.workerAcceptOrder(
                userInfo.id, event.orderId);
            if (check == true) {
              // List<OrderModel> orders =
              //     await _orderRepository.getUnacceptedWorkerOrders();
              // if (orders.isNotEmpty) {
              //   emit(WorkerHaveOrderLoadedState(orders, event.token));
              // } else
              //   emit(NoUnacceptedOrderState(event.token));
              emit(WorkerAcceptedOrderSuccessfullyState(event.token));
            } else
              emit(NoUnacceptedOrderState(event.token));
          } else {
            message = "Данный заказ забрал другой работник или он был отменён!";
            emit(WorkerUnacceptedOrdersLoadedState(allOrders, event.token));
          }
        } else {
          emit(NoUnacceptedOrderState(event.token));
        }
      } catch (e) {
        emit(WorkerUnacceptedOrdersErrorState(e.toString()));
      }
    }));
  }
}
