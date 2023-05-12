import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_states.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_events.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_states.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientBasketBloc extends Bloc<ClientBasketEvent, ClientBasketState> {
  final BasketRepository _basketRepository;
  final UserInfoRepository _userInfoRepository;
  bool? bonusesApplied = false;
  int? usedBonuses = 0;
  //double basketPrice = 0;

  ClientBasketBloc(this._basketRepository, this._userInfoRepository)
      : super(ClientBasketLoadingState()) {
    on<LoadClientBasketEvent>((event, emit) async {
      emit(ClientBasketLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        int basketsPrice = 0;
        if (baskets.isNotEmpty) {
          baskets.forEach((e) {
            basketsPrice += (e.price as int);
          });
          // basketPrice = basketsPrice;
          emit(ClientBasketLoadedState(baskets, userInfo, basketsPrice));
        } else {
          emit(ClientBasketEmptyState());
        }
      } catch (e) {
        emit(ClientBasketErrorState(e.toString()));
      }
    });

    on<AppliedBonusesEvent>((event, emit) async {
      int basketPrice;
      if (event.user.bonuses! <= event.basketPrice * 0.15) {
        basketPrice = event.basketPrice - (event.user.bonuses as int);
        bonusesApplied = true;
        usedBonuses = event.user.bonuses;
        emit(ClientBasketLoadedState(event.baskets, event.user, basketPrice));
      } else if (event.user.bonuses! > event.basketPrice * 0.15) {
        basketPrice = (event.basketPrice - (event.basketPrice * 0.15).toInt());
        bonusesApplied = true;
        usedBonuses = (event.basketPrice * 0.15).toInt();
        emit(ClientBasketLoadedState(event.baskets, event.user, basketPrice));
      }
    });

    on<DisbandedBonusesEvent>((event, emit) async {
      int basketPrice = event.basketPrice;
      basketPrice = basketPrice + (usedBonuses as int);
      bonusesApplied = false;
      usedBonuses = 0;
      emit(ClientBasketLoadedState(event.baskets, event.user, basketPrice));
    });

    on<AddToBasketEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final oneBasket =
            baskets.firstWhere((element) => element.id == event.selectedIndex);
        oneBasket.amount = oneBasket.amount! + 1;
        await _basketRepository.updateBasket(oneBasket);
        int basketsPrice = 0;
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
          newBaskets.forEach((e) {
            // if (e.id == event.selectedIndex) {
            basketsPrice += (e.price as int);
            // }
          });
          if (bonusesApplied == true) {
            if (userInfo.bonuses! <= basketsPrice * 0.15) {
              usedBonuses = userInfo.bonuses;
              basketsPrice = basketsPrice - (userInfo.bonuses as int);
              emit(ClientBasketLoadedState(newBaskets, userInfo, basketsPrice));
            } else if (userInfo.bonuses! > basketsPrice * 0.15) {
              basketsPrice = basketsPrice - (basketsPrice * 0.15).toInt();
              usedBonuses = (basketsPrice * 0.15).toInt();
              emit(ClientBasketLoadedState(newBaskets, userInfo, basketsPrice));
            }
          } else
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
          int basketsPrice = 0;
          final newBaskets =
              await _basketRepository.getBasketsOfUser(userInfo.id);
          if (newBaskets.isNotEmpty) {
            newBaskets.forEach((e) {
              // if (e.id == event.selectedIndex) {
              basketsPrice += (e.price as int);
              //}
            });
            if (bonusesApplied == true) {
              if (userInfo.bonuses! <= basketsPrice * 0.15) {
                usedBonuses = userInfo.bonuses;
                basketsPrice = basketsPrice - (userInfo.bonuses as int);
                emit(ClientBasketLoadedState(
                    newBaskets, userInfo, basketsPrice));
              } else if (userInfo.bonuses! > basketsPrice * 0.15) {
                basketsPrice = basketsPrice - (basketsPrice * 0.15).toInt();
                usedBonuses = (basketsPrice * 0.15).toInt();
                emit(ClientBasketLoadedState(
                    newBaskets, userInfo, basketsPrice));
              }
            } else
              emit(ClientBasketLoadedState(newBaskets, userInfo, basketsPrice));
          } else {
            emit(ClientBasketEmptyState());
          }
        } else if (oneBasket.amount == 0) {
          await _basketRepository.deleteBasket(oneBasket.id);
          int basketsPrice = 0;
          final newBaskets =
              await _basketRepository.getBasketsOfUser(userInfo.id);
          if (newBaskets.isNotEmpty) {
            newBaskets.forEach((e) {
              // if (e.id == event.selectedIndex) {
              basketsPrice += (e.price as int);
              // }
            });
            if (bonusesApplied == true) {
              if (userInfo.bonuses! <= basketsPrice * 0.15) {
                usedBonuses = userInfo.bonuses;
                basketsPrice = basketsPrice - (userInfo.bonuses as int);
                emit(ClientBasketLoadedState(
                    newBaskets, userInfo, basketsPrice));
              } else if (userInfo.bonuses! > basketsPrice * 0.15) {
                basketsPrice = basketsPrice - (basketsPrice * 0.15).toInt();
                usedBonuses = (basketsPrice * 0.15).toInt();
                emit(ClientBasketLoadedState(
                    newBaskets, userInfo, basketsPrice));
              }
            } else
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
