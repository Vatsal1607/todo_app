import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/add_todo_provider.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add todo'),
      ),
      body: Consumer<AddTodoProvider>(
        builder: (context, addTodoProvider, child) => Form(
          key: addTodoProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // required
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'Please Enter the Title';
                    }
                  },
                ),
                SizedBox(
                  height: 30.0
                ),
                // Text('Select Due Date', style: TextStyle(fontSize: 15.0),),
                SizedBox(
                    height: 10.0
                ),
                // Consumer<AddTodoProvider>(
                //   builder: (BuildContext context, addTodoProvider, child) {
                //     return
                GestureDetector(
                  onTap: () {
                    addTodoProvider.pickDate(context);
                  },
                  child: TextFormField(
                    controller: addTodoProvider.dueDateController,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Select Due Date',
                      hintStyle: TextStyle(color: Colors.black),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Colors.grey, // Set the disabled border color here
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  //     );
                  //   },
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Select Priority:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Consumer<AddTodoProvider>(
                      builder: (BuildContext context,
                          AddTodoProvider addTodoProvider, Widget? child) {
                        return Center(
                          child: DropdownButton<String>(
                            value: addTodoProvider.selectedPriority,
                            hint: Text('Select Priority'),
                            items: addTodoProvider.priorities
                                .map((String priority) {
                              return DropdownMenuItem<String>(
                                value: priority,
                                child: Text(priority),
                              );
                            }).toList(),
                            onChanged: addTodoProvider.onChangePriority,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () {
                    if(addTodoProvider.formKey.currentState!.validate()){
                      debugPrint('Form validated');
                      if (addTodoProvider.selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a due date')),
                        );
                      } else {
                        // TODO: Add data to the todo list
                      }
                    }
                    else {
                      debugPrint('Form not validated');
                    }
                  },
                  child: Container(
                    height: 40.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
