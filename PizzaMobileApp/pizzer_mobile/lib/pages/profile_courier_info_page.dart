import 'package:pizzer_mobile/models/user_info_model.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/profile_info/profile_info_bloc.dart';
import 'package:pizzer_mobile/blocs/profile_info/profile_info_states.dart';
import 'package:pizzer_mobile/blocs/profile_info/profile_info_events.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';

class ProfileCourierInfoPage extends StatelessWidget {
  String? token;
  ProfileCourierInfoPage({super.key, this.token});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileInfoBloc>(
          create: (BuildContext context) =>
              ProfileInfoBloc(UserInfoRepository()),
        ),
      ],
      child: blocBody(),
    );
  }

  @override
  Widget blocBody() {
    return BlocProvider(
      create: (context) => ProfileInfoBloc(UserInfoRepository())
        ..add(LoadProfileInfoEvent(token)),
      child: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedNoAllowedChangeProfileInfoState) {
            return userInfoNoChangeLoaded(context, state);
          }
          if (state is LoadedAllowedChangeProfileInfoState) {
            return userInfoChangeLoaded(context, state);
          }
          if (state is ProfileInfoErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget userInfoChangeLoaded(context, state) {
    UserInfoModel user = state.userInfoModel;
    return SingleChildScrollView(
      child: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SizedBox(
                    width: (MediaQuery.of(context).size.width),
                    child: TextFormField(
                      maxLength: 69,
                      initialValue: state.previousName,
                      // controller: TextEditingController(
                      //     text: stateInfo.address),
                      onChanged: (value) =>
                          BlocProvider.of<ProfileInfoBloc>(context).add(
                              ProfileNameChangedEvent(
                                  token,
                                  value,
                                  state.previousName,
                                  state.previousPhone,
                                  user)),
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
                          hintText: 'ФИО',
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
                      initialValue: state.previousPhone,
                      maxLength: 11,
                      // controller: TextEditingController(
                      //     text: stateInfo.phone),
                      onChanged: (value) =>
                          BlocProvider.of<ProfileInfoBloc>(context).add(
                              ProfilePhoneChangedEvent(
                                  token,
                                  value,
                                  state.previousName,
                                  state.previousPhone,
                                  user)),
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
                      keyboardType: TextInputType.phone,
                      //inputFormatters: <TextInputFormatter>[
                      //   MaskTextInputFormatter(
                      //       mask: '+8 (9##) ###-##-##',
                      //       filter: {"#": RegExp(r'[0-9]')},
                      //       type: MaskAutoCompletionType.lazy),
                      // ]
                    )))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? (MediaQuery.of(context).size.height / 16)
                        : (MediaQuery.of(context).size.height / 8),
                width: (MediaQuery.of(context).size.width),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Эл. почта: ${user.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 30
                                  : MediaQuery.of(context).size.width / 30,
                              fontFamily: "Times New Roman"),
                        ))))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? (MediaQuery.of(context).size.height / 16)
                        : (MediaQuery.of(context).size.height / 8),
                width: (MediaQuery.of(context).size.width),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Ваш паспорт: ${user.passport}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 30
                                  : MediaQuery.of(context).size.width / 30,
                              fontFamily: "Times New Roman"),
                        ))))),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
          child: GestureDetector(
            child: Container(
              width:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 1.4
                      : (MediaQuery.of(context).size.width) / 1.25,
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 10
                      : (MediaQuery.of(context).size.width) / 13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 36, 163, 24),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
              ),
              child: Center(
                  child: Text(
                'Сохранить изменения',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
              )),
            ),
            onTap: () => {
              BlocProvider.of<ProfileInfoBloc>(context)
                  .add(ProfileInfoChangedEvent(token))
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: GestureDetector(
            child: Container(
              width:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 1.4
                      : (MediaQuery.of(context).size.width) / 1.25,
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 10
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
                'Выйти из аккаунта',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
              )),
            ),
            onTap: () =>
                {BlocProvider.of<AppBloc>(context).add(UserLogOutEvent())},
          ),
        )
      ]),
    );
  }

  Widget userInfoNoChangeLoaded(context, state) {
    UserInfoModel user = state.userInfoModel;
    return SingleChildScrollView(
      child: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SizedBox(
                    width: (MediaQuery.of(context).size.width),
                    child: TextFormField(
                      maxLength: 69,
                      initialValue: state.previousName,
                      // controller: TextEditingController(
                      //     text: stateInfo.address),
                      onChanged: (value) =>
                          BlocProvider.of<ProfileInfoBloc>(context).add(
                              ProfileNameChangedEvent(
                                  token,
                                  value,
                                  state.previousName,
                                  state.previousPhone,
                                  user)),
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
                          hintText: 'ФИО',
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
                      initialValue: state.previousPhone,
                      maxLength: 11,
                      // controller: TextEditingController(
                      //     text: stateInfo.phone),
                      onChanged: (value) =>
                          BlocProvider.of<ProfileInfoBloc>(context).add(
                              ProfilePhoneChangedEvent(
                                  token,
                                  value,
                                  state.previousName,
                                  state.previousPhone,
                                  user)),
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
                      keyboardType: TextInputType.phone,
                      //inputFormatters: <TextInputFormatter>[
                      //   MaskTextInputFormatter(
                      //       mask: '+8 (9##) ###-##-##',
                      //       filter: {"#": RegExp(r'[0-9]')},
                      //       type: MaskAutoCompletionType.lazy),
                      // ]
                    )))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? (MediaQuery.of(context).size.height / 16)
                        : (MediaQuery.of(context).size.height / 8),
                width: (MediaQuery.of(context).size.width),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Эл. почта: ${user.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 30
                                  : MediaQuery.of(context).size.width / 30,
                              fontFamily: "Times New Roman"),
                        ))))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? (MediaQuery.of(context).size.height / 16)
                        : (MediaQuery.of(context).size.height / 8),
                width: (MediaQuery.of(context).size.width),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Ваш паспорт: ${user.passport}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 30
                                  : MediaQuery.of(context).size.width / 30,
                              fontFamily: "Times New Roman"),
                        ))))),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
          child: GestureDetector(
            child: Container(
              width:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 1.4
                      : (MediaQuery.of(context).size.width) / 1.25,
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 10
                      : (MediaQuery.of(context).size.width) / 13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 203, 203, 203),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
              ),
              child: Center(
                  child: Text(
                'Сохранить изменения',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
              )),
            ),
            onTap: () => {},
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: GestureDetector(
            child: Container(
              width:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 1.4
                      : (MediaQuery.of(context).size.width) / 1.25,
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? (MediaQuery.of(context).size.width) / 10
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
                'Выйти из аккаунта',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
              )),
            ),
            onTap: () =>
                {BlocProvider.of<AppBloc>(context).add(UserLogOutEvent())},
          ),
        )
      ]),
    );
  }
}
