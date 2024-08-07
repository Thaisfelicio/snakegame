import 'package:flutter/material.dart';
import 'package:snakegame/components/button_form.dart';
import 'package:snakegame/components/colors.dart';
import 'package:snakegame/components/melhor_pontuacao.dart';
import 'package:snakegame/components/pontuacao.dart';
import 'package:snakegame/database/user_model.dart';
import 'package:snakegame/pages/snake_game.dart';

class TelaPontuacoes extends StatelessWidget {
  final UserModel usuario;
  final List<int> pontuacoes;
  const TelaPontuacoes(
      {required this.usuario, required this.pontuacoes, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_score,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.width * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pontuações',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 12,
                      color: AppColors.background_game),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                MelhorPontuacao(melhorPontuacao: usuario.maiorPontuacao),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                Text(
                  'Jogadas recentes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 18,
                      color: AppColors.background_app),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Column(
                  children: pontuacoes
                      .map((pontos) => Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.05),
                          child: Pontuacao(pontos: pontos)))
                      .toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                ButtonForm(
                    text: 'Voltar',
                    aoPressionar: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TelaSnakeGame(usuario: usuario)));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
