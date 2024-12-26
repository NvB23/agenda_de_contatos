import 'package:agenda_de_contatos/helpers/contact_helper.dart';

class Contact {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;

  Contact();

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    phone = map[phoneColumn];
    email = map[emailColumn];
    image = map[imageColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      phoneColumn: phone,
      emailColumn: email,
      imageColumn: image,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Contact(id: $id, name:$name, phone:$phone, email:$email, image:$image)';
  }
}
