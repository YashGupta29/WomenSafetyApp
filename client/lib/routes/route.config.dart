import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:women_safety_app/common/constants/route.constants.dart';

class MyAppRouter {
  static final _myAppRouterConstants = MyAppRouterConstants();
  static final allRoutes = _myAppRouterConstants.getAllRoutes();
  static final allProtectedRoutesPaths =
      _myAppRouterConstants.getProtectedRoutesPath();
  static final allAuthRoutesPaths = _myAppRouterConstants.getAuthRoutesPath();
  static GoRouter getRouter(Preference<bool> isLoggedIn) {
    GoRouter router = GoRouter(
      routes: [
        ...allRoutes.map((MyAppRouterRoute myAppRouterRoute) => GoRoute(
              name: myAppRouterRoute.routeName,
              path: myAppRouterRoute.routePath,
              pageBuilder: ((context, state) =>
                  MaterialPage(child: myAppRouterRoute.routePage)),
            )),
      ],
      redirect: (context, state) {
        if (!isLoggedIn.getValue() &&
            allProtectedRoutesPaths.contains(state.location)) {
          print('Trying to access protected route -> ${state.location}');
          return _myAppRouterConstants.login.routePath;
        } else if (isLoggedIn.getValue() &&
            allAuthRoutesPaths.contains(state.location)) {
          print('Trying to access auth route -> ${state.location}');
          return _myAppRouterConstants.home.routePath;
        }
        return null;
      },
    );

    return router;
  }
}
