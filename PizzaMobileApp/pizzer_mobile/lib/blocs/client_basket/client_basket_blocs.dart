import 'package:pizzer_mobile/blocs/client_basket/client_basket_events.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_states.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientBasketBloc extends Bloc<ClientBasketEvent, ClientBasketState> {
  final BasketRepository _basketRepository;
  final UserInfoRepository _userInfoRepository;

  ClientBasketBloc(this._basketRepository, this._userInfoRepository)
      : super(ClientBasketLoadingState()) {
    on<LoadClientBasketEvent>((event, emit) async {
      emit(ClientBasketLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        double basketsPrice = 0;
        if (baskets.isNotEmpty) {
          baskets.forEach((e) {
            basketsPrice += (e.price as double);
          });
          emit(ClientBasketLoadedState(baskets, userInfo, basketsPrice));
        } else {
          emit(ClientBasketEmptyState());
        }
      } catch (e) {
        emit(ClientBasketErrorState(e.toString()));
      }
    });

    on<AddToBasketEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final oneBasket =
            baskets.firstWhere((element) => element.id == event.selectedIndex);
        oneBasket.amount = oneBasket.amount! + 1;
        await _basketRepository.updateBasket(oneBasket);
        double basketsPrice = 0;
        // if (baskets.isNotEmpty) {
        //   baskets.forEach((e) async {
        //     if (e.id == event.selectedIndex) {
        //       e.amount = e.amount! + 1;
        //       await _basketRepository.updateBasket(e);
        //     }
        //   });
        final newBaskets =
            await _basketRepository.getBasketsOfUser(userInfo.id);
        if (newBaskets.isNotEmpty) {
          newBaskets.forEach((e) async {
            if (e.id == event.selectedIndex) {
              basketsPrice += (e.price as double);
            }
          });
          emit(ClientBasketLoadedState(newBaskets, userInfo, basketsPrice));
        } else {
          emit(ClientBasketEmptyState());
        }
      } catch (e) {
        emit(ClientBasketErrorState(e.toString()));
      }
    });

    on<DecreaseBasketEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final oneBasket =
            baskets.firstWhere((element) => element.id == event.selectedIndex);
        oneBasket.amount = oneBasket.amount! - 1;
        if (oneBasket.amount != 0) {
          await _basketRepository.updateBasket(oneBasket);
          double basketsPrice = 0;
          final newBaskets =
              await _basketRepository.getBasketsOfUser(userInfo.id);
          if (newBaskets.isNotEmpty) {
            newBaskets.forEach((e) async {
              if (e.id == event.selectedIndex) {
                basketsPrice += (e.price as double);
              }
            });
            emit(ClientBasketLoadedState(newBaskets, userInfo, basketsPrice));
          } else {
            emit(ClientBasketEmptyState());
          }
        } else if (oneBasket.amount == 0) {
          await _basketRepository.deleteBasket(oneBasket.id);
          double basketsPrice = 0;
          final newBaskets =
              await _basketRepository.getBasketsOfUser(userInfo.id);
          if (newBaskets.isNotEmpty) {
            newBaskets.forEach((e) async {
              if (e.id == event.selectedIndex) {
                basketsPrice += (e.price as double);
              }
            });
            emit(ClientBasketLoadedState(newBaskets, userInfo, basketsPrice));
          } else {
            emit(ClientBasketEmptyState());
          }
        }
      } catch (e) {
        emit(ClientBasketErrorState(e.toString()));
      }
    });
  }
}
