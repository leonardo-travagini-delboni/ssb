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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black;
  final int _timer = 3;
  double maxWidth = 300;
  double maxHeight = 300;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    dp('Splash screen started.');
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: _timer)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            key: _scaffoldKey,
            body: Container(
              padding: const EdgeInsets.all(8.0),
              color: backgroundColor,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/img/ssb.png',
                    width: 300.0,
                    height: 300.0,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Paróquia São Sebastião',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Novo Horizonte - SP',
                    style: TextStyle(fontSize: 16.0, color: textColor),
                  ),
                ],
              ),
            ),
          );
        } else {
          return FutureBuilder(
            future: Future.delayed(Duration(seconds: _timer)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  key: _scaffoldKey,
                  body: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: backgroundColor,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/img/diocese.png',
                          fit: BoxFit.contain,
                          width: maxWidth,
                          height: maxHeight,
                        ),
                        Text(
                          'Diocese de Catanduva',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Catanduva - SP',
                          style: TextStyle(fontSize: 16.0, color: textColor),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return FutureBuilder(
                  future: Future.delayed(Duration(seconds: _timer)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Scaffold(
                        key: _scaffoldKey,
                        body: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: backgroundColor,
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/img/nsa.png',
                                fit: BoxFit.contain,
                                width: maxWidth,
                                height: maxHeight,
                              ),
                              Text(
                                'Bíblia Sagrada',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Versão Ave-Maria',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return FutureBuilder(
                        future: Future.delayed(Duration(seconds: _timer)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Scaffold(
                              key: _scaffoldKey,
                              body: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: backgroundColor,
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset(
                                      'assets/img/ai.png',
                                      fit: BoxFit.contain,
                                      width: maxWidth,
                                      height: maxHeight,
                                    ),
                                    Text(
                                      'IA Católica',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Direto pelo WhatsApp',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return FutureBuilder(
                              future: Future.delayed(Duration(seconds: _timer))
                                  .then((_) {
                                    // Skip Introduction Screen
                                    if (appProvider.skipIntro) {
                                      dp('Splash done. Navigating to /home');
                                      appProvider.setRoute('/home');
                                    }
                                    // Go to Introduction Screen
                                    else {
                                      dp('Splash done. Navigating to /intro');
                                      appProvider.setRoute('/intro');
                                    }
                                  }),
                              builder: (context, snapshot) {
                                return Scaffold(
                                  key: _scaffoldKey,
                                  body: Container(
                                    color: backgroundColor,
                                    padding: const EdgeInsets.all(8.0),
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Um oferecimento de ...',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: textColor,
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/img/dti.png',
                                          width: 300.0,
                                          height: 300.0,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          'Sites, Sistemas e Aplicativos',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
