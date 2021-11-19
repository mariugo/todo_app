import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBProvider {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'tarefas.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tarefas(id TEXT PRIMARY KEY, tarefa TEXT, data TEXT)');
    }, version: 1);
  }

  static Future<void> inserir(String tabela, Map<String, dynamic> dados) async {
    final db = await DBProvider.database();
    db.insert(
      tabela,
      dados,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> deletar(String id) async {
    final db = await DBProvider.database();
    db.delete('tarefas', where: 'id=?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String tabela) async {
    final db = await DBProvider.database();
    return db.query(tabela);
  }
}
