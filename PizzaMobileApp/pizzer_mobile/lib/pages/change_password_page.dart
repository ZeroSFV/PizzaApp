import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/change_password/change_password_bloc.dart';
import 'package:pizzer_mobile/blocs/change_password/change_password_states.dart';
import 'package:pizzer_mobile/blocs/change_password/change_password_events.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  String? token;
  ChangePasswordPage({super.key, this.token});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangePasswordBloc>(
          create: (BuildContext context) =>
              ChangePasswordBloc(AccountRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(AccountRepository())
        ..add(LoadChangePasswordEvent(token)),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          if (state is ChangePasswordLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedNoAllowedChangePasswordState) {
            return ChangePasswordNoChangeLoaded(context, state);
          }
          if (state is LoadedAllowedChangePasswordState) {
            return ChangePasswordChangeLoaded(context, state);
          }
          if (state is IncorrectNewPasswordState) {
            return IncorrectNewPasswordLoaded(context, state);
          }
          if (state is IncorrectRepeatChangePasswordState) {
            return IncorrectRepeatPasswordLoaded(context, state);
          }
          if (state is IncorrectOldPasswordState) {
            return IncorrectOldPasswordLoaded(context, state);
          }
          if (state is ChangePasswordErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget ChangePasswordNoChangeLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
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
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            OldPasswordChangedEvent(token, value,
                                state.newPassword, state.repeatPassword)),
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
                        hintText: 'Старый пароль',
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
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            NewPasswordChangedEvent(token, state.oldPassword,
                                value, state.repeatPassword)),
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
                        hintText: 'Новый пароль',
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
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            RepeatPasswordChangedEvent(token, state.oldPassword,
                                state.newPassword, value)),
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
                        hintText: 'Повторите новый пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
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
              color: Color.fromARGB(255, 158, 158, 158),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сменить пароль',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            )),
          ),
          onTap: () => {},
        ),
      ),
      Center(
          child: Container(
              child: Text(
        '${BlocProvider.of<ChangePasswordBloc>(context).successMessage}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 65, 174, 37)),
      )))
    ]));
  }

  Widget ChangePasswordChangeLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
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
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            OldPasswordChangedEvent(token, value,
                                state.newPassword, state.repeatPassword)),
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
                        hintText: 'Старый пароль',
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
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            NewPasswordChangedEvent(token, state.oldPassword,
                                value, state.repeatPassword)),
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
                        hintText: 'Новый пароль',
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
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            RepeatPasswordChangedEvent(token, state.oldPassword,
                                state.newPassword, value)),
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
                        hintText: 'Повторите новый пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
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
              color: Color.fromARGB(255, 47, 181, 32),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сменить пароль',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ChangePasswordBloc>(context)
                .add(NewPasswordSubmittedEvent(token))
          },
        ),
      )
    ]));
  }

  Widget IncorrectNewPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
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
                    initialValue: state.oldPassword,
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            OldPasswordChangedEvent(token, value,
                                state.newPassword, state.repeatPassword)),
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
                        hintText: 'Старый пароль',
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
                    initialValue: state.newPassword,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            NewPasswordChangedEvent(token, state.oldPassword,
                                value, state.repeatPassword)),
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
                        hintText: 'Новый пароль',
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
                    initialValue: state.repeatPassword,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            RepeatPasswordChangedEvent(token, state.oldPassword,
                                state.newPassword, value)),
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
                        hintText: 'Повторите новый пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
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
              color: Color.fromARGB(255, 47, 181, 32),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сменить пароль',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ChangePasswordBloc>(context)
                .add(NewPasswordSubmittedEvent(token))
          },
        ),
      ),
      Center(
          child: Container(
              child: Text(
        "Новый пароль введен не правильно! Пароль должен быть от 6 до 30 символов и не должен содержать пробелов",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      )))
    ]));
  }

  Widget IncorrectOldPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
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
                    initialValue: state.oldPassword,
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            OldPasswordChangedEvent(token, value,
                                state.newPassword, state.repeatPassword)),
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
                        hintText: 'Старый пароль',
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
                    initialValue: state.newPassword,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            NewPasswordChangedEvent(token, state.oldPassword,
                                value, state.repeatPassword)),
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
                        hintText: 'Новый пароль',
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
                    initialValue: state.repeatPassword,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            RepeatPasswordChangedEvent(token, state.oldPassword,
                                state.newPassword, value)),
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
                        hintText: 'Повторите новый пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
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
              color: Color.fromARGB(255, 47, 181, 32),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сменить пароль',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ChangePasswordBloc>(context)
                .add(NewPasswordSubmittedEvent(token))
          },
        ),
      ),
      Center(
          child: Container(
              child: Text(
        "Старый пароль введен не правильно!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      )))
    ]));
  }

  Widget IncorrectRepeatPasswordLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
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
                    initialValue: state.oldPassword,
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            OldPasswordChangedEvent(token, value,
                                state.newPassword, state.repeatPassword)),
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
                        hintText: 'Старый пароль',
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
                    initialValue: state.newPassword,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            NewPasswordChangedEvent(token, state.oldPassword,
                                value, state.repeatPassword)),
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
                        hintText: 'Новый пароль',
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
                    initialValue: state.repeatPassword,
                    maxLength: 30,
                    // controller: TextEditingController(
                    //     text: stateInfo.phone),
                    onChanged: (value) =>
                        BlocProvider.of<ChangePasswordBloc>(context).add(
                            RepeatPasswordChangedEvent(token, state.oldPassword,
                                state.newPassword, value)),
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
                        hintText: 'Повторите новый пароль',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 30
                                : MediaQuery.of(context).size.width / 30,
                            fontFamily: "Times New Roman")),
                  )))),
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
              color: Color.fromARGB(255, 47, 181, 32),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Center(
                child: Text(
              'Сменить пароль',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ChangePasswordBloc>(context)
                .add(NewPasswordSubmittedEvent(token))
          },
        ),
      ),
      Center(
          child: Container(
              child: Text(
        "Повторный пароль введён неправильно!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      )))
    ]));
  }
}
