import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzer_mobile/blocs/worker_navigation_bar/worker_navigation_bar_bloc.dart';
import 'package:pizzer_mobile/blocs/worker_navigation_bar/worker_navigation_bar_events.dart';
import 'package:pizzer_mobile/blocs/worker_navigation_bar/worker_navigation_bar_states.dart';
import 'package:pizzer_mobile/pages/unaccepted_order_courier_page.dart';
import 'package:pizzer_mobile/pages/accepted_order_courier_page.dart';
import 'package:pizzer_mobile/pages/profile_courier_page.dart';

class CourierPage extends StatelessWidget {
  String? token;
  CourierPage({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WorkerNavigationBarBloc>(
            create: (BuildContext context) => WorkerNavigationBarBloc(0),
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
          body: BlocBuilder<WorkerNavigationBarBloc, WorkerNavigationBarState>(
            builder: (BuildContext context, WorkerNavigationBarState state) {
              if (state is UnacceptedOrdersPageLoadedState) {
                return UnacceptedOrderCourierPage(token: token);
                //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJla3Nfc2Z2QG1haWwucnUiLCJuYW1lIjoi0JzQuNGF0LDQuNC7INCR0LDRg9GB0L7QsiDQlNC80LjRgtGA0LjQtdCy0LjRhyIsInN1YiI6IjUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNjg5NzQ3NDExLCJpc3MiOiJQaXp6ZXJCYWNrRW5kIiwiYXVkIjoiUGl6emVyTW9iaWxlIn0.w7pqPIIkWw2HmyPhyRarP6vLJ3WDXmQU_mn-pHxutLg");
              }
              if (state is AcceptedOrderPageLoadedState) {
                return AcceptedOrderCourierPage(token: token);
                // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJla3Nfc2Z2QG1haWwucnUiLCJuYW1lIjoi0JzQuNGF0LDQuNC7INCR0LDRg9GB0L7QsiDQlNC80LjRgtGA0LjQtdCy0LjRhyIsInN1YiI6IjUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZXhwIjoxNjg5NzQ3NDExLCJpc3MiOiJQaXp6ZXJCYWNrRW5kIiwiYXVkIjoiUGl6emVyTW9iaWxlIn0.w7pqPIIkWw2HmyPhyRarP6vLJ3WDXmQU_mn-pHxutLg");
              }
              if (state is WorkerProfilePageOrderLoadedState) {
                return ProfileCourierPage(token: token);
              }
              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<WorkerNavigationBarBloc, WorkerNavigationBarState>(
                  builder:
                      (BuildContext context, WorkerNavigationBarState state) {
            return BottomNavigationBar(
              currentIndex: BlocProvider.of<WorkerNavigationBarBloc>(context)
                  .currentIndex,
              selectedItemColor: Colors.red,
              items: <BottomNavigationBarItem>[
                (state is UnacceptedOrdersPageLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        label: "Непринятые заказы",
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.cancel_outlined, color: Colors.black),
                        label: 'Непринятые заказы',
                      ),
                (state is AcceptedOrderPageLoadedState)
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.done, color: Colors.red),
                        label: 'Принятые заказы',
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.done_outline, color: Colors.black),
                        label: 'Принятые заказы',
                      ),
                (state is WorkerProfilePageOrderLoadedState)
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
                BlocProvider.of<WorkerNavigationBarBloc>(context)
                    .add(PageTapped(index)),
                // BlocProvider.of<NavigationBarBloc>(context).currentIndex =
                //     index,
              },
            );
          }),
        ));
  }
}
