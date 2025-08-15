import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:women_safety_app/common/constants/route.constants.dart';
import 'package:women_safety_app/common/services/api.service.dart';
import 'package:women_safety_app/home/services/contacts.service.dart' as app_contacts;
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
  app_contacts.ContactsService contactsService = app_contacts.ContactsService();

  Future<void> _addContact() async {
    List<Contact> systemContacts = await FastContacts.getAllContacts();
    // For demonstration, we'll take the first contact
    // In a real app, you'd show a picker dialog
    Contact? contact = systemContacts.isNotEmpty ? systemContacts.first : null;
    print('Selected contact -> $contact');
    if (contact != null && contact.phones.isNotEmpty) {
      bool isAlreadyPresent = false;
      for (ContactI c in this.contacts) {
        if (c.name == contact.displayName) {
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
        contact.displayName,
        contact.phones[0].number,
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
      this.contacts.add(contactAdded);
      if (mounted) {
        setState(() {
          this.contacts = this.contacts;
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
