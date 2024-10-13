import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

import '../services/api_client.dart';

class TodoListProvider with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  List<TodoModel> _todoList = [];
  bool _isLoading = false;

  List<TodoModel> get todoList => _todoList;
  bool get isLoading => _isLoading;

  Future<void> fetchTodoList(context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _todoList = await _apiClient.getTodoList();
      log(_todoList.toString());
    } catch (e) {
      debugPrint('Error fetching data: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addTodo(String title, String dueDate, String priorities) {
    final newTodo = TodoModel(
      userId: 1, // Set userId as needed
      id: _todoList.length + 1, // Auto-generate a new ID or handle it as needed
      title: title,
      completed: false, // Default to false when adding a new todo
      dueDate: dueDate,
      priorities: priorities,
    );

    _todoList.add(newTodo);
    notifyListeners();
  }
}
