import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter app'),
      ),
      body: Column(
        // mainAxisAlignment:
        //     MainAxisAlignment.start, // verticial aligment for column
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
          UserTransactions()
          
        ],
      ),
    ));
  }
}
