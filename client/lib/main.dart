import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:women_safety_app/routes/route.config.dart';
import 'package:women_safety_app/common/constants/colors.constants.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  StreamingSharedPreferences sf = await StreamingSharedPreferences.instance;
  Preference<bool> isLoggedIn = sf.getBool("isLoggedIn", defaultValue: false);
  print('Is user logged in -> ${isLoggedIn.getValue()}');
  final GoRouter appRouter = MyAppRouter.getRouter(isLoggedIn);
  return runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Women Security App',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
    ),
  );
}
