import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../common/constants/route.constants.dart';
import '../../common/constants/colors.constants.dart';
import '../../common/components/rounded_button.dart';
import 'welcome.background.dart';

class WelcomePageBody extends StatelessWidget {
  const WelcomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // This size provides us the total height and width of the screen
    MyAppRouterConstants myAppRouterConstants = MyAppRouterConstants();
    return WelcomePageBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "WELCOME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              text: "Login",
              press: () => context.pushReplacementNamed(
                myAppRouterConstants.login.routeName,
              ),
            ),
            RoundedButton(
              text: "Signup",
              press: () => context.pushReplacementNamed(
                myAppRouterConstants.signup.routeName,
              ),
              color: primaryLightColor,
              textColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
