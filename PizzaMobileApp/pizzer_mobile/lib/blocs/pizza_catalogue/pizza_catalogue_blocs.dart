import 'package:pizzer_mobile/blocs/pizza_catalogue/pizza_catalogue_events.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue/pizza_catalogue_states.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PizzaCatalogueBloc
    extends Bloc<PizzaCatalogueEvent, PizzaCatalogueState> {
  final PizzaRepository _pizzaRepository;

  PizzaCatalogueBloc(this._pizzaRepository)
      : super(PizzaCatalogueLoadingState()) {
    on<LoadPizzaCatalogueEvent>((event, emit) async {
      emit(PizzaCatalogueLoadingState());
      try {
        final pizzas = await _pizzaRepository.getPizzas();
        emit(PizzaCatalogueLoadedState(pizzas));
      } catch (e) {
        emit(PizzaCatalogueErrorState(e.toString()));
      }
    });

    on<LoadChosenPizzaEvent>(((event, emit) async {
      emit(ChosenPizzaLoadingState(event.name));
      try {
        final pizzasWithName =
            await _pizzaRepository.getBigPizzaByName(event.name);
        emit(ChosenBigPizzaLoadedState(pizzasWithName));
      } catch (e) {
        emit(ChosenPizzaErrorState(e.toString()));
      }
    }));

    on<LoadChosenMediumPizzaEvent>(((event, emit) async {
      // emit(ChosenPizzaLoadingState(event.name));
      try {
        final pizzasWithName =
            await _pizzaRepository.getMediumPizzaByName(event.name);
        emit(ChosenMediumPizzaLoadedState(pizzasWithName));
      } catch (e) {
        emit(ChosenPizzaErrorState(e.toString()));
      }
    }));

    on<LoadChosenBigPizzaEvent>(((event, emit) async {
      // emit(ChosenPizzaLoadingState(event.name));
      try {
        final pizzasWithName =
            await _pizzaRepository.getBigPizzaByName(event.name);
        emit(ChosenBigPizzaLoadedState(pizzasWithName));
      } catch (e) {
        emit(ChosenPizzaErrorState(e.toString()));
      }
    }));
  }
}
