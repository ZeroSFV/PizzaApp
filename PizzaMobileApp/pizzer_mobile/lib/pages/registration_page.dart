import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/registration/registration_bloc.dart';
import 'package:pizzer_mobile/blocs/registration/registration_states.dart';
import 'package:pizzer_mobile/blocs/registration/registration_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationBloc>(
          create: (BuildContext context) =>
              RegistrationBloc(AccountRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          RegistrationBloc(AccountRepository())..add(LoadRegistrationEvent()),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is LoadingRegistrationState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedNoAllowedRegistrationState) {
            return NoRegistrationLoaded(context, state);
          }
          if (state is LoadedAllowedRegistrationState) {
            return RegistrationLoaded(context, state);
          }
          if (state is IncorrectPasswordState) {
            return IncorrectPasswordLoaded(context, state);
          }
          if (state is IncorrectRepeatPasswordState) {
            return IncorrectRepeatPasswordLoaded(context, state);
          }
          if (state is EmailIsNotAllowedState) {
            return IncorrectEmailLoaded(context, state);
          }
          if (state is RegistrationSuccessState) {
            BlocProvider.of<AppBloc>(context).add(LoadSignInAppEvent());
          }
          if (state is RegistrationErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget NoRegistrationLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Регистрация',
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
                        BlocProvider.of<RegistrationBloc>(context).add(
                            EmailChangedEvent(value, state.name, state.phone,
                                state.password, state.repeatPassword)),
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
                    maxLength: 49,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            NameChangedEvent(state.email, value, state.phone,
                                state.password, state.repeatPassword)),
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
                        hintText: 'ФИО пользователя',
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
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PhoneChangedEvent(state.email, state.name, value,
                                state.password, state.repeatPassword)),
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
                        hintText: 'Номер телефона',
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
                    maxLength: 30,
                    obscureText: true,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PasswordChangedEvent(state.email, state.name,
                                state.phone, value, state.repeatPassword)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            RepeatPasswordChangedEvent(state.email, state.name,
                                state.phone, state.password, value)),
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
                        hintText: 'Повторите пароль',
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
              'Зарегистрироваться',
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

  Widget RegistrationLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Регистрация',
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
                        BlocProvider.of<RegistrationBloc>(context).add(
                            EmailChangedEvent(value, state.name, state.phone,
                                state.password, state.repeatPassword)),
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
                    maxLength: 49,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            NameChangedEvent(state.email, value, state.phone,
                                state.password, state.repeatPassword)),
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
                        hintText: 'ФИО пользователя',
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
                    maxLength: 11,

                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PhoneChangedEvent(state.email, state.name, value,
                                state.password, state.repeatPassword)),
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
                        hintText: 'Номер телефона',
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
                    maxLength: 30,
                    obscureText: true,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PasswordChangedEvent(state.email, state.name,
                                state.phone, value, state.repeatPassword)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            RepeatPasswordChangedEvent(state.email, state.name,
                                state.phone, state.password, value)),
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
                        hintText: 'Повторите пароль',
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
              'Зарегистрироваться',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<RegistrationBloc>(context).add(
                RegistrationSubmittedEvent(state.email, state.name, state.phone,
                    state.password, state.repeatPassword))
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

  Widget IncorrectPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Регистрация',
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
                    initialValue: state.email,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            EmailChangedEvent(value, state.name, state.phone,
                                state.password, state.repeatPassword)),
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
                    maxLength: 49,
                    initialValue: state.name,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            NameChangedEvent(state.email, value, state.phone,
                                state.password, state.repeatPassword)),
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
                        hintText: 'ФИО пользователя',
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
                    maxLength: 11,
                    initialValue: state.phone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PhoneChangedEvent(state.email, state.name, value,
                                state.password, state.repeatPassword)),
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
                        hintText: 'Номер телефона',
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
                    maxLength: 30,
                    obscureText: true,
                    initialValue: state.password,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PasswordChangedEvent(state.email, state.name,
                                state.phone, value, state.repeatPassword)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    initialValue: state.repeatPassword,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            RepeatPasswordChangedEvent(state.email, state.name,
                                state.phone, state.password, value)),
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
                        hintText: 'Повторите пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
      Center(
          child: Container(
              child: Text(
        "Пароль имеет пробелы или имеет неправильную длину! Пароль должен быть от 6 до 30 символов!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      ))),
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
              'Зарегистрироваться',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<RegistrationBloc>(context).add(
                RegistrationSubmittedEvent(state.email, state.name, state.phone,
                    state.password, state.repeatPassword))
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

  Widget IncorrectRepeatPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Регистрация',
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
                    initialValue: state.email,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            EmailChangedEvent(value, state.name, state.phone,
                                state.password, state.repeatPassword)),
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
                    maxLength: 49,
                    initialValue: state.name,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            NameChangedEvent(state.email, value, state.phone,
                                state.password, state.repeatPassword)),
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
                        hintText: 'ФИО пользователя',
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
                    maxLength: 11,
                    initialValue: state.phone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PhoneChangedEvent(state.email, state.name, value,
                                state.password, state.repeatPassword)),
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
                        hintText: 'Номер телефона',
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
                    maxLength: 30,
                    obscureText: true,
                    initialValue: state.password,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PasswordChangedEvent(state.email, state.name,
                                state.phone, value, state.repeatPassword)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    initialValue: state.repeatPassword,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            RepeatPasswordChangedEvent(state.email, state.name,
                                state.phone, state.password, value)),
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
                        hintText: 'Повторите пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
      Center(
          child: Container(
              child: Text(
        "Пароль не совпадает с тем, который введен в повторении",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      ))),
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
              'Зарегистрироваться',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<RegistrationBloc>(context).add(
                RegistrationSubmittedEvent(state.email, state.name, state.phone,
                    state.password, state.repeatPassword))
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
            'Регистрация',
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
                    initialValue: state.email,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            EmailChangedEvent(value, state.name, state.phone,
                                state.password, state.repeatPassword)),
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
                    maxLength: 49,
                    initialValue: state.name,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            NameChangedEvent(state.email, value, state.phone,
                                state.password, state.repeatPassword)),
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
                        hintText: 'ФИО пользователя',
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
                    maxLength: 11,
                    initialValue: state.phone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PhoneChangedEvent(state.email, state.name, value,
                                state.password, state.repeatPassword)),
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
                        hintText: 'Номер телефона',
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
                    maxLength: 30,
                    obscureText: true,
                    initialValue: state.password,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            PasswordChangedEvent(state.email, state.name,
                                state.phone, value, state.repeatPassword)),
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
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    initialValue: state.repeatPassword,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context).add(
                            RepeatPasswordChangedEvent(state.email, state.name,
                                state.phone, state.password, value)),
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
                        hintText: 'Повторите пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
      Center(
          child: Container(
              child: Text(
        "Аккаунт с такой почтой уже существует! Введите другую почту!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      ))),
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
              'Зарегистрироваться',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<RegistrationBloc>(context).add(
                RegistrationSubmittedEvent(state.email, state.name, state.phone,
                    state.password, state.repeatPassword))
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
}
