import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';

class CaritasScreen extends StatefulWidget {
  const CaritasScreen({super.key});

  @override
  State<CaritasScreen> createState() => _CaritasScreenState();
}

class _CaritasScreenState extends State<CaritasScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    dp('CaritasScreen started');
    String title = "Cáritas Catanduva";
    Widget body = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Image.asset(
                'assets/img/caritas.png',
                width: 300.0,
                height: 300.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  dp('Voltar button pressed');
                  appProvider.setRoute('/home');
                },
                icon: Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: title),
      drawer: sidebar(context),
      body: SafeArea(child: body),
      bottomNavigationBar: footer(context),
    );
  }
}
