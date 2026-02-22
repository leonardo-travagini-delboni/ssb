import 'package:flutter/material.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Container _bodyHome(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Text(
                'Bem-vindo à $appName!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Image.asset(
                'assets/img/igrejas/ssb11.png',
                width: 350.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30.0),
              Text(
                'Informações sobre a Paróquia, ler a Bíblia, e muito mais!',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 250.0,
                height: 60.0,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.explore,
                    size: 28.0,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                  onPressed: () {
                    dp('HomeScreen: Explore button tapped');
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).appBarTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8.0,
                  ),
                  label: Text(
                    'Clique aqui!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dp('HomeScreen started');
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: appName),
      drawer: sidebar(context),
      body: _bodyHome(context),
      bottomNavigationBar: footer(context),
    );
  }
}
