import 'package:pizzer_mobile/blocs/user_orders/user_orders_events.dart';
import 'package:pizzer_mobile/blocs/user_orders/user_orders_states.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class UserOrdersBloc extends Bloc<UserOrderEvent, UserOrdersState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;

  UserOrdersBloc(this._orderRepository, this._userInfoRepository)
      : super(UserOrderLoadingState()) {
    on<LoadUserOrderEvent>((event, emit) async {
      emit(UserOrderLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final orders = await _orderRepository.getUserAllOrder(userInfo.id);
        if (orders.isNotEmpty)
          emit(UserOrdersLoadedState(orders));
        else
          emit(UserNoOrdersState());
      } catch (e) {
        emit(UserOrdersErrorState(e.toString()));
      }
    });

    on<LoadChosenOrderEvent>(((event, emit) async {
      emit(ChosenOrderLoadingState(event.token, event.orderId));
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final allOrders = await _orderRepository.getUserAllOrder(userInfo.id);
        if (allOrders.isNotEmpty) {
          final singleOrder =
              allOrders.firstWhere((element) => element.id == event.orderId);
          emit(ChosenOrderLoadedState(singleOrder));
        } else
          emit(UserNoOrdersState());
      } catch (e) {
        emit(UserOrdersErrorState(e.toString()));
      }
    }));
  }
}
