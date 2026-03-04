import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  Timer? _timer;

  // Definição das telas em uma estrutura de dados simples
  final List<Map<String, String>> _pages = [
    {
      'img': 'assets/img/ssb.png',
      'title': 'Paróquia São Sebatião',
      'subtitle': 'Novo Horizonte - SP',
    },
    {
      'img': 'assets/img/diocese.png',
      'title': 'Diocese de Catanduva',
      'subtitle': 'Catanduva - SP',
    },
    {
      'img': 'assets/img/nsa.png',
      'title': 'Bíblia Sagrada',
      'subtitle': 'Versão Ave-Maria',
    },
    {
      'img': 'assets/img/ai.png',
      'title': 'IA Católica',
      'subtitle': 'Direto pelo WhatsApp',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSequence() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _pages.length - 1) {
        setState(() => _currentIndex++);
      } else {
        timer.cancel();
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final route = appProvider.skipIntro ? '/home' : '/intro';

    dp('Splash done. Navigating to $route');
    appProvider.setRoute(route);
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = _pages[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: Container(
            key: ValueKey<int>(
              _currentIndex,
            ), // Essencial para a animação funcionar
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Se for a última tela, inverte a ordem texto/imagem como no seu original
                if (_currentIndex == _pages.length - 1)
                  Text(
                    currentPage['title']!,
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                  ),
                // Imagem centralizada
                Image.asset(
                  currentPage['img']!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                // Texto abaixo da imagem, centralizado
                Column(
                  children: [
                    if (_currentIndex != _pages.length - 1)
                      Text(
                        currentPage['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      currentPage['subtitle']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
