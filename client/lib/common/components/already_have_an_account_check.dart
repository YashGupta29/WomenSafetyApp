import 'package:flutter/material.dart';
import '../constants/colors.constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    required this.login,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            login ? "Don't have an Account? " : "Already have an Account? ",
            style: const TextStyle(color: primaryColor),
          ),
          Text(
            login ? "Signup" : "Login",
            style: const TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
