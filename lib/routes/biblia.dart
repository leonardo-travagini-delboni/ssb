import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/biblia.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';

class BibliaScreen extends StatefulWidget {
  const BibliaScreen({super.key});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    BibliaProvider bibliaProvider = Provider.of<BibliaProvider>(context);
    String testamento = bibliaProvider.testamento;
    List<String> livros = bibliaProvider.livrosDisponiveis;
    String book = bibliaProvider.book;
    String chapter = bibliaProvider.chapter;
    List<Map<String, dynamic>> versiculos = bibliaProvider
        .versiculosDisponiveis(testamento, book, chapter);
    String title = 'Bíblia Sagrada';
    Widget body = Placeholder();
    dp('Biblia Screen - Test: $testamento, Book: $book, Chapter: $chapter');

    // ESCOLHA DO TESTAMENTO
    if (testamento.isEmpty) {
      title = 'Bíblia Sagrada Ave Maria';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nsa.png',
                fit: BoxFit.contain,
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                'Qual o testamento?',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('Bíblia: Antigo Testamento tapped');
                      bibliaProvider.setTestamento('antigoTestamento');
                    },
                    icon: Icon(Icons.book),
                    label: Text('ANTIGO'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('Bíblia: Novo Testamento tapped');
                      bibliaProvider.setTestamento('novoTestamento');
                    },
                    icon: Icon(Icons.book),
                    label: Text('NOVO'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('ou demais opções abaixo:'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('BibliaScreen: Voltar button tapped');
                      appProvider.setRoute('/home');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final String fullPath = '$pdfsPath/$bibliaFile';
                        dp('Loading PDF from assets for sharing: $fullPath');
                        final data = await rootBundle.load(fullPath);
                        final bytes = data.buffer.asUint8List();
                        // CASE 1 : WEB
                        if (kIsWeb) {
                          dp('Sharing PDF on web platform');
                          await SharePlus.instance.share(
                            ShareParams(
                              text: 'Confira a Bíblia Sagrada Ave Maria!',
                              files: [
                                XFile.fromData(
                                  bytes,
                                  name: bibliaFile,
                                  mimeType: 'application/pdf',
                                ),
                              ],
                            ),
                          );
                          dp('Web share/download disparado');
                        }
                        // CASE 2 : MOBILE (ANDROID / iOS)
                        else if (Platform.isAndroid || Platform.isIOS) {
                          dp('Sharing PDF on mobile platform');
                          final directory = await getTemporaryDirectory();
                          final file = File('${directory.path}/$bibliaFile');
                          await file.writeAsBytes(bytes, flush: true);
                          final sharePlus = await SharePlus.instance.share(
                            ShareParams(
                              text: 'Confira a Bíblia Versão Ave Maria!',
                              files: [XFile(file.path)],
                            ),
                          );
                          dp('Share result: $sharePlus');
                        }
                        // CASE 3: ELSE - DESKTOP (WINDOWS / MAC / LINUX)
                        else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.yellow,
                                content: Text(
                                  'Compartilhar PDF ainda não é suportado nesta plataforma.',
                                ),
                              ),
                            );
                          }
                          return;
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                'PDF compartilhado com sucesso!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        dp('Share sheet opened successfully');
                      }
                      // ERROR
                      catch (e) {
                        dp('Error sharing PDF: $e');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Erro ao compartilhar PDF: $e'),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Compartilhar PDF'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    // ESCOLHA DO LIVRO
    else if (book.isEmpty) {
      title = bibliaProvider.nomeAmigavelTestamento(testamento);
      body = Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/img/nsa.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'Qual livro você deseja?',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: livros
                        .map(
                          (l) => ListTile(
                            title: Text(l),
                            leading: Icon(Icons.book),
                            onTap: () {
                              dp('Bíblia: Livro $l tapped');
                              bibliaProvider.setBook(l);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      dp('Bíblia: Voltar to testamento selection');
                      bibliaProvider.clearAll();
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Voltar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // ESCOLHA DO CAPÍTULO
    else if (chapter.isEmpty) {
      title = book;
      body = Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/img/nsa.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'Qual capítulo de $book?',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: bibliaProvider.capitulosDisponiveisString
                        .map(
                          (c) => ListTile(
                            title: Text('Capítulo $c'),
                            leading: Icon(Icons.book),
                            onTap: () {
                              dp('Bíblia: Capítulo $c tapped');
                              bibliaProvider.setChapter(c);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      bibliaProvider.setBook('');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Voltar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // EXIBIÇÃO DO CAPÍTULO ESCOLHIDO
    else {
      title = '$book - Cap. $chapter';
      body = Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/img/nsa.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                for (var v in versiculos)
                  ListTile(
                    title: Text('${v['versiculo']}. ${v['texto']}'),
                    leading: Icon(Icons.book),
                  ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      bibliaProvider.setChapter('');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Voltar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Estrutura da tela
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: title),
      drawer: sidebar(context),
      body: body,
      bottomNavigationBar: footer(context),
    );
  }
}
