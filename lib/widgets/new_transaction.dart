import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addHandler;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addHandler);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              //onChanged: (val) => titleInput = val,
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (val) => amountInput = val,
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: () {
                addHandler(titleController.text, double.parse(amountController.text));
              },
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
