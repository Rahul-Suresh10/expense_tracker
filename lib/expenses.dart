import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        date: DateTime.now(),
        amount: 4.99,
        category: Category.leisure),
    Expense(
        title: 'Cinema',
        date: DateTime.now(),
        amount: 7.8,
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(
              addExpense: addExpense,
            ));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Expense deleted'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(child: Text('List is empty'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
