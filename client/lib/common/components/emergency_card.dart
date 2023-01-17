import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:women_safety_app/common/constants/colors.constants.dart';
import 'package:women_safety_app/common/services/call.service.dart';

class EmergencyCard extends StatelessWidget {
  final String emergencyTitle;
  final String emergencyText;
  final String emergencyNumber;
  const EmergencyCard(
      {super.key,
      required this.emergencyTitle,
      required this.emergencyText,
      required this.emergencyNumber});

  _callNumber(BuildContext context) async {
    final number = emergencyNumber.split("-").join("");
    await CallService.callNumber(context, number);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _callNumber(context),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          bottom: 5,
        ),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Container(
            height: 180,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryMediumColor,
                  primaryColor,
                  primaryMediumColor,
                  primaryColor,
                  primaryMediumColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    emergencyTitle,
                    style: TextStyle(
                      color: primaryLightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.06,
                    ),
                  ),
                  Text(
                    emergencyText,
                    style: TextStyle(
                      color: primaryLightColor,
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        emergencyNumber,
                        style: TextStyle(
                          color: primaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.050,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
