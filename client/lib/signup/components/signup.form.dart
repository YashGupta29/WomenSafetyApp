import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:women_safety_app/common/services/api.service.dart';
import 'package:women_safety_app/signup/services/signup.service.dart';
import '../../common/components/rounded_button.dart';
import '../../common/components/rounded_input_field.dart';
import '../../common/components/rounded_password_field.dart';
import '../../common/constants/route.constants.dart';

class SignupPageForm extends StatefulWidget {
  const SignupPageForm({super.key});

  @override
  State<SignupPageForm> createState() => _SignupPageFormState();
}

class _SignupPageFormState extends State<SignupPageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MyAppRouterConstants myAppRouterConstants = MyAppRouterConstants();
    SignupService signupService = SignupService();
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        RoundedInputField(
          hintText: "Your Email",
          onChanged: ((value) {}),
          validator: (p0) {
            if (p0 == null || p0.isEmpty) return "Email can't be empty";
            if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(p0)) {
              return "Enter valid Email Address";
            }

            return null;
          },
          fieldValue: email,
        ),
        RoundedPasswordField(
          onChanged: (value) {},
          validator: (p0) {
            if (p0 == null || p0.isEmpty) return "Password can't be empty";
            return null;
          },
          fieldValue: password,
        ),
        RoundedButton(
          text: "Signup",
          press: () async {
            if (_formKey.currentState!.validate()) {
              print("Validated");
              print('Email -> ${email.text}');
              print('Password -> ${password.text}');
              context.loaderOverlay.show();
              final ApiResponse res =
                  await signupService.signupWithEmailAndPassword(
                email.text,
                password.text,
              );
              context.loaderOverlay.hide();
              print('User Signup Completed Response -> ${res.data}');
              if (res.isSuccess) {
                StreamingSharedPreferences sf =
                    await StreamingSharedPreferences.instance;
                sf.setBool(
                  "isLoggedIn",
                  true,
                );
                sf.setString(
                  "authToken",
                  res.data?["tokens"]?["access"]?["token"],
                );
                sf.setString(
                  "user",
                  jsonEncode(res.data?['user']),
                );
                context.pushReplacementNamed(
                  myAppRouterConstants.home.routeName,
                );
              }
            } else {
              print("Not Validated");
            }
          },
        ),
      ]),
    );
  }
}
