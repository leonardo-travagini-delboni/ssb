import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';

class CronogramaScreen extends StatefulWidget {
  const CronogramaScreen({super.key});

  @override
  State<CronogramaScreen> createState() => _CronogramaScreenState();
}

class _CronogramaScreenState extends State<CronogramaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    dp('CronogramaScreen started');
    Widget body = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30.0),
              const Text(
                'Confira nosso Cronograma Mensal abaixo:',
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                width: screenWidth * 0.8,
                height: screenHeight > 600
                    ? screenHeight * 0.6
                    : screenHeight * 0.4,
                child: PdfViewer.asset('$pdfsPath/$cronogramaFile'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('Voltar button pressed');
                      appProvider.setRoute('/home');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final String fullPath = '$pdfsPath/$cronogramaFile';
                        dp('Loading PDF from assets for sharing: $fullPath');
                        final data = await rootBundle.load(fullPath);
                        final bytes = data.buffer.asUint8List();
                        // CASE 1 : WEB
                        if (kIsWeb) {
                          dp('Sharing PDF on web platform');
                          await SharePlus.instance.share(
                            ShareParams(
                              text: 'Confira o Cronograma Mensal da Paróquia!',
                              files: [
                                XFile.fromData(
                                  bytes,
                                  name: cronogramaFile,
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
                          final file = File(
                            '${directory.path}/$cronogramaFile',
                          );

                          await file.writeAsBytes(bytes, flush: true);
                          final sharePlus = await SharePlus.instance.share(
                            ShareParams(
                              text:
                                  'Confira o Cronograma Mensal da Paróquia São Sebastião!',
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
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: cronogramaTitle),
      drawer: sidebar(context),
      body: SafeArea(child: body),
      bottomNavigationBar: footer(context),
    );
  }
}
