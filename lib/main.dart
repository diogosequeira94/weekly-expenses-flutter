import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weekly_expenses/components/chart.dart';
import 'package:flutter_weekly_expenses/components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _transactionId = 0;

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return TransactionForm(_addTransaction);
          });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: _transactionId,
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    print(newTransaction.id);
    _transactionId++;
    Navigator.of(context).pop();
  }

  _removeTransaction(int id){
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _openTransactionFormModal(context))
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height
        - appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: availableHeight * 0.30,
                child: Chart(_recentTransactions)),
            Container(
              height: availableHeight * 0.70,
                child: TransactionList(_transactions, _removeTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

