import 'package:flutter/material.dart';
import 'contacts.body.dart';

class ContactsPageList extends StatelessWidget {
  final Function deleteContact;
  ContactsPageList({
    Key? key,
    required this.contacts,
    required this.deleteContact,
  }) : super(key: key);

  final List<ContactI> contacts;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.82,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 15,
          ),
          ...contacts.map(
            (ContactI contact) => ContactCard(
              contact: contact,
              deleteContact: deleteContact,
            ),
          )
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final ContactI contact;
  final Function deleteContact;
  const ContactCard({
    Key? key,
    required this.contact,
    required this.deleteContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        elevation: 3,
        child: Container(
          width: size.width * 0.9,
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    contact.number,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => deleteContact(contact.id),
              child: const Center(
                child: Icon(
                  Icons.delete,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
