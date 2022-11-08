import 'dart:async';
import 'package:agenda_contatos/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          """
            CREATE TABLE $contactTable(
              $idColumn INTEGER PRIMARY KEY, 
              $nameColumn TEXT,
              $emailColumn TEXT,
              $phoneColumn TEXT,
              $imageColumn TEXT
            )
          """,
        );
      },
    );
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap() as Map<String, Object?>);
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database dbContact = await db;

    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.isNotEmpty) return Contact.fromMap(maps.first);

    return null;
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(
      contactTable,
      where: "$idColumn = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(
      contactTable,
      contact.toMap() as Map<String, Object?>,
      where: "$idColumn = ?",
      whereArgs: [contact.id],
    );
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await db;

    List<Map> listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = [];

    for (var element in listMap) {
      listContact.add(Contact.fromMap(element));
    }

    return listContact;
  }

  Future<int?> getTotalContact() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future<void> close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
