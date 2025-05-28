import 'package:sqflite/sqflite.dart';

class DbService {
  /// singleton
  DbService._();

  /// get instance
  static final getInstance = DbService._();
  Database? db;

  Database getDb() {
    if (db != null) return db!;
    db = openDb();
    return db!;
  }

  Database openDb() {}
}
