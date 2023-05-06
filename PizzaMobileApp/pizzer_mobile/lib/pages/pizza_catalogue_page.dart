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
            return pizzasLoaded(context, state);
          }
          if (state is PizzaCatalogueErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is ChosenPizzaLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ChosenBigPizzaLoadedState) {
            return bigPizzaLoaded(context, state);
          }
          if (state is ChosenMediumPizzaLoadedState) {
            return mediumPizzaLoaded(context, state);
          }
          if (state is ChosenPizzaErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget bigPizzaLoaded(context, state) {
    PizzaModel bigPizza = state.bigPizzaWithName;
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<PizzaCatalogueBloc>(context)
              .add(LoadPizzaCatalogueEvent());
          return Future.value(false);
        },
        child: SingleChildScrollView(
            child: Column(children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? MediaQuery.of(context).size.height / 4
                        : MediaQuery.of(context).size.height / 4,
                    foregroundImage: AssetImage(bigPizza.photo.toString()),
                  ))),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${bigPizza.name}',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${bigPizza.description}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${bigPizza.consistance}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      width: (MediaQuery.of(context).size.width),
                      height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 8
                          : (MediaQuery.of(context).size.width) / 12,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(200, 210, 210, 210),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      child: Row(children: [
                        Container(
                          width: (MediaQuery.of(context).size.width) / 2,
                          height: (MediaQuery.of(context).size.width) / 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)),
                          ),
                          child: Center(
                              child: Text(
                            "Большая",
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                        GestureDetector(
                            onTap: () => BlocProvider.of<PizzaCatalogueBloc>(
                                    context)
                                .add(LoadChosenMediumPizzaEvent(bigPizza.name)),
                            child: Container(
                                width:
                                    (MediaQuery.of(context).size.width) / 2.25,
                                height: (MediaQuery.of(context).size.width) / 8,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(180, 220, 220, 220),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40.0),
                                      bottomRight: Radius.circular(40.0)),
                                ),
                                child: Center(
                                    child: Text(
                                  "Средняя",
                                  style: TextStyle(color: Colors.black),
                                ))))
                      ])))),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(left: 10.0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(180, 220, 220, 220),
                            shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back),
                      ),
                      onTap: () =>
                          BlocProvider.of<PizzaCatalogueBloc>(context).add(
                            LoadPizzaCatalogueEvent(),
                          ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                  child: GestureDetector(
                    child: Container(
                      width: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 1.4
                          : (MediaQuery.of(context).size.width) / 1.25,
                      height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 7
                          : (MediaQuery.of(context).size.width) / 13,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      child: Center(
                          child: Text(
                        'В корзину за ${bigPizza.price} Р',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: () => {},
                  )),
            ],
          )
        ])));
  }

  Widget mediumPizzaLoaded(context, state) {
    PizzaModel bigPizza = state.mediumPizzaWithName;
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<PizzaCatalogueBloc>(context)
              .add(LoadPizzaCatalogueEvent());
          return Future.value(false);
        },
        child: SingleChildScrollView(
            child: Column(children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                      radius: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 5
                          : MediaQuery.of(context).size.height / 5,
                      // backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? MediaQuery.of(context).size.height / 4
                              : MediaQuery.of(context).size.height / 4,
                          backgroundColor: Colors.white,
                          foregroundImage:
                              AssetImage(bigPizza.photo.toString()))))),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${bigPizza.name}',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${bigPizza.description}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${bigPizza.consistance}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      width: (MediaQuery.of(context).size.width),
                      height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 8
                          : (MediaQuery.of(context).size.width) / 12,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(200, 210, 210, 210),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      child: Row(children: [
                        GestureDetector(
                            onTap: () => BlocProvider.of<PizzaCatalogueBloc>(
                                    context)
                                .add(LoadChosenBigPizzaEvent(bigPizza.name)),
                            child: Container(
                              width: (MediaQuery.of(context).size.width) / 2.25,
                              height: (MediaQuery.of(context).size.width) / 8,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(180, 220, 220, 220),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0),
                                    topLeft: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0)),
                              ),
                              child: Center(
                                  child: Text(
                                "Большая",
                                style: TextStyle(color: Colors.black),
                              )),
                            )),
                        Container(
                            width: (MediaQuery.of(context).size.width) / 2,
                            height: (MediaQuery.of(context).size.width) / 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                            ),
                            child: Center(
                                child: Text(
                              "Средняя",
                              style: TextStyle(color: Colors.black),
                            )))
                      ])))),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(left: 10.0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(180, 220, 220, 220),
                            shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back),
                      ),
                      onTap: () =>
                          BlocProvider.of<PizzaCatalogueBloc>(context).add(
                            LoadPizzaCatalogueEvent(),
                          ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                  child: GestureDetector(
                    child: Container(
                      width: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 1.4
                          : (MediaQuery.of(context).size.width) / 1.25,
                      height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 7
                          : (MediaQuery.of(context).size.width) / 13,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      child: Center(
                          child: Text(
                        'В корзину за ${bigPizza.price} Р',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: () => {},
                  )),
            ],
          )
        ])));
  }

  Widget pizzasLoaded(context, state) {
    List<PizzaModel> pizzasList = state.pizzas;
    return ListView.builder(
        itemCount: pizzasList.length,
        itemBuilder: (_, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: GestureDetector(
                onTap: () => BlocProvider.of<PizzaCatalogueBloc>(context)
                    .add(LoadChosenPizzaEvent(pizzasList[index].name)),
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
                                            fontSize: (MediaQuery.of(context)
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    62)
                                            : TextStyle(
                                                fontSize: MediaQuery.of(context)
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
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40)
                                          : TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  44),
                                    )),
                                    Expanded(
                                        child: Padding(
                                            padding:
                                                (MediaQuery.of(context).orientation ==
                                                        Orientation.portrait)
                                                    ? (const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 10))
                                                    : (const EdgeInsets.fromLTRB(
                                                        30, 0, 30, 5)),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black),
                                                child: Text('Выбрать'),
                                                onPressed: () =>
                                                    BlocProvider.of<PizzaCatalogueBloc>(context)
                                                        .add(LoadChosenPizzaEvent(pizzasList[index].name))))),
                                  ])),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
