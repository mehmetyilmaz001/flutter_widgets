import 'package:flutter/material.dart';
import 'package:flutter_widgets/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mehmet',
      home: new HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.purple, 
        accentColor: Colors.amber,
        fontFamily: 'Quicksand'
        ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Dinner', amount: 22.34, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Market', amount: 101.50, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx){
      //Get last 7 days records
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

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

  void _openNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_adNewTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mehmet Flutter Widget Workout'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openNewTransaction(context),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openNewTransaction(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment:
          //     MainAxisAlignment.start, // verticial aligment for column
          crossAxisAlignment:
              CrossAxisAlignment.stretch, //horizontal aligment for column
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions)
          ],
        ),
      ),
    );
  }
}
