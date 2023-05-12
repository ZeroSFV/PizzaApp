import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_blocs.dart';
import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_events.dart';
import 'package:pizzer_mobile/blocs/navigation_bar/navigation_bar_states.dart';
import 'package:pizzer_mobile/pages/basket_page.dart';
import 'package:pizzer_mobile/pages/pizza_catalogue_page.dart';

class ClientOrderPage extends StatelessWidget {
  String? token;
  ClientOrderPage({super.key, this.token});

  Widget build(BuildContext context) {
    return Text("50");
  }
}
