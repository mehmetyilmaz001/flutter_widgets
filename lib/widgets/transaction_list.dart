import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  Widget _listEmpty(BuildContext ctx){
    return Column(
      children: <Widget>[
        Text('Empty list!', style: Theme.of(ctx).textTheme.title,),
        SizedBox(height: 20,),
        Container(height: 200, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty ? _listEmpty(context) : ListView.builder(
        itemBuilder: (ctx, index) {
          Transaction tx = transactions[index];
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${tx.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Theme.of(context).primaryColor,
                  )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tx.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('dd.mm.yyyy H:s').format(tx.date),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
