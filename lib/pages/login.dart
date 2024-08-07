import 'package:flutter/material.dart';
import 'package:snakegame/components/button_form.dart';
import 'package:snakegame/components/colors.dart';
import 'package:snakegame/database/db.dart';
import 'package:snakegame/database/user_model.dart';
import 'package:snakegame/pages/register.dart';
import 'package:snakegame/pages/snake_game.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final DB db = DB.instance;

  Future<void> loginUsuario(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String senha = senhaController.text;
      var usuario = await db.autenticarUsuario(email, senha);

      print(usuario);
      if (usuario != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login realizado com sucesso!')));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TelaSnakeGame(usuario: usuario)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas!')));
      }
    }
  }

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
                                  labelText: 'Email',
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu email';
                                  }
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira sua senha';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1),
                              ButtonForm(
                                  text: 'Entrar',
                                  aoPressionar: () => loginUsuario(context)),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                child: Text(
                                  'Não possui uma conta? Fazer cadastro',
                                  style: TextStyle(
                                      color: AppColors.snake_color,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.snake_color),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1),
                            ],
                          )))
                ],
              ),
            )),
      ),
    );
  }
}
