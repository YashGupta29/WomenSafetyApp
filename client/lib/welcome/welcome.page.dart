import 'package:flutter/material.dart';
import 'components/welcome.body.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomePageBody(),
    );
  }
}
