import 'package:flutter/material.dart';
import 'package:women_safety_app/common/components/live_safe_card.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          LiveSafeCard(
            imgText: "PS",
            cardText: "Police Stations",
            location: "Police Stations near me",
          ),
          LiveSafeCard(
            imgText: "HO",
            cardText: "Hospitals",
            location: "Hospitals near me",
          ),
          LiveSafeCard(
            imgText: "PH",
            cardText: "Pharmacy",
            location: "Pharmacy near me",
          ),
          LiveSafeCard(
            imgText: "BS",
            cardText: "Bus Stations",
            location: "Bus Stations near me",
          ),
        ],
      ),
    );
  }
}
