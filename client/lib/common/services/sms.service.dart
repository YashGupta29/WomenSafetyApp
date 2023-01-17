import 'package:background_sms/background_sms.dart';
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

    bool? supportCustomSim = await BackgroundSms.isSupportCustomSim;
    print('Does device supports custom sim -> $supportCustomSim');
    for (String number in recipients) {
      SmsStatus result;
      // Device supports custom sim
      if (supportCustomSim!) {
        result = await BackgroundSms.sendMessage(
            phoneNumber: number, message: message, simSlot: 1);
      }
      // Device doesn't support custom sim
      else {
        result = await BackgroundSms.sendMessage(
            phoneNumber: number, message: message);
      }

      if (result == SmsStatus.sent) {
        print('SMS Sent to -> $number');
        print('SMS Message -> $message');
      } else {
        print('There was a problem sending SMS');
      }
    }
  }
}
