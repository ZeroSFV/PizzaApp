import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_blocs.dart';
import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_events.dart';
import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_states.dart';
import 'package:pizzer_mobile/pages/basket_page.dart';
import 'package:pizzer_mobile/pages/pizza_catalogue_page.dart';

class ClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBarBloc>(
            create: (BuildContext context) => NavigationBarBloc(0),
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
          body: BlocBuilder<NavigationBarBloc, NavigationBarState>(
            builder: (BuildContext context, NavigationBarState state) {
              if (state is CataloguePageLoadedState) {
                return PizzaCataloguePage();
              }
              if (state is BasketPageLoadedState) {
                return BasketPage(
                    token:
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJla3Nfc2Z2QG1haWwucnUiLCJuYW1lIjoi0JzQuNGF0LDQuNC7INCR0LDRg9GB0L7QsiIsInN1YiI6IjUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNjg5NTU4MDYyLCJpc3MiOiJQaXp6ZXJCYWNrRW5kIiwiYXVkIjoiUGl6emVyTW9iaWxlIn0.4XoZ09N6rmmdbkbM1J7qmC10Oed8c2vRxO6z-l8Cw1Y");
              }
              if (state is ProfilePageLoadedState) {
                return Text('${state.number}');
              }
              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<NavigationBarBloc, NavigationBarState>(
                  builder: (BuildContext context, NavigationBarState state) {
            return BottomNavigationBar(
              currentIndex:
                  BlocProvider.of<NavigationBarBloc>(context).currentIndex,
              selectedItemColor: Colors.red,
              items: <BottomNavigationBarItem>[
                (state is CataloguePageLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.local_pizza, color: Colors.red),
                        label: "Меню",
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.local_pizza_outlined,
                            color: Colors.black),
                        label: 'Меню',
                      ),
                (state is BasketPageLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_basket, color: Colors.red),
                        label: 'Корзина',
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_basket_outlined,
                            color: Colors.black),
                        label: 'Корзина',
                      ),
                (state is ProfilePageLoadedState)
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
                BlocProvider.of<NavigationBarBloc>(context)
                    .add(PageTapped(index)),
                // BlocProvider.of<NavigationBarBloc>(context).currentIndex =
                //     index,
              },
            );
          }),
        ));
  }
}
