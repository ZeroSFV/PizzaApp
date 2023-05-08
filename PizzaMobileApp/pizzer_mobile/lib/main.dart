import 'package:flutter/material.dart';
import 'package:pizzer_mobile/pages/pizza_catalogue_page.dart';
import 'package:pizzer_mobile/pages/client_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzer',
      home: ClientPage(),
    );
  }
}
