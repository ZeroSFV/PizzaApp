import 'package:pizzer_mobile/blocs/pizza_catalogue_events.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue_states.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue_blocs.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:flutter/material.dart';

class PizzaCataloguePage extends StatelessWidget {
  const PizzaCataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PizzaCatalogueBloc>(
          create: (BuildContext context) =>
              PizzaCatalogueBloc(PizzaRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pizzer',
            style: TextStyle(fontSize: 25, fontFamily: 'GrandHotel'),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
        ),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => PizzaCatalogueBloc(
        PizzaRepository(),
      )..add(LoadPizzaCatalogueEvent()),
      child: BlocBuilder<PizzaCatalogueBloc, PizzaCatalogueState>(
        builder: (context, state) {
          if (state is PizzaCatalogueLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PizzaCatalogueLoadedState) {
            List<PizzaModel> pizzasList = state.pizzas;
            return ListView.builder(
                itemCount: pizzasList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 33,
                              child: Image.asset(
                                pizzasList[index].photo.toString(),
                              ),
                            ),
                            Expanded(
                              flex: 66,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 20,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        30)),
                                            '${pizzasList[index].name}')),
                                  ),
                                  Expanded(
                                      flex: 30,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${pizzasList[index].consistance}',
                                            style: (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait)
                                                ? TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            62)
                                                : TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            62),
                                          ))),
                                  Expanded(
                                      flex: 25,
                                      child: Row(children: [
                                        Expanded(
                                            child: Text(
                                          'от ${pizzasList[index].price} Р',
                                          style: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          40)
                                              : TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          44),
                                        )),
                                        Expanded(
                                            child: Padding(
                                                padding: (MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.portrait)
                                                    ? (const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 10))
                                                    : (const EdgeInsets.fromLTRB(
                                                        30, 0, 30, 5)),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            foregroundColor:
                                                                Colors.black),
                                                    child: Text('Выбрать'),
                                                    onPressed: () {}))),
                                      ])),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          if (state is PizzaCatalogueErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }

          return Container();
        },
      ),
    );
  }
}
