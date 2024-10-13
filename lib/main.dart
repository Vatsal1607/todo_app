import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/providers/add_todo_provider.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'providers/bottom_navigation_bar_provider.dart';
import 'providers/todo_list_provider.dart';
import 'providers/user_profile_provider.dart';
import 'routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz; // Import timezone data

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize timezone data
  tz.initializeTimeZones();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (_) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider<AddTodoProvider>(
          create: (_) => AddTodoProvider(),
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (_) => UserProfileProvider()..loadUserData(),
        ),
        ChangeNotifierProvider<TodoListProvider>(
          create: (_) => TodoListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.home,
        onGenerateRoute: AppRoutes.generateRoute,
        home: HomeScreen(), // Fallback home screen
      ),
    );
  }
}
