import 'dart:typed_data' show ByteData;

import 'package:download/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
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
  final String _assetsPath = 'assets/pdf';
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    dp('CronogramaScreen started');
    String title = "Cronograma Mensal";
    Widget body = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight > 600
                    ? screenHeight * 0.6
                    : screenHeight * 0.4,
                child: PdfViewer.asset('$_assetsPath/$cronogramaFile'),
              ),
              const SizedBox(height: 30.0),
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
                        // Carrega o PDF do assets
                        final ByteData bytes = await rootBundle.load(
                          '$_assetsPath/$cronogramaFile',
                        );
                        final List<int> byteList = bytes.buffer.asUint8List();

                        // Faz o download do arquivo
                        final stream = Stream.fromIterable(byteList);
                        await download(stream, cronogramaFile);

                        dp('PDF downloaded successfully');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                'PDF baixado com sucesso!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        dp('Error downloading PDF: $e');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Erro ao baixar PDF: $e',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.download),
                    label: const Text('Baixar PDF'),
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
      appBar: header(context, title: title),
      drawer: sidebar(context),
      body: body,
      bottomNavigationBar: footer(context),
    );
  }
}
