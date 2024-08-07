import 'package:flutter/material.dart';
import 'package:snakegame/database/db.dart';
import 'package:snakegame/pages/pontuacoes.dart';
import 'package:snakegame/pages/register.dart';
import 'package:snakegame/pages/snake_game.dart';
import 'package:snakegame/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final DB db = DB.instance;
//   await db.deletarDatabase();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TelaSplash());
  }
}
