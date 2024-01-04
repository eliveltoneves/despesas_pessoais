import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/controller/transaction_controller.dart';
import 'package:despesas/models/transaction_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final transactionController = TransactionController();
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Observer(
              builder: (_) {
                return Chart(transactionController.recentTransactions);
              },
            ),
            Observer(
              builder: (context) =>
                  TransactionList(
                  transactions: transactionController.transactions,
                  onRemove: _removeTrasnsaction,
                  transactionController: transactionController
                )              
              
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}