import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_list_provider.dart';

import '../models/todo_model.dart';
import '../providers/add_todo_provider.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
      ),
      body: Consumer<AddTodoProvider>(
        builder: (context, addTodoProvider, child) => Form(
          key: addTodoProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: addTodoProvider.titleController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 30.0),
                // Text('Select Due Date', style: TextStyle(fontSize: 15.0),),
                const SizedBox(height: 10.0),
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
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
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
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Select Priority:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Consumer<AddTodoProvider>(
                      builder: (BuildContext context,
                          AddTodoProvider addTodoProvider, Widget? child) {
                        return Center(
                          child: DropdownButton<String>(
                            value: addTodoProvider.selectedPriority,
                            // hint: const Text('Select Priority'),
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
                const SizedBox(height: 30.0),
                Consumer<TodoListProvider>(
                  builder: (context, todoListProvider, child) =>
                      GestureDetector(
                    onTap: () {
                      if (addTodoProvider.formKey.currentState!.validate()) {
                        debugPrint('Form validated');
                        if (addTodoProvider.selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select a due date')),
                          );
                        } else {
                          debugPrint(
                              'Title is: ${addTodoProvider.titleController.text}');
                          debugPrint(
                              'Due date is: ${addTodoProvider.dueDateController.text}');
                          debugPrint(
                              'Selected priority is: ${addTodoProvider.selectedPriority}');
                          debugPrint(
                              'TodoList Length (on Save) is: ${todoListProvider.todoList.length}');

                          /// Add data to the todoList
                          todoListProvider.addTodo(
                            addTodoProvider.titleController.text,
                            addTodoProvider.dueDateController.text,
                            addTodoProvider.selectedPriority,
                          );
                          addTodoProvider.titleController.clear();
                          addTodoProvider.dueDateController.clear();
                          addTodoProvider.selectedPriority = 'Low';
                          Navigator.pop(context);
                        }
                      } else {
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
                      child: const Center(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
