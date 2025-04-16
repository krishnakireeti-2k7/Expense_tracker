import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var darkColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 99, 125));
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkColorScheme,
      ),
      home: Expenses(),
    ),
  );
}