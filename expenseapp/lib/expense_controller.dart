import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseController extends ChangeNotifier {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(String title, double amount, DateTime date) {
    _expenses.add(Expense(title: title, amount: amount, date: date));
    notifyListeners(); // Important: Call this to update UI
  }
}
