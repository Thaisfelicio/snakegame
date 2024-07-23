import 'package:flutter/material.dart';
import 'package:snakegame/components/colors.dart';

class MelhorPontuacao extends StatelessWidget {
  final int melhorPontuacao;

  const MelhorPontuacao({required this.melhorPontuacao, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          color: AppColors.background_better_score,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(95, 0, 0, 0),
                offset: Offset(-3, 4),
                blurRadius: 0)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Melhor pontuação: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width / 18,
                color: AppColors.better_score_letter,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    size: MediaQuery.of(context).size.width * 0.15,
                    color: AppColors.snake_color,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    '$melhorPontuacao Pontos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 12,
                        color: AppColors.better_score_letter),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
