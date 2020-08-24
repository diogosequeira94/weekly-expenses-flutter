import 'package:flutter/material.dart';
import 'package:flutter_weekly_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      )
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '${tr.value.toStringAsFixed(2)} €',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(tr.title,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                        )),
                    Text(
                      DateFormat('d MMM y').format(tr.date),
                      style: TextStyle(
                          color: Colors.grey[700]
                      ),),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
