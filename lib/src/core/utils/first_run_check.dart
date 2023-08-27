import 'package:sqlite3/sqlite3.dart';

abstract class FirstRunCheck {
  Future<void> check();
}

class FirstRunCheckSQLite implements FirstRunCheck {
  final Database db;
  FirstRunCheckSQLite({required this.db});
  @override
  Future<void> check() async {
    db.execute("""
      CREATE TABLE if not exists contacts(
        id INTEGER NOT NULL PRIMARY KEY,
        contactJson TEXT NOT NULL
      );
    """);
  }
}
