// lib/add_expense_dialog.dart

import 'package:flutter/material.dart';
import 'expense.dart';

class AddExpenseDialog extends StatefulWidget {
  final Function(Expense) onAddExpense;

  const AddExpenseDialog({Key? key, required this.onAddExpense}) : super(key: key);

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addExpense() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedDate != null) {
      final expense = Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate!,
      );
      widget.onAddExpense(expense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => _selectDate(context),
            child: Text(_selectedDate == null
                ? 'Select Date'
                : 'Selected Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: _addExpense,
          child: Text('Add Expense'),
        ),
      ],
    );
  }
}
