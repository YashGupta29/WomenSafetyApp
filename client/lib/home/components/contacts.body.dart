import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:women_safety_app/common/constants/route.constants.dart';
import 'package:women_safety_app/common/services/api.service.dart';
import 'package:women_safety_app/home/services/contacts.service.dart';
import 'package:go_router/go_router.dart';
import 'contacts.list.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ContactI {
  final String id;
  final String name;
  final String number;

  Map<dynamic, dynamic> _toJson() => {
        "id": id,
        "name": name,
        "number": number,
      };

  @override
  String toString() {
    return jsonEncode(_toJson());
  }

  const ContactI({
    required this.id,
    required this.name,
    required this.number,
  });
}

class ContactsPageBody extends StatefulWidget {
  const ContactsPageBody({super.key});

  @override
  State<ContactsPageBody> createState() => _ContactsPageBodyState();
}

class _ContactsPageBodyState extends State<ContactsPageBody> {
  List<ContactI> contacts = [];
  ContactsService contactsService = ContactsService();

  Future<void> _addContact() async {
    FlutterContactPicker _contactPicker = FlutterContactPicker();
    Contact? contact = await _contactPicker.selectContact();
    print('Selected contact -> $contact');
    if (contact != null) {
      bool isAlreadyPresent = false;
      for (ContactI c in contacts) {
        if (c.name == contact.fullName!) {
          isAlreadyPresent = true;
          break;
        }
      }
      if (isAlreadyPresent) {
        print('Already present contact.');
        return;
      }
      context.loaderOverlay.show();
      final ApiResponse res = await contactsService.addContact(
        contact.fullName!,
        contact.phoneNumbers![0],
      );
      context.loaderOverlay.hide();
      if (res.statusCode == StatusCode.UNAUTHORIZED) {
        print('Unauthorized');
        context.pushReplacementNamed(
          MyAppRouterConstants().login.routeName,
        );
      }
      print(
          'Contact Added -> ${res.data?["id"]} ${res.data?["name"]} ${res.data?["number"]}');
      ContactI contactAdded = ContactI(
          id: res.data?["id"],
          name: res.data?["name"],
          number: res.data?["number"]);
      contacts.add(contactAdded);
      if (mounted) {
        setState(() {
          contacts = contacts;
        });
      }
    } else {
      print('Contact selected is null');
    }
  }

  Future<void> deleteContact(String contactId) async {
    print('Deleting contact -> $contactId');
    context.loaderOverlay.show();
    final ApiResponse res = await contactsService.deleteContact(contactId);
    context.loaderOverlay.hide();
    if (res.statusCode == StatusCode.UNAUTHORIZED) {
      print('Unauthorized');
      context.pushReplacementNamed(
        MyAppRouterConstants().login.routeName,
      );
    }
    print('Contact Deleted Successfully -> ${res.isSuccess}');
    contacts.removeWhere((element) => element.id == contactId);
    if (mounted) {
      setState(() {
        contacts = contacts;
      });
    }
  }

  Future<void> _getContacts() async {
    setState(() {
      contacts = [];
    });
    context.loaderOverlay.show();
    final ApiResponse res = await contactsService.getContacts();
    context.loaderOverlay.hide();
    if (res.statusCode == StatusCode.UNAUTHORIZED) {
      print('Unauthorized');
      context.pushReplacementNamed(
        MyAppRouterConstants().login.routeName,
      );
    }
    print('Contacts -> ${res.data?["results"]}');
    List<dynamic> contactsList = res.data?["results"];
    for (dynamic c in contactsList) {
      Map<String, dynamic> contactJson = jsonDecode(jsonEncode(c));
      ContactI contactI = ContactI(
          id: contactJson["id"],
          name: contactJson["name"],
          number: contactJson["number"]);
      contacts.add(contactI);
    }
    if (mounted) {
      setState(() {
        contacts = contacts;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: ContactsPageList(
              contacts: contacts,
              deleteContact: deleteContact,
            ),
          ),
          Positioned(
            bottom: 20,
            right: size.width * 0.05,
            child: FloatingActionButton(
              onPressed: () => _addContact(),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
