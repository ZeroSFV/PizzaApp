import 'package:flutter/material.dart';
import 'package:pizzer_mobile/pages/pizza_catalogue_page.dart';
import 'package:pizzer_mobile/pages/client_page.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/pages/client_page.dart';
import 'package:pizzer_mobile/pages/client_order_page.dart';
import 'package:pizzer_mobile/repositories/order_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (BuildContext context) =>
                AppBloc(UserInfoRepository(), OrderRepository())
                  ..add(SignInSubmittedEvent()),
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
              if (state is ClientNoOrderState) {
                return ClientPage(token: state.token);
              }
              if (state is ClientActiveOrderState) {
                return ClientOrderPage();
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
