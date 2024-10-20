// lib/expense_list_page.dart

import 'package:flutter/material.dart';
import 'expense.dart';
import 'expense_item.dart';
import 'add_expense_dialog.dart';

class ExpenseListPage extends StatefulWidget {
  @override
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final List<Expense> _expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense List')),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          return ExpenseItem(expense: _expenses[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddExpenseDialog(onAddExpense: _addExpense);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
