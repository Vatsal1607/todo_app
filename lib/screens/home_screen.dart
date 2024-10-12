import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/routes/routes_name.dart';

import '../providers/bottom_navigation_bar_provider.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, child) {
          return bottomNavigationProvider.screens[bottomNavigationProvider.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (BuildContext context, bottomNavigationProvider, Widget? child) {
          // bottomNavigationBar:
          return BottomNavigationBar(
            onTap: (index) {
              bottomNavigationProvider.setCurrentIndex(index);
            },
            currentIndex: bottomNavigationProvider.currentIndex,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
          );
        },
      ),

    );
  }
}
