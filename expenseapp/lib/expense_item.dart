// lib/expense_item.dart

import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          expense.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Amount: \$${expense.amount.toStringAsFixed(2)}\nDate: ${expense.date.toLocal().toString().split(' ')[0]}',
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.money),
      ),
    );
  }
}
