import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'package:todo_app/screens/user_profile_screen.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<Widget> screens = [
    TodoListScreen(),
    UserProfileScreen(),
  ];

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}