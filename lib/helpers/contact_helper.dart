import 'dart:async';

import 'package:agenda_de_contatos/helpers/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String contactTable = "contactTable";
const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String phoneColumn = "phoneColumn";
const String emailColumn = "emailColumn";
const String imageColumn = "imageColumn";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper._internal();

  factory ContactHelper() => _instance;

  ContactHelper._internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'contacts_new.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute(
            "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $phoneColumn TEXT, $emailColumn TEXT, $imageColumn TEXT)");
      },
    );
  }

  Future<Contact> saveContact(Contact contact) async {
    final Database? dbContact = await db;
    contact.id = await dbContact!.insert(
      contactTable,
      contact.toMap(),
    );
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    final Database? dbContact = await db;
    List<Map> maps = await dbContact!.query(contactTable,
        columns: [idColumn, nameColumn, phoneColumn, emailColumn, imageColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    final Database? dbContact = await db;
    return await dbContact!
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    final Database? dbContact = await db;
    return await dbContact!.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    final Database? dbContact = await db;
    List listMap = await dbContact!.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = [];
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int?> getNumberContacts(int id) async {
    final Database? dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact!.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future<void> closeDb() async {
    final Database? dbContact = await db;
    dbContact!.close();
  }
}
