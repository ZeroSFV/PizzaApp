import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_bloc.dart';
import 'package:pizzer_mobile/blocs/app_bloc/app_events.dart';
import 'package:pizzer_mobile/blocs/navigation_bar_order/navigation_bar_order_bloc.dart';
import 'package:pizzer_mobile/blocs/navigation_bar_order/navigation_bar_order_events.dart';
import 'package:pizzer_mobile/blocs/navigation_bar_order/navigation_bar_order_states.dart';
import 'package:pizzer_mobile/pages/order_page.dart';
import 'package:pizzer_mobile/pages/pizza_catalogue_order_page.dart';
import 'package:pizzer_mobile/pages/profile_page.dart';

class ClientOrderPage extends StatelessWidget {
  String? token;
  //Timer? timer;
  ClientOrderPage({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBarOrderBloc>(
            create: (BuildContext context) => NavigationBarOrderBloc(1),
          ),
        ],
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text(
          //     'Pizzer',
          //     style: TextStyle(fontSize: 25, fontFamily: 'GrandHotel'),
          //   ),
          //   backgroundColor: Colors.white,
          //   foregroundColor: Colors.red,
          // ),
          body: BlocBuilder<NavigationBarOrderBloc, NavigationBarOrderState>(
            builder: (BuildContext context, NavigationBarOrderState state) {
              if (state is CataloguePageOrderLoadedState) {
                return PizzaCatalogueOrderPage(token: token);
                //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJla3Nfc2Z2QG1haWwucnUiLCJuYW1lIjoi0JzQuNGF0LDQuNC7INCR0LDRg9GB0L7QsiDQlNC80LjRgtGA0LjQtdCy0LjRhyIsInN1YiI6IjUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNjg5NzQ3NDExLCJpc3MiOiJQaXp6ZXJCYWNrRW5kIiwiYXVkIjoiUGl6emVyTW9iaWxlIn0.w7pqPIIkWw2HmyPhyRarP6vLJ3WDXmQU_mn-pHxutLg");
              }
              if (state is OrderPageLoadedState) {
                return OrderPage(token: token);
                // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJla3Nfc2Z2QG1haWwucnUiLCJuYW1lIjoi0JzQuNGF0LDQuNC7INCR0LDRg9GB0L7QsiDQlNC80LjRgtGA0LjQtdCy0LjRhyIsInN1YiI6IjUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNjg5NzQ3NDExLCJpc3MiOiJQaXp6ZXJCYWNrRW5kIiwiYXVkIjoiUGl6emVyTW9iaWxlIn0.w7pqPIIkWw2HmyPhyRarP6vLJ3WDXmQU_mn-pHxutLg");
              }
              if (state is ProfilePageOrderLoadedState) {
                return ProfilePage(token: token);
              }
              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<NavigationBarOrderBloc, NavigationBarOrderState>(
                  builder:
                      (BuildContext context, NavigationBarOrderState state) {
            return BottomNavigationBar(
              currentIndex:
                  BlocProvider.of<NavigationBarOrderBloc>(context).currentIndex,
              selectedItemColor: Colors.red,
              items: <BottomNavigationBarItem>[
                (state is CataloguePageOrderLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.local_pizza, color: Colors.red),
                        label: "Меню",
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.local_pizza_outlined,
                            color: Colors.black),
                        label: 'Меню',
                      ),
                (state is OrderPageLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.delivery_dining, color: Colors.red),
                        label: 'Заказ',
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.delivery_dining_outlined,
                            color: Colors.black),
                        label: 'Заказ',
                      ),
                (state is ProfilePageOrderLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.person, color: Colors.red),
                        label: 'Профиль',
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.person_outlined, color: Colors.black),
                        label: 'Профиль',
                      ),
              ],
              onTap: (index) => {
                BlocProvider.of<NavigationBarOrderBloc>(context)
                    .add(PageTapped(index)),
                // BlocProvider.of<NavigationBarBloc>(context).currentIndex =
                //     index,
              },
            );
          }),
        ));
  }
}
