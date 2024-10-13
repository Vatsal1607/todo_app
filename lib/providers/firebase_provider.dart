import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz; // Import the timezone package
import 'package:timezone/data/latest.dart' as tz; // Import timezone data
import '../models/todo_model.dart';

class FirebaseProvider with ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  FirebaseProvider() {
    requestPermission();
    initializeLocalNotifications();
    setupMessageHandlers();
    debugPrint('FirebaseProvider called');
  }

  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'your_channel_id',
              'your_channel_name',
              channelDescription: 'your_channel_description',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');
  }

  // Future<void> scheduleNotification(TodoModel todo) async {
  //   // Parse the dueDate string into a DateTime object
  //   DateTime dueDateTime = DateTime.parse(todo.dueDate.toString()); // Ensure the date format is "YYYY-MM-DD"
  //
  //   // Set the notification to trigger at the start of the due date
  //   // var scheduledDate = tz.TZDateTime.from(
  //   //   DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day, 9, 0), // Example: Notify at 9:00 AM on due date
  //   //   tz.local, // Use local timezone
  //   // );
  //
  //
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     int.parse(todo.id.toString()), // Unique ID for the notification
  //     'Todo Reminder',
  //     'Your todo "${todo.title}" is due today!',
  //     scheduledDate, // Trigger exactly at the due date
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'your_channel_id',
  //         'your_channel_name',
  //         channelDescription: 'your_channel_description',
  //       ),
  //     ),
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //     UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  Future<void> scheduleNotification(TodoModel todo) async {
    // Parse the dueDate string into a DateTime object
    DateTime dueDateTime = DateTime.parse(todo.dueDate.toString()); // Ensure the date format is "YYYY-MM-DD"

    // Create a DateTime object for the start of the due date
    DateTime scheduleDate = DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);

    // If the due date is today, set the time to now + 1 second to ensure it is in the future
    DateTime now = DateTime.now();
    if (scheduleDate.isBefore(now) || scheduleDate.isAtSameMomentAs(now)) {
      scheduleDate = now.add(Duration(seconds: 1));
    }

    // Convert to TZDateTime
    var scheduledDate = tz.TZDateTime.from(scheduleDate, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(todo.id.toString()), // Unique ID for the notification
      'Todo Reminder',
      'Your todo "${todo.title}" is due today!',
      scheduledDate, // Schedule immediately if the due date is today
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }



}
