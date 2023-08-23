import 'package:expense_tracker/models/expense_item.dart';

class ExpenseData {
  // list of all expenses
  List<ExpenseItem> overAllExpenseList = [];

  // get expense list
  List<ExpenseItem> getExpenseList() {
    return overAllExpenseList;
  }

  //add new expense
  void addExpense(ExpenseItem expenseItem) {
    overAllExpenseList.add(expenseItem);
  }

  //delete expense
  void deleteExpense(ExpenseItem expenseItem) {
    overAllExpenseList.remove(expenseItem);
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
  DateTime startOfWeekDate(DateTime dateTime) {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for(int i=0;i<7;i++)
    {
      if(getDayName(today.subtract(Duration(days: i)))=="Sun")
      {
        startOfWeek = today.subtract(Duration(days: i));
        break;
      }
    }
    return startOfWeek!; 
  }

  /*
  convert overall list of expense into daily expense summary

  e.g. overallExpenseList

  */
}
