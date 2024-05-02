import 'package:expensetracker/widgets/expenses_list/expenses_list.dart';
import 'package:expensetracker/widgets/new_expense.dart';
import 'package:expensetracker/widgets/testModal.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/models/expense.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});
 @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _resgisteredExpenses = [
    Expense(
    title: 'Flutter Course', 
    amount: 19.99, 
    date: DateTime.now(), 
    category: Category.work
    ),
    Expense(
    title: 'Cinema', 
    amount: 15.69, 
    date: DateTime.now(), 
    category: Category.leisure
    ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),

    );
  }

  void _addExpense(Expense expense){
    setState((){
      _resgisteredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _resgisteredExpenses.indexOf(expense);
    setState((){
      _resgisteredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted.'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _resgisteredExpenses.insert(expenseIndex, expense);
          }
          );
        },
        )
      ));
  }

  @override
  Widget build(context){
    Widget mainContent = const Center(child: Text("No expenses found. Start adding some!"),
    );

    if(_resgisteredExpenses.isNotEmpty){
      mainContent = ExpensesList(
            expenses: _resgisteredExpenses, 
            onRemoveExpense: _removeExpense,
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon:const Icon(Icons.add),
            )
        ],
      ),
      body: Column(
        children:[
          const Text('The chart'),
          Expanded(
            child: mainContent
          ),
        ],
    ),
    );
  }
}