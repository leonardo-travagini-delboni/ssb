import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/routes/cronograma.dart';
import 'package:ssb/routes/diocese.dart';
import 'package:ssb/routes/intro.dart';
import 'package:ssb/routes/splash.dart';
import 'package:ssb/routes/home.dart';
import 'package:ssb/routes/biblia.dart';
import 'package:ssb/routes/paroquia.dart';
import 'package:ssb/routes/game.dart';
import 'package:ssb/routes/social.dart';
import 'package:ssb/routes/creditos.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    String route = appProvider.route;
    bool isLoading = appProvider.isLoading;
    bool skipIntro = appProvider.skipIntro;
    // LOADING
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // SPLASH
    else if (route == '/splash') {
      return const SplashScreen();
    }
    // INTRO
    else if (route == '/intro') {
      if (skipIntro) {
        dp('RouterScreen: skipIntro is true, navigating to /home');
        appProvider.setRoute('/home');
        return const HomeScreen();
      } else {
        return const IntroScreen();
      }
    }
    // HOME
    else if (route == '/home') {
      return const HomeScreen();
    }
    // PAROQUIA
    else if (route == '/paroquia') {
      return const ParoquiaScreen();
    }
    // CRONOGRAMA
    else if (route == '/cronograma') {
      return const CronogramaScreen();
    }
    // BIBLIA
    else if (route == '/biblia') {
      return const BibliaScreen();
    }
    // GAME
    else if (route == '/game') {
      return const GameScreen();
    }
    // DIOCESE
    else if (route == '/diocese') {
      return const DioceseScreen();
    }
    // SOCIAL
    else if (route == '/social') {
      return const SocialScreen();
    }
    // CREDITOS
    else if (route == '/creditos') {
      return const CreditosScreen();
    }
    // ELSE
    else {
      appProvider.setRoute('/home');
      return const HomeScreen();
    }
  }
}
