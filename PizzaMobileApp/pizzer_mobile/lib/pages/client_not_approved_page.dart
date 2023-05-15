import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/approve_user/approve_user_bloc.dart';
import 'package:pizzer_mobile/blocs/approve_user/approve_user_states.dart';
import 'package:pizzer_mobile/blocs/approve_user/approve_user_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class ClientNotApprovedPage extends StatelessWidget {
  String? token;
  String? approvalCode;
  ClientNotApprovedPage({super.key, this.token, this.approvalCode});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApproveUserBloc>(
          create: (BuildContext context) =>
              ApproveUserBloc(AccountRepository(), UserInfoRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          ApproveUserBloc(AccountRepository(), UserInfoRepository())
            ..add(LoadApproveUserEvent(token, approvalCode, "")),
      child: BlocBuilder<ApproveUserBloc, ApproveUserState>(
        builder: (context, state) {
          if (state is LoadingApprovalUserState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedNoAllowedApproveUserState) {
            return NoApproveUserLoaded(context, state);
          }
          if (state is LoadedAllowedApproveUserState) {
            return ApproveUserLoaded(context, state);
          }
          if (state is IncorrectApprovalCodeState) {
            return IncorrectApproveUserLoaded(context, state);
          }
          if (state is ApprovalUserSuccessState) {
            BlocProvider.of<AppBloc>(context)
                .add(SignInSubmittedAppEvent(token));
          }
          if (state is ApprovalUserErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget NoApproveUserLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Введите код подтверждения с электронной почты',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
          ))),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 6,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<ApproveUserBloc>(context).add(
                            CheckApprovalCodeChangedEvent(
                                state.token, state.approvalCode, value)),
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
                        hintText: 'Код подтверждения',
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
              'Ввести код подтверждения',
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

  Widget ApproveUserLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            'Введите код подтверждения с электронной почты',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
          ))),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 6,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<ApproveUserBloc>(context).add(
                            CheckApprovalCodeChangedEvent(
                                state.token, state.approvalCode, value)),
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
                        hintText: 'Код подтверждения',
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
              'Ввести код подтверждения',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ApproveUserBloc>(context).add(
                ApproveUserSubmittedEvent(
                    state.token, state.approvalCode, state.checkApprovalCode))
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

  Widget IncorrectApproveUserLoaded(context, state) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: Center(
              child: Text(
            textAlign: TextAlign.center,
            'Введите код подтверждения с электронной почты',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
          ))),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width),
                  child: TextFormField(
                    maxLength: 6,
                    // controller: TextEditingController(
                    //     text: stateInfo.address),
                    onChanged: (value) =>
                        BlocProvider.of<ApproveUserBloc>(context).add(
                            CheckApprovalCodeChangedEvent(state.token,
                                state.approvalCode, state.checApprovalCode)),
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
                        hintText: 'Код подтверждения',
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
              'Ввести код подтверждения',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            )),
          ),
          onTap: () => {
            BlocProvider.of<ApproveUserBloc>(context).add(
                ApproveUserSubmittedEvent(
                    state.token, state.approvalCode, state.checkApprovalCode))
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
        "Введён неправильный код подтверждения!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      ))),
    ]));
  }
}
