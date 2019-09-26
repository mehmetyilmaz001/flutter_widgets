import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widgets/widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addHandler;

  NewTransaction(this.addHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final enteredDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }

    widget.addHandler(enteredTitle, enteredAmount, enteredDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickkedDate) {
      if (pickkedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickkedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  //onChanged: (val) => titleInput = val,
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  autofocus: true),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //onChanged: (val) => amountInput = val,
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMMMd().format(_selectedDate))),
                    AdaptiveFltaButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Transaction'),
                onPressed: _submitData,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
