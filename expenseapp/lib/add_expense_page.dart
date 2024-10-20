import 'package:flutter/material.dart';
import 'expense_controller.dart';

class AddExpensePage extends StatefulWidget {
  final ExpenseController controller;

  const AddExpensePage({required this.controller});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
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
        _selectedDate = picked; // Only storing the date, no time included
      });
    }
  }

  void _addExpense() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedDate != null) {
      widget.controller.addExpense(
        _titleController.text,
        double.parse(_amountController.text),
        _selectedDate!, // Date is already in DateTime format, no time included
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  : 'Selected Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'), // Show only the date part
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
