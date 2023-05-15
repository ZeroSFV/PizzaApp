import 'package:pizzer_mobile/blocs/worker_orders/worker_orders_events.dart';
import 'package:pizzer_mobile/blocs/worker_orders/worker_orders_states.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class WorkerOrdersBloc extends Bloc<WorkerOrderEvent, WorkerOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;

  WorkerOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(WorkerOrderLoadingState()) {
    on<LoadWorkerOrderEvent>((event, emit) async {
      emit(WorkerOrderLoadingState());
      try {
        final workerInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders = await _orderRepository.getWorkerAllOrder(workerInfo.id);
        if (orders.isNotEmpty)
          emit(WorkerOrdersLoadedState(orders));
        else
          emit(WorkerNoOrdersState());
      } catch (e) {
        emit(WorkerOrdersErrorState(e.toString()));
      }
    });

    on<LoadChosenOrderEvent>(((event, emit) async {
      emit(ChosenOrderLoadingState(event.token, event.orderId));
      try {
        final workerInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders =
            await _orderRepository.getWorkerAllOrder(workerInfo.id);
        if (allOrders.isNotEmpty) {
          final singleOrder =
              allOrders.firstWhere((element) => element.id == event.orderId);
          emit(ChosenOrderLoadedState(singleOrder));
        } else
          emit(WorkerNoOrdersState());
      } catch (e) {
        emit(WorkerOrdersErrorState(e.toString()));
      }
    }));
  }
}
