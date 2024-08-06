import 'package:flutter/material.dart';
import 'package:snakegame/pages/pontuacoes.dart';
import 'package:snakegame/pages/register.dart';
import 'package:snakegame/pages/snake_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RegisterPage());
  }
}
