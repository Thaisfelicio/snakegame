import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakegame/database/db.dart';
import 'package:snakegame/pages/pontuacoes.dart';

class TelaSnakeGame extends StatefulWidget {
  final int usuarioId;

  const TelaSnakeGame({super.key, required this.usuarioId});

  @override
  State<TelaSnakeGame> createState() => _TelaSnakeGameState();
}

enum Direction { cima, baixo, esquerda, direita }

class _TelaSnakeGameState extends State<TelaSnakeGame> {
  int linha = 20, coluna = 20;
  List<int> listaBorda = [];
  List<int> posicaoCobrinha = [];
  int cabecaCobrinha = 0;
  int pontos = 0;
  late Direction direcao;
  late int posicaoComida;

  final DB db = DB.instance;

  @override
  void initState() {
    iniciarJogo();
    super.initState();
  }

  void iniciarJogo() {
    pontos = 0;
    fazerBorda();
    gerarComida();
    direcao = Direction.direita;
    posicaoCobrinha = [45, 44, 43];
    cabecaCobrinha = posicaoCobrinha.first;
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      atualizarCobrinha();
      if (verificarColisao()) {
        timer.cancel();
        mostrarDialogoGameOver();
      }
    });
  }

  void mostrarDialogoGameOver() async {
    //pegar o id do user pelo parametro de login
    final int? usuarioId = widget.usuarioId;

    await db.inserirPontuacao(usuarioId!, pontos);
    int maiorPontuacaoAtual = await db.obterMaiorPontuacao(usuarioId);

    if (pontos > maiorPontuacaoAtual) {
      await db.atualizarMaiorPontuacao(usuarioId, pontos);
    }

    List<int> pontuacoes = await db.pegarPontuacoes(usuarioId);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Game Over"),
            content: const Text("Sua cobrinha bateu!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    iniciarJogo();
                  },
                  child: const Text("Recomeçar")),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaPontuacoes(
                              melhorPontuacao: maiorPontuacaoAtual,
                              pontuacoes: pontuacoes))),
                  child: const Text("Ver pontuações"))
            ],
          );
        });
  }

  bool verificarColisao() {
    //se a cobrinha colidir com a borda
    if (listaBorda.contains(cabecaCobrinha)) return true;
    //se a cobrinha colidir com ela mesma
    if (posicaoCobrinha.sublist(1).contains(cabecaCobrinha)) return true;

    return false;
  }

  void gerarComida() {
    posicaoComida = Random().nextInt(linha * coluna);
    if (listaBorda.contains(posicaoComida)) {
      gerarComida();
    }
  }

  void atualizarCobrinha() {
    setState(() {
      switch (direcao) {
        case Direction.cima:
          posicaoCobrinha.insert(0, cabecaCobrinha - coluna);
          break;
        case Direction.baixo:
          posicaoCobrinha.insert(0, cabecaCobrinha + coluna);
          break;
        case Direction.direita:
          posicaoCobrinha.insert(0, cabecaCobrinha + 1);
          break;
        case Direction.esquerda:
          posicaoCobrinha.insert(0, cabecaCobrinha - 1);
          break;
      }
      // posicaoCobrinha.insert(0, cabecaCobrinha + 1);
    });

    if (cabecaCobrinha == posicaoComida) {
      pontos++;
      gerarComida();
    } else {
      posicaoCobrinha.removeLast();
    }

    cabecaCobrinha = posicaoCobrinha.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _buildVisualizacaoJogo()),
          _buildControlesJogo()
        ],
      ),
    );
  }

  Widget _buildVisualizacaoJogo() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: coluna),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: preencherCorCaixa(index),
          ),
        );
      },
      itemCount: linha * coluna,
    );
  }

  Widget _buildControlesJogo() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Score : $pontos'),
          IconButton(
            onPressed: () {
              if (direcao != Direction.baixo) direcao = Direction.cima;
            },
            icon: const Icon(Icons.arrow_circle_up_rounded),
            iconSize: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (direcao != Direction.direita) {
                    direcao = Direction.esquerda;
                  }
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 100,
              ),
              const SizedBox(
                width: 100,
              ),
              IconButton(
                onPressed: () {
                  if (direcao != Direction.esquerda) {
                    direcao = Direction.direita;
                  }
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 100,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direcao != Direction.cima) direcao = Direction.baixo;
            },
            icon: const Icon(Icons.arrow_circle_down_rounded),
            iconSize: 100,
          ),
        ],
      ),
    );
  }

  Color preencherCorCaixa(int index) {
    if (listaBorda.contains(index)) {
      return Colors.yellow;
    } else {
      if (posicaoCobrinha.contains(index)) {
        if (cabecaCobrinha == index) {
          return Colors.green;
        } else {
          return Colors.lightGreenAccent.withOpacity(0.9);
        }
      } else {
        if (index == posicaoComida) {
          return Colors.red;
        }
      }
    }
    return Colors.grey.withOpacity(0.05);
  }

  void fazerBorda() {
    // listaBorda.clear();

    //borda de cima
    for (int i = 0; i < coluna; i++) {
      if (!listaBorda.contains(i)) {
        listaBorda.add(i);
      }
    }
    //borda da esquerda
    for (int i = 0; i < linha * coluna; i = i + coluna) {
      if (!listaBorda.contains(i)) {
        listaBorda.add(i);
      }
    }
    //borda da direita
    for (int i = coluna - 1; i < linha * coluna; i = i + coluna) {
      if (!listaBorda.contains(i)) {
        listaBorda.add(i);
      }
    }
    //borda de baixo
    // for (int i = coluna * 2 - 1; i < linha * coluna - 1; i += coluna) {
    //   listaBorda.add(i);
    // }
    for (int i = (linha * coluna) - coluna; i < linha * coluna; i = i + 1) {
      if (!listaBorda.contains(i)) {
        listaBorda.add(i);
      }
    }
  }
}
