import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/reset_password/reset_password_bloc.dart';
import 'package:pizzer_mobile/blocs/reset_password/reset_password_states.dart';
import 'package:pizzer_mobile/blocs/reset_password/reset_password_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResetPasswordBloc>(
          create: (BuildContext context) =>
              ResetPasswordBloc(AccountRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          ResetPasswordBloc(AccountRepository())..add(LoadResetPasswordEvent()),
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          if (state is LoadingResetPasswordState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedNoAllowedResetPasswordState) {
            return NoResetPasswordLoaded(context, state);
          }
          if (state is LoadedAllowedResetPasswordState) {
            return ResetPasswordLoaded(context, state);
          }
          if (state is IncorrectEmailState) {
            return IncorrectEmailLoaded(context, state);
          }
          if (state is ResetPasswordSuccessState) {
            BlocProvider.of<AppBloc>(context).add(LoadSignInAppEvent());
          }
          if (state is ResetPasswordErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget NoResetPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Сбросить пароль',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 40),
          ))),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 49,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<ResetPasswordBloc>(context)
                            .add(EmailChangedEvent(value)),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 30
                            : MediaQuery.of(context).size.width / 30,
                        fontFamily: "Times New Roman"),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                        ),
                        hintText: 'Электронная почта',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 1.4
                : (MediaQuery.of(context).size.width) / 1.25,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 10
                : (MediaQuery.of(context).size.width) / 13,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 158, 158, 158),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сбросить пароль',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {},
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 1.4
                : (MediaQuery.of(context).size.width) / 1.25,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 10
                : (MediaQuery.of(context).size.width) / 13,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Вернуться к странице входа',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () =>
              {BlocProvider.of<AppBloc>(context).add(LoadSignInAppEvent())},
        ),
      ),
    ]));
  }

  Widget ResetPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Сбросить пароль',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 40),
          ))),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 49,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<ResetPasswordBloc>(context)
                            .add(EmailChangedEvent(value)),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 30
                            : MediaQuery.of(context).size.width / 30,
                        fontFamily: "Times New Roman"),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                        ),
                        hintText: 'Электронная почта',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 1.4
                : (MediaQuery.of(context).size.width) / 1.25,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 10
                : (MediaQuery.of(context).size.width) / 13,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 181, 32),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сбросить пароль',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ResetPasswordBloc>(context)
                .add(ResetPasswordSubmittedEvent(state.email))
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 1.4
                : (MediaQuery.of(context).size.width) / 1.25,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 10
                : (MediaQuery.of(context).size.width) / 13,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Вернуться к странице входа',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () =>
              {BlocProvider.of<AppBloc>(context).add(LoadSignInAppEvent())},
        ),
      ),
    ]));
  }

  Widget IncorrectEmailLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Сбросить пароль',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 40),
          ))),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 49,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<ResetPasswordBloc>(context)
                            .add(EmailChangedEvent(value)),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 30
                            : MediaQuery.of(context).size.width / 30,
                        fontFamily: "Times New Roman"),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                        ),
                        hintText: 'Электронная почта',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 1.4
                : (MediaQuery.of(context).size.width) / 1.25,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 10
                : (MediaQuery.of(context).size.width) / 13,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 181, 32),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сбросить пароль',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ResetPasswordBloc>(context)
                .add(ResetPasswordSubmittedEvent(state.email))
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 1.4
                : (MediaQuery.of(context).size.width) / 1.25,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? (MediaQuery.of(context).size.width) / 10
                : (MediaQuery.of(context).size.width) / 13,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Вернуться к странице входа',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () =>
              {BlocProvider.of<AppBloc>(context).add(LoadSignInAppEvent())},
        ),
      ),
      Center(
          child: Container(
              child: Text(
        "Пользователя с данной почтой не существует!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      ))),
    ]));
  }
}
