import 'package:snakegame/database/user_model.dart';
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
      version: 2,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_usuario);
    await db.execute(_pontuacoes);
  }

  String get _usuario => '''
    CREATE TABLE usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT,
      senha TEXT,
      maiorPontuacao INTEGER
    );
  ''';

  String get _pontuacoes => '''
    CREATE TABLE pontuacoes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usuarioId INTEGER,
      pontuacao INTEGER,
      FOREIGN KEY (usuarioId) REFERENCES usuario(id)
    );
  ''';

  Future<UserModel?> autenticarUsuario(UserModel user) async {
    final Database database = await _initDatabase();

    var res = await database.rawQuery(
        "SELECT * FROM usuario WHERE email = ? AND senha = ?",
        [user.email, user.senha]);

    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    } else {
      return null;
    }
  }

  Future<int> criarUsuario(UserModel user) async {
    final Database database = await _initDatabase();

    return database.insert("usuario", user.toMap());
  }

  Future<void> inserirPontuacao(int usuarioId, int pontuacao) async {
    final Database database = await _initDatabase();

    await database.insert("pontuacoes", {
      "usuarioId": usuarioId,
      "pontuacao": pontuacao,
    });
  }

  Future<List<int>> pegarPontuacoes(int usuarioId) async {
    final Database database = await _initDatabase();

    final List<Map<String, dynamic>> maps = await database.query(
      "pontuacoes",
      where: "usuarioId = ?",
      whereArgs: [usuarioId],
    );

    return List.generate(maps.length, (i) {
      return maps[i]['pontuacao'];
    });
  }

  Future<void> atualizarMaiorPontuacao(int usuarioId, int pontuacao) async {
    final Database database = await _initDatabase();

    await database.update(
      "usuario",
      {"maiorPontuacao": pontuacao},
      where: "id = ?",
      whereArgs: [usuarioId],
    );
  }

  Future<int> obterMaiorPontuacao(int usuarioId) async {
    final Database database = await _initDatabase();

    final List<Map<String, dynamic>> maps = await database.query(
      "usuario",
      where: "id = ?",
      whereArgs: [usuarioId],
      columns: ["maiorPontuacao"],
    );

    if (maps.isNotEmpty) {
      return maps.first["maiorPontuacao"];
    } else {
      return 0;
    }
  }

  Future<void> deletarDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'JOGOCOBRINHA.db');

    // Excluir o banco de dados
    await deleteDatabase(path);

    print("Banco de dados excluído com sucesso!");
  }
}
