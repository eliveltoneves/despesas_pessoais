import 'package:despesas/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final TransactionController transactionController;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onRemove,
    required this.transactionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final transactions = transactionController.transactions;

      return SizedBox(
        height: 600,
        child: transactions.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nenhuma Transação Cadastrada!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              'R\$ ${tr.value.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () => onRemove(tr.id),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
