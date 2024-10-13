import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screens/add_todo_screen.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'package:todo_app/screens/user_profile_screen.dart';

import '../screens/home_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutesName.addTodo:
        return MaterialPageRoute(builder: (_) => AddTodoScreen());
      case RoutesName.userProfile:
        return MaterialPageRoute(builder: (_) => UserProfileScreen());
      case RoutesName.todoListScreen:
        return MaterialPageRoute(builder: (_) => TodoListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            Future.delayed(Duration.zero, () {
              // Exit the app.
              SystemNavigator.pop();
            });
            return Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            );
          },
        );
    }
  }
}
