import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/components/colors.dart';
import 'package:snakegame/pages/register.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key});

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    navegarParaTelaPrincipal();
  }

  void navegarParaTelaPrincipal() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_splash,
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Image.asset('lib/img/splash_img_sem_fundo.png'),
      )),
    );
  }
}
