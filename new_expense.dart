import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {

  final _titleController = TextEditingController();
  final _numController = TextEditingController();

  @override
  void dispose(){
    _titleController.dispose();
    _numController.dispose();
    super.dispose();
  }


  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;


  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: now
      );
      setState((){
        _selectedDate = pickedDate;
      });
  }

  void _submitExpenseDate(){
    final enterAmount = double.tryParse(_numController.text); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      //show error message
      showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Invalid input'), 
      content: const Text('Please enter a valid title, amount, date and category.'),
      actions: [
        TextButton(
          onPressed:() {
          Navigator.pop(ctx);
        },
        child: const Text('Okay'),
        ),
        ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: enterAmount, 
        date: _selectedDate!, 
        category: _selectedCategory
        )
      );
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16,48,16,16),
    child: Column(
      children: [
        TextField(
          maxLength: 50,
          controller: _titleController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
        ),
        Row(
          children:[
            Expanded(
              child: TextField(
                        maxLength: 50,
                        controller: _numController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
              prefixText: '\$ ',
              label: Text('Amount'),
                        ),
                      ),
            ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children:[
            Text(_selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),
            ),
            IconButton(onPressed: (){
              _presentDatePicker();
            }, 
            icon: const Icon(
              Icons.calendar_month_outlined,
              )
            )
        ],
        ),
        ),
        ],
        ),
        Row(
          children: [
            DropdownButton(
              value: _selectedCategory,
              items: Category.values.map(
              (Category)=>DropdownMenuItem(
                value: Category,
                child: Text(
                  Category.name.toUpperCase(),
                  ),
                  ),
                  )
                  .toList(),
               onChanged: (value){
                if(value==null){
                    return;
                  }
                setState((){
                  _selectedCategory = value;
                }
                );
               },
               ),
              
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Cancelled');
                },
                child: const Text('Cancel'),
              ),
            ),
            ElevatedButton(
              onPressed: _submitExpenseDate,
              child: const Text('Save')
            ),
          ],
        )
      ],
    ),
  );
}
}