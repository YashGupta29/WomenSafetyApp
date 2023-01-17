import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> getLocationPermission() async {
    Map<Permission, PermissionStatus> permission =
        await [Permission.location].request();
    print('Location Service Status -> ${permission[Permission.location]}');
    return await Permission.location.status.isGranted;
  }

  static Future<bool> getSmsPermission() async {
    Map<Permission, PermissionStatus> permission =
        await [Permission.sms].request();
    print('SMS Service Status -> ${permission[Permission.sms]}');
    return await Permission.sms.status.isGranted;
  }

  static Future<bool> getPhonePermission() async {
    Map<Permission, PermissionStatus> permission =
        await [Permission.phone].request();
    print('Phone Service Status -> ${permission[Permission.phone]}');
    return await Permission.phone.status.isGranted;
  }

  static Future<bool> getCameraPermission() async {
    Map<Permission, PermissionStatus> permission =
        await [Permission.camera].request();
    print('Camera Service Status -> ${permission[Permission.camera]}');
    return await Permission.camera.status.isGranted;
  }

  static Future<bool> getContactsPermission() async {
    Map<Permission, PermissionStatus> permission =
        await [Permission.contacts].request();
    print('Contacts Service Status -> ${permission[Permission.contacts]}');
    return await Permission.contacts.status.isGranted;
  }

  static getRequiredPermissions() async {
    List<Permission> requiredPermissions = [];
    if (!(await Permission.location.status.isGranted)) {
      requiredPermissions.add(Permission.location);
    }
    if (!(await Permission.sms.status.isGranted)) {
      requiredPermissions.add(Permission.sms);
    }
    if (!(await Permission.phone.status.isGranted)) {
      requiredPermissions.add(Permission.phone);
    }
    if (!(await Permission.camera.status.isGranted)) {
      requiredPermissions.add(Permission.camera);
    }
    if (!(await Permission.contacts.status.isGranted)) {
      requiredPermissions.add(Permission.contacts);
    }
    print("Asking for necessary permissions -> $requiredPermissions");
    Map<Permission, PermissionStatus> permissions =
        await requiredPermissions.request();
    print('Location Permission Status -> ${permissions[Permission.location]}');
    print('SMS Permission Status -> ${permissions[Permission.sms]}');
    print('Phone Permission Status -> ${permissions[Permission.phone]}');
    print('Camera Permission Status -> ${permissions[Permission.camera]}');
    print('Contacts Permission Status -> ${permissions[Permission.contacts]}');
  }
}
