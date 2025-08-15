import 'package:flutter/material.dart';
// import 'package:flutter_incoming_call/flutter_incoming_call.dart'; // Temporarily disabled
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uuid/uuid.dart';
import 'package:women_safety_app/common/services/permission.service.dart';

// Temporary enum to replace HandleType from flutter_incoming_call
enum HandleType { number, generic }

class CallService {
  static callNumber(BuildContext context, String number) async {
    if (!(await PermissionService.getPhonePermission())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not able to proceed. Please provide calling access'),
        ),
      );
      return;
    }

    print('Calling on Number -> $number');
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  static triggerIncomingCall({
    required String name,
    required String avatar,
    required String handle,
    required HandleType handleType,
    required bool hasVideo,
  }) async {
    // Temporarily disabled incoming call functionality - will be replaced with modern implementation
    print('Incoming call feature temporarily disabled');
    print('Would trigger call for: $name ($handle)');
    // TODO: Implement incoming call with modern package that supports current Android Gradle Plugin
  }
}
