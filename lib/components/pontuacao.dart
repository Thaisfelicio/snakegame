import 'package:flutter/material.dart';
import 'package:snakegame/components/colors.dart';

class Pontuacao extends StatelessWidget {
  final int pontos;

  const Pontuacao({required this.pontos, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: AppColors.background_splash,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: MediaQuery.of(context).size.width * 0.02),
        child: Row(
          children: [
            Text(
              'SCORE',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 20,
                  color: AppColors.background_game),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            Text(
              '$pontos pontos',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 22,
                  color: AppColors.snake_color,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
