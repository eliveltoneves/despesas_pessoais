// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionController on _TransactionControllerBase, Store {
  Computed<List<Transaction>>? _$recentTransactionsComputed;

  @override
  List<Transaction> get recentTransactions => (_$recentTransactionsComputed ??=
          Computed<List<Transaction>>(() => super.recentTransactions,
              name: '_TransactionControllerBase.recentTransactions'))
      .value;

  late final _$transactionsAtom =
      Atom(name: '_TransactionControllerBase.transactions', context: context);

  @override
  ObservableList<Transaction> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<Transaction> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$_TransactionControllerBaseActionController =
      ActionController(name: '_TransactionControllerBase', context: context);

  @override
  void addTransaction(String title, double value, DateTime date) {
    final _$actionInfo = _$_TransactionControllerBaseActionController
        .startAction(name: '_TransactionControllerBase.addTransaction');
    try {
      return super.addTransaction(title, value, date);
    } finally {
      _$_TransactionControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTransaction(String id) {
    final _$actionInfo = _$_TransactionControllerBaseActionController
        .startAction(name: '_TransactionControllerBase.removeTransaction');
    try {
      return super.removeTransaction(id);
    } finally {
      _$_TransactionControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
transactions: ${transactions},
recentTransactions: ${recentTransactions}
    ''';
  }
}
