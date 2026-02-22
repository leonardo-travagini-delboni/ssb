import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    dp('IntroScreen started');

    // Single PageViewModel
    PageViewModel buildSinglePage(
      String title,
      String body,
      String imageAsset,
      Color pageColor,
    ) {
      return PageViewModel(
        title: title,
        body: body,
        image: Center(child: Image.asset(imageAsset, height: 250.0)),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyTextStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
      );
    }

    // PageViewModel List
    List<PageViewModel> pages = [
      buildSinglePage(
        "Bem-vindo à Paróquia São Sebastião!",
        "Nossa comunidade em um só lugar: missas, pastorais, Bíblia e muito mais.",
        'assets/img/intro/1.png',
        Colors.white,
      ),
      buildSinglePage(
        "Cronograma Mensal e Atividades",
        "Fique por dentro do nosso cronograma mensal , horários de missa e confissões.",
        'assets/img/intro/2.png',
        Colors.white,
      ),
      buildSinglePage(
        "Bíblia Sagrada Ave Maria",
        "A Palavra de Deus totalmente offline, para você ler onde e quando quiser.",
        'assets/img/intro/3.png',
        Colors.white,
      ),
      buildSinglePage(
        "Pastorais e Ministérios",
        "Conecte-se aos líderes pastorais pelo WhatsApp e participe você também.",
        'assets/img/intro/4.png',
        Colors.white,
      ),
      buildSinglePage(
        "Vamos Fazer a Obra do Senhor!",
        "Junte-se a nós para fortalecer nossa fé e comunidade. Compartilhe!",
        'assets/img/intro/5.png',
        Colors.white,
      ),
    ];

    // Body Widget
    Widget body = IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: pages,
      onDone: () {
        dp('IntroScreen: Done button tapped');
        appProvider.setRoute('/home');
      },
      onSkip: () {
        dp('IntroScreen: Skip button tapped');
        appProvider.setSkipIntro(true);
        appProvider.setRoute('/home');
      },
      showSkipButton: true,
      showBackButton: true,
      back: const Icon(Icons.arrow_back, color: Colors.black87),
      skip: const Text(
        'Pular',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.black87),
      done: const Text(
        'Iniciar',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );

    return Scaffold(key: _scaffoldKey, body: body);
  }
}
