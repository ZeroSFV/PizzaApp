import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_blocs.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_events.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_states.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_events.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_states.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';
import 'package:pizzer_mobile/repositories/basket_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/client_basket/client_basket_blocs.dart';
import 'package:pizzer_mobile/models/basket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizzer_mobile/blocs/delivery_info/delivery_info_bloc.dart';
import 'package:pizzer_mobile/blocs/delivery_info/delivery_info_events.dart';
import 'package:pizzer_mobile/blocs/delivery_info/delivery_info_states.dart';
import 'package:pizzer_mobile/blocs/payment_type/payment_type_bloc.dart';
import 'package:pizzer_mobile/blocs/payment_type/payment_type_events.dart';
import 'package:pizzer_mobile/blocs/payment_type/payment_type_states.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';

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
    int basketPrice = state.basketPrice;
    int givenBonuses = (basketPrice * 0.1).toInt();
    String? paymentType;
    String? change;
    int? bonusesUsed = BlocProvider.of<ClientBasketBloc>(context).usedBonuses;
    // if (usedBonuses == false) bonusesUsed = 0;
    // if (usedBonuses == true) {
    //   if (user.bonuses! <= basketPrice * 0.15) {
    //     bonusesUsed = user.bonuses as int;
    //   } else if (user.bonuses! > basketPrice * 0.15) {
    //     bonusesUsed = (basketPrice * 0.15).toInt();
    //     basketPrice = basketPrice - bonusesUsed;
    //   }
    // }
    return SingleChildScrollView(
        child: Column(children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: basketList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: (MediaQuery.of(context).orientation ==
                      Orientation.portrait)
                  ? Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Card(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                                            MediaQuery.of(context).size.width /
                                                13.5,
                                            MediaQuery.of(context).size.height /
                                                24,
                                            0,
                                            0)
                                        : EdgeInsets
                                            .fromLTRB(
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
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            Expanded(
                                                flex: 1,
                                                // padding: EdgeInsets.fromLTRB(
                                                //     12, 0, 1, 0),
                                                child: GestureDetector(
                                                    onTap: () =>
                                                        BlocProvider.of<ClientBasketBloc>(
                                                                context)
                                                            .add(DecreaseBasketEvent(
                                                                token,
                                                                basketList[index]
                                                                    .id)),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          40.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          40.0)),
                                                        ),
                                                        // color: Colors.black,
                                                        width:
                                                            (MediaQuery.of(context)
                                                                    .size
                                                                    .width) /
                                                                25,
                                                        height: (MediaQuery.of(context)
                                                                    .orientation ==
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
                                                              fontSize: 25),
                                                        ))))),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height) /
                                                            15,
                                                    //color: Colors.red,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            '${basketList[index].amount}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25,
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
                                                                  basketList[
                                                                          index]
                                                                      .id))
                                                        },
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          borderRadius:
                                                              BorderRadius.only(
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
                                                              fontSize: 25),
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
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Text(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height /
                                                          15)),
                                                  '${basketList[index].pizzaName}' +
                                                      ' ' +
                                                      '${basketList[index].sizeName}'))))),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 4,
                                        MediaQuery.of(context).size.height / 24,
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
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            Expanded(
                                                flex: 1,
                                                child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                    child: GestureDetector(
                                                        onTap: () => BlocProvider.of<ClientBasketBloc>(context).add(
                                                            DecreaseBasketEvent(
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
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          40.0)),
                                                            ),
                                                            // color:
                                                            //     Colors.black,
                                                            width: (MediaQuery.of(context)
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
                                                                : (MediaQuery.of(context).size.width) / 15,
                                                            child: Center(
                                                                child: Text(
                                                              "-",
                                                              style: TextStyle(
                                                                fontSize: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) /
                                                                    18,
                                                              ),
                                                            )))))),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height) /
                                                            8,
                                                    //color: Colors.red,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            '${basketList[index].amount}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) /
                                                                    18,
                                                                fontFamily:
                                                                    "Arial"))))),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                                  child: GestureDetector(
                                                      onTap: () => {
                                                            BlocProvider.of<
                                                                        ClientBasketBloc>(
                                                                    context)
                                                                .add(AddToBasketEvent(
                                                                    token,
                                                                    basketList[
                                                                            index]
                                                                        .id))
                                                          },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        40.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        40.0)),
                                                          ),
                                                          width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width) /
                                                              10,
                                                          height: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  12
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  16,
                                                          child: Center(
                                                              child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                fontSize: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) /
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
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
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
                                  ? (MediaQuery.of(context).size.height) / 30
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
                              // bonusesUsed = stateBonuses.userBonuses!.toInt();
                              // basketPrice =
                              //     basketPrice - bonusesUsed.toDouble();
                              return Row(children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                    child: Text(
                                      '-' +
                                          '${BlocProvider.of<ClientBasketBloc>(context).usedBonuses}'
                                              ' бонусов',
                                      style: TextStyle(
                                          fontSize: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                                  30
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
                                                    3.8,
                                                0,
                                                0,
                                                0)
                                            : EdgeInsets.fromLTRB(
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    1.8,
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
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: (MediaQuery.of(context)
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
                                        usedBonuses = false,
                                        BlocProvider.of<BonusesBloc>(context)
                                            .add(BonusesChange(
                                                false,
                                                user.bonuses,
                                                state.basketPrice)),
                                        // basketPrice += bonusesUsed,
                                        // bonusesUsed = 0
                                        BlocProvider.of<ClientBasketBloc>(
                                                context)
                                            .add(DisbandedBonusesEvent(
                                                basketList, user, basketPrice))
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
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                                  30
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
                                              fontSize: (MediaQuery.of(context)
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
                                        usedBonuses = true,
                                        BlocProvider.of<BonusesBloc>(context)
                                            .add(BonusesChange(
                                                true,
                                                user.bonuses,
                                                state.basketPrice)),
                                        BlocProvider.of<ClientBasketBloc>(
                                                context)
                                            .add(AppliedBonusesEvent(
                                                basketList, user, basketPrice)),

                                        // bonusesUsed =
                                        //     BlocProvider.of<BonusesBloc>(
                                        //             context)
                                        //         .bonuses!,
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
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                                  30
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
                                              fontSize: (MediaQuery.of(context)
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
          )),
      BlocProvider(
          create: (context) => DeliveryInfoBloc()..add(EmptyInfoEvent()),
          child: BlocBuilder<DeliveryInfoBloc, DeliveryInfoState>(
              builder: (context, stateInfo) {
            if (stateInfo is EmptyInfoState) {
              return Column(
                children: [
                  Container(
                    color: Color.fromARGB(255, 238, 238, 238),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                "Доставка",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 30
                                        : MediaQuery.of(context).size.width /
                                            25,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(AddressChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText: 'Адрес',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                  )))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                      onChanged: (value) =>
                                          BlocProvider.of<DeliveryInfoBloc>(
                                                  context)
                                              .add(FlatChangedEvent(value)),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman"),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          hintText: '№ квартиры / офиса',
                                          hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman")),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ])))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width) /
                                              2.20,
                                      child: TextField(
                                          onChanged: (value) => BlocProvider.of<
                                                  DeliveryInfoBloc>(context)
                                              .add(EntranceChangedEvent(value)),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Подъезд',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  fontFamily:
                                                      "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ]))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.width /
                                              30
                                          : MediaQuery.of(context).size.width /
                                              14),
                                  child: SizedBox(
                                      width: (MediaQuery.of(context).size.width) /
                                          2.20,
                                      child: TextField(
                                          onChanged: (value) => BlocProvider.of<DeliveryInfoBloc>(context)
                                              .add(FloorChangedEvent(value)),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Этаж',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(context).orientation == Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context).size.width / 30,
                                                  fontFamily: "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ]))),
                            ]),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                    maxLength: 12,
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(PhoneChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Times New Roman"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText: 'Номер телефона',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                    keyboardType: TextInputType.phone,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   MaskTextInputFormatter(
                                    //       mask: '+8 (9##) ###-##-##',
                                    //       filter: {"#": RegExp(r'[0-9]')},
                                    //       type: MaskAutoCompletionType.lazy),
                                    // ]
                                  )))),
                      // Center(
                      //     child: Padding(
                      //         padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      //         child: Container(
                      //             width: (MediaQuery.of(context).size.width),
                      //             height: (MediaQuery.of(context).orientation ==
                      //                     Orientation.portrait)
                      //                 ? (MediaQuery.of(context).size.width) / 12
                      //                 : (MediaQuery.of(context).size.width) /
                      //                     12,
                      //             decoration: BoxDecoration(
                      //               //color: Color.fromARGB(200, 210, 210, 210),
                      //               border: Border.all(
                      //                 color: Color.fromARGB(199, 118, 118, 118),
                      //               ),
                      //               borderRadius: BorderRadius.only(
                      //                   topRight: Radius.circular(40.0),
                      //                   bottomRight: Radius.circular(40.0),
                      //                   topLeft: Radius.circular(40.0),
                      //                   bottomLeft: Radius.circular(40.0)),
                      //             ),
                      //             child: Row(children: [
                      //               Container(
                      //                 width:
                      //                     (MediaQuery.of(context).size.width) /
                      //                         2,
                      //                 height:
                      //                     (MediaQuery.of(context).size.width) /
                      //                         8,
                      //                 decoration: BoxDecoration(
                      //                   color: Color.fromARGB(255, 255, 32, 16),

                      //                   /// border: Border.all(color: Colors.black),
                      //                   borderRadius: BorderRadius.only(
                      //                       topRight: Radius.circular(40.0),
                      //                       bottomRight: Radius.circular(40.0),
                      //                       topLeft: Radius.circular(40.0),
                      //                       bottomLeft: Radius.circular(40.0)),
                      //                 ),
                      //                 child: Center(
                      //                     child: Text(
                      //                   "Как можно быстрее",
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: (MediaQuery.of(context)
                      //                                   .orientation ==
                      //                               Orientation.portrait)
                      //                           ? (MediaQuery.of(context)
                      //                                   .size
                      //                                   .width) /
                      //                               30
                      //                           : (MediaQuery.of(context)
                      //                                   .size
                      //                                   .width) /
                      //                               50),
                      //                 )),
                      //               ),
                      //               GestureDetector(
                      //                   onTap: () => {
                      //                         // BlocProvider.of<PizzaCatalogueBloc>(context)
                      //                         //     .add(LoadChosenMediumPizzaEvent(
                      //                         //         bigPizza.name))
                      //                       },
                      //                   child: Container(
                      //                       width: (MediaQuery.of(context)
                      //                               .size
                      //                               .width) /
                      //                           2.28,
                      //                       height: (MediaQuery.of(context)
                      //                               .size
                      //                               .width) /
                      //                           8,
                      //                       decoration: BoxDecoration(
                      //                         color: Color.fromARGB(
                      //                             255, 238, 238, 238),
                      //                         //color: Colors.black,
                      //                         borderRadius: BorderRadius.only(
                      //                             topRight:
                      //                                 Radius.circular(40.0),
                      //                             bottomRight:
                      //                                 Radius.circular(40.0)),
                      //                       ),
                      //                       child: Center(
                      //                           child: Text(
                      //                         "Ко времени",
                      //                         style: TextStyle(
                      //                             color: Color.fromARGB(
                      //                                 255, 162, 162, 162),
                      //                             fontSize: (MediaQuery.of(
                      //                                             context)
                      //                                         .orientation ==
                      //                                     Orientation.portrait)
                      //                                 ? (MediaQuery.of(context)
                      //                                         .size
                      //                                         .width) /
                      //                                     30
                      //                                 : (MediaQuery.of(context)
                      //                                         .size
                      //                                         .width) /
                      //                                     50),
                      //                       ))))
                      //             ])))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  height:
                                      (MediaQuery.of(context).size.width) / 4,
                                  child: TextField(
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(CommentChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    maxLines:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 5
                                            : 6,
                                    maxLength: 256,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText:
                                            'Комментарий курьеру или работнику...',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                  )))),
                    ]),
                  ),
                  BlocProvider(
                      create: (context) =>
                          PaymentTypeBloc()..add(CashChosenEvent()),
                      child: BlocBuilder<PaymentTypeBloc, PaymentTypeState>(
                          builder: (context, statePayment) {
                        if (statePayment is CashPaymentState) {
                          paymentType = "Наличными";
                          change = statePayment.change;
                          return Container(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                        "Оплата",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                            fontWeight: FontWeight.w800),
                                      ))),
                              Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width),
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
                                            //color: Color.fromARGB(200, 210, 210, 210),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  199, 118, 118, 118),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            Container(
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  2,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 32, 16),

                                                /// border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Наличными",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            30
                                                        : (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            50),
                                              )),
                                            ),
                                            GestureDetector(
                                                onTap: () => {
                                                      paymentType = "Картой",
                                                      change = "",
                                                      BlocProvider.of<
                                                                  PaymentTypeBloc>(
                                                              context)
                                                          .add(
                                                              CardChosenEvent())
                                                    },
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2.28,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            8,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 251, 251, 251),
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      40.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      40.0)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Картой",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                          fontSize: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  30
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  50),
                                                    ))))
                                          ])))),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width),
                                      child: TextField(
                                          onChanged: (value) => {
                                                BlocProvider.of<
                                                            PaymentTypeBloc>(
                                                        context)
                                                    .add(ChangeChangedEvent(
                                                        value)),
                                                change = value
                                              },
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Нужна сдача: 0 Р',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  fontFamily:
                                                      "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ])))
                            ],
                          ));
                        }
                        if (statePayment is CardPaymentState) {
                          paymentType = "Картой";
                          change = "";
                          return Container(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                        "Оплата",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                            fontWeight: FontWeight.w800),
                                      ))),
                              Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width),
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
                                            //color: Color.fromARGB(200, 210, 210, 210),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  199, 118, 118, 118),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            GestureDetector(
                                                onTap: () => {
                                                      BlocProvider.of<
                                                                  PaymentTypeBloc>(
                                                              context)
                                                          .add(
                                                              CashChosenEvent())
                                                    },
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2.28,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            8,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 251, 251, 251),
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      40.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      40.0)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Наличными",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                          fontSize: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  30
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  50),
                                                    )))),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait)
                                                  ? (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.99
                                                  : (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.8475,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 32, 16),

                                                /// border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Картой",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            30
                                                        : (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            50),
                                              )),
                                            ),
                                          ])))),
                            ],
                          ));
                        }
                        return Container();
                      })),
                  Row(
                    children: [
                      Expanded(
                          flex: 7,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Бонусов за заказ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 20
                                        : MediaQuery.of(context).size.width /
                                            30),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${givenBonuses}',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 20
                                      : MediaQuery.of(context).size.width / 30,
                                  color: Colors.red)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "К оплате",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 25
                                        : MediaQuery.of(context).size.width /
                                            28,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${basketPrice}',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 25
                                      : MediaQuery.of(context).size.width / 28,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: GestureDetector(
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 1
                              : (MediaQuery.of(context).size.width) / 1,
                          height: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 15
                              : (MediaQuery.of(context).size.width) / 13,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 0, 0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)),
                          ),
                          child: Center(
                              child: Text(
                            'Оформить заказ >',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30),
                          )),
                        ),
                        onTap: () => {},
                      ))
                ],
              );
            }
            if (stateInfo is FilledInfoState) {
              return Column(
                children: [
                  Container(
                    color: Color.fromARGB(255, 238, 238, 238),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                "Доставка",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 30
                                        : MediaQuery.of(context).size.width /
                                            25,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                    // controller: TextEditingController(
                                    //     text: stateInfo.address),
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(AddressChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText: 'Адрес',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                  )))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                      // controller: TextEditingController(
                                      //     text: stateInfo.flat),
                                      onChanged: (value) =>
                                          BlocProvider.of<DeliveryInfoBloc>(
                                                  context)
                                              .add(FlatChangedEvent(value)),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman"),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          hintText: '№ квартиры / офиса',
                                          hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman")),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ])))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width) /
                                              2.20,
                                      child: TextField(
                                          // controller: TextEditingController(
                                          //     text: stateInfo.entrance),
                                          onChanged: (value) => BlocProvider.of<
                                                  DeliveryInfoBloc>(context)
                                              .add(EntranceChangedEvent(value)),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Подъезд',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  fontFamily:
                                                      "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ]))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width /
                                              30
                                          : MediaQuery.of(context).size.width /
                                              14),
                                  child: SizedBox(
                                      width: (MediaQuery.of(context).size.width) /
                                          2.20,
                                      child: TextField(
                                          // controller: TextEditingController(
                                          //     text: stateInfo.floor),
                                          onChanged: (value) => BlocProvider.of<DeliveryInfoBloc>(context)
                                              .add(FloorChangedEvent(value)),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context).size.width / 30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Этаж',
                                              hintStyle: TextStyle(fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? 20 : MediaQuery.of(context).size.width / 30, fontFamily: "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ]))),
                            ]),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                    // controller: TextEditingController(
                                    //     text: stateInfo.phone),
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(PhoneChangedEvent(value)),
                                    maxLength: 11,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText: 'Номер телефона',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                    keyboardType: TextInputType.phone,
                                  )))),
                      // Center(
                      //     child: Padding(
                      //         padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      //         child: Container(
                      //             width: (MediaQuery.of(context).size.width),
                      //             height: (MediaQuery.of(context).orientation ==
                      //                     Orientation.portrait)
                      //                 ? (MediaQuery.of(context).size.width) / 12
                      //                 : (MediaQuery.of(context).size.width) /
                      //                     12,
                      //             decoration: BoxDecoration(
                      //               //color: Color.fromARGB(200, 210, 210, 210),
                      //               border: Border.all(
                      //                 color: Color.fromARGB(199, 118, 118, 118),
                      //               ),
                      //               borderRadius: BorderRadius.only(
                      //                   topRight: Radius.circular(40.0),
                      //                   bottomRight: Radius.circular(40.0),
                      //                   topLeft: Radius.circular(40.0),
                      //                   bottomLeft: Radius.circular(40.0)),
                      //             ),
                      //             child: Row(children: [
                      //               Container(
                      //                 width:
                      //                     (MediaQuery.of(context).size.width) /
                      //                         2,
                      //                 height:
                      //                     (MediaQuery.of(context).size.width) /
                      //                         8,
                      //                 decoration: BoxDecoration(
                      //                   color: Color.fromARGB(255, 255, 32, 16),

                      //                   /// border: Border.all(color: Colors.black),
                      //                   borderRadius: BorderRadius.only(
                      //                       topRight: Radius.circular(40.0),
                      //                       bottomRight: Radius.circular(40.0),
                      //                       topLeft: Radius.circular(40.0),
                      //                       bottomLeft: Radius.circular(40.0)),
                      //                 ),
                      //                 child: Center(
                      //                     child: Text(
                      //                   "Как можно быстрее",
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: (MediaQuery.of(context)
                      //                                   .orientation ==
                      //                               Orientation.portrait)
                      //                           ? (MediaQuery.of(context)
                      //                                   .size
                      //                                   .width) /
                      //                               30
                      //                           : (MediaQuery.of(context)
                      //                                   .size
                      //                                   .width) /
                      //                               50),
                      //                 )),
                      //               ),
                      //               GestureDetector(
                      //                   onTap: () => {
                      //                         // BlocProvider.of<PizzaCatalogueBloc>(context)
                      //                         //     .add(LoadChosenMediumPizzaEvent(
                      //                         //         bigPizza.name))
                      //                       },
                      //                   child: Container(
                      //                       width: (MediaQuery.of(context)
                      //                               .size
                      //                               .width) /
                      //                           2.28,
                      //                       height: (MediaQuery.of(context)
                      //                               .size
                      //                               .width) /
                      //                           8,
                      //                       decoration: BoxDecoration(
                      //                         color: Color.fromARGB(
                      //                             255, 238, 238, 238),
                      //                         //color: Colors.black,
                      //                         borderRadius: BorderRadius.only(
                      //                             topRight:
                      //                                 Radius.circular(40.0),
                      //                             bottomRight:
                      //                                 Radius.circular(40.0)),
                      //                       ),
                      //                       child: Center(
                      //                           child: Text(
                      //                         "Ко времени",
                      //                         style: TextStyle(
                      //                             color: Color.fromARGB(
                      //                                 255, 162, 162, 162),
                      //                             fontSize: (MediaQuery.of(
                      //                                             context)
                      //                                         .orientation ==
                      //                                     Orientation.portrait)
                      //                                 ? (MediaQuery.of(context)
                      //                                         .size
                      //                                         .width) /
                      //                                     30
                      //                                 : (MediaQuery.of(context)
                      //                                         .size
                      //                                         .width) /
                      //                                     50),
                      //                       ))))
                      //             ])))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  height:
                                      (MediaQuery.of(context).size.width) / 4,
                                  child: TextField(
                                    // controller: TextEditingController(
                                    //     text: stateInfo.comment),
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(CommentChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    maxLines:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 5
                                            : 6,
                                    maxLength: 256,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText:
                                            'Комментарий курьеру или работнику...',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                  )))),
                    ]),
                  ),
                  BlocProvider(
                      create: (context) =>
                          PaymentTypeBloc()..add(CashChosenEvent()),
                      child: BlocBuilder<PaymentTypeBloc, PaymentTypeState>(
                          builder: (context, statePayment) {
                        if (statePayment is CashPaymentState) {
                          paymentType = "Наличными";
                          change = statePayment.change;
                          return Container(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                        "Оплата",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                            fontWeight: FontWeight.w800),
                                      ))),
                              Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width),
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
                                            //color: Color.fromARGB(200, 210, 210, 210),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  199, 118, 118, 118),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            Container(
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  2,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 32, 16),

                                                /// border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Наличными",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            30
                                                        : (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            50),
                                              )),
                                            ),
                                            GestureDetector(
                                                onTap: () => {
                                                      paymentType = "Картой",
                                                      change = "",
                                                      BlocProvider.of<
                                                                  PaymentTypeBloc>(
                                                              context)
                                                          .add(
                                                              CardChosenEvent())
                                                    },
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2.28,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            8,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 251, 251, 251),
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      40.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      40.0)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Картой",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                          fontSize: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  30
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  50),
                                                    ))))
                                          ])))),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width),
                                      child: TextField(
                                          onChanged: (value) => {
                                                BlocProvider.of<
                                                            PaymentTypeBloc>(
                                                        context)
                                                    .add(ChangeChangedEvent(
                                                        value)),
                                                change = value
                                              },
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Нужна сдача: 0 Р',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  fontFamily:
                                                      "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ])))
                            ],
                          ));
                        }
                        if (statePayment is CardPaymentState) {
                          paymentType = "Картой";
                          change = "";
                          return Container(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                        "Оплата",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                            fontWeight: FontWeight.w800),
                                      ))),
                              Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width),
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
                                            //color: Color.fromARGB(200, 210, 210, 210),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  199, 118, 118, 118),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            GestureDetector(
                                                onTap: () => {
                                                      BlocProvider.of<
                                                                  PaymentTypeBloc>(
                                                              context)
                                                          .add(
                                                              CashChosenEvent())
                                                    },
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2.28,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            8,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 251, 251, 251),
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      40.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      40.0)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Наличными",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                          fontSize: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  30
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  50),
                                                    )))),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait)
                                                  ? (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.99
                                                  : (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.8475,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 32, 16),

                                                /// border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Картой",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            30
                                                        : (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            50),
                                              )),
                                            ),
                                          ])))),
                            ],
                          ));
                        }
                        return Container();
                      })),
                  Row(
                    children: [
                      Expanded(
                          flex: 7,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Бонусов за заказ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 20
                                        : MediaQuery.of(context).size.width /
                                            30),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${givenBonuses}',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 20
                                      : MediaQuery.of(context).size.width / 30,
                                  color: Colors.red)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "К оплате",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 25
                                        : MediaQuery.of(context).size.width /
                                            28,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${basketPrice}',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 25
                                      : MediaQuery.of(context).size.width / 28,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: GestureDetector(
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 1
                              : (MediaQuery.of(context).size.width) / 1,
                          height: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 15
                              : (MediaQuery.of(context).size.width) / 13,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 112, 112, 112),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)),
                          ),
                          child: Center(
                              child: Text(
                            'Оформить заказ >',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30),
                          )),
                        ),
                        onTap: () => {},
                      ))
                ],
              );
            }
            if (stateInfo is FilledAllState) {
              return Column(
                children: [
                  Container(
                    color: Color.fromARGB(255, 238, 238, 238),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                "Доставка",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 30
                                        : MediaQuery.of(context).size.width /
                                            25,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                    // controller: TextEditingController(
                                    //     text: stateInfo.address),
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(AddressChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText: 'Адрес',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                  )))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                      // controller: TextEditingController(
                                      //     text: stateInfo.flat),
                                      onChanged: (value) =>
                                          BlocProvider.of<DeliveryInfoBloc>(
                                                  context)
                                              .add(FlatChangedEvent(value)),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman"),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          hintText: '№ квартиры / офиса',
                                          hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman")),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ])))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width) /
                                              2.20,
                                      child: TextField(
                                          // controller: TextEditingController(
                                          //     text: stateInfo.entrance),
                                          onChanged: (value) => BlocProvider.of<
                                                  DeliveryInfoBloc>(context)
                                              .add(EntranceChangedEvent(value)),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Подъезд',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  fontFamily:
                                                      "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ]))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width /
                                              30
                                          : MediaQuery.of(context).size.width /
                                              14),
                                  child: SizedBox(
                                      width: (MediaQuery.of(context).size.width) /
                                          2.20,
                                      child: TextField(
                                          // controller: TextEditingController(
                                          //     text: stateInfo.floor),
                                          onChanged: (value) => BlocProvider.of<DeliveryInfoBloc>(context)
                                              .add(FloorChangedEvent(value)),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context).size.width / 30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Этаж',
                                              hintStyle: TextStyle(fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? 20 : MediaQuery.of(context).size.width / 30, fontFamily: "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ]))),
                            ]),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  child: TextField(
                                    maxLength: 11,
                                    // controller: TextEditingController(
                                    //     text: stateInfo.phone),
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(PhoneChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText: 'Номер телефона',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                    keyboardType: TextInputType.phone,
                                    //inputFormatters: <TextInputFormatter>[
                                    //   MaskTextInputFormatter(
                                    //       mask: '+8 (9##) ###-##-##',
                                    //       filter: {"#": RegExp(r'[0-9]')},
                                    //       type: MaskAutoCompletionType.lazy),
                                    // ]
                                  )))),
                      // Center(
                      //     child: Padding(
                      //         padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      //         child: Container(
                      //             width: (MediaQuery.of(context).size.width),
                      //             height: (MediaQuery.of(context).orientation ==
                      //                     Orientation.portrait)
                      //                 ? (MediaQuery.of(context).size.width) / 12
                      //                 : (MediaQuery.of(context).size.width) /
                      //                     12,
                      //             decoration: BoxDecoration(
                      //               //color: Color.fromARGB(200, 210, 210, 210),
                      //               border: Border.all(
                      //                 color: Color.fromARGB(199, 118, 118, 118),
                      //               ),
                      //               borderRadius: BorderRadius.only(
                      //                   topRight: Radius.circular(40.0),
                      //                   bottomRight: Radius.circular(40.0),
                      //                   topLeft: Radius.circular(40.0),
                      //                   bottomLeft: Radius.circular(40.0)),
                      //             ),
                      //             child: Row(children: [
                      //               Container(
                      //                 width:
                      //                     (MediaQuery.of(context).size.width) /
                      //                         2,
                      //                 height:
                      //                     (MediaQuery.of(context).size.width) /
                      //                         8,
                      //                 decoration: BoxDecoration(
                      //                   color: Color.fromARGB(255, 255, 32, 16),

                      //                   /// border: Border.all(color: Colors.black),
                      //                   borderRadius: BorderRadius.only(
                      //                       topRight: Radius.circular(40.0),
                      //                       bottomRight: Radius.circular(40.0),
                      //                       topLeft: Radius.circular(40.0),
                      //                       bottomLeft: Radius.circular(40.0)),
                      //                 ),
                      //                 child: Center(
                      //                     child: Text(
                      //                   "Как можно быстрее",
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: (MediaQuery.of(context)
                      //                                   .orientation ==
                      //                               Orientation.portrait)
                      //                           ? (MediaQuery.of(context)
                      //                                   .size
                      //                                   .width) /
                      //                               30
                      //                           : (MediaQuery.of(context)
                      //                                   .size
                      //                                   .width) /
                      //                               50),
                      //                 )),
                      //               ),
                      //               GestureDetector(
                      //                   onTap: () => {
                      //                         // BlocProvider.of<PizzaCatalogueBloc>(context)
                      //                         //     .add(LoadChosenMediumPizzaEvent(
                      //                         //         bigPizza.name))
                      //                       },
                      //                   child: Container(
                      //                       width: (MediaQuery.of(context)
                      //                               .size
                      //                               .width) /
                      //                           2.28,
                      //                       height: (MediaQuery.of(context)
                      //                               .size
                      //                               .width) /
                      //                           8,
                      //                       decoration: BoxDecoration(
                      //                         color: Color.fromARGB(
                      //                             255, 238, 238, 238),
                      //                         //color: Colors.black,
                      //                         borderRadius: BorderRadius.only(
                      //                             topRight:
                      //                                 Radius.circular(40.0),
                      //                             bottomRight:
                      //                                 Radius.circular(40.0)),
                      //                       ),
                      //                       child: Center(
                      //                           child: Text(
                      //                         "Ко времени",
                      //                         style: TextStyle(
                      //                             color: Color.fromARGB(
                      //                                 255, 162, 162, 162),
                      //                             fontSize: (MediaQuery.of(
                      //                                             context)
                      //                                         .orientation ==
                      //                                     Orientation.portrait)
                      //                                 ? (MediaQuery.of(context)
                      //                                         .size
                      //                                         .width) /
                      //                                     30
                      //                                 : (MediaQuery.of(context)
                      //                                         .size
                      //                                         .width) /
                      //                                     50),
                      //                       ))))
                      //             ])))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  width: (MediaQuery.of(context).size.width),
                                  height:
                                      (MediaQuery.of(context).size.width) / 4,
                                  child: TextField(
                                    // controller: TextEditingController(
                                    //     text: stateInfo.comment),
                                    onChanged: (value) =>
                                        BlocProvider.of<DeliveryInfoBloc>(
                                                context)
                                            .add(CommentChangedEvent(value)),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? 20
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                        fontFamily: "Times New Roman"),
                                    maxLines:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 5
                                            : 6,
                                    maxLength: 256,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft:
                                                  Radius.circular(40.0)),
                                        ),
                                        hintText:
                                            'Комментарий курьеру или работнику...',
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman")),
                                  )))),
                    ]),
                  ),
                  BlocProvider(
                      create: (context) =>
                          PaymentTypeBloc()..add(CashChosenEvent()),
                      child: BlocBuilder<PaymentTypeBloc, PaymentTypeState>(
                          builder: (context, statePayment) {
                        if (statePayment is CashPaymentState) {
                          paymentType = "Наличными";
                          change = statePayment.change;
                          return Container(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                        "Оплата",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                            fontWeight: FontWeight.w800),
                                      ))),
                              Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width),
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
                                            //color: Color.fromARGB(200, 210, 210, 210),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  199, 118, 118, 118),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            Container(
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  2,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 32, 16),

                                                /// border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Наличными",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            30
                                                        : (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            50),
                                              )),
                                            ),
                                            GestureDetector(
                                                onTap: () => {
                                                      paymentType = "Картой",
                                                      change = "",
                                                      BlocProvider.of<
                                                                  PaymentTypeBloc>(
                                                              context)
                                                          .add(
                                                              CardChosenEvent()),
                                                      change = "0",
                                                    },
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2.28,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            8,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 251, 251, 251),
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      40.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      40.0)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Картой",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                          fontSize: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  30
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  50),
                                                    ))))
                                          ])))),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width),
                                      child: TextField(
                                          onChanged: (value) => {
                                                BlocProvider.of<
                                                            PaymentTypeBloc>(
                                                        context)
                                                    .add(ChangeChangedEvent(
                                                        value)),
                                                change = value
                                              },
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                              fontFamily: "Times New Roman"),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              hintText: 'Нужна сдача: 0 Р',
                                              hintStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? 20
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  fontFamily:
                                                      "Times New Roman")),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ])))
                            ],
                          ));
                        }
                        if (statePayment is CardPaymentState) {
                          paymentType = "Картой";
                          change = "";
                          return Container(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                        "Оплата",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                            fontWeight: FontWeight.w800),
                                      ))),
                              Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Container(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width),
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
                                            //color: Color.fromARGB(200, 210, 210, 210),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  199, 118, 118, 118),
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0)),
                                          ),
                                          child: Row(children: [
                                            GestureDetector(
                                                onTap: () => {
                                                      BlocProvider.of<
                                                                  PaymentTypeBloc>(
                                                              context)
                                                          .add(
                                                              CashChosenEvent()),
                                                      paymentType = "Наличными"
                                                    },
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2.28,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            8,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 251, 251, 251),
                                                      //color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      40.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      40.0)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Наличными",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                          fontSize: (MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .portrait)
                                                              ? (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  30
                                                              : (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) /
                                                                  50),
                                                    )))),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait)
                                                  ? (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.99
                                                  : (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      1.8475,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 32, 16),

                                                /// border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Картой",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            30
                                                        : (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            50),
                                              )),
                                            ),
                                          ])))),
                            ],
                          ));
                        }
                        return Container();
                      })),
                  Row(
                    children: [
                      Expanded(
                          flex: 7,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Бонусов за заказ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 20
                                        : MediaQuery.of(context).size.width /
                                            30),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${givenBonuses}',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 20
                                      : MediaQuery.of(context).size.width / 30,
                                  color: Colors.red)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "К оплате",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 25
                                        : MediaQuery.of(context).size.width /
                                            28,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${basketPrice}',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 25
                                      : MediaQuery.of(context).size.width / 28,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: GestureDetector(
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 1
                              : (MediaQuery.of(context).size.width) / 1,
                          height: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 15
                              : (MediaQuery.of(context).size.width) / 13,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 9, 203, 25),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)),
                          ),
                          child: Center(
                              child: Text(
                            'Оформить заказ >',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30),
                          )),
                        ),
                        onTap: () => {
                          BlocProvider.of<AppBloc>(context).add(
                              ClientCreatedOrderEvent(
                                  token.toString(),
                                  stateInfo.address.toString() +
                                      ", кв. " +
                                      stateInfo.flat.toString() +
                                      ", подъезд " +
                                      stateInfo.entrance.toString() +
                                      ", этаж " +
                                      stateInfo.floor.toString(),
                                  stateInfo.phone.toString(),
                                  paymentType.toString(),
                                  change,
                                  bonusesUsed,
                                  givenBonuses,
                                  stateInfo.comment))
                        },
                      ))
                ],
              );
            }
            return Container();
          }))
    ]));
  }
}
