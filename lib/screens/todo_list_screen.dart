import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_list_provider.dart';

import '../routes/routes_name.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using `addPostFrameCallback` to ensure the method is called after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoListProvider>().fetchTodoList(context);
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ToDo List'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: GestureDetector(
              onTap: () {
                context.read<TodoListProvider>().fetchTodoList(context);
              },
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, todoListProvider, child) {
          if (todoListProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (todoListProvider.todoList.isEmpty) {
            return const Center(
              child: Text(
                'No items found.',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }
          return ListView.separated(
            // reverse: true,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 15.0,
            ),
            itemCount: todoListProvider.todoList.length,
            itemBuilder: (context, index) {
              debugPrint(
                  'TodoList Length is (list builder): ${todoListProvider.todoList.length}');
              final todo = todoListProvider.todoList.reversed.toList()[index];
              return ListTile(
                tileColor: Colors.grey.withOpacity(0.3),
                title: Text('Title: ${todo.title}'),
                subtitle: Row(
                  children: [
                    Text('${todo.id}'),
                    const SizedBox(width: 10.0),
                    Text('Due date: ${todo.dueDate ?? ''}'),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Status: ${todo.completed}',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    if (todo.priorities != null && todo.priorities!.isNotEmpty)
                      Text(
                        'Priority: ${todo.priorities ?? ''}',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10.0);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addTodo);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
