import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:women_safety_app/common/services/location.service.dart';
import 'package:women_safety_app/common/services/sms.service.dart';

class SafeHome extends StatefulWidget {
  const SafeHome({super.key});

  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        print('Phone is shaking');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );

        // Do stuff on phone shake
        _sendMessage(context);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  _sendMessage(BuildContext context) async {
    CurrentLocation? currentLocation =
        await LocationService.getCurrentLocation(context);
    if (currentLocation == null) {
      print('Error in getting current location');
      return;
    }
    // SmsService.sendSms(context, '09599638983',
    //     'Hello, Need help. \nMy Current Location is -> ${currentLocation.googleUrl}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (() async {
        _sendMessage(context);
      }),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: size.width * 0.92,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    ListTile(
                      title: Text("Send Location"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
