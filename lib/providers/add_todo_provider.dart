import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo_model.dart';

class AddTodoProvider extends ChangeNotifier {
  DateTime? selectedDate;
  String? errorMessage;
  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedPriority = 'Low'; // Store the selected priority here
  final List<String> priorities = ['Low', 'Medium', 'High'];

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          DateTime.now(), // Ensure that the user cannot select a past date
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      DateTime parsedDate = DateTime.parse(selectedDate.toString());
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      // print(formattedDate);
      dueDateController.text = formattedDate;
      errorMessage = null; // Clear error message if the date is valid
      notifyListeners();
    } else {
      // dueDateController  .text = 'Select Due Date';
      errorMessage = 'Please select a valid due date.';
      notifyListeners();
    }
  }

  onChangePriority(String? newValue) {
    if(newValue != null){
      selectedPriority = newValue;
      notifyListeners();
    }
  }


}
