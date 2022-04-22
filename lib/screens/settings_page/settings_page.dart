import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool value = false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: SwitchListTile(
              title: const Text('subscribe on topics'),
              value: value,
              onChanged: (_) {
                value = !value;
                setState(() {});
                fcmSubscribe();
              },
            ),
          ),
          TextButton(
              onPressed: () {
                sendLocalNotification(
                  'Congratulation',
                  'You subscribed to receiving push notifications',
                );
              },
              child: const Text('send test notification'),)
        ],
      ),
    );
  }

  Future<void> fcmSubscribe() async {
    if (value) {
      final isPermitted = await Settings.checkPermissionOnSettingsPage();
      if (isPermitted) {
        await firebaseMessaging.subscribeToTopic('topic');
        await sendLocalNotification(
          'Congratulation',
          'You subscribed to receiving push notifications',
        );
      } else {
        await _showMyDialog();
        value = false;
      }
    } else {
      await firebaseMessaging.unsubscribeFromTopic('topic');
      print('unsubscribed');
    }
  }

  Future<void> sendLocalNotification(String? title, String? body) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon_192');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    const channel = AndroidNotificationChannel(
      'id_channel',
      'name_channel_android',
      description: 'This channel for important notifications',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications permission'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to receive notifications?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () async {
                Navigator.pop(context);
                setState(() {});
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
