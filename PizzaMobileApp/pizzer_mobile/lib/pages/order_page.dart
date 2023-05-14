import 'package:pizzer_mobile/models/user_info_model.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/pizza_catalogue_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/client_order/client_order_bloc.dart';
import 'package:pizzer_mobile/blocs/client_order/client_order_states.dart';
import 'package:pizzer_mobile/blocs/client_order/client_order_events.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/order_lines_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_states.dart';

class OrderPage extends StatelessWidget {
  //Timer? timer;
  String? token;
  OrderPage({super.key, this.token});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClientOrderBloc>(
          create: (BuildContext context) =>
              ClientOrderBloc(OrderRepository(), UserInfoRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          ClientOrderBloc(OrderRepository(), UserInfoRepository())
            ..add(LoadClientOrderEvent(token)),
      child: BlocBuilder<ClientOrderBloc, ClientOrderState>(
        builder: (context, state) {
          if (state is ClientOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is ClientOrderLoadedState) {
            return orderLoaded(context, state);
          }
          if (state is ClientOrderErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is ClientOrderFinishedState) {
            return Padding(
                padding: EdgeInsets.fromLTRB(
                    10,
                    MediaQuery.of(context).size.height / 4,
                    10,
                    MediaQuery.of(context).size.height / 4),
                child: Center(
                    child: Column(children: [
                  Text(
                      "Ваш заказ доставлен. Нажмите ОК, чтобы вернуться к созданию заказов",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? MediaQuery.of(context).size.width / 16
                            : MediaQuery.of(context).size.width / 24,
                      )),
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
                          'ОК',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 30),
                        )),
                      ),
                      onTap: () => {
                            BlocProvider.of<AppBloc>(context)
                                .add(ClientReturnedToOrderingEvent(state.token))
                          })
                ])));
          }
          if (state is ClientOrderCancelledState) {
            BlocProvider.of<AppBloc>(context)
                .add(ClientReturnedToOrderingEvent(token));
          }
          return Container();
        },
      ),
    );
  }

  Widget orderLoaded(context, state) {
    OrderModel order = state.order;
    UserInfoModel user = state.user;
    bool orderCanBeCancelled = state.orderCanBeCancelled;
    return SingleChildScrollView(
        child: Column(children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: order.orderLines!.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          30)),
                                              '${order.orderLines![index].pizzaName}' +
                                                  ' ' +
                                                  '${order.orderLines![index].sizeName}'))))),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: (MediaQuery.of(context).size.height) / 15,
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
                                style: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                40)
                                    : TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
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
          child: Container(
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height / 4
                      : MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color.fromARGB(239, 50, 50, 50)),
                      bottom:
                          BorderSide(color: Color.fromARGB(239, 50, 50, 50)))),
              child: Column(children: [
                Center(
                  child: Container(
                      child: Text(
                    "Статус заказа",
                    style: TextStyle(fontSize: 35),
                  )),
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Container(
                            child: Text(
                      '${order.statusName}',
                      style: TextStyle(fontSize: 40),
                    )))),
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          child: Container(
                            width: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? (MediaQuery.of(context).size.width) / 2
                                : (MediaQuery.of(context).size.width) / 2,
                            height: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? (MediaQuery.of(context).size.width) / 13
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
                              'Обновить статус',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                          onTap: () => {
                            BlocProvider.of<ClientOrderBloc>(context).add(
                                CheckIfOrderChangedStatusEvent(
                                    token, order.statusId))
                          },
                        )))
              ]))),
      Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column(
            children: [
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
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text('${order.price!.toInt()} Р',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
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
                            "Время создания:",
                            style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text(
                          '${order.creationTime.toString().substring(11, 19)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
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
                            "Будет доставлен до:",
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 28,
                                fontWeight: FontWeight.w800),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text(
                          '${order.predictedTime.toString().substring(11, 19)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
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
                            "Адрес доставки: ",
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 28,
                                fontWeight: FontWeight.w800),
                          ))),
                  Expanded(
                      flex: 3,
                      child: Text('${order.address}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
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
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 28,
                                fontWeight: FontWeight.w800),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text('${order.payingType}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
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
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 28,
                                fontWeight: FontWeight.w800),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text('${order.change} Р',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 18
                                  : MediaQuery.of(context).size.width / 28,
                              fontWeight: FontWeight.w800)))
                ],
              ),
              (orderCanBeCancelled == true)
                  ? Padding(
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
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)),
                          ),
                          child: Center(
                              child: Text(
                            'Отменить заказ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30),
                          )),
                        ),
                        onTap: () => {
                          BlocProvider.of<ClientOrderBloc>(context)
                              .add(TryCancellingOrderEvent(token))
                        },
                      ))
                  : Padding(
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
                            color: Color.fromARGB(255, 137, 137, 137),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)),
                          ),
                          child: Center(
                              child: Text(
                            'Отменить заказ уже нельзя',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30),
                          )),
                        ),
                        onTap: () => {},
                      ))
            ],
          ))
    ]));
  }
}
