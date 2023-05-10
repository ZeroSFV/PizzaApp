import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_blocs.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_events.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_states.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_events.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_states.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_blocs.dart';
import 'package:pizzer_mobile/models/basket_model.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatelessWidget {
  BasketPage({super.key, this.token});
  String? token;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClientBasketBloc>(
          create: (BuildContext context) =>
              ClientBasketBloc(BasketRepository(), UserInfoRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          ClientBasketBloc(BasketRepository(), UserInfoRepository())
            ..add(LoadClientBasketEvent(token)),
      child: BlocBuilder<ClientBasketBloc, ClientBasketState>(
        builder: (context, state) {
          if (state is ClientBasketLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is ClientBasketLoadedState) {
            return basketsLoaded(context, state);
          }
          if (state is ClientBasketErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is ClientBasketEmptyState) {
            return basketsEmpty(context, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget basketsEmpty(context, state) {
    return SingleChildScrollView(
        child: Center(
            child: Column(children: [
      Icon(Icons.sentiment_dissatisfied_outlined,
          color: Color.fromARGB(240, 117, 117, 117),
          size: MediaQuery.of(context).size.height / 3),
      Text("Ваша корзина пуста",
          style: TextStyle(
              color: Color.fromARGB(240, 117, 117, 117),
              fontSize:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height / 20
                      : MediaQuery.of(context).size.width / 20)),
      Text("Для начала оформления заказа добавьте пиццу из каталога",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height / 38
                      : MediaQuery.of(context).size.width / 38))
    ])));
  }

  Widget basketsLoaded(context, state) {
    List<BasketModel> basketList = state.baskets;
    bool usedBonuses = false;
    UserInfoModel user = state.user;
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: basketList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: Card(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2,
                                                    child: Text(
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                30)),
                                                        '${basketList[index].pizzaName}' +
                                                            ' ' +
                                                            '${basketList[index].sizeName}'))))),
                                    Expanded(
                                      child: Padding(
                                          padding: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      13.5,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      24,
                                                  0,
                                                  0)
                                              : EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      13,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      24,
                                                  0,
                                                  0),
                                          child: Column(children: [
                                            Center(
                                                child: Text(
                                              '${basketList[index].price} Р',
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
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Container(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    4.3,
                                                height: (MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.portrait)
                                                    ? (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        12
                                                    : (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        12,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  40.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  40.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40.0)),
                                                ),
                                                child: Row(children: [
                                                  Expanded(
                                                      flex: 1,
                                                      // padding: EdgeInsets.fromLTRB(
                                                      //     12, 0, 1, 0),
                                                      child: GestureDetector(
                                                          onTap: () => BlocProvider.of<
                                                                      ClientBasketBloc>(
                                                                  context)
                                                              .add(DecreaseBasketEvent(
                                                                  token,
                                                                  basketList[index]
                                                                      .id)),
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            40.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            40.0)),
                                                              ),
                                                              // color: Colors.black,
                                                              width: (MediaQuery.of(context)
                                                                      .size
                                                                      .width) /
                                                                  25,
                                                              height: (MediaQuery.of(context).orientation ==
                                                                      Orientation
                                                                          .portrait)
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
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25),
                                                              ))))),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                          height: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height) /
                                                              15,
                                                          //color: Colors.red,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.red,
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  '${basketList[index].amount}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25,
                                                                      fontFamily:
                                                                          "Arial"))))),
                                                  Expanded(
                                                      flex: 1,
                                                      // padding: EdgeInsets.fromLTRB(
                                                      //     0, 1, 10, 0),
                                                      child: GestureDetector(
                                                          onTap: () => {
                                                                BlocProvider.of<
                                                                            ClientBasketBloc>(
                                                                        context)
                                                                    .add(AddToBasketEvent(
                                                                        token,
                                                                        basketList[index]
                                                                            .id))
                                                              },
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            40.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            40.0)),
                                                              ),
                                                              width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  25,
                                                              height: (MediaQuery.of(
                                                                              context)
                                                                          .orientation ==
                                                                      Orientation
                                                                          .portrait)
                                                                  ? (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width) /
                                                                      13
                                                                  : (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width) /
                                                                      15,
                                                              child: Center(
                                                                  child: Text(
                                                                "+",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25),
                                                              ))))),
                                                ]),
                                              ),
                                            )
                                          ])),
                                    )
                                  ],
                                )),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Card(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                30, 0, 0, 0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: Text(
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                (MediaQuery.of(context)
                                                                        .size
                                                                        .height /
                                                                    15)),
                                                        '${basketList[index].pizzaName}' +
                                                            ' ' +
                                                            '${basketList[index].sizeName}'))))),
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  24,
                                              0,
                                              0),
                                          child: Column(children: [
                                            Center(
                                                child: Text(
                                              '${basketList[index].price} Р',
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
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Container(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    4.3,
                                                height: (MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.portrait)
                                                    ? (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        12
                                                    : (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        16,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  40.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  40.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40.0)),
                                                ),
                                                child: Row(children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 0, 0, 0),
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () => BlocProvider.of<
                                                                              ClientBasketBloc>(
                                                                          context)
                                                                      .add(DecreaseBasketEvent(
                                                                          token,
                                                                          basketList[index]
                                                                              .id)),
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(40.0),
                                                                            bottomLeft: Radius.circular(40.0)),
                                                                      ),
                                                                      // color:
                                                                      //     Colors.black,
                                                                      width: (MediaQuery.of(context).size.width) / 10,
                                                                      height: (MediaQuery.of(context).orientation == Orientation.portrait) ? (MediaQuery.of(context).size.width) / 12 : (MediaQuery.of(context).size.width) / 15,
                                                                      child: Center(
                                                                          child: Text(
                                                                        "-",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              (MediaQuery.of(context).size.width) / 18,
                                                                        ),
                                                                      )))))),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                          height: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height) /
                                                              8,
                                                          //color: Colors.red,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.red,
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  '${basketList[index].amount}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          (MediaQuery.of(context).size.width) /
                                                                              18,
                                                                      fontFamily:
                                                                          "Arial"))))),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 10, 0),
                                                        child: GestureDetector(
                                                            onTap: () => {
                                                                  BlocProvider.of<
                                                                              ClientBasketBloc>(
                                                                          context)
                                                                      .add(AddToBasketEvent(
                                                                          token,
                                                                          basketList[index]
                                                                              .id))
                                                                },
                                                            child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              40.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              40.0)),
                                                                ),
                                                                width: (MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .width) /
                                                                    10,
                                                                height: (MediaQuery.of(context)
                                                                            .orientation ==
                                                                        Orientation
                                                                            .portrait)
                                                                    ? (MediaQuery.of(context)
                                                                            .size
                                                                            .width) /
                                                                        12
                                                                    : (MediaQuery.of(context)
                                                                            .size
                                                                            .width) /
                                                                        16,
                                                                child: Center(
                                                                    child: Text(
                                                                  "+",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          (MediaQuery.of(context).size.width) /
                                                                              18),
                                                                ))))),
                                                  )
                                                ]),
                                              ),
                                            )
                                          ])),
                                    )
                                  ],
                                )),
                          ),
              );
            }),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Container(
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height / 6
                      : MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color.fromARGB(239, 50, 50, 50)),
                      bottom:
                          BorderSide(color: Color.fromARGB(239, 50, 50, 50)))),
              child: Column(children: [
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? EdgeInsets.fromLTRB(10, 10, 0, 0)
                              : EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "Бонусы",
                            style: TextStyle(
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? 20
                                    : (MediaQuery.of(context).size.width) / 30,
                                fontFamily: "Times New Roman"),
                          ),
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: BlocProvider(
                            create: (context) => BonusesBloc(usedBonuses),
                            child: BlocBuilder<BonusesBloc, BonusesState>(
                                builder: (context, stateBonuses) {
                              if (stateBonuses is BonusesAppliedState) {
                                return Row(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        '-' +
                                            '${stateBonuses.userBonuses}}'
                                                ' бонусов',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Times New Roman"),
                                      )),
                                  Padding(
                                      padding: (MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait)
                                          ? EdgeInsets.fromLTRB(70, 0, 0, 0)
                                          : EdgeInsets.fromLTRB(280, 0, 0, 0),
                                      child: GestureDetector(
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  3
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  5,
                                          height: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  10
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  13,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Color.fromARGB(
                                                255, 197, 197, 197),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Отменить',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                        ),
                                        onTap: () => {
                                          BlocProvider.of<BonusesBloc>(context)
                                              .add(BonusesChange(
                                                  false,
                                                  user.bonuses,
                                                  state.basketPrice))
                                        },
                                      ))
                                ]);
                              }
                              if (stateBonuses is BonusesDeletedState) {
                                return Row(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        'Доступно: ' + '${user.bonuses}',
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait)
                                                ? 20
                                                : (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    30,
                                            fontFamily: "Times New Roman"),
                                      )),
                                  Padding(
                                      padding:
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait)
                                              ? EdgeInsets.fromLTRB(
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      4.2,
                                                  0,
                                                  0,
                                                  0)
                                              : EdgeInsets.fromLTRB(
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.9,
                                                  0,
                                                  0,
                                                  0),
                                      child: GestureDetector(
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  3
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  5,
                                          height: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  10
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  13,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Применить',
                                            style: TextStyle(
                                                fontFamily: "Times New Roman",
                                                color: Colors.black,
                                                fontSize: (MediaQuery.of(
                                                                context)
                                                            .orientation ==
                                                        Orientation.portrait)
                                                    ? (MediaQuery.of(context)
                                                            .size
                                                            .height) /
                                                        30
                                                    : (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        30),
                                          )),
                                        ),
                                        onTap: () => {
                                          BlocProvider.of<BonusesBloc>(context)
                                              .add(BonusesChange(
                                                  true,
                                                  user.bonuses,
                                                  state.basketPrice))
                                        },
                                      ))
                                ]);
                              }
                              if (stateBonuses is NoBonusesState) {
                                return Row(children: [
                                  Padding(
                                      padding:
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait)
                                              ? EdgeInsets.fromLTRB(8, 0, 0, 0)
                                              : EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        'Доступно: ' + '${user.bonuses}',
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait)
                                                ? 20
                                                : (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    30,
                                            fontFamily: "Times New Roman"),
                                      )),
                                  Padding(
                                      padding:
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait)
                                              ? EdgeInsets.fromLTRB(
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      4.2,
                                                  0,
                                                  0,
                                                  0)
                                              : EdgeInsets.fromLTRB(
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.9,
                                                  0,
                                                  0,
                                                  0),
                                      child: GestureDetector(
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  3
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  5,
                                          height: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  10
                                              : (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  13,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Нет бонусов',
                                            style: TextStyle(
                                                fontFamily: "Times New Roman",
                                                color: Color.fromARGB(
                                                    255, 255, 0, 0),
                                                fontSize: (MediaQuery.of(
                                                                context)
                                                            .orientation ==
                                                        Orientation.portrait)
                                                    ? (MediaQuery.of(context)
                                                            .size
                                                            .height) /
                                                        30
                                                    : (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        30),
                                          )),
                                        ),
                                        onTap: () => {
                                          // BlocProvider.of<BonusesBloc>(context)
                                          //     .add(BonusesChange(true, user.bonuses,state.basketPrice))
                                        },
                                      ))
                                ]);
                              }
                              return Container();
                            }))))
              ]),
            ))
      ],
    ));
  }
}
