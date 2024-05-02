import 'package:flutter/material.dart';

class TestModal extends StatefulWidget{
  TestModal({super.key});

  @override
  State<TestModal> createState(){
    return _TestModalState();
  }
} 

class _TestModalState extends State<TestModal>{
  // Widget build(context){
  //   return const Text("Modal Sheet");
  // }

  final _titleController = TextEditingController();
  final _numController = TextEditingController();

  void dispose(){
    _titleController.dispose();
    _numController.dispose();
    super.dispose();
  }
  
  Widget build(context){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title')
              ),
          ),
          TextField(
          maxLength: 50,
          controller: _numController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText: '\$ ',
            label: Text('Amount'),
            ),
            ),
        Row(
          children:[
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right:10.0),
            child: OutlinedButton(
              onPressed: (){
                Navigator.pop(context);
                print('Cancelled');
              },
              child: const Text('Cancel')
              ),
          ),
          ElevatedButton(
            onPressed: (){
            print(_titleController.text);
            print(_numController.text);
          }, 
          child: const Text('Save')
          ),
        ]
        )
      ],
      )
    );
  }
}