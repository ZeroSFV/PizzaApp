import 'package:flutter/services.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_states.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/models/make_order_model.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserInfoRepository _userInfoRepository;
  final OrderRepository _orderRepository;

  AppBloc(this._userInfoRepository, this._orderRepository)
      : super(SignInState()) {
    on<SignInSubmittedAppEvent>((event, emit) async {
      final String? token = event.token;
      final userInfo = await _userInfoRepository.getUserInfo(token);
      if (userInfo.role == "user") {
        final activeOrder =
            await _orderRepository.checkActiveOrder(userInfo.id);
        if (activeOrder == true) {
          emit(ClientActiveOrderState(token));
        } else {
          emit(ClientNoOrderState(token));
        }
      }
    });

    on<LoadResetPasswordAppEvent>((event, emit) async {
      emit(ResetPasswordState());
    });

    on<LoadRegistrationAppEvent>((event, emit) async {
      emit(RegistrationState());
    });

    on<LoadSignInAppEvent>(((event, emit) async {
      emit(SignInState());
    }));

    on<UserLogOutEvent>((event, emit) async {
      emit(SignInState());
    });

    on<ClientCreatedOrderEvent>((event, emit) async {
      final userInfo = await _userInfoRepository.getUserInfo(event.token);
      final String clientName = userInfo.name.toString();
      final MakeOrderModel makeOrderModel = MakeOrderModel();
      makeOrderModel.clientId = userInfo.id;
      makeOrderModel.address = event.address;
      makeOrderModel.phoneNumber = event.phoneNumber;
      makeOrderModel.clientName = clientName;
      makeOrderModel.payingType = event.payingType;
      if (event.change != "")
        makeOrderModel.change = int.parse(event.change.toString());
      else
        makeOrderModel.change = 0;
      makeOrderModel.usedBonuses = event.usedBonuses;
      makeOrderModel.givenBonuses = event.givenBonuses;
      makeOrderModel.comment = event.comment;

      try {
        await _orderRepository.makeOrder(makeOrderModel);
        emit(ClientActiveOrderState(event.token));
      } catch (e) {
        //emit((e.toString()));
      }
    });

    on<CheckIfOrderFinishedEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final activeOrder =
            await _orderRepository.checkActiveOrder(userInfo.id);
        if (activeOrder == false) {
          event.timer.cancel();
          emit(ShowUserFinishOrderState(event.token));
        }
      } catch (e) {
        emit(ServerErrorState(e.toString()));
      }
    });

    on<ClientReturnedToOrderingEvent>(((event, emit) {
      emit(ClientNoOrderState(event.token));
    }));
  }
}
