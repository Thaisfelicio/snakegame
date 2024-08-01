import 'package:flutter/material.dart';
import 'package:snakegame/components/button_form.dart';
import 'package:snakegame/components/colors.dart';
import 'package:snakegame/database/db.dart';
import 'package:snakegame/database/user_model.dart';
import 'package:snakegame/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  bool estaValidado = false;
  bool isLoginTrue = false;
  final DB db = DB.instance;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
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
                    'Cadastrar',
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
                                keyboardType: TextInputType.emailAddress,
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
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  labelText: 'Confirmar senha',
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
                              ButtonForm(
                                  text: 'Cadastrar',
                                  aoPressionar: () async {
                                    String senha = senhaController.text;
                                    String confirmarSenha =
                                        confirmarSenhaController.text;

                                    if (senha == confirmarSenha) {
                                      var res = await db.autenticarUsuario(
                                          UserModel(
                                              email: emailController.text,
                                              senha: senhaController.text,
                                              maiorPontuacao: 0));

                                      if (res == true) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      } else {
                                        setState(() {
                                          isLoginTrue = true;
                                        });
                                      }
                                    } else {
                                      print("As senhas não correspondem.");
                                    }
                                  }),
                            ],
                          )))
                ],
              ),
            )),
      ),
    );
  }
}
