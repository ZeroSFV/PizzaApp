import 'package:pizzer_mobile/blocs/add_to_basket/add_to_basket_bloc.dart';
import 'package:pizzer_mobile/blocs/add_to_basket/add_to_basket_events.dart';
import 'package:pizzer_mobile/blocs/add_to_basket/add_to_basket_states.dart';
import 'package:pizzer_mobile/blocs/filters/filters_events.dart';
import 'package:pizzer_mobile/blocs/filters/filters_states.dart';
import 'package:pizzer_mobile/blocs/filters/filters_bloc.dart';
import 'package:pizzer_mobile/blocs/add_to_basket_medium/add_to_basket_medium_states.dart';
import 'package:pizzer_mobile/blocs/add_to_basket_medium/add_to_basket_medium_events.dart';
import 'package:pizzer_mobile/blocs/add_to_basket_medium/add_to_basket_medium_bloc.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue/pizza_catalogue_events.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue/pizza_catalogue_states.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/pizza_catalogue/pizza_catalogue_blocs.dart';
import 'package:pizzer_mobile/models/pizza_model.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class PizzaCataloguePage extends StatelessWidget {
  PizzaCataloguePage({super.key, this.token});
  String? token;
  String? filtersValue = "-";

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
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadingFilteredPizzaCatalogueState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is PizzaCatalogueLoadedState) {
            return Scaffold(
              body: pizzasLoaded(context, state),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.filter_alt),
                onPressed: () {
                  BlocProvider.of<PizzaCatalogueBloc>(context)
                      .add(LoadFiltersEvent(filtersValue));
                },
              ),
            );
          }
          if (state is FilteredPizzaCatalogueLoadedState) {
            return Scaffold(
              body: filteredPizzasLoaded(context, state),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.filter_alt),
                onPressed: () {
                  BlocProvider.of<PizzaCatalogueBloc>(context)
                      .add(LoadFiltersEvent(filtersValue));
                },
              ),
            );
          }
          if (state is PizzaCatalogueErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is FilteredPizzaCatalogueErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is ChosenPizzaLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
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

          if (state is LoadedFiltersState) {
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
                                  BlocProvider.of<PizzaCatalogueBloc>(context)
                                      .add(LoadChosenMediumPizzaEvent(
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
                                    BlocProvider.of<PizzaCatalogueBloc>(context)
                                        .add(LoadPizzaCatalogueEvent())
                                  }
                                else
                                  {
                                    BlocProvider.of<PizzaCatalogueBloc>(context)
                                        .add(LoadFilteredPizzaCatalogueEvent(
                                            filtersValue))
                                  }
                              }))),
              Expanded(
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                      child: BlocProvider(
                          create: (context) => AddToBasketBloc(
                              BasketRepository(), UserInfoRepository())
                            ..add(LoadPizzaEvent(token, bigPizza.id)),
                          child: BlocBuilder<AddToBasketBloc, AddToBasketState>(
                              builder: (context, stateBaskets) {
                            if (stateBaskets is PizzaNotInBasketState) {
                              return GestureDetector(
                                child: Container(
                                  width: (MediaQuery.of(context).orientation ==
                                          Orientation.portrait)
                                      ? (MediaQuery.of(context).size.width) /
                                          1.4
                                      : (MediaQuery.of(context).size.width) /
                                          1.25,
                                  height: (MediaQuery.of(context).orientation ==
                                          Orientation.portrait)
                                      ? (MediaQuery.of(context).size.width) / 7
                                      : (MediaQuery.of(context).size.width) /
                                          13,
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
                                onTap: () => {
                                  BlocProvider.of<AddToBasketBloc>(context).add(
                                      CreateBasketEvent(token, bigPizza.id))
                                },
                              );
                            }
                            if (stateBaskets is PizzaInBasketState) {
                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width) / 4.3,
                                height: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 12
                                    : (MediaQuery.of(context).size.width) / 12,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40.0),
                                      bottomRight: Radius.circular(40.0),
                                      topLeft: Radius.circular(40.0),
                                      bottomLeft: Radius.circular(40.0)),
                                ),
                                child: Row(children: [
                                  Expanded(
                                      flex: 1,
// padding: EdgeInsets.fromLTRB(
// 12, 0, 1, 0),
                                      child: GestureDetector(
                                          onTap: () =>
                                              BlocProvider.of<AddToBasketBloc>(
                                                      context)
                                                  .add(DecreasePizzaEvent(
                                                      token, bigPizza.id)),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 250, 250, 250),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  25,
                                              height: (MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait)
                                                  ? (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      13
                                                  : (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      15,
                                              child: Center(
                                                  child: Text(
                                                "-",
                                                style: TextStyle(fontSize: 25),
                                              ))))),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                                  15
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  12,
//color: Colors.red,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                              child: Text(
                                                  textAlign: TextAlign.center,
                                                  '${stateBaskets.pizzaAmount}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontFamily: "Arial"))))),
                                  Expanded(
                                      flex: 1,
// padding: EdgeInsets.fromLTRB(
// 0, 1, 10, 0),
                                      child: GestureDetector(
                                          onTap: () => {
                                                BlocProvider.of<
                                                            AddToBasketBloc>(
                                                        context)
                                                    .add(AddPizzaEvent(
                                                        token, bigPizza.id))
                                              },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 250, 250, 250),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0)),
                                              ),
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  25,
                                              height: (MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait)
                                                  ? (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      13
                                                  : (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      15,
                                              child: Center(
                                                  child: Text(
                                                "+",
                                                style: TextStyle(fontSize: 25),
                                              ))))),
                                ]),
                              );
                            }
                            return Container();
                          })))),
            ],
          )
        ])));
  }

  Widget mediumPizzaLoaded(context, state) {
    PizzaModel mediumPizza = state.mediumPizzaWithName;
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
                            onTap: () => BlocProvider.of<PizzaCatalogueBloc>(
                                    context)
                                .add(LoadChosenBigPizzaEvent(mediumPizza.name)),
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
                                    BlocProvider.of<PizzaCatalogueBloc>(context)
                                        .add(LoadPizzaCatalogueEvent())
                                  }
                                else
                                  {
                                    BlocProvider.of<PizzaCatalogueBloc>(context)
                                        .add(LoadFilteredPizzaCatalogueEvent(
                                            filtersValue))
                                  }
                              }))),
              Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                    child: BlocProvider(
                        create: (context) => AddToBasketBlocMedium(
                            BasketRepository(), UserInfoRepository())
                          ..add(LoadMediumPizzaEvent(token, mediumPizza.id)),
                        child: BlocBuilder<AddToBasketBlocMedium,
                                AddToBasketMediumState>(
                            builder: (context, stateBaskets) {
                          if (stateBaskets is MediumPizzaNotInBasketState) {
                            return GestureDetector(
                              child: Container(
                                width: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 1.4
                                    : (MediaQuery.of(context).size.width) /
                                        1.25,
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
                                  'В корзину за ${mediumPizza.price} Р',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              onTap: () => {
                                BlocProvider.of<AddToBasketBlocMedium>(context)
                                    .add(CreateMediumBasketEvent(
                                        token, mediumPizza.id))
                              },
                            );
                          }
                          if (stateBaskets is MediumPizzaInBasketState) {
                            return Container(
                              width: (MediaQuery.of(context).size.width) / 4.3,
                              height: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? (MediaQuery.of(context).size.width) / 12
                                  : (MediaQuery.of(context).size.width) / 12,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0),
                                    topLeft: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0)),
                              ),
                              child: Row(children: [
                                Expanded(
                                    flex: 1,
// padding: EdgeInsets.fromLTRB(
// 12, 0, 1, 0),
                                    child: GestureDetector(
                                        onTap: () => BlocProvider.of<
                                                AddToBasketBlocMedium>(context)
                                            .add(DecreaseMediumPizzaEvent(
                                                token, mediumPizza.id)),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 250, 250, 250),
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(40.0),
                                                  bottomLeft:
                                                      Radius.circular(40.0)),
                                            ),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                25,
                                            height: (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait)
                                                ? (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    13
                                                : (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    15,
                                            child: Center(
                                                child: Text(
                                              "-",
                                              style: TextStyle(fontSize: 25),
                                            ))))),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: (MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait)
                                            ? (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                15
                                            : (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                12,
//color: Colors.red,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                            child: Text(
                                                textAlign: TextAlign.center,
                                                '${stateBaskets.pizzaAmount}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontFamily: "Arial"))))),
                                Expanded(
                                    flex: 1,
// padding: EdgeInsets.fromLTRB(
// 0, 1, 10, 0),
                                    child: GestureDetector(
                                        onTap: () => {
                                              BlocProvider.of<
                                                          AddToBasketBlocMedium>(
                                                      context)
                                                  .add(AddMediumPizzaEvent(
                                                      token, mediumPizza.id))
                                            },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 250, 250, 250),
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(40.0),
                                                  bottomRight:
                                                      Radius.circular(40.0)),
                                            ),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                25,
                                            height: (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait)
                                                ? (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    13
                                                : (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    15,
                                            child: Center(
                                                child: Text(
                                              "+",
                                              style: TextStyle(fontSize: 25),
                                            ))))),
                              ]),
                            );
                          }
                          return Container();
                        }))),
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
                                                        PizzaCatalogueBloc>(context)
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

  Widget filteredPizzasLoaded(context, state) {
    List<PizzaModel> filteredPizzasList = state.filteredPizzas;
    return ListView.builder(
        itemCount: filteredPizzasList.length,
        itemBuilder: (_, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: GestureDetector(
                onTap: () => BlocProvider.of<PizzaCatalogueBloc>(context)
                    .add(LoadChosenPizzaEvent(filteredPizzasList[index].name)),
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
                                                        PizzaCatalogueBloc>(context)
                                                    .add(LoadChosenPizzaEvent(filteredPizzasList[index].name))))),
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
        create: (context) => FiltersBloc(
              valueFilters,
            )..add(LoadFiltersPageEvent(valueFilters)),
        child: BlocBuilder<FiltersBloc, FiltersState>(
            builder: (context, stateFilter) {
          if (stateFilter is LoadFiltersPageState) {
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
                          BlocProvider.of<FiltersBloc>(context)
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
                          BlocProvider.of<FiltersBloc>(context)
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
                          BlocProvider.of<FiltersBloc>(context)
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
                          BlocProvider.of<FiltersBloc>(context)
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
                          BlocProvider.of<FiltersBloc>(context)
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
                      BlocProvider.of<PizzaCatalogueBloc>(context)
                          .add(LoadPizzaCatalogueEvent())
                    }
                  else
                    {
                      BlocProvider.of<PizzaCatalogueBloc>(context)
                          .add(LoadFilteredPizzaCatalogueEvent(filtersValue))
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
                    BlocProvider.of<PizzaCatalogueBloc>(context)
                        .add(LoadPizzaCatalogueEvent())
                  },
                ),
              )
            ]));
          }
          return Container();
        }));
  }
}
