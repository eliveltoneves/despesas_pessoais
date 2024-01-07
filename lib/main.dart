import 'package:despesas/controller/transaction_controller.dart';
import 'package:despesas/screens/home_page.dart';

import 'package:flutter/material.dart';

void main() => runApp(Despesas());

class Despesas extends StatelessWidget {
  final transactionController = TransactionController();
  Despesas({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const Homepage(),
      theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            labelLarge: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          appBarTheme: const AppBarTheme(
              color: Colors.purple,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    );
  }
}