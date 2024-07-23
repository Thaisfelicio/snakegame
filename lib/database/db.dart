import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  //construtor com acesso privado
  DB._();
  //criar uma instancia de DB
  static final DB instance = DB._();
  //instancia do sqlite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'JOGOCOBRINHA.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_usuario);
    await db.execute(_historicoPontos);
  }

  String get _usuario => '''
    CREATE TABLE usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT,
      senha TEXT,
      maiorPontuacao INTEGER
    );
  ''';

  String get _historicoPontos => '''
    CREATE TABLE historico (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pontos INTEGER
    );
  ''';
}
