import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafeCard extends StatelessWidget {
  final String imgText;
  final String cardText;
  final String location;
  const LiveSafeCard(
      {super.key,
      required this.imgText,
      required this.cardText,
      required this.location});

  _openMap() async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    await launchUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openMap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Text(imgText),
                ),
              ),
            ),
            Text(cardText)
          ],
        ),
      ),
    );
  }
}
