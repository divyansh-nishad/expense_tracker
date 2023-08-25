import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
            ),
            //expense amount
            TextField(
              controller: newExpenseAmountController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  //save
  void save() {
    ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: (newExpenseAmountController.text),
        dateTime: DateTime.now());
    Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);

    Navigator.pop(context);
  }

  //cancel
  void cancel() {}

  //clear
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            //expense list
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.getExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                      name: value.getExpenseList()[index].name,
                      amount: value.getExpenseList()[index].amount,
                      dateTime: value.getExpenseList()[index].dateTime,
                    ))
          ],
        ),
      ),
    );
  }
}
