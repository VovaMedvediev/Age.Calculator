import 'package:permission_handler/permission_handler.dart';

// ignore: avoid_classes_with_only_static_members
class Settings {
  // ignore: always_declare_return_types, type_annotate_public_apis
  static checkPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      print('status Denied');
      await Permission.notification.request();
    } else if (status.isGranted) {
      print('status Granted');
      await Permission.notification.request();
    } else if (status.isLimited) {
      print('status Limited');
    } else if (status.isRestricted) {
      print('status Restricted');
    }
  }

  static Future<bool> checkPermissionOnSettingsPage() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      print('status Denied');
      return false;
    } else if (status.isGranted) {
      print('status Granted');
      return true;
    } else if (status.isLimited) {
      print('status Limited');
      return false;
    } else {
      print('status Restricted');
      return false;
    }
  }
}
