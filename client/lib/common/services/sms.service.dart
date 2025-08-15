// import 'package:flutter_sms/flutter_sms.dart'; // Temporarily disabled
import 'package:flutter/material.dart';
import 'permission.service.dart';

class SmsService {
  static sendSms(
    BuildContext context,
    List<String> recipients,
    String message, {
    String? filePath,
  }) async {
    if (!(await PermissionService.getSmsPermission())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not able to proceed. Please provide sms access'),
        ),
      );
      return;
    }

    // Temporarily disabled SMS functionality - will be replaced with modern implementation
    print('SMS would be sent to: $recipients');
    print('Message: $message');
    // TODO: Implement SMS with modern package that supports current Android Gradle Plugin
  }
}
