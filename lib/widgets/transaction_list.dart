import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  Widget _listEmpty(BuildContext ctx) {
    return LayoutBuilder(builder: (ctx, constraints) {
      Column(
        children: <Widget>[
          Text(
            'Empty list!',
            style: Theme.of(ctx).textTheme.title,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ))
        ],
      );
    });
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
      trailing: MediaQuery.of(ctx).size.width > 360
          ? FlatButton.icon(
              textColor: Theme.of(ctx).errorColor,
              icon: Icon(Icons.delete),
              label: Text('Delete'),
              onPressed: () => this.deleteTx(tx.id),
            )
          : IconButton(
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
