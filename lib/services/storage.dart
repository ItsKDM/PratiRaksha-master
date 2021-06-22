import "package:path_provider/path_provider.dart";
import "dart:async";
import "dart:io" as io;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import '../models/contactModel.dart';

class Storage {
  static Database _db;
  static const String NUMBER = 'number';
  static const String TABLE = 'contacts';
  static const String DB_NAME = 'contactsdb.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($NUMBER TEXT PRIMARY KEY)");
  }

  Future<ContactModel> save(ContactModel newContact) async {
    var dbClient = await db;
    var res = await dbClient.insert(TABLE, newContact.toMap());
    return newContact;
  }

  Future<List<ContactModel>> getContacts() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [NUMBER]);
    List<ContactModel> contacts = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        contacts.add(ContactModel.fromMap(maps[i]));
      }
    }
    return contacts;
  }

  Future<int> delete(String number) async {
    var dbClient = await db;
    return await dbClient
        .delete(TABLE, where: '$NUMBER = ?', whereArgs: [number]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
