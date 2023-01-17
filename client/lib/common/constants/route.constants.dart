import 'package:flutter/material.dart';
import '../../login/login.page.dart';
import '../../signup/signup.page.dart';
import '../../welcome/welcome.page.dart';
import '../../home/home.page.dart';

class MyAppRouterRoute {
  final String routeName;
  final String routePath;
  final Widget routePage;

  MyAppRouterRoute(
      {required this.routeName,
      required this.routePath,
      required this.routePage});
}

class MyAppRouterConstants {
  MyAppRouterRoute home = MyAppRouterRoute(
    routeName: "home",
    routePath: "/home",
    routePage: const HomePage(),
  );
  MyAppRouterRoute welcome = MyAppRouterRoute(
    routeName: "welcome",
    routePath: "/",
    routePage: const WelcomePage(),
  );
  MyAppRouterRoute login = MyAppRouterRoute(
    routeName: "login",
    routePath: "/login",
    routePage: const LoginPage(),
  );
  MyAppRouterRoute signup = MyAppRouterRoute(
    routeName: "signup",
    routePath: "/signup",
    routePage: const SignupPage(),
  );

  List<MyAppRouterRoute> getAllRoutes() {
    return <MyAppRouterRoute>[
      home,
      welcome,
      login,
      signup,
    ];
  }

  List<String> getProtectedRoutesPath() {
    return <String>[
      home.routePath,
    ];
  }

  List<String> getAuthRoutesPath() {
    return <String>[
      welcome.routePath,
      login.routePath,
      signup.routePath,
    ];
  }
}
