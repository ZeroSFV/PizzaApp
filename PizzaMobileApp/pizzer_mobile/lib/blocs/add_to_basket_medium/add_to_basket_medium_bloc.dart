import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/add_to_basket_medium/add_to_basket_medium_states.dart';
import 'package:pizzer_mobile/blocs/add_to_basket_medium/add_to_basket_medium_events.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToBasketBlocMedium
    extends Bloc<AddToBasketMediumEvent, AddToBasketMediumState> {
  final BasketRepository _basketRepository;
  final UserInfoRepository _userInfoRepository;

  AddToBasketBlocMedium(this._basketRepository, this._userInfoRepository)
      : super(LoadMediumPizzaState()) {
    on<LoadMediumPizzaEvent>((event, emit) async {
      //emit(LoadPizzaState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final singleBasket =
            baskets.firstWhere((element) => element.pizzaId == event.pizzaId);
        if (singleBasket == null) {
          emit(MediumPizzaNotInBasketState());
        } else {
          emit(MediumPizzaInBasketState(singleBasket.amount));
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(MediumPizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });

    on<AddMediumPizzaEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final singleBasket =
            baskets.firstWhere((element) => element.pizzaId == event.pizzaId);
        singleBasket.amount = singleBasket.amount! + 1;
        await _basketRepository.updateBasket(singleBasket);
        final basketsNew =
            await _basketRepository.getBasketsOfUser(userInfo.id);
        final singleBasketNew = basketsNew
            .firstWhere((element) => element.pizzaId == event.pizzaId);
        if (singleBasketNew != null)
          emit(MediumPizzaInBasketState(singleBasketNew.amount));
        else {
          emit(MediumPizzaNotInBasketState());
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(MediumPizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });

    on<DecreaseMediumPizzaEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final singleBasket =
            baskets.firstWhere((element) => element.pizzaId == event.pizzaId);
        singleBasket.amount = singleBasket.amount! - 1;
        if (singleBasket.amount != 0) {
          await _basketRepository.updateBasket(singleBasket);
          final basketsNew =
              await _basketRepository.getBasketsOfUser(userInfo.id);
          final singleBasketNew = basketsNew
              .firstWhere((element) => element.pizzaId == event.pizzaId);
          if (singleBasketNew != null)
            emit(MediumPizzaInBasketState(singleBasketNew.amount));
          else {
            emit(MediumPizzaNotInBasketState());
          }
        } else {
          await _basketRepository.deleteBasket(singleBasket.id);
          emit(MediumPizzaNotInBasketState());
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(MediumPizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });

    on<CreateMediumBasketEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        if (userInfo != null) {
          await _basketRepository.createBasket(userInfo.id, event.pizzaId);
          final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
          final basket =
              baskets.firstWhere((element) => element.pizzaId == event.pizzaId);
          emit(MediumPizzaInBasketState(basket.amount));
        } else {
          emit(MediumPizzaNotInBasketState());
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(MediumPizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });
  }
}
