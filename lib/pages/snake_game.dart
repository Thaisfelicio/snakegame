import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TelaSnakeGame extends StatefulWidget {
  const TelaSnakeGame({super.key});

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

  @override
  void initState() {
    iniciarJogo();
    super.initState();
  }

  void iniciarJogo() {
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

  void mostrarDialogoGameOver() {
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
                  child: const Text("Recomeçar"))
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
      padding: const EdgeInsets.all(20),
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

  fazerBorda() {
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
    for (int i = (linha * coluna) - coluna; i < linha * coluna; i = i + 1) {
      if (!listaBorda.contains(i)) {
        listaBorda.add(i);
      }
    }
  }
}
