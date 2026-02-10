import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/theme.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';
import 'package:ssb/provider/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditosScreen extends StatefulWidget {
  const CreditosScreen({super.key});

  @override
  State<CreditosScreen> createState() => _CreditosScreenState();
}

class _CreditosScreenState extends State<CreditosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    dp('CreditosScreen started');
    String title = "Créditos";
    Widget body = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
              Text(
                'Sobre o Aplicativo',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                color: themeProvider.theme == lightTheme
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
                child: Image.asset(
                  'assets/img/ssb.png',
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                '''
Este aplicativo foi desenvolvido e doado gratuitamente para a Paróquia São Sebastião de Novo Horizonte - SP, com o objetivo de fornecer acesso fácil e rápido a informações, recursos e serviços relacionados à paróquia.
                ''',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              Text(
                '''
O app foi desenvolvido utilizando-se da tecnologia Flutter, o que permite a reutilização de seu código para múltiplas plataformas, como Mobile (Android e iOS), Desktop (Windows, Linux e macOS) e Web.
                ''',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              Text(
                '''
Nele é possível acessar o cronograma mensal dos eventos paroquiais, horários e locais das missas e celebrações, atendimento paroquial, horários das confissões, pastorais e comunidade religiosa, além da história da Paróquia, do padroeiro e da Diocese de Catanduva - SP.
                ''',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              Text(
                '''
Novas funcionalidades estão sendo adicionadas constantemente, como jogos, integração com redes sociais e inteligência artificial para atendimento e suporte aos fiéis.
                ''',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20.0),
              Divider(color: Theme.of(context).dividerColor, thickness: 1.0),
              const SizedBox(height: 20.0),
              Text(
                'Sobre o Desenvolvedor',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Image.asset(
                'assets/img/dti.png',
                width: 300.0,
                height: 300.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20.0),
              Text(
                "DELBONI TI",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                "Sites, aplicativos e sistemas",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).appBarTheme.backgroundColor,
                ),
                onPressed: () async {
                  String url = "https://www.delboniti.com.br";
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    dp('Could not launch $url');
                  }
                },
                label: Text(
                  'www.delboniti.com.br',
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
                icon: Icon(
                  Icons.open_in_new,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  String url =
                      "https://api.whatsapp.com/send/?phone=5511994421880";
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    dp('Could not launch $url');
                  }
                },
                label: Text(
                  '(11) 99442-1880',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
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
      body: body,
      bottomNavigationBar: footer(context),
    );
  }
}
