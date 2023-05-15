import 'package:pizzer_mobile/blocs/worker_accepted_order/worker_accepted_order_events.dart';
import 'package:pizzer_mobile/blocs/worker_accepted_order/worker_accepted_order_states.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class WorkerAcceptedOrdersBloc
    extends Bloc<WorkerAcceptedOrdersEvent, WorkerAcceptedOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;

  WorkerAcceptedOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(WorkerAcceptedOrdersLoadingState()) {
    on<LoadWorkerAcceptedOrdersEvent>((event, emit) async {
      emit(WorkerAcceptedOrdersLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders = await _orderRepository.getWorkerActiveOrder(userInfo.id);
        if (orders == null) {
          emit(NoAcceptedOrderState(event.token));
        } else {
          emit(WorkerAcceptedOrdersLoadedState(orders, event.token));
        }
      } catch (e) {
        emit(WorkerAcceptedOrdersErrorState(e.toString()));
      }
    });

    on<ToNextStatusOrderEvent>((event, emit) async {
      _orderRepository.toNextStatus(event.order.id);
      emit(NoAcceptedOrderState(event.token));
    });
  }
}
