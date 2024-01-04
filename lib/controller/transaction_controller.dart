import 'package:mobx/mobx.dart';
import 'package:despesas/models/transaction_model.dart';

part 'transaction_controller.g.dart';

// ignore: library_private_types_in_public_api
class TransactionController = _TransactionControllerBase
    with _$TransactionController;

abstract class _TransactionControllerBase with Store {
  @observable
  ObservableList<Transaction> transactions = ObservableList<Transaction>();

  @computed
  List<Transaction> get recentTransactions {
    return transactions
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @action
  void addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      value: value,
      date: date,
    );

    transactions.add(newTransaction);
  }

  @action
  void removeTransaction(String id) {
    transactions.removeWhere((tr) => tr.id == id);
  }
}
