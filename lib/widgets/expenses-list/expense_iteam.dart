import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseIteam extends StatelessWidget {
  const ExpenseIteam(this.expense, {super.key});

  final Expense1 expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds a subtle shadow for depth
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ), // Adds spacing around the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounds the corners
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600, // Makes the title semi-bold
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space evenly
              children: [
                Text(
                  '₹${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.blueGrey[800], // Slightly darker amount
                  ),
                ),
                Row(
                  children: [
                    Container(
                      //added container for better icon background
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        catagoryIcon[expense.catagory],
                        size: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      expense.formattedDate,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
