import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';

class GameProvider extends ChangeNotifier {
  // Parameters
  List<dynamic> _quizAll = [];
  List<dynamic> _quizCur = [];
  List<int> _quizAns = [];
  int _step = 0;
  int _level = 1;

  // Getters
  List<dynamic> get quizAll => _quizAll;
  List<dynamic> get quizCur => _quizCur;
  List<int> get ans => _quizAns;
  int get step => _step;
  int get level => _level;

  // Getting the current question
  Map<String, dynamic>? get currentQuestion {
    if (_quizCur.isEmpty || _step >= _quizCur.length) return null;
    return _quizCur[_step];
  }

  // Inicializador
  GameProvider() {
    _loadQuiz();
  }

  // Carrega o quiz do arquivo JSON
  Future<void> _loadQuiz() async {
    try {
      final jsonString = await rootBundle.loadString(gameJson);
      _quizAll = json.decode(jsonString);
      dp('Quiz carregado: ${_quizAll.length} questões no total.');
    } catch (e) {
      dp('Erro ao carregar JSON: $e');
    }
  }

  /// Starta um novo jogo com o nível selecionado
  void newGame(int selectedLevel, {int numQuestions = 10}) {
    _level = selectedLevel;
    _step = 0;
    _quizAns = [];
    List<dynamic> filtered = _quizAll
        .where((q) => q['nivel'] == _level)
        .toList();
    filtered.shuffle();
    _quizCur = filtered.take(numQuestions).toList();
    dp('Novo jogo iniciado: Nível $_level com ${_quizCur.length} questões.');
    notifyListeners();
  }

  /// Checka a resposta selecionada
  void checkAnswer(String selectedOption) {
    if (currentQuestion == null) return;
    String correct = currentQuestion!['resposta'];
    if (selectedOption == correct) {
      _quizAns.add(1); // Acerto
      dp('Questão $_step: Acertou');
    } else {
      _quizAns.add(0); // Erro
      dp('Questão $_step: Errou (Resposta: $correct)');
    }
    _step++;
    notifyListeners();
  }

  /// Reinicia o estado se necessário
  void reset() {
    _step = 0;
    _quizAns = [];
    _quizCur = [];
    notifyListeners();
  }
}
