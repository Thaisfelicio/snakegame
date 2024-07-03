import 'package:flutter/material.dart';
import 'package:snakegame/components/colors.dart';
import 'package:snakegame/components/melhor_pontuacao.dart';
import 'package:snakegame/components/pontuacao.dart';

class TelaPontuacoes extends StatelessWidget {
  final int melhorPontuacao;
  final List<int> pontuacoes;
  const TelaPontuacoes(
      {required this.melhorPontuacao, required this.pontuacoes, super.key});

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
                MelhorPontuacao(melhorPontuacao: 100),
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
                Pontuacao(pontos: 80)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
