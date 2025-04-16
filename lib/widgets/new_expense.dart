import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:delightful_toast/delight_toast.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense1 expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Catagory _selectedCatagory = Catagory.others;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmout = double.tryParse(
      _amountController.text,
    ); //tryPrase("hello") => null, tryParse('1.3) => 1.3
    final invalidAmout = enteredAmout == null || enteredAmout <= 0;
    if (_titleController.text.trim().isEmpty) {
      // toast of empty title
      DelightToastBar(
        builder: (context) {
          return ToastCard(
            title: Text(
              'Give Valid Input',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            leading: Icon(Icons.warning_amber_rounded),
          );
        },
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: Duration(seconds: 2),
      ).show(context);
    } else if (invalidAmout) {
      //toast for invalid amount
      DelightToastBar(
        builder: (context) {
          return ToastCard(
            title: Text(
              'Enter Valid Amout',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            leading: Icon(Icons.warning_amber_rounded),
          );
        },
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: Duration(seconds: 2),
      ).show(context);
    } else if (_selectedDate == null) {
      // toast for not sleceting date
      DelightToastBar(
        builder: (context) {
          return ToastCard(
            title: Text('Select Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            leading: Icon(Icons.warning_amber_rounded),
          );
        },
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: Duration(seconds: 2),
      ).show(context);
    }
    widget.onAddExpense(
      Expense1(
        title: _titleController.text,
        amount: enteredAmout!,
        date: _selectedDate!,
        catagory: _selectedCatagory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Name Expense TextField
          TextField(
            controller: _titleController,
            autocorrect: true,
            maxLength: 50,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Name Expense',
              labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          SizedBox(height: 12),

          // Amount & Date Row
          Row(
            children: [
              // Amount Field
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    prefixText: '₹ ',
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),

              // Date Picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null ? 'Select Date' : formatter.format(_selectedDate!),
                      style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_today, color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 30),

          // Dropdown for Category
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<Catagory>(
              value: _selectedCatagory,
              items:
                  Catagory.values
                      .map(
                        (catagory) => DropdownMenuItem(
                          value: catagory,
                          child: Text(
                            catagory.name.toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCatagory = value;
                });
              },
              underline: SizedBox(),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              dropdownColor: Colors.white,
            ),
          ),

          SizedBox(height: 24),

          // Save & Cancel Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Save Button (on the left)
              ElevatedButton(
                onPressed: () {
                  submitExpenseData();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 4,
                ),
                child: Text('Save', style: TextStyle(fontSize: 15)),
              ),

              // Cancel Button (on the right)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black.withOpacity(0.2)),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 2,
                ),
                child: Text('Cancel', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
