import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/game.dart'; // Importe seu GameProvider
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    GameProvider gameProvider = Provider.of<GameProvider>(context);

    dp('GameScreen building - Step: ${gameProvider.step}');

    String title = "Quiz Bíblico";
    Widget body;

    // LÓGICA DE ESTADO DO BODY
    if (gameProvider.quizCur.isEmpty) {
      // 1. TELA DE SELEÇÃO DE NÍVEL
      body = _buildLevelSelection(gameProvider, appProvider);
    } else if (gameProvider.step < gameProvider.quizCur.length) {
      // 2. TELA DE PERGUNTA ATIVA
      body = _buildQuizInterface(context, gameProvider);
    } else {
      // 3. TELA DE RESULTADO
      body = _buildResultSummary(context, gameProvider, appProvider);
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: title),
      drawer: sidebar(context),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: body,
        ),
      ),
      bottomNavigationBar: footer(context),
    );
  }

  // Widget: Seleção de Nível
  Widget _buildLevelSelection(GameProvider game, AppProvider appProvider) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Escolha um nível para começar:",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(4, (index) {
              int lvl = index + 1;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 60),
                ),
                onPressed: () => game.newGame(lvl),
                child: Text("Nível $lvl"),
              );
            }),
          ),
          const SizedBox(height: 20),
          const Text(
            "Cada nível contém 10 perguntas de mesmo nível de dificuldade. Boa sorte!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              dp('GameScreen: Voltar button tapped');
              appProvider.setRoute('/home');
            },
            icon: Icon(Icons.arrow_back),
            label: const Text('Voltar para Home'),
          ),
        ],
      ),
    );
  }

  // Widget: Interface do Quiz (Pergunta e Opções)
  Widget _buildQuizInterface(BuildContext context, GameProvider game) {
    var questao = game.currentQuestion!;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Progresso e Vidas (representadas pelos ícones de acerto/erro na lista _ans)
          LinearProgressIndicator(value: (game.step + 1) / 10),
          const SizedBox(height: 20),
          Text(
            "Pergunta ${game.step + 1} de 10",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Texto da Pergunta
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                questao['titulo'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Opções Dinâmicas (A, B, C, D)
          ...['A', 'B', 'C', 'D'].map(
            (opt) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => game.checkAnswer(opt),
                child: Text(
                  "$opt) ${questao[opt]}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              dp('GameScreen: Reiniciar jogo button tapped');
              game.reset();
            },
            icon: Icon(Icons.restart_alt),
            label: const Text('Reiniciar Jogo'),
          ),
        ],
      ),
    );
  }

  // Widget: Resumo Final
  Widget _buildResultSummary(
    BuildContext context,
    GameProvider game,
    AppProvider app,
  ) {
    int acertos = game.ans.where((e) => e == 1).length;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            acertos >= 7 ? Icons.emoji_events : Icons.sentiment_dissatisfied,
            size: 80,
            color: Colors.amber,
          ),
          const SizedBox(height: 20),
          Text(
            "Fim de Jogo!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Você acertou $acertos de 10 perguntas",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),

          // Lista de ícones (Check/Close) para feedback visual
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: game.ans
                .map(
                  (e) => Icon(
                    e == 1 ? Icons.check_circle : Icons.cancel,
                    color: e == 1 ? Colors.green : Colors.red,
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => game.reset(),
                child: const Text("Tentar Novamente"),
              ),
              ElevatedButton(
                onPressed: () => app.setRoute('/home'),
                child: const Text("Sair"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
