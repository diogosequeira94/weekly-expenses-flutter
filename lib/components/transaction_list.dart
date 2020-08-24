import 'package:flutter/material.dart';
import 'package:flutter_weekly_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final void Function(String) onRemove;
  final List<Transaction> _transactions;

  TransactionList(this._transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _transactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            'No transactions yet!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 200,
            child: Image.asset('assets/images/zzz.jpg',
            fit: BoxFit.cover),
          )
        ],
      ) : ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (ctx, index){
          final tr = _transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 5.0
            ) ,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                      child: Text('${tr.value} €')),
                ),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(tr.date)
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => onRemove(tr.id),
            ),
          ));
        },
      ),
    );
  }
}
