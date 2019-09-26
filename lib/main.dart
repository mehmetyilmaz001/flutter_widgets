import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_widgets/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  //Force app to look only potraitUp mode
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mehmet',
      home: new HomeScreen(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white))),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Dinner', amount: 22.34, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Market', amount: 101.50, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      //Get last 7 days records
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _adNewTransaction(String title, double amount, DateTime date) {
    final newItem = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(newItem);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
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
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Flutter IOS'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    _openNewTransaction(context);
                  },
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Mehmet Flutter Widget Workout'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _openNewTransaction(context),
              )
            ],
          );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment:
          //     MainAxisAlignment.start, // verticial aligment for column
          crossAxisAlignment:
              CrossAxisAlignment.stretch, //horizontal aligment for column
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart', style: Theme.of(context).textTheme.title),
                Switch.adaptive(
                  // .adaptive is for os specific design
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : Container(),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: TransactionList(_transactions, _deleteTransaction))
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openNewTransaction(context),
                  ),
            body: pageBody);
  }
}
