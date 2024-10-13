# todo_app

A simple Flutter ToDo application that allows users to manage their tasks efficiently with a user-friendly interface and various features, including user profiles, local storage, and API integration.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [State Management](#state-management)
- [Local Storage](#local-storage)
- [Push Notifications](#push-notifications)
- [Routing](#routing)
- [Code Quality](#code-quality)
- [Version Control](#version-control)

## Features

1. **Home Screen:**
    - Displays a list of ToDo items with details: Title, Due Date, and Status (Pending/Completed).
    - Floating action button to navigate to the "Add ToDo" screen.
    - Bottom navigation bar for easy navigation between the ToDo list and user profile.

2. **Add ToDo Screen:**
    - Form with required fields: Title (Text field) and Due Date (Date Picker).
    - Priority selection (Dropdown: Low, Medium, High).
    - Input validation for required fields.
    - Redirects to home screen after adding a new ToDo item.

3. **User Profile Screen:**
    - Displays user information: Name, Email, and Profile Picture.
    - Options to update name and email, with changes saved in local storage.
    - Basic profile picture upload functionality.

4. **API Integration:**
    - Fetches sample ToDo items from a REST API ([JSONPlaceholder](https://jsonplaceholder.typicode.com/todos)).
    - Shows loading indicator while fetching data.
    - Handles error scenarios with a retry button.

5. **State Management:**
    - Utilizes Provider for state management.
    - Supports adding new ToDos and updating the list after fetching data.
    - Global state for user profile data.

6. **Local Storage:**
    - Uses SharedPreferences to save updated user profile data.
    - Persists data across app relaunches.

7. **Animations:**
    - Animated screen transitions.
    - Subtle animations for new ToDo additions.

8. **Form Validation:**
    - Validates title and due date fields with appropriate error messages.

9. **Push Notifications:**
    - Sets up Firebase for scheduling push notifications when a ToDo item’s due date approaches.

10. **Routing:**
    - Implements named routes for screen navigation.
    - Optional deep linking for specific ToDo items.

11. **Code Quality:**
    - Organized code structure with separate files for screens, models, providers, and services.
    - Clear comments and naming conventions.

12. **Version Control:**
    - Utilizes Git for version control.
    - Provides a GitHub/GitLab repository link with structured commits and branches.

## Requirements

- Flutter SDK
- Dart
- Firebase (for push notifications)
- Provider package for state management
- SharedPreferences package for local storage
- ImagePicker package (for profile picture uploads)

## Installation

1. Clone the repository:

   ```bash
   git clone <repository-link>


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
