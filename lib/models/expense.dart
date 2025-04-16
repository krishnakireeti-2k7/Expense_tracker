import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat('MMMM dd, yy');

enum Catagory { food, travel, knowlege, leisure, others }

const catagoryIcon = {
  Catagory.food: Icons.lunch_dining,
  Catagory.knowlege: Icons.book,
  Catagory.leisure: Icons.movie,
  Catagory.travel: Icons.location_pin,
  Catagory.others: Icons.more_rounded,
};

class Expense1 {
  Expense1({
    required this.title,
    required this.amount,
    required this.date,
    required this.catagory,
  }) : id = uuid.v4(); // this will generate and unique id
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Catagory catagory;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.catagory, required this.expenses});

  ExpenseBucket.forCatagory(List<Expense1> allExpenses, this.catagory)
    : expenses =
          allExpenses.where((element) => element.catagory == catagory).toList();

  final Catagory catagory;
  final List<Expense1> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
