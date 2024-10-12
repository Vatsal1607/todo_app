import 'package:flutter/material.dart';
import 'package:todo_app/providers/add_todo_provider.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'providers/bottom_navigation_bar_provider.dart';
import 'routes/routes_name.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
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
      ),
    );
  }
}
