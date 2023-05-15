import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/courier_orders/courier_orders_bloc.dart';
import 'package:pizzer_mobile/blocs/courier_orders/courier_orders_states.dart';
import 'package:pizzer_mobile/blocs/courier_orders/courier_orders_events.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:flutter/material.dart';

class CourierOrdersPage extends StatelessWidget {
  String? token;
  CourierOrdersPage({super.key, this.token});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CourierOrdersBloc>(
          create: (BuildContext context) =>
              CourierOrdersBloc(OrderRepository(), UserInfoRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          CourierOrdersBloc(OrderRepository(), UserInfoRepository())
            ..add(LoadCourierOrderEvent(token)),
      child: BlocBuilder<CourierOrdersBloc, CourierOrdersState>(
        builder: (context, state) {
          if (state is CourierOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is CourierOrdersLoadedState) {
            return courierOrdersLoaded(context, state);
          }
          if (state is ChosenOrderLoadedState) {
            return chosenOrderLoaded(context, state);
          }
          if (state is CourierNoOrdersState) {
            return courierNoOrder(context, state);
          }
          if (state is CourierOrdersErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget courierOrdersLoaded(context, state) {
    List<OrderModel> orderList = state.orders;
    return ListView.builder(
      shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      itemCount: orderList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: GestureDetector(
            onTap: () => BlocProvider.of<CourierOrdersBloc>(context)
                .add(LoadChosenOrderEvent(token, orderList[index].id)),
            child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height / 4
                        : MediaQuery.of(context).size.height / 2.5,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Container(
                                      child: Text("Дата заказа",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman",
                                          ))))),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Container(
                                      child: Text(
                                          '${orderList[index].creationTime.toString().substring(0, 10)}',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                            fontFamily: "Times New Roman",
                                          ),
                                          textAlign: TextAlign.right))))
                        ],
                      ),
                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Container(
                                    child: Text("Сумма заказа",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman",
                                        ),
                                        textAlign: TextAlign.left)))),
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Container(
                                    child: Text('${orderList[index].price} Р',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman",
                                        ),
                                        textAlign: TextAlign.right))))
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Container(
                                    child: Text("Адрес доставки",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman",
                                        ),
                                        textAlign: TextAlign.left)))),
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Container(
                                    child: Text(
                                        '${orderList[index].streetAddress}',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                          fontFamily: "Times New Roman",
                                        ),
                                        textAlign: TextAlign.right))))
                      ]),
                      Expanded(
                          child: Row(children: [
                        Expanded(
                            child: Padding(
                                padding: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (EdgeInsets.fromLTRB(
                                        10,
                                        20,
                                        (MediaQuery.of(context).size.width /
                                            10),
                                        10))
                                    : (EdgeInsets.fromLTRB(
                                        10,
                                        20,
                                        MediaQuery.of(context).size.width / 10,
                                        10)),
                                child: GestureDetector(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15.0),
                                              bottomRight:
                                                  Radius.circular(15.0),
                                              topLeft: Radius.circular(15.0),
                                              bottomLeft:
                                                  Radius.circular(15.0)),
                                        ),
                                        child: Text(
                                          'Подробности',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: (MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait)
                                                  ? (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      28)
                                                  : (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      40)),
                                        )),
                                    onTap: () => {
                                          BlocProvider.of<CourierOrdersBloc>(
                                                  context)
                                              .add(LoadChosenOrderEvent(
                                                  token, orderList[index].id))
                                        }))),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        )
                      ]))
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget chosenOrderLoaded(context, state) {
    OrderModel order = state.singleOrder;
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<CourierOrdersBloc>(context)
              .add(LoadCourierOrderEvent(token));
          return Future.value(false);
        },
        child: SingleChildScrollView(
            child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: order.orderLines!.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Card(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
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
                                                  '${order.orderLines![index].pizzaName}' +
                                                      ' ' +
                                                      '${order.orderLines![index].sizeName}'))))),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height:
                                      (MediaQuery.of(context).size.height) / 15,
                                  //color: Colors.red,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          '${order.orderLines![index].count}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: "Arial"))),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    '${order.orderLines![index].pizzaPrice * order.orderLines![index].count} Р',
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
                                  ),
                                ),
                              )
                            ],
                          )),
                    ));
              }),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                            child: Text(
                              "Номер заказа:",
                              style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ))),
                    Expanded(
                        flex: 2,
                        child: Text('${order.id}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(
                                  255,
                                  0,
                                  0,
                                  0,
                                ))))
                  ]),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                            child: Text(
                              "Статус заказа:",
                              style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ))),
                    Expanded(
                        flex: 2,
                        child: Text('${order.statusName}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(
                                  255,
                                  0,
                                  0,
                                  0,
                                ))))
                  ]),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Время создания:",
                                style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800,
                                ),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text(
                              '${order.creationTime.toString().substring(0, 19)}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(
                                    255,
                                    0,
                                    0,
                                    0,
                                  ))))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Должен был быть доставлен до:",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text(
                              '${order.predictedTime.toString().substring(0, 19)}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Доставлен/отменён в:",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 1,
                          child: (order.finishedTime == null)
                              ? Text('',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? 18
                                          : MediaQuery.of(context).size.width /
                                              35,
                                      fontWeight: FontWeight.w800))
                              : Text('${order.finishedTime.toString().substring(0, 19)}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? 18
                                          : MediaQuery.of(context).size.width /
                                              35,
                                      fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Доставил:",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 1,
                          child: (order.finishedTime == null)
                              ? Text('',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? 18
                                          : MediaQuery.of(context).size.width /
                                              35,
                                      fontWeight: FontWeight.w800))
                              : Text('${order.courierName}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? 18
                                          : MediaQuery.of(context).size.width /
                                              35,
                                      fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Общая стоимость заказа: ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text('${order.price}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Тип оплаты: ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text('${order.payingType}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Сдача: ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text('${order.change}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Точный адрес: ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text('${order.address}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Указанный телефон: ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text('${order.phoneNumber}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Общая стоимость заказа:",
                                style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800,
                                ),
                              ))),
                      Expanded(
                          flex: 2,
                          child: Text('${order.price!.toInt()} Р',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait
                                      ? 18
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(
                                    255,
                                    0,
                                    0,
                                    0,
                                  ))))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Text(
                                "Комментарий курьеру/работнику: ",
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? 18
                                        : MediaQuery.of(context).size.width /
                                            35,
                                    fontWeight: FontWeight.w800),
                              ))),
                      Expanded(
                          flex: 2,
                          child: (order.comment != null)
                              ? Text('${order.comment}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? 18
                                          : MediaQuery.of(context).size.width /
                                              35,
                                      fontWeight: FontWeight.w800))
                              : Text('',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? 18
                                          : MediaQuery.of(context).size.width /
                                              35,
                                      fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Center(
                      child: Padding(
                          padding: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (EdgeInsets.fromLTRB(0, 20, 0, 10))
                              : (EdgeInsets.fromLTRB(0, 20, 0, 10)),
                          child: GestureDetector(
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0),
                                        bottomLeft: Radius.circular(15.0)),
                                  ),
                                  child: Text(
                                    'Вернуться к истории заказов',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: (MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait)
                                            ? (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                28)
                                            : (MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40)),
                                  )),
                              onTap: () => {
                                    BlocProvider.of<CourierOrdersBloc>(context)
                                        .add(LoadCourierOrderEvent(token))
                                  })))
                ],
              ))
        ])));
  }

  Widget courierNoOrder(context, state) {
    return SingleChildScrollView(
        child: Center(
            child: Column(children: [
      Text("Заказов нет",
          style: TextStyle(
              color: Color.fromARGB(240, 117, 117, 117),
              fontSize:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height / 20
                      : MediaQuery.of(context).size.width / 20)),
      Text("Примите заказы и они отобразятся в этом окне",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height / 38
                      : MediaQuery.of(context).size.width / 38))
    ])));
  }
}
