import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_profile_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    // userProfileProvider.nameController.text = 'Roman Reigns';
    // userProfileProvider.emailController.text = 'roman@gmail.com';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('User Profile'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {
                // Modal bottom sheet for edit profile details (name, email)
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2 + 400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userProfileProvider.nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              suffixIcon: InkWell(
                                onTap: () =>
                                    userProfileProvider.nameController.clear(),
                                child: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: userProfileProvider.emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              suffixIcon: InkWell(
                                onTap: () =>
                                    userProfileProvider.emailController.clear(),
                                child: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Hero(
                            tag: 'add-todo-tag',
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                                onPressed: () {
                                  userProfileProvider.saveName();
                                  userProfileProvider.saveEmail();
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 5.0),
                  Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<UserProfileProvider>(
                builder: (context, userProfileProvider, child) =>
                    GestureDetector(
                  onTap: userProfileProvider.pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: userProfileProvider.profileImage != null
                        ? FileImage(userProfileProvider.profileImage!)
                        : null,
                    backgroundColor: Colors.grey.shade200,
                    child: userProfileProvider.profileImage == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey.shade700,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Hero(
                tag: 'add-todo-tag',
                child: Text(
                  'Name: ${userProfileProvider.name}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${userProfileProvider.email}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
