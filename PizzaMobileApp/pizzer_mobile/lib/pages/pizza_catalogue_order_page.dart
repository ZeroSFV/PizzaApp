import 'package:pizzer_mobile/blocs/filters_order/filters_order_events.dart';
import 'package:pizzer_mobile/blocs/filters_order/filters_order_states.dart';
import 'package:pizzer_mobile/blocs/filters_order/filters_order_bloc.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue_order/pizza_catalogue_order_events.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue_order/pizza_catalogue_order_states.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue_order/pizza_catalogue_order_bloc.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class PizzaCatalogueOrderPage extends StatelessWidget {
  PizzaCatalogueOrderPage({super.key, this.token});
  String? token;
  String? filtersValue = "-";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PizzaCatalogueOrderBloc>(
          create: (BuildContext context) =>
              PizzaCatalogueOrderBloc(PizzaRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => PizzaCatalogueOrderBloc(
        PizzaRepository(),
      )..add(LoadPizzaCatalogueOrderEvent()),
      child: BlocBuilder<PizzaCatalogueOrderBloc, PizzaCatalogueOrderState>(
        builder: (context, state) {
          if (state is PizzaCatalogueOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadingFilteredPizzaOrderCatalogueState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is PizzaCatalogueOrderLoadedState) {
            return Scaffold(
              body: pizzasLoaded(context, state),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.filter_alt),
                onPressed: () {
                  BlocProvider.of<PizzaCatalogueOrderBloc>(context)
                      .add(LoadFiltersOrderEvent(filtersValue));
                },
              ),
            );
          }
          if (state is FilteredPizzaCatalogueOrderLoadedState) {
            return Scaffold(
              body: filteredPizzasLoaded(context, state),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.filter_alt),
                onPressed: () {
                  BlocProvider.of<PizzaCatalogueOrderBloc>(context)
                      .add(LoadFiltersOrderEvent(filtersValue));
                },
              ),
            );
          }
          if (state is PizzaCatalogueOrderErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is FilteredPizzaCatalogueOrderErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is ChosenPizzaOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is ChosenBigPizzaOrderLoadedState) {
            return bigPizzaLoaded(context, state);
          }
          if (state is ChosenMediumPizzaOrderLoadedState) {
            return mediumPizzaLoaded(context, state);
          }
          if (state is ChosenPizzaOrderErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }

          if (state is LoadedFiltersOrderState) {
            return FiltersPage(filtersValue);
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
          BlocProvider.of<PizzaCatalogueOrderBloc>(context)
              .add(LoadPizzaCatalogueOrderEvent());
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
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 30
                          : MediaQuery.of(context).size.width / 30,
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
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 45
                          : MediaQuery.of(context).size.width / 45,
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
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 55
                          : MediaQuery.of(context).size.width / 55,
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 30
                                    : (MediaQuery.of(context).size.width) / 50),
                          )),
                        ),
                        GestureDetector(
                            onTap: () => {
                                  BlocProvider.of<PizzaCatalogueOrderBloc>(
                                          context)
                                      .add(LoadChosenMediumPizzaOrderEvent(
                                          bigPizza.name))
                                },
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
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  30
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  50),
                                ))))
                      ])))),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          2, 0, (MediaQuery.of(context).size.width) / 2.5, 5),
                      child: GestureDetector(
                          child: Container(
                            height: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.height / 15
                                : MediaQuery.of(context).size.width / 15,
                            width: 50,
                            margin: const EdgeInsets.only(left: 10.0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(180, 220, 220, 220),
                                shape: BoxShape.circle),
                            child: Icon(Icons.arrow_back),
                          ),
                          onTap: () => {
                                if (filtersValue == "-")
                                  {
                                    BlocProvider.of<PizzaCatalogueOrderBloc>(
                                            context)
                                        .add(LoadPizzaCatalogueOrderEvent())
                                  }
                                else
                                  {
                                    BlocProvider.of<PizzaCatalogueOrderBloc>(
                                            context)
                                        .add(
                                            LoadFilteredPizzaCatalogueOrderEvent(
                                                filtersValue))
                                  }
                              }))),
              Expanded(
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
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
                            'У вас уже есть заказ',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        onTap: () => {},
                      ))),
            ],
          )
        ])));
  }

  Widget mediumPizzaLoaded(context, state) {
    PizzaModel mediumPizza = state.mediumPizzaWithName;
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<PizzaCatalogueOrderBloc>(context)
              .add(LoadPizzaCatalogueOrderEvent());
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
                              AssetImage(mediumPizza.photo.toString()))))),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${mediumPizza.name}',
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 30
                          : MediaQuery.of(context).size.width / 30,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Times New Roman"),
                ),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                child: Text(
                  '${mediumPizza.description}',
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 45
                          : MediaQuery.of(context).size.width / 45,
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
                  '${mediumPizza.consistance}',
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 55
                          : MediaQuery.of(context).size.width / 55,
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
                            onTap: () =>
                                BlocProvider.of<PizzaCatalogueOrderBloc>(
                                        context)
                                    .add(LoadChosenBigPizzaOrderEvent(
                                        mediumPizza.name)),
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
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: (MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait)
                                        ? (MediaQuery.of(context).size.width) /
                                            30
                                        : (MediaQuery.of(context).size.width) /
                                            50),
                              )),
                            )),
                        Container(
                            width: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? (MediaQuery.of(context).size.width) / 1.90
                                : (MediaQuery.of(context).size.width) / 1.8348,
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
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: (MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait)
                                      ? (MediaQuery.of(context).size.width) / 30
                                      : (MediaQuery.of(context).size.width) /
                                          50),
                            )))
                      ])))),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          2, 0, (MediaQuery.of(context).size.width) / 2.5, 5),
                      child: GestureDetector(
                          child: Container(
                            height: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.height / 15
                                : MediaQuery.of(context).size.width / 15,
                            width: 50,
                            margin: const EdgeInsets.only(left: 10.0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(180, 220, 220, 220),
                                shape: BoxShape.circle),
                            child: Icon(Icons.arrow_back),
                          ),
                          onTap: () => {
                                if (filtersValue == "-")
                                  {
                                    BlocProvider.of<PizzaCatalogueOrderBloc>(
                                            context)
                                        .add(LoadPizzaCatalogueOrderEvent())
                                  }
                                else
                                  {
                                    BlocProvider.of<PizzaCatalogueOrderBloc>(
                                            context)
                                        .add(
                                            LoadFilteredPizzaCatalogueOrderEvent(
                                                filtersValue))
                                  }
                              }))),
              Expanded(
                flex: 3,
                child: Padding(
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
                            'У вас уже есть заказ',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        onTap: () => {})),
              )
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
                onTap: () => BlocProvider.of<PizzaCatalogueOrderBloc>(context)
                    .add(LoadChosenPizzaOrderEvent(pizzasList[index].name)),
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
                                                    ? (EdgeInsets.fromLTRB(
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            16),
                                                        0,
                                                        10,
                                                        10))
                                                    : (EdgeInsets.fromLTRB(
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10),
                                                        0,
                                                        30,
                                                        5)),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black),
                                                child: Text(
                                                  'Выбрать',
                                                  style: TextStyle(
                                                      fontSize: (MediaQuery.of(
                                                                      context)
                                                                  .orientation ==
                                                              Orientation
                                                                  .portrait)
                                                          ? (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              40)
                                                          : (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              40)),
                                                ),
                                                onPressed: () => BlocProvider.of<
                                                        PizzaCatalogueOrderBloc>(context)
                                                    .add(LoadChosenPizzaOrderEvent(pizzasList[index].name))))),
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

  Widget filteredPizzasLoaded(context, state) {
    List<PizzaModel> filteredPizzasList = state.filteredPizzas;
    return ListView.builder(
        itemCount: filteredPizzasList.length,
        itemBuilder: (_, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: GestureDetector(
                onTap: () => BlocProvider.of<PizzaCatalogueOrderBloc>(context)
                    .add(LoadChosenPizzaOrderEvent(
                        filteredPizzasList[index].name)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 33,
                          child: Image.asset(
                            filteredPizzasList[index].photo.toString(),
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
                                        '${filteredPizzasList[index].name}')),
                              ),
                              Expanded(
                                  flex: 30,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${filteredPizzasList[index].consistance}',
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
                                      'от ${filteredPizzasList[index].price} Р',
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
                                                    ? (EdgeInsets.fromLTRB(
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            16),
                                                        0,
                                                        10,
                                                        10))
                                                    : (EdgeInsets.fromLTRB(
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10),
                                                        0,
                                                        30,
                                                        5)),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black),
                                                child: Text(
                                                  'Выбрать',
                                                  style: TextStyle(
                                                      fontSize: (MediaQuery.of(
                                                                      context)
                                                                  .orientation ==
                                                              Orientation
                                                                  .portrait)
                                                          ? (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              40)
                                                          : (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              40)),
                                                ),
                                                onPressed: () => BlocProvider.of<
                                                        PizzaCatalogueOrderBloc>(context)
                                                    .add(LoadChosenPizzaOrderEvent(filteredPizzasList[index].name))))),
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

  Widget FiltersPage(valueFilters) {
    return BlocProvider(
        create: (context) => FiltersOrderBloc(
              valueFilters,
            )..add(LoadFiltersPageOrderEvent(valueFilters)),
        child: BlocBuilder<FiltersOrderBloc, FiltersOrderState>(
            builder: (context, stateFilter) {
          if (stateFilter is LoadFiltersPageOrderState) {
            return Center(
                child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                    color: Color.fromARGB(255, 244, 244, 244),
                    child: Center(
                        child: Text("Фильтр пицц",
                            style: TextStyle(fontSize: 30)))),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width / 8)
                          : (MediaQuery.of(context).size.width / 8),
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.height / 24)
                          : (MediaQuery.of(context).size.height / 24),
                      0,
                      0),
                  child: ListTile(
                      title:
                          Text("Нет фильтров", style: TextStyle(fontSize: 30)),
                      leading: Radio(
                        activeColor: Colors.red,
                        value: "-",
                        groupValue: stateFilter.value,
                        onChanged: (newValue) {
                          filtersValue = newValue.toString();
                          BlocProvider.of<FiltersOrderBloc>(context)
                              .add(ValueChangedEvent(newValue.toString()));
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width / 8)
                          : (MediaQuery.of(context).size.width / 8),
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.height / 24)
                          : (MediaQuery.of(context).size.height / 24),
                      0,
                      0),
                  child: ListTile(
                      title: Text("Мясная", style: TextStyle(fontSize: 30)),
                      leading: Radio(
                        activeColor: Colors.red,
                        value: "Мясная",
                        groupValue: stateFilter.value,
                        onChanged: (newValue) {
                          filtersValue = newValue.toString();
                          BlocProvider.of<FiltersOrderBloc>(context)
                              .add(ValueChangedEvent(newValue.toString()));
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width / 8)
                          : (MediaQuery.of(context).size.width / 8),
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.height / 24)
                          : (MediaQuery.of(context).size.height / 24),
                      0,
                      0),
                  child: ListTile(
                      title: Text("Острая", style: TextStyle(fontSize: 30)),
                      leading: Radio(
                        activeColor: Colors.red,
                        value: "Острая",
                        groupValue: stateFilter.value,
                        onChanged: (newValue) {
                          filtersValue = newValue.toString();
                          BlocProvider.of<FiltersOrderBloc>(context)
                              .add(ValueChangedEvent(newValue.toString()));
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width / 8)
                          : (MediaQuery.of(context).size.width / 8),
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.height / 24)
                          : (MediaQuery.of(context).size.height / 24),
                      0,
                      0),
                  child: ListTile(
                      title: Text("Грибная", style: TextStyle(fontSize: 30)),
                      leading: Radio(
                        activeColor: Colors.red,
                        value: "Грибная",
                        groupValue: stateFilter.value,
                        onChanged: (newValue) {
                          filtersValue = newValue.toString();
                          BlocProvider.of<FiltersOrderBloc>(context)
                              .add(ValueChangedEvent(newValue.toString()));
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width / 8)
                          : (MediaQuery.of(context).size.width / 8),
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.height / 24)
                          : (MediaQuery.of(context).size.height / 24),
                      0,
                      0),
                  child: ListTile(
                      title: Text("Рыбная", style: TextStyle(fontSize: 30)),
                      leading: Radio(
                        activeColor: Colors.red,
                        value: "Рыбная",
                        groupValue: stateFilter.value,
                        onChanged: (newValue) {
                          filtersValue = newValue.toString();
                          BlocProvider.of<FiltersOrderBloc>(context)
                              .add(ValueChangedEvent(newValue.toString()));
                        },
                      ))),
              Expanded(
                flex: 2,
                child: Container(color: Color.fromARGB(255, 249, 249, 249)),
              ),
              GestureDetector(
                child: Container(
                  width: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 1.4
                      : (MediaQuery.of(context).size.width) / 1.25,
                  height: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 15
                      : (MediaQuery.of(context).size.width) / 13,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                  child: Center(
                      child: Text(
                    'Применить',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
                  )),
                ),
                onTap: () => {
                  if (filtersValue == "-")
                    {
                      BlocProvider.of<PizzaCatalogueOrderBloc>(context)
                          .add(LoadPizzaCatalogueOrderEvent())
                    }
                  else
                    {
                      BlocProvider.of<PizzaCatalogueOrderBloc>(context).add(
                          LoadFilteredPizzaCatalogueOrderEvent(filtersValue))
                    }
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: GestureDetector(
                  child: Container(
                    width: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? (MediaQuery.of(context).size.width) / 1.4
                        : (MediaQuery.of(context).size.width) / 1.25,
                    height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? (MediaQuery.of(context).size.width) / 15
                        : (MediaQuery.of(context).size.width) / 13,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 0, 0),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                    child: Center(
                        child: Text(
                      'Сбросить фильтры',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30),
                    )),
                  ),
                  onTap: () => {
                    filtersValue = "-",
                    BlocProvider.of<PizzaCatalogueOrderBloc>(context)
                        .add(LoadPizzaCatalogueOrderEvent())
                  },
                ),
              )
            ]));
          }
          return Container();
        }));
  }
}
