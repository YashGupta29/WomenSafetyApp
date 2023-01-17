import 'package:flutter/material.dart';
import 'package:women_safety_app/common/components/emergency_card.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          EmergencyCard(
            emergencyTitle: "Active Emergency",
            emergencyText: "Call 1-0-0 for emergency",
            emergencyNumber: '1-0-0',
          ),
          EmergencyCard(
            emergencyTitle: "Ambulance",
            emergencyText: "In case of medical emergency",
            emergencyNumber: '1-0-2',
          ),
          EmergencyCard(
            emergencyTitle: "Fire brigade",
            emergencyText: "In case of fire emergency",
            emergencyNumber: '1-0-1',
          ),
        ],
      ),
    );
  }
}
