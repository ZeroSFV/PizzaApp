import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/add_to_basket/add_to_basket_states.dart';
import 'package:pizzer_mobile/blocs/add_to_basket/add_to_basket_events.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToBasketBloc extends Bloc<AddToBasketEvent, AddToBasketState> {
  final BasketRepository _basketRepository;
  final UserInfoRepository _userInfoRepository;

  AddToBasketBloc(this._basketRepository, this._userInfoRepository)
      : super(LoadPizzaState()) {
    on<LoadPizzaEvent>((event, emit) async {
      //emit(LoadPizzaState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
        final singleBasket =
            baskets.firstWhere((element) => element.pizzaId == event.pizzaId);
        if (singleBasket == null) {
          emit(PizzaNotInBasketState());
        } else {
          emit(PizzaInBasketState(singleBasket.amount));
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(PizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });

    on<AddPizzaEvent>((event, emit) async {
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
          emit(PizzaInBasketState(singleBasketNew.amount));
        else {
          emit(PizzaNotInBasketState());
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(PizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });

    on<DecreasePizzaEvent>((event, emit) async {
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
            emit(PizzaInBasketState(singleBasketNew.amount));
          else {
            emit(PizzaNotInBasketState());
          }
        } else {
          await _basketRepository.deleteBasket(singleBasket.id);
          emit(PizzaNotInBasketState());
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(PizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });

    on<CreateBasketEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        if (userInfo != null) {
          await _basketRepository.createBasket(userInfo.id, event.pizzaId);
          final baskets = await _basketRepository.getBasketsOfUser(userInfo.id);
          final basket =
              baskets.firstWhere((element) => element.pizzaId == event.pizzaId);
          emit(PizzaInBasketState(basket.amount));
        } else {
          emit(PizzaNotInBasketState());
        }
      } catch (e) {
        String? message = e.toString();
        if (message == "Bad state: No element") {
          emit(PizzaNotInBasketState());
        } else
          emit(AddToBasketErrorState(e.toString()));
      }
    });
  }
}
