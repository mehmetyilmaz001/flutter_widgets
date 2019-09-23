import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  UserTransactions({Key key}) : super(key: key);

  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Dinner', amount: 22.34, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Market', amount: 101.50, date: DateTime.now()),
  ];

  void _adNewTransaction(String title, double amount) {
    final newItem = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[NewTransaction(_adNewTransaction), TransactionList(_transactions)]);
  }
}
