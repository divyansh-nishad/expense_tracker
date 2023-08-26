import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overAllExpenseList = [];

  // get expense list
  List<ExpenseItem> getExpenseList() {
    return overAllExpenseList;
  }

  //prepare data to display
  final db = HiveDatabse();
  void prepareData() {
    if(db.readData().isNotEmpty){
      overAllExpenseList = db.readData();
    }
    // notifyListeners();
  }

  //add new expense
  void addExpense(ExpenseItem expenseItem) {
    overAllExpenseList.add(expenseItem);
    db.saveData(overAllExpenseList);
    notifyListeners();
  }

  //delete expense
  void deleteExpense(ExpenseItem expenseItem) {
    overAllExpenseList.remove(expenseItem);
    db.saveData(overAllExpenseList);
    notifyListeners();
  }

  // get weekday from date time

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tues";
      case 3:
        return "Wed";
      case 4:
        return "Thurs";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  //get the date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  convert overall list of expense into daily expense summary

  e.g. overallExpenseList

  */
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overAllExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
