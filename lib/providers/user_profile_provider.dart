import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileProvider extends ChangeNotifier {
  File? profileImage;
  String name = '';
  String email = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // Save the name to SharedPreferences
  Future<void> saveName() async {
    name = nameController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    notifyListeners();
  }

  // Save the email to SharedPreferences
  Future<void> saveEmail() async {
    email = emailController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    notifyListeners();
  }

  // Load data from SharedPreferences when the provider is initialized
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? 'Roman Reigns';
    email = prefs.getString('email') ?? 'roman@gmail.com';
    nameController.text = prefs.getString('name') ?? 'Roman Reigns';
    emailController.text = prefs.getString('email') ?? 'roman@gmail.com';
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  // show modal bottom sheet
}
