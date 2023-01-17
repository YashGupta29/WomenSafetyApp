import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:women_safety_app/common/constants/colors.constants.dart';
import 'package:women_safety_app/home/components/contacts.body.dart';
import '../../common/services/api.service.dart';
import '../../common/services/image.service.dart';
import '../../common/services/location.service.dart';
import '../../common/services/sms.service.dart';
import '../services/contacts.service.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody>
    with SingleTickerProviderStateMixin {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  late double _scale;
  late AnimationController _controller;
  List<ContactI> contacts = [];
  ContactsService contactsService = ContactsService();
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _notifyContacts(BuildContext context) async {
    CurrentLocation? currentLocation =
        await LocationService.getCurrentLocation(context);

    // await CallService.triggerIncomingCall(
    //   name: "Test user",
    //   avatar: "Test Avatar",
    //   handle: "Handle",
    //   handleType: HandleType.number,
    //   hasVideo: false,
    // );

    List<ContactI> contacts = await _getContacts();
    List<String> recipients = [];
    for (ContactI contactI in contacts) {
      String number = contactI.number.split(" ").join("");
      print('Number length -> ${number.length}');
      if (number.length > 10) number = number.substring(number.length - 10);
      print(
          'Number of Contact after removing unwanted spaces and numbers -> $number');
      recipients.add(number);
    }

    List<String> imgPaths = [];
    List<XFile>? images = await ImageService.clickPictures(context);
    if (images != null) {
      for (XFile img in images) {
        print('Image path -> ${img.path}');
        String url = await ImageService.uploadImage(img.path);
        print('Images uploaded url -> $url');
        imgPaths.add(url);
      }
      ;
    } else {
      print('Not able to capture any image');
    }

    print('List of recipients - > $recipients');
    print('List of images - > $imgPaths');
    String imgS = '';

    for (String img in imgPaths) {
      imgS += "$img\n";
    }

    print('Images String -> $imgS');

    if (currentLocation != null) {
      await SmsService.sendSms(
        context,
        recipients,
        'Location: ${currentLocation.googleUrl}. \nCamera Pictures:$imgS',
      );
    }
  }

  Future<List<ContactI>> _getContacts() async {
    List<ContactI> contacts = [];
    final ApiResponse res = await contactsService.getContacts();
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

    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _scale = 1 - _controller.value;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      child: const Text(
                        "Are you in an emergency?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          height: 1.3,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.7,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Press the below button and your location will be shared with you loved ones.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Container(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 22,
                        color: secondaryLightColor,
                      ),
                    ),
                    child: GestureDetector(
                      onTapUp: _tapUp,
                      onTapDown: _tapDown,
                      onTap: () {
                        print('SOS Button Pressed');
                        _notifyContacts(context);
                      },
                      child: Transform.scale(
                        scale: _scale,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: secondaryColor,
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.sos,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
