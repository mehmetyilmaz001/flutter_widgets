import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  Widget _listEmpty(BuildContext ctx) {
    return Column(
      children: <Widget>[
        Text(
          'Empty list!',
          style: Theme.of(ctx).textTheme.title,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ))
      ],
    );
  }

  Widget _listItem(context, i) {
    Transaction tx = transactions[i];
    return (Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 1)),
            padding: EdgeInsets.all(10),
            child: Text('\$${tx.amount.toStringAsFixed(2)}',
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('dd.mm.yyyy H:s').format(tx.date),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    ));
  }

  Widget _listItem2(ctx, i) {
    Transaction tx = transactions[i];

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
            child: Text('\$${tx.amount}'),
          ),
        ),
      ),
      title: Text(
        tx.title,
        style: Theme.of(ctx).textTheme.title,
      ),
      subtitle: Text(DateFormat.yMMM().format(tx.date)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        color: Theme.of(ctx).errorColor,
        onPressed: () => this.deleteTx(tx.id),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? _listEmpty(context)
          : ListView.builder(
              itemBuilder: (ctx, i) {
                //return _listItem(ctx, i);
                return _listItem2(ctx, i);
              },
              itemCount: transactions.length,
              scrollDirection: Axis.vertical,
            ),
    );
  }
}
