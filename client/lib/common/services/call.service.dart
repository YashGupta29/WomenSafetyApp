import 'package:flutter/material.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uuid/uuid.dart';
import 'package:women_safety_app/common/services/permission.service.dart';

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
    await FlutterIncomingCall.configure(
        appName: 'incoming_call',
        duration: 10000,
        android: ConfigAndroid(
          vibration: true,
          ringtonePath: 'default',
          channelId: 'calls',
          channelName: 'Calls channel name',
          channelDescription: 'Calls channel description',
        ),
        ios: ConfigIOS(
          iconName: 'AppIcon40x40',
          ringtonePath: null,
          includesCallsInRecents: false,
          supportsVideo: true,
          maximumCallGroups: 2,
          maximumCallsPerCallGroup: 1,
        ));

    final String uuid = Uuid().v4();
    print('Triggering Incoming Call');
    await FlutterIncomingCall.displayIncomingCall(
        uuid, name, avatar, handle, handleType, hasVideo);
  }
}
