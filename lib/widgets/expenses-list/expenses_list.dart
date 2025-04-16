import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses-list/expense_iteam.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.removeExpense});

  final List<Expense1> expenses;
  final void Function(Expense1 expense) removeExpense;

  @override
  Widget build(BuildContext context) {
  
    // TODO: implement build
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseIteam(expenses[index]),
          ),
    );
  }
}
