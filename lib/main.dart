import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_weekly_expenses/components/chart.dart';
import 'package:flutter_weekly_expenses/components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return TransactionForm(_addTransaction);
          });
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble.toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    
    Navigator.of(context).pop();
  }

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tenis 1 ',
        value: 310.76,
        date: DateTime.now().subtract(Duration(
          days: 3
      ))
    ),
    Transaction(
        id: 't2',
        title: 'Conta de Luz 1',
        value: 221.76,
        date: DateTime.now().subtract(Duration(
          days: 4))
    ),
    Transaction(
        id: 't3',
        title: 'Novo Tenis 2',
        value: 310.76,
        date: DateTime.now()
      ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () => _openTransactionFormModal(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions),
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

