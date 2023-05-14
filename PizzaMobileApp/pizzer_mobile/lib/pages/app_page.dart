import 'package:flutter/material.dart';
import 'package:pizzer_mobile/pages/pizza_catalogue_page.dart';
import 'package:pizzer_mobile/pages/client_page.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/pages/client_page.dart';
import 'package:pizzer_mobile/pages/client_order_page.dart';
import 'package:pizzer_mobile/pages/sign_in_page.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class AppPage extends StatelessWidget {
  AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (BuildContext context) =>
                AppBloc(UserInfoRepository(), OrderRepository())
                  ..add(LoadSignInAppEvent()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Pizzer',
              style: TextStyle(fontSize: 25, fontFamily: 'GrandHotel'),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
          ),
          body: BlocBuilder<AppBloc, AppState>(
            builder: (BuildContext context, AppState state) {
              if (state is SignInState) {
                return SignInPage();
              }
              if (state is RegistrationState) {
                return Container();
              }
              if (state is ResetPasswordState) {
                return Container();
              }
              if (state is ClientNoOrderState) {
                return ClientPage(token: state.token);
              }
              if (state is ClientActiveOrderState) {
                // const oneSec = Duration(seconds: 3);
                // Timer timer = Timer.periodic(
                //     oneSec,
                //     (timer) => BlocProvider.of<AppBloc>(context)
                //         .add(CheckIfOrderFinishedEvent(state.token, timer)));
                return ClientOrderPage(token: state.token);
              }
              if (state is ShowUserFinishOrderState) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                          "Ваш заказ доставлен. Нажмите ОК, чтобы вернуться к созданию заказов",
                          style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.width / 8
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
                        },
                      ),
                    ],
                  ),
                );
              }
              // if (state is ProfilePageLoadedState) {
              //   return Text('${state.number}');
              // }
              return Container();
            },
          ),
        ));
  }
}
