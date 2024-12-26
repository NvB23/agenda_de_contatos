import 'package:agenda_de_contatos/helpers/contact.dart';
import 'package:agenda_de_contatos/helpers/contact_card.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact?> contacts = [];

  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = "Naum";
    c.email = "naum@email.com";
    c.phone = "83993699594";
    c.image = "imagetest";

    helper.saveContact(c);

    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
        print(contacts);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contatos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            contactCard(context, index, contacts);
            return null;
          }),
    );
  }
}
