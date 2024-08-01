import 'package:flutter/material.dart';
import 'package:snakegame/components/button_form.dart';
import 'package:snakegame/components/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_app,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            decoration: const BoxDecoration(
              color: AppColors.background_app,
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
                    child: Image.asset(
                        'lib/img/iconeSnakeApp_withoutBackground.png'),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 12,
                      color: AppColors.background_splash,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.background_input),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.background_input),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor: AppColors.background_input,
                                  filled: true,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.background_input),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.background_input),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor: AppColors.background_input,
                                  filled: true,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1),
                              ButtonForm(text: 'Entrar', aoPressionar: () {}),
                            ],
                          )))
                ],
              ),
            )),
      ),
    );
  }
}
