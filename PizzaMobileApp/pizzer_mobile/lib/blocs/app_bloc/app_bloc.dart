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
    on<SignInSubmittedEvent>((event, emit) async {
      final String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJla3Nfc2Z2QG1haWwucnUiLCJuYW1lIjoi0JzQuNGF0LDQuNC7INCR0LDRg9GB0L7QsiDQlNC80LjRgtGA0LjQtdCy0LjRhyIsInN1YiI6IjUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNjg5NzQ3NDExLCJpc3MiOiJQaXp6ZXJCYWNrRW5kIiwiYXVkIjoiUGl6emVyTW9iaWxlIn0.w7pqPIIkWw2HmyPhyRarP6vLJ3WDXmQU_mn-pHxutLg";
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
  }
}
