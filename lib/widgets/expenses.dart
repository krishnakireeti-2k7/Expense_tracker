import 'package:expense_tracker/widgets/expenses-list/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses-list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense1> _registeredExpenses = [
    /* This list will be filled with all the iteams created 
  */];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense1 expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

 void _removeExpense(Expense1 expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),

        backgroundColor: const Color.fromARGB(151, 0, 0, 0), // Dark background for contrast

        content: Row(
          children: [
            Expanded(
              child: Text(
                'Item Deleted', // More user-friendly message
                style: TextStyle(color: Colors.white), // White text for visibility
              ),
            ),
          ],
        ),

        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.blue, // Bright color for the action button
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        shape: RoundedRectangleBorder(
          // Rounded corners for a modern look
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating, // Floating behavior for better visibility
        margin: EdgeInsets.all(8.0), // add margin
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent;
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expanded(
        // Wrap ExpensesList in Expanded
        child: ExpensesList(expenses: _registeredExpenses, removeExpense: _removeExpense),
      );
    } else {
      mainContent = Expanded(
        child: Center(
          child: Text(
            'Start Adding your Expenses',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(128, 0, 0, 0),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFD3D3D3), // Background color of the whole screen
      body: Stack(
        children: [
          // Body content
          Column(
            children: [
              SizedBox(height: 130), // space for floating AppBar
              Chart(expenses: _registeredExpenses),
              mainContent,
            ],
          ),

          // Floating AppBar with black overlay
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(181, 0, 0, 0), // Semi-transparent black color
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Expense',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: _openAddExpenseOverlay,
                      icon: Icon(Icons.add, color: Colors.white),
                      tooltip: 'Add new expense',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
