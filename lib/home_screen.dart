import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSyncing = false;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  void startSyncing() async {
    setState(() {
      isSyncing = true;
    });
    showNotification('Syncing SMS...');
  }

  void stopSyncing() {
    setState(() {
      isSyncing = false;
    });
    showNotification('Stopped Syncing SMS');
  }

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'This channel is used for SMS sync notifications', // Keep description relevant
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'SMS Sync',
      message,
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glowing circle effect around the check icon
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.greenAccent.withOpacity(0.5),
                      Colors.greenAccent.withOpacity(0),
                    ],
                    stops: const [0.7, 1],
                    center: Alignment.center,
                  ),
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 100,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 10),

              // Status Text
              const Center(
                child: Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 180),

              // Start Button
              ElevatedButton(
                onPressed: isSyncing ? null : startSyncing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Start Syncing'),
              ),

              const SizedBox(height: 20),

              // Stop Button
              ElevatedButton(
                onPressed: isSyncing ? stopSyncing : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Stop Syncing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
