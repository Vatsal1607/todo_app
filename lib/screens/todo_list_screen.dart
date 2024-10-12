import 'package:flutter/material.dart';

import '../routes/routes_name.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ToDo List'),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text('Title'),
          subtitle: Text('Due date'),
          trailing: Text('Status (pending/complete)'),
        );
      }, separatorBuilder: (context, index) {
        return SizedBox();
      }, ),
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
