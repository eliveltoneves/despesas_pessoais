import 'dart:io';

import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/controller/transaction_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final transactionController = TransactionController();
  bool _showChart = false;

  _addTransaction(String title, double value, DateTime date) {
    transactionController.addTransaction(title, value, date);
    Navigator.of(context).pop();
  }

  _removeTrasnsaction(String id) {
    transactionController.removeTransaction(id);
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  } 

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
      ? GestureDetector(onTap: fn, child: Icon(icon))
      : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool islandscape = mediaQuery.orientation == Orientation.landscape;
    final actions = [
      if (islandscape)
          _getIconButton(
            _showChart ? Icons.list : Icons.show_chart,
             () {
                setState(() {
                  _showChart = !_showChart;
                });
              },
             ),
        _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context),
        ),
    ];

    final  appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: actions
    );    

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*opcao para mostrar grafico em landscape com switch
             if (islandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Exibir Gráfico'),
                    Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.secondary,
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        }),
                  ],
                )*/
            if (_showChart || !islandscape)
              SizedBox(
                height: availableHeight * (islandscape ? 0.9 : 0.25),
                child: Observer(
                  builder: (_) {
                    return Chart(transactionController.recentTransactions);
                  },
                ),
              ),
            if (!_showChart || !islandscape)
              SizedBox(
                height: availableHeight * (islandscape ? 1 : 0.75),
                child: Observer(
                    builder: (context) => TransactionList(
                        transactions: transactionController.transactions,
                        onRemove: _removeTrasnsaction,
                        transactionController: transactionController)),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
