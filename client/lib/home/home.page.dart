import 'package:flutter/material.dart';
import 'package:women_safety_app/common/services/permission.service.dart';
import 'package:women_safety_app/home/components/contacts.body.dart';
import 'package:women_safety_app/home/components/home.body.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../common/services/api.service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  Future<void> getLocalData() async {
    StreamingSharedPreferences sf = await StreamingSharedPreferences.instance;
    final isLoggedIn = sf.getBool("isLoggedIn", defaultValue: false);
    final authToken = sf.getString("authToken", defaultValue: "");
    final user = sf.getString("user", defaultValue: "");
    print('User Logged in -> ${isLoggedIn.getValue()}');
    print('User Auth Token -> ${authToken.getValue()}');
    print('User Data -> ${user.getValue()}');
  }

  Future<void> deleteAuthData(BuildContext context) async {
    StreamingSharedPreferences sf = await StreamingSharedPreferences.instance;
    sf.remove("isLoggedIn");
    sf.remove("authToken");
    sf.remove("user");
    context.pushReplacementNamed("login");
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    getLocalData();
    PermissionService.getRequiredPermissions();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _selectedPage == 0 ? "HOME" : "CONTACTS",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:
          _selectedPage == 0 ? const HomePageBody() : const ContactsPageBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _selectedPage == 0 ? Colors.red : Colors.black,
        onPressed: () => setState(
          () {
            _selectedPage = 0;
          },
        ),
        child: const Icon(Icons.sos),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.contacts,
                  color: _selectedPage == 1 ? Colors.red : Colors.black,
                ),
                onPressed: () => setState(
                  () {
                    _selectedPage = 1;
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => deleteAuthData(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
