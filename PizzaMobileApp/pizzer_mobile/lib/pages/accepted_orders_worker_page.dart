import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/worker_accepted_order/worker_accepted_order_bloc.dart';
import 'package:pizzer_mobile/blocs/worker_accepted_order/worker_accepted_order_events.dart';
import 'package:pizzer_mobile/blocs/worker_accepted_order/worker_accepted_order_states.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:flutter/material.dart';

class AcceptedOrderWorkerPage extends StatelessWidget {
  String? token;
  AcceptedOrderWorkerPage({super.key, this.token});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorkerAcceptedOrdersBloc>(
          create: (BuildContext context) =>
              WorkerAcceptedOrdersBloc(OrderRepository(), UserInfoRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          WorkerAcceptedOrdersBloc(OrderRepository(), UserInfoRepository())
            ..add(LoadWorkerAcceptedOrdersEvent(token)),
      child: BlocBuilder<WorkerAcceptedOrdersBloc, WorkerAcceptedOrdersState>(
        builder: (context, state) {
          if (state is WorkerAcceptedOrdersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is WorkerAcceptedOrdersLoadedState) {
            return chosenOrderLoaded(context, state);
          }
          if (state is NoAcceptedOrderState) {
            return noOrderLoaded(context, state);
          }
          if (state is WorkerAcceptedOrdersErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget chosenOrderLoaded(context, state) {
    OrderModel order = state.order;
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
                              fontSize: MediaQuery.of(context).orientation ==
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
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w800),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text(
                          '${order.predictedTime.toString().substring(0, 19)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
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
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w800),
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text('${order.phoneNumber}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: MediaQuery.of(context).orientation ==
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
                            "Комментарий курьеру/работнику: ",
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18
                                    : MediaQuery.of(context).size.width / 35,
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
                                      : MediaQuery.of(context).size.width / 35,
                                  fontWeight: FontWeight.w800))
                          : Text('',
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
              Center(
                  child: Padding(
                      padding: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (EdgeInsets.fromLTRB(0, 20, 0, 10))
                          : (EdgeInsets.fromLTRB(0, 20, 0, 10)),
                      child: GestureDetector(
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0)),
                              ),
                              child: Center(
                                  child: Text(
                                'Завершить заказ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: (MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait)
                                        ? (MediaQuery.of(context).size.height /
                                            28)
                                        : (MediaQuery.of(context).size.width /
                                            40)),
                              ))),
                          onTap: () => {
                                BlocProvider.of<WorkerAcceptedOrdersBloc>(
                                        context)
                                    .add(ToNextStatusOrderEvent(
                                        state.token, order))
                              })))
            ],
          ))
    ]));
  }

  Widget noOrderLoaded(context, state) {
    return SingleChildScrollView(
        child: Container(
            height: (MediaQuery.of(context).size.height / 1.3),
            width: (MediaQuery.of(context).size.width),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Align(
              alignment: Alignment.center,
              child: Text("Заказов нет",
                  style: TextStyle(
                      color: Color.fromARGB(240, 117, 117, 117),
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 20
                          : MediaQuery.of(context).size.width / 20)),
            )));
  }
}
