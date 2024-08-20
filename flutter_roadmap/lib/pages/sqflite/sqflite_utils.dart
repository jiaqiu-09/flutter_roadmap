import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  return await openDatabase(
    join(await getDatabasesPath(), 'my_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)',
      );
    },
    version: 1,
  );
}

Future<void> insertItem(Database db, Map<String, dynamic> item) async {
  await db.insert(
    'items',
    item,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map<String, dynamic>>> getItems(Database db) async {
  return await db.query('items');
}

Future<void> updateItem(Database db, Map<String, dynamic> item) async {
  await db.update(
    'items',
    item,
    where: 'id = ?',
    whereArgs: [item['id']],
  );
}

Future<void> deleteItem(Database db, int id) async {
  await db.delete(
    'items',
    where: 'id = ?',
    whereArgs: [id],
  );
}
