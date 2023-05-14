import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pizzer_mobile/blocs/sign_in/sign_in_states.dart';
import 'package:pizzer_mobile/blocs/sign_in/sign_in_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (BuildContext context) => SignInBloc(AccountRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          SignInBloc(AccountRepository())..add(LoadSignInEvent()),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          if (state is LoadingSignInState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedNoAllowedSignInState) {
            return NoSignInLoaded(context, state);
          }
          if (state is LoadedAllowedSignInState) {
            return SignInLoaded(context, state);
          }
          if (state is IncorrectEmailPasswordState) {
            return IncorrectEmailPasswordLoaded(context, state);
          }
          if (state is SignInSuccessState) {
            BlocProvider.of<AppBloc>(context)
                .add(SignInSubmittedAppEvent(state.token));
          }
          if (state is SignInErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget NoSignInLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Вход в систему',
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
                    onChanged: (value) => BlocProvider.of<SignInBloc>(context)
                        .add(EmailChangedEvent(value, state.password)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) => BlocProvider.of<SignInBloc>(context)
                        .add(PasswordChangedEvent(state.email, value)),
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
                        hintText: 'Пароль',
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
              'Войти',
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
              'Забыл пароль',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<AppBloc>(context).add(LoadResetPasswordAppEvent())
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
              'Регистрация',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<AppBloc>(context).add(LoadRegistrationAppEvent())
          },
        ),
      ),
    ]));
  }

  Widget SignInLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Вход в систему',
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
                    onChanged: (value) => BlocProvider.of<SignInBloc>(context)
                        .add(EmailChangedEvent(value, state.password)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    obscureText: true,

                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) => BlocProvider.of<SignInBloc>(context)
                        .add(PasswordChangedEvent(state.email, value)),
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
                        hintText: 'Пароль',
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
              'Войти',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<SignInBloc>(context)
                .add(SignInSubmittedEvent(state.email, state.password))
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
              'Забыл пароль',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<AppBloc>(context).add(LoadResetPasswordAppEvent())
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
              'Регистрация',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<AppBloc>(context).add(LoadRegistrationAppEvent())
          },
        ),
      ),
    ]));
  }

  Widget IncorrectEmailPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Вход в систему',
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
                    initialValue: state.email,
                    onChanged: (value) => BlocProvider.of<SignInBloc>(context)
                        .add(EmailChangedEvent(value, state.password)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    obscureText: true,
                    initialValue: state.password,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) => BlocProvider.of<SignInBloc>(context)
                        .add(PasswordChangedEvent(state.email, value)),
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
                        hintText: 'Пароль',
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
              'Войти',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<SignInBloc>(context)
                .add(SignInSubmittedEvent(state.email, state.password))
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
              'Забыл пароль',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<AppBloc>(context).add(LoadResetPasswordAppEvent())
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
              'Регистрация',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<AppBloc>(context).add(LoadRegistrationAppEvent())
          },
        ),
      ),
      Center(
          child: Container(
              child: Text(
        "Электронная почта или пароль введены неправильно!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      )))
    ]));
  }
}
