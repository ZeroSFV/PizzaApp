import 'package:pizzer_mobile/blocs/pizza_catalogue_order/pizza_catalogue_order_events.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue_order/pizza_catalogue_order_states.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PizzaCatalogueOrderBloc
    extends Bloc<PizzaCatalogueOrderEvent, PizzaCatalogueOrderState> {
  final PizzaRepository _pizzaRepository;

  PizzaCatalogueOrderBloc(this._pizzaRepository)
      : super(PizzaCatalogueOrderLoadingState()) {
    on<LoadPizzaCatalogueOrderEvent>((event, emit) async {
      emit(PizzaCatalogueOrderLoadingState());
      try {
        final pizzas = await _pizzaRepository.getPizzas();
        emit(PizzaCatalogueOrderLoadedState(pizzas));
      } catch (e) {
        emit(PizzaCatalogueOrderErrorState(e.toString()));
      }
    });

    on<LoadFilteredPizzaCatalogueOrderEvent>((event, emit) async {
      emit(LoadingFilteredPizzaOrderCatalogueState());
      try {
        final filteredPizzas =
            await _pizzaRepository.getFilteredPizzas(event.value);
        emit(FilteredPizzaCatalogueOrderLoadedState(filteredPizzas));
      } catch (e) {
        emit(FilteredPizzaCatalogueOrderErrorState(e.toString()));
      }
    });

    on<LoadChosenPizzaOrderEvent>(((event, emit) async {
      emit(ChosenPizzaOrderLoadingState(event.name));
      try {
        final pizzasWithName =
            await _pizzaRepository.getBigPizzaByName(event.name);
        emit(ChosenBigPizzaOrderLoadedState(pizzasWithName));
      } catch (e) {
        emit(ChosenPizzaOrderErrorState(e.toString()));
      }
    }));

    on<LoadChosenMediumPizzaOrderEvent>(((event, emit) async {
      // emit(ChosenPizzaLoadingState(event.name));
      try {
        final pizzasWithName =
            await _pizzaRepository.getMediumPizzaByName(event.name);
        emit(ChosenMediumPizzaOrderLoadedState(pizzasWithName));
      } catch (e) {
        emit(ChosenPizzaOrderErrorState(e.toString()));
      }
    }));

    on<LoadChosenBigPizzaOrderEvent>(((event, emit) async {
      // emit(ChosenPizzaLoadingState(event.name));
      try {
        final pizzasWithName =
            await _pizzaRepository.getBigPizzaByName(event.name);
        emit(ChosenBigPizzaOrderLoadedState(pizzasWithName));
      } catch (e) {
        emit(ChosenPizzaOrderErrorState(e.toString()));
      }
    }));

    on<LoadFiltersOrderEvent>(((event, emit) async {
      // emit(ChosenPizzaLoadingState(event.name));
      emit(LoadedFiltersOrderState(event.value));
    }));
  }
}
