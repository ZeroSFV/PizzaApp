import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/profile/profile_bloc.dart';
import 'package:pizzer_mobile/blocs/profile/profile_states.dart';
import 'package:pizzer_mobile/blocs/profile/profile_events.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/pages/change_password_page.dart';
import 'package:pizzer_mobile/pages/profile_courier_info_page.dart';
import 'package:pizzer_mobile/pages/courier_orders_page.dart';

class ProfileCourierPage extends StatelessWidget {
  String? token;
  ProfileCourierPage({super.key, this.token});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(UserInfoRepository()),
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
          ProfileBloc(UserInfoRepository())..add(LoadProfileEvent(token)),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is UserOrderState) {
            return courierOrdersLoaded(context, state);
          }
          if (state is ProfileInfoChosenState) {
            return courierProfileInfoLoaded(context, state);
          }
          if (state is ChangePasswordState) {
            return changePasswordLoaded(context, state);
          }
          if (state is ProfileErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget courierProfileInfoLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                width: (MediaQuery.of(context).size.width) / 1,
                height:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? (MediaQuery.of(context).size.width) / 10
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
                      width: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? (MediaQuery.of(context).size.width) / 3.1
                          : (MediaQuery.of(context).size.width) / 3.03,
                      height: (MediaQuery.of(context).size.width) / 10,
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
                        "Профиль",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? (MediaQuery.of(context).size.width) / 30
                                : (MediaQuery.of(context).size.width) / 50),
                      ))),
                  GestureDetector(
                      onTap: () => BlocProvider.of<ProfileBloc>(context)
                          .add(OrdersChosenEvent(token)),
                      child: Container(
                        width: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? (MediaQuery.of(context).size.width) / 3.1
                            : (MediaQuery.of(context).size.width) / 3.03,
                        height: (MediaQuery.of(context).size.width) / 10,
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
                          "Заказы",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? (MediaQuery.of(context).size.width) / 30
                                  : (MediaQuery.of(context).size.width) / 50),
                        )),
                      )),
                  GestureDetector(
                      onTap: () => BlocProvider.of<ProfileBloc>(context)
                          .add(PasswordChosenEvent(token)),
                      child: Container(
                        width: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? (MediaQuery.of(context).size.width) / 3.1
                            : (MediaQuery.of(context).size.width) / 3.03,
                        height: (MediaQuery.of(context).size.width) / 10,
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
                          "Смена пароля",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? (MediaQuery.of(context).size.width) / 30
                                  : (MediaQuery.of(context).size.width) / 50),
                        )),
                      ))
                ]))),
        ProfileCourierInfoPage(
          token: token,
        ),
      ],
    ));
  }

  Widget courierOrdersLoaded(context, state) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 10
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
                        onTap: () => BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileInfoChosenEvent(token)),
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 3.1
                              : (MediaQuery.of(context).size.width) / 3.03,
                          height: (MediaQuery.of(context).size.width) / 10,
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
                            "Профиль",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 30
                                    : (MediaQuery.of(context).size.width) / 50),
                          )),
                        )),
                    Container(
                        width: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? (MediaQuery.of(context).size.width) / 3.1
                            : (MediaQuery.of(context).size.width) / 3.03,
                        height: (MediaQuery.of(context).size.width) / 10,
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
                          "Заказы",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? (MediaQuery.of(context).size.width) / 30
                                  : (MediaQuery.of(context).size.width) / 50),
                        ))),
                    GestureDetector(
                        onTap: () => BlocProvider.of<ProfileBloc>(context)
                            .add(PasswordChosenEvent(token)),
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 3.1
                              : (MediaQuery.of(context).size.width) / 3.03,
                          height: (MediaQuery.of(context).size.width) / 10,
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
                            "Смена пароля",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 30
                                    : (MediaQuery.of(context).size.width) / 50),
                          )),
                        )),
                  ]))),
          CourierOrdersPage(
            token: token,
          ),
        ],
      ),
    ));
  }

  Widget changePasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 10
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
                        onTap: () => BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileInfoChosenEvent(token)),
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 3.1
                              : (MediaQuery.of(context).size.width) / 3.03,
                          height: (MediaQuery.of(context).size.width) / 10,
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
                            "Профиль",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 30
                                    : (MediaQuery.of(context).size.width) / 50),
                          )),
                        )),
                    GestureDetector(
                        onTap: () => BlocProvider.of<ProfileBloc>(context)
                            .add(OrdersChosenEvent(token)),
                        child: Container(
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? (MediaQuery.of(context).size.width) / 3.1
                              : (MediaQuery.of(context).size.width) / 3.03,
                          height: (MediaQuery.of(context).size.width) / 10,
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
                            "Заказы",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? (MediaQuery.of(context).size.width) / 30
                                    : (MediaQuery.of(context).size.width) / 50),
                          )),
                        )),
                    Container(
                        width: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? (MediaQuery.of(context).size.width) / 3.09
                            : (MediaQuery.of(context).size.width) / 3.03,
                        height: (MediaQuery.of(context).size.width) / 10,
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
                          "Смена пароля",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? (MediaQuery.of(context).size.width) / 30
                                  : (MediaQuery.of(context).size.width) / 50),
                        ))),
                  ]))),
          ChangePasswordPage(
            token: token,
          ),
        ],
      ),
    ));
  }
}
