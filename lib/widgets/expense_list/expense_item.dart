import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseItem, {super.key});

  final Expense expenseItem;

  @override
  Widget build(context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              children: [
                Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
                const Spacer(), //Takes all available space
                Row(
                  children: [
                    Icon(categoryIcons[expenseItem.category]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(expenseItem.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
