import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(),
            //expense amount
            TextField(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
