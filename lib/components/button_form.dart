import 'package:flutter/material.dart';
import 'package:snakegame/components/colors.dart';

class ButtonForm extends StatelessWidget {
  final String text;
  final void Function() aoPressionar;

  const ButtonForm({required this.text, required this.aoPressionar, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: aoPressionar,
      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 15,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppColors.button_color,
          foregroundColor: AppColors.background_game,
          elevation: 2,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
              MediaQuery.of(context).size.width * 0.12)),
      child: Text(text),
    );
  }
}
