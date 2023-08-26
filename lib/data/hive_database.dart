import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDatabse {
  //reference to the hive box
  final _myBox = Hive.box('expense_database');

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpense = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      //create expense item
      ExpenseItem expenseItem = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      allExpense.add(expenseItem);
    }
    return allExpense;
  }
}
