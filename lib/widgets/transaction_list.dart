import 'package:flutter/material.dart';
import 'package:flutter_widgets/widgets/transaction_item.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? _listEmpty(context)
          : ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                      key: ValueKey(tx.id), transaction: tx, deleteTx: deleteTx))
                  .toList(),
            ),
    );
  }
}
