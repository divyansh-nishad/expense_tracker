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
  final newExpenseRupeeController = TextEditingController();
  final newExpensePaiseController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

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
              decoration: InputDecoration(
                hintText: 'Expense Name',
              ),
            ),
            //expense amount
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseRupeeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Rupee',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: newExpensePaiseController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Paise',
                    ),
                  ),
                ),
              ],
            )
            // TextField(
            //   controller: newExpenseAmountController,
            // ),
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

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  //save
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseRupeeController.text.isNotEmpty &&
        newExpensePaiseController.text.isNotEmpty) {
      String amount =
          '${newExpenseRupeeController.text}.${newExpensePaiseController.text}';
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: (amount),
          dateTime: DateTime.now());
      Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    }
    clear();
    Navigator.pop(context);
  }

  //cancel
  void cancel() {
    clear();
    Navigator.pop(context);
  }

  //clear
  void clear() {
    newExpenseNameController.clear();
    newExpenseRupeeController.clear();
    newExpensePaiseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            const SizedBox(
              height: 20,
            ),
            //expense list
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.getExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                      name: value.getExpenseList()[index].name,
                      amount: value.getExpenseList()[index].amount,
                      dateTime: value.getExpenseList()[index].dateTime,
                      deleteTapped: (p0) =>
                          deleteExpense(value.getExpenseList()[index]),
                    ))
          ],
        ),
      ),
    );
  }
}
