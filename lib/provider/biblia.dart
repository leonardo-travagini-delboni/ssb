import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssb/config/func.dart';

class BibliaProvider extends ChangeNotifier {
  Map<String, dynamic> _biblia = {};
  String _testamento = '';
  String _book = '';
  String _chapter = '';

  Map<String, dynamic> get biblia => _biblia;
  String get testamento => _testamento;
  String get chapter => _chapter;
  String get book => _book;

  // Static parameters
  static const Map<String, String> _nomeTestamentos = {
    'antigoTestamento': 'Antigo Testamento',
    'novoTestamento': 'Novo Testamento',
  };

  BibliaProvider() {
    _loadBiblia();
  }

  Future<void> _loadBiblia() async {
    dp('Biblia Provider - Loading Biblia JSON');
    final jsonString = await rootBundle.loadString('assets/json/biblia.json');
    _biblia = json.decode(jsonString);
    notifyListeners();
  }

  // 1) Testamentos disponíveis
  List<String> get testamentosDisponiveis {
    if (_biblia.isEmpty) return [];
    return _nomeTestamentos.keys.where((k) => _biblia.containsKey(k)).toList();
  }

  String nomeAmigavelTestamento(String key) => _nomeTestamentos[key] ?? key;

  // 2) Livros disponíveis do testamento selecionado
  List<String> get livrosDisponiveis {
    if (_biblia.isEmpty || _testamento.isEmpty) return [];
    final list = _biblia[_testamento];
    if (list is! List) return [];
    return list
        .whereType<Map<String, dynamic>>()
        .map((b) => (b['nome'] ?? '').toString())
        .where((n) => n.isNotEmpty)
        .toList();
  }

  // 3) Capítulos disponíveis do livro selecionado
  List<int> get capitulosDisponiveis {
    if (_biblia.isEmpty || _testamento.isEmpty || _book.isEmpty) return [];
    final livros = _biblia[_testamento];
    if (livros is! List) return [];
    final livro = livros
        .whereType<Map<String, dynamic>>()
        .cast<Map<String, dynamic>?>()
        .firstWhere(
          (b) => (b?['nome']?.toString() ?? '') == _book,
          orElse: () => null,
        );
    if (livro == null) return [];
    final caps = livro['capitulos'];
    if (caps is! List) return [];
    return caps
        .whereType<Map<String, dynamic>>()
        .map((c) => c['capitulo'])
        .whereType<int>()
        .toList();
  }

  // Se você quiser já em String (pra Dropdown):
  List<String> get capitulosDisponiveisString =>
      capitulosDisponiveis.map((c) => c.toString()).toList();

  // Versículos disponíveis do capítulo selecionado
  List<Map<String, dynamic>> versiculosDisponiveis(
    String testamento,
    String book,
    String chapter,
  ) {
    // 1) Validações básicas
    if (_biblia.isEmpty ||
        testamento.isEmpty ||
        book.isEmpty ||
        chapter.isEmpty) {
      return [];
    }

    // 2) Lista de livros do testamento
    final livros = _biblia[testamento];
    if (livros is! List) return [];

    // 3) Encontra o livro
    final livro = livros
        .whereType<Map<String, dynamic>>()
        .cast<Map<String, dynamic>?>()
        .firstWhere(
          (b) => (b?['nome']?.toString() ?? '') == book,
          orElse: () => null,
        );
    if (livro == null) return [];

    // 4) Lista de capítulos
    final caps = livro['capitulos'];
    if (caps is! List) return [];

    // 5) Encontra o capítulo
    final cap = caps
        .whereType<Map<String, dynamic>>()
        .cast<Map<String, dynamic>?>()
        .firstWhere(
          (c) => (c?['capitulo']?.toString() ?? '') == chapter,
          orElse: () => null,
        );
    if (cap == null) return [];

    // 6) Pega versículos
    final versiculos = cap['versiculos'];
    if (versiculos is! List) return [];
    return versiculos.whereType<Map<String, dynamic>>().toList();
  }

  // Setters com notifyListeners
  void setTestamento(String testamento) {
    dp('Biblia Provider - Setting testamento to: $testamento');
    _testamento = testamento;
    notifyListeners();
  }

  void setBook(String book) {
    dp('Biblia Provider - Setting book to: $book');
    _book = book;
    notifyListeners();
  }

  void setChapter(String chapter) {
    dp('Biblia Provider - Setting chapter to: $chapter');
    _chapter = chapter;
    notifyListeners();
  }

  void clearAll() {
    dp('Biblia Provider - Clearing all');
    _testamento = '';
    _book = '';
    _chapter = '';
    notifyListeners();
  }
}
