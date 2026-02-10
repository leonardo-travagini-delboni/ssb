import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
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
    dp('GameScreen started');
    String title = "Jogo Bíblico";
    Widget body = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Em breve teremos um jogo bíblico para você se divertir e aprender mais sobre a Bíblia!',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                dp('GameScreen: Voltar button tapped');
                appProvider.setRoute('/home');
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: title),
      drawer: sidebar(context),
      body: body,
      bottomNavigationBar: footer(context),
    );
  }
}
