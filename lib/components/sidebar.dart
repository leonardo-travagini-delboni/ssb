import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/biblia.dart';
import 'package:ssb/provider/paroquia.dart';
import 'package:url_launcher/url_launcher.dart';

Drawer sidebar(BuildContext context) {
  AppProvider appProvider = Provider.of<AppProvider>(context);
  ParoquiaProvider paroquiaProvider = Provider.of<ParoquiaProvider>(context);
  BibliaProvider bibliaProvider = Provider.of<BibliaProvider>(context);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appName,
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Novo Horizonte - SP',
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Início'),
          subtitle: const Text('Tela inicial do aplicativo'),
          onTap: () {
            dp('Sidebar: Início tapped');
            if (appProvider.route != '/home') {
              dp('Sidebar: Navigating to /home');
              appProvider.setRoute('/home');
            }
            Navigator.pop(context);
          },
        ),
        if (enableCronograma)
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Cronograma Mensal'),
            subtitle: const Text('Eventos e Atividades Paroquiais'),
            onTap: () {
              dp('Sidebar: Cronograma Mensal tapped');
              paroquiaProvider.clearAll();
              if (appProvider.route != '/cronograma') {
                dp('Sidebar: Navigating to /cronograma');
                appProvider.setRoute('/cronograma');
              }
              Navigator.pop(context);
            },
          ),
        ListTile(
          leading: const Icon(Icons.church),
          title: const Text('Paróquia São Sebastião'),
          subtitle: const Text('Missas, Confissões, PIX, etc'),
          onTap: () {
            dp('Sidebar: Paróquia São Sebastião tapped');
            paroquiaProvider.clearAll();
            if (appProvider.route != '/paroquia') {
              dp('Sidebar: Navigating to /paroquia');
              appProvider.setRoute('/paroquia');
            }
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Bíblia Sagrada'),
          subtitle: const Text('Versão Ave Maria'),
          onTap: () {
            dp('Sidebar: Bíblia Sagrada tapped');
            bibliaProvider.clearAll();
            if (appProvider.route != '/biblia') {
              dp('Sidebar: Navigating to /biblia');
              appProvider.setRoute('/biblia');
            }
            Navigator.pop(context);
          },
        ),
        if (enableDiocese)
          ListTile(
            leading: const Icon(Icons.church),
            title: const Text('Diocese'),
            subtitle: const Text('Informações da Diocese'),
            onTap: () {
              dp('Sidebar: Diocese tapped');
              bibliaProvider.clearAll();
              if (appProvider.route != '/diocese') {
                dp('Sidebar: Navigating to /diocese');
                appProvider.setRoute('/diocese');
              }
              Navigator.pop(context);
            },
          ),
        if (enableGame)
          ListTile(
            leading: const Icon(Icons.sports_esports),
            title: const Text('Jogo Bíblico'),
            subtitle: const Text('Perguntas e Respostas'),
            onTap: () {
              dp('Sidebar: Jogo Bíblico tapped');
              if (appProvider.route != '/game') {
                dp('Sidebar: Navigating to /game');
                appProvider.setRoute('/game');
              }
              Navigator.pop(context);
            },
          ),
        if (enableIA)
          ListTile(
            leading: const Icon(Icons.smart_toy),
            title: Text('IA Católica Grátis'),
            subtitle: Text('Converse pelo WhatsApp'),
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(aiWhatsapp))) {
                dp('Sidebar: Launching AI WhatsApp');
                if (context.mounted) {
                  Navigator.pop(context);
                }
                await launchUrl(
                  Uri.parse(aiWhatsapp),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
        if (enableSocial)
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Redes Sociais'),
            subtitle: const Text('Curte, comente e compartilhe!'),
            onTap: () {
              dp('Sidebar: Redes Sociais tapped');
              bibliaProvider.clearAll();
              if (appProvider.route != '/social') {
                dp('Sidebar: Navigating to /social');
                appProvider.setRoute('/social');
              }
              Navigator.pop(context);
            },
          ),
        if (enableCreditos)
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Créditos'),
            subtitle: const Text('Maiores informações'),
            onTap: () {
              dp('Sidebar: Créditos tapped');
              bibliaProvider.clearAll();
              if (appProvider.route != '/creditos') {
                dp('Sidebar: Navigating to /creditos');
                appProvider.setRoute('/creditos');
              }
              Navigator.pop(context);
            },
          ),
        ListTile(
          leading: Icon(Icons.close),
          title: Text('Fechar'),
          subtitle: Text('Fechar o menu lateral'),
          onTap: () async {
            dp('Sidebar: Fechar tapped');
            if (context.mounted) Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
