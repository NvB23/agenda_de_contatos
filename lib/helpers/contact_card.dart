import 'dart:io';

import 'package:agenda_de_contatos/helpers/contact.dart';
import 'package:flutter/material.dart';

Widget contactCard(BuildContext context, int index, List<Contact?> contacts) {
  return GestureDetector(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index]!.image != null
                          ? FileImage(File(contacts[index]!.image!))
                              as ImageProvider<Object>
                          : const AssetImage("images/person.png"))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text(
                    contacts[index]!.name ?? "",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    contacts[index]!.email ?? "",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    contacts[index]!.phone ?? "",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
