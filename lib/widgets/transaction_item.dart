import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

Color _bgColor;

  @override
  void initState() {
    super.initState();

    const bgColors = [
     Colors.red,
     Colors.black,
     Colors.blue,
     Colors.purple
     ];

     _bgColor = bgColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _bgColor,
        radius: 30,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
            child: Text('\$${widget.transaction.amount}'),
          ),
        ),
      ),
      title: Text(
        widget.transaction.title,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(DateFormat.yMMM().format(widget.transaction.date)),
      trailing: MediaQuery.of(context).size.width > 360
          ? FlatButton.icon(
              textColor: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
              label: Text('Delete'),
              onPressed: () => this.widget.deleteTx(widget.transaction.id),
            )
          : IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => this.widget.deleteTx(widget.transaction.id),
            ),
    );
  }
}
