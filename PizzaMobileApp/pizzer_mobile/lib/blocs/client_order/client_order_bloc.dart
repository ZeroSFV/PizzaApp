import 'dart:js';

import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_states.dart';
import 'package:pizzer_mobile/blocs/client_order/client_order_events.dart';
import 'package:pizzer_mobile/blocs/client_order/client_order_states.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientOrderBloc extends Bloc<ClientOrderEvent, ClientOrderState> {
  final OrderRepository _orderRepository;
  final UserInfoRepository _userInfoRepository;

  //double basketPrice = 0;

  ClientOrderBloc(this._orderRepository, this._userInfoRepository)
      : super(ClientOrderLoadingState()) {
    on<LoadClientOrderEvent>((event, emit) async {
      emit(ClientOrderLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        bool checkOrder = await _orderRepository.checkActiveOrder(userInfo.id);
        if (checkOrder == true) {
          bool orderCanBeCancelled;
          final order = await _orderRepository.getUserActiveOrder(userInfo.id);
          if (order.statusId == 1)
            orderCanBeCancelled = true;
          else
            orderCanBeCancelled = false;
          emit(ClientOrderLoadedState(order, userInfo, orderCanBeCancelled));
        } else {
          emit(ClientOrderFinishedState(event.token));
        }
      } catch (e) {
        emit(ClientOrderErrorState(e.toString()));
      }
    });

    on<CheckIfOrderChangedStatusEvent>(((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        bool checkOrder = await _orderRepository.checkActiveOrder(userInfo.id);
        if (checkOrder == true) {
          bool orderCanBeCancelled;
          final order = await _orderRepository.getUserActiveOrder(userInfo.id);
          if (order.statusId == 1)
            orderCanBeCancelled = true;
          else
            orderCanBeCancelled = false;
          if (event.statusId != order.id)
            emit(ClientOrderLoadedState(order, userInfo, orderCanBeCancelled));
        } else {
          emit(ClientOrderFinishedState(event.token));
        }
      } catch (e) {
        emit(ClientOrderErrorState(e.toString()));
      }
    }));

    on<TryCancellingOrderEvent>(((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        bool checkOrder = await _orderRepository.checkActiveOrder(userInfo.id);
        if (checkOrder == true) {
          bool orderCanBeCancelled;
          final order = await _orderRepository.getUserActiveOrder(userInfo.id);
          if (order.statusId == 1) {
            orderCanBeCancelled = true;
            _orderRepository.cancelOrder(order.id);
            emit(ClientOrderCancelledState(event.token));
          } else {
            orderCanBeCancelled = false;
            emit(ClientOrderLoadedState(order, userInfo, orderCanBeCancelled));
          }
        } else {
          emit(ClientOrderFinishedState(event.token));
        }
      } catch (e) {
        emit(ClientOrderErrorState(e.toString()));
      }
    }));
  }
}
