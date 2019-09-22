import 'package:flutter/material.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Dinner', amount: 22.34, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Market', amount: 101.50, date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter app'),
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, // verticial aligment for column
        crossAxisAlignment:
            CrossAxisAlignment.stretch, //horizontal aligment for column
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('Chart'),
              elevation: 5,
            ),
          ),
          Column(
              children: transactions.map((tx) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 1)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      tx.amount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(tx.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      Text(tx.date.toString(), style: TextStyle(color: Colors.grey),),
                    ],
                  )
                ],
              ),
            );
          }).toList())
        ],
      ),
    ));
  }
}
