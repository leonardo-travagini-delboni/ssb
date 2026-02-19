import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/paroquia.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class ParoquiaScreen extends StatefulWidget {
  const ParoquiaScreen({super.key});

  @override
  State<ParoquiaScreen> createState() => _ParoquiaScreenState();
}

class _ParoquiaScreenState extends State<ParoquiaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    dp('ParoquiaScreen started');
    ParoquiaProvider paroquiaProvider = Provider.of<ParoquiaProvider>(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    String headerTitle = 'Paróquia São Sebastião';
    Widget body = Container();

    // Método auxiliar para criar linhas de informação
    Widget buildInfoRow(IconData icon, String label, String value) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8.0),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 4.0),
          Expanded(child: Text(value)),
        ],
      );
    }

    // MISSAS
    if (paroquiaProvider.categoria == 'missas') {
      headerTitle = 'Horários das Missas';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  ...ParoquiaProvider.missasMap.entries.map((entry) {
                    String dia = entry.key;
                    Map<String, String> horarios = entry.value;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dia[0].toUpperCase() + dia.substring(1),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...horarios.entries.map((horario) {
                          String hora = horario.key;
                          String local = horario.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350,
                                child: ListTile(
                                  leading: Icon(Icons.church),
                                  title: Text(hora),
                                  subtitle: Text(local),
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          dp('ParoquiaScreen: Voltar button tapped');
                          paroquiaProvider.setCategoria('');
                        },
                        icon: Icon(Icons.arrow_back),
                        label: const Text('Voltar'),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          dp('ParoquiaScreen: Confissões button tapped');
                          paroquiaProvider.setCategoria('confissoes');
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: const Text('Confissões'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    // CONFISSÕES
    else if (paroquiaProvider.categoria == 'confissoes') {
      headerTitle = 'Horários das Confissões';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...ParoquiaProvider.confissoesMap.entries.map((entry) {
                    String dia = entry.key;
                    Map<String, String> horarios = entry.value;
                    return Column(
                      children: [
                        Text(
                          dia[0].toUpperCase() + dia.substring(1),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...horarios.entries.map((horario) {
                          String hora = horario.key;
                          String local = horario.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350,
                                child: ListTile(
                                  leading: Icon(Icons.church),
                                  title: Text(hora),
                                  subtitle: Text(local),
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    );
                  }),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          dp('ParoquiaScreen: Voltar button tapped');
                          paroquiaProvider.setCategoria('');
                        },
                        icon: Icon(Icons.arrow_back),
                        label: const Text('Voltar'),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          dp('ParoquiaScreen: Doações PIX button tapped');
                          paroquiaProvider.setCategoria('doacoes');
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: const Text('Doações'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    // DOAÇÕES
    else if (paroquiaProvider.categoria == 'doacoes') {
      headerTitle = 'Doações via PIX';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Para doar utilize o QR Code a seguir:',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Image.asset(
                  'assets/img/pix.png',
                  width: 250.0,
                  height: 250.0,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'ou então copie a chave PIX a seguir:',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Modalidade: ${ParoquiaProvider.pixMap["pix_tipo_chave"] ?? ''}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          'Recebedor: ${ParoquiaProvider.pixMap["pix_recebedor"] ?? ''}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          'Banco: ${ParoquiaProvider.pixMap["pix_banco"] ?? ''}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ParoquiaProvider.pixMap["pix_chave"] ?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.copy),
                              onPressed: () {
                                String pixChave =
                                    ParoquiaProvider.pixMap["pix_chave"] ?? '';
                                Clipboard.setData(
                                  ClipboardData(text: pixChave),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 3),
                                    content: Text(
                                      'Chave PIX copiada!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Voltar button tapped');
                        paroquiaProvider.setCategoria('');
                      },
                      icon: Icon(Icons.arrow_back),
                      label: const Text('Voltar'),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Atendimento button tapped');
                        paroquiaProvider.setCategoria('atendimento');
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: const Text('Atendimento'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    // ATENDIMENTO
    else if (paroquiaProvider.categoria == 'atendimento') {
      headerTitle = 'Atendimento Paroquial';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...ParoquiaProvider.atendimentoMap.entries.map((entry) {
                    String dia = entry.key;
                    Map<String, String> horarios = entry.value;
                    return Column(
                      children: [
                        Text(
                          dia[0].toUpperCase() + dia.substring(1),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...horarios.entries.map((horario) {
                          String hora = horario.key;
                          String local = horario.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350,
                                child: ListTile(
                                  leading: Icon(Icons.support_agent),
                                  title: Text(hora),
                                  subtitle: Text(local),
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    );
                  }),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          dp('ParoquiaScreen: Voltar button tapped');
                          paroquiaProvider.setCategoria('');
                        },
                        icon: Icon(Icons.arrow_back),
                        label: const Text('Voltar'),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          dp('ParoquiaScreen: Nossas Igrejas button tapped');
                          paroquiaProvider.setCategoria('igrejas');
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: const Text('Igrejas'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    // IGREJAS
    else if (paroquiaProvider.categoria == 'igrejas') {
      headerTitle = 'Nossas Igrejas';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...ParoquiaProvider.igrejasMap.asMap().entries.map((entry) {
                  String nome = entry.value['nome'] ?? '';
                  String endereco = entry.value['endereco'] ?? '';
                  String bairro = entry.value['bairro'] ?? '';
                  String cep = entry.value['cep'] ?? '';
                  List<String> carousel = (List<String>.from(
                    entry.value['carousel'] ?? ['assets/img/na.png'],
                  ));
                  String responsavel = entry.value['responsavel'] ?? '';
                  String telefone = entry.value['telefone'] ?? '';
                  String whatsapp = entry.value['whatsapp'] ?? '';
                  Map<String, String> missas = Map<String, String>.from(
                    entry.value['missas'] ?? {},
                  );
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.church),
                      title: Text(
                        nome,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('$endereco, $bairro - CEP: $cep'),
                      trailing: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CarouselSlider(
                          items: carousel
                              .map(
                                (imagem) => Image.asset(
                                  imagem,
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    dp('Paroquia: Error loading img for $nome');
                                    return Image.asset(
                                      'assets/img/na.png',
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 50.0,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 2),
                            autoPlayAnimationDuration: Duration(
                              milliseconds: 800,
                            ),
                            enableInfiniteScroll: true,
                            viewportFraction: 1.0,
                          ),
                        ),
                      ),
                      onTap: () {
                        dp('ParoquiaScreen: Igreja $nome tapped');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                nome,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 200.0,
                                        height: 200.0,
                                        child: CarouselSlider(
                                          items: carousel
                                              .map(
                                                (imagem) => Image.asset(
                                                  imagem,
                                                  width: 250.0,
                                                  height: 250.0,
                                                  fit: BoxFit.contain,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        dp(
                                                          'Paroquia: Error loading img for $nome',
                                                        );
                                                        return Image.asset(
                                                          'assets/img/na.png',
                                                          width: 250.0,
                                                          height: 250.0,
                                                          fit: BoxFit.contain,
                                                        );
                                                      },
                                                ),
                                              )
                                              .toList(),
                                          options: CarouselOptions(
                                            height: 250.0,
                                            autoPlay: true,
                                            autoPlayInterval: Duration(
                                              seconds: 2,
                                            ),
                                            autoPlayAnimationDuration: Duration(
                                              milliseconds: 800,
                                            ),
                                            enableInfiniteScroll: true,
                                            viewportFraction: 1.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Container(
                                        height: 1,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        color: Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor,
                                      ),
                                      const SizedBox(height: 14.0),
                                      Text(
                                        'Responsável:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (responsavel.isNotEmpty) ...[
                                        const SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Nome:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text(responsavel),
                                          ],
                                        ),
                                      ],
                                      if (telefone.isNotEmpty) ...[
                                        const SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Telefone:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text(telefone),
                                          ],
                                        ),
                                      ],
                                      if (whatsapp.isNotEmpty) ...[
                                        const SizedBox(height: 8.0),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () async {
                                            if (await canLaunchUrl(
                                              Uri.parse(whatsapp),
                                            )) {
                                              await launchUrl(
                                                Uri.parse(whatsapp),
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            }
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'WhatsApp',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 14.0),
                                      Container(
                                        height: 1,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        color: Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor,
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        'Horários das Missas:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      ...missas.entries.map((horario) {
                                        String dia = horario.key;
                                        String hora = horario.value;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 350,
                                              child: ListTile(
                                                leading: Icon(Icons.schedule),
                                                title: Text(dia),
                                                subtitle: Text(hora),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                      const SizedBox(height: 10.0),
                                      Container(
                                        height: 1,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        color: Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor,
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        'Endereço:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        '$endereco, $bairro - CEP: $cep',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10.0),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.close),
                                  tooltip: 'Voltar',
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Voltar button tapped');
                        paroquiaProvider.setCategoria('');
                      },
                      icon: Icon(Icons.arrow_back),
                      label: const Text('Voltar'),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Nossas Pastorais button tapped');
                        paroquiaProvider.setCategoria('pastorais');
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: const Text('Pastorais'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    // PASTORAIS
    else if (paroquiaProvider.categoria == 'pastorais') {
      headerTitle = 'Nossas Pastorais';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...ParoquiaProvider.pastoraisMap.map((entry) {
                  String nome = entry['nome'] ?? '';
                  String descricao = entry['descricao'] ?? '';
                  String imagem = entry['imagem'] ?? 'assets/img/na.png';
                  String responsavel = entry['responsavel'] ?? '';
                  String telefone = entry['telefone'] ?? '';
                  String whatsapp = entry['whatsapp'] ?? '';
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.group),
                      title: Text(
                        nome,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(descricao),
                      trailing: Image.asset(
                        imagem,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        dp('ParoquiaScreen: Pastoral $nome tapped');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                nome,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        descricao,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8.0),
                                      Image.asset(
                                        imagem,
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Responsável:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(responsavel),
                                        ],
                                      ),
                                      if (telefone.isNotEmpty) ...[
                                        const SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Telefone:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text(telefone),
                                          ],
                                        ),
                                      ],
                                      if (whatsapp.isNotEmpty) ...[
                                        const SizedBox(height: 8.0),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () async {
                                            if (await canLaunchUrl(
                                              Uri.parse(whatsapp),
                                            )) {
                                              await launchUrl(
                                                Uri.parse(whatsapp),
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            }
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'WhatsApp',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 16.0),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.close),
                                  tooltip: 'Voltar',
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Voltar button tapped');
                        paroquiaProvider.setCategoria('');
                      },
                      icon: Icon(Icons.arrow_back),
                      label: const Text('Voltar'),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Nossos Padres button tapped');
                        paroquiaProvider.setCategoria('padres');
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: const Text('Padres'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    // PADRES
    else if (paroquiaProvider.categoria == 'padres') {
      headerTitle = 'Nossos Sacerdotes';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...ParoquiaProvider.padresMap.map((entry) {
                  String apelido = entry['apelido'] ?? '';
                  String nome = entry['nome'] ?? '';
                  String periodo = entry['periodo'] ?? '';
                  String imagem = entry['imagem'] ?? 'assets/img/na.png';
                  return Card(
                    child: ExpansionTile(
                      leading: Image.asset(
                        imagem,
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        apelido,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(periodo),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                nome,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                periodo,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 10.0),
                              Image.asset(
                                imagem,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Voltar button tapped');
                        paroquiaProvider.setCategoria('');
                      },
                      icon: Icon(Icons.arrow_back),
                      label: const Text('Voltar'),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: História button tapped');
                        paroquiaProvider.setCategoria('historia');
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: const Text('História'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    // HISTORIA
    else if (paroquiaProvider.categoria == 'historia') {
      headerTitle = 'Nossa História';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto da Paróquia
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/img/igrejas/ssb1.png',
                  width: double.infinity,
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20.0),

              // Nome da Paróquia
              Text(
                'Paróquia São Sebastião',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),

              // Informações básicas
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(
                        Icons.calendar_today,
                        'Fundação:',
                        '14/12/2008',
                      ),
                      const SizedBox(height: 8.0),
                      buildInfoRow(
                        Icons.location_on,
                        'Endereço:',
                        'Rua São Sebastião, 355',
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person, size: 20),
                          const SizedBox(width: 8.0),
                          Text(
                            'Pároco Atual: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text('Padre Eugênio Pessato')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // História
              Text(
                'Nossa História',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Originalmente uma capela, pertencia juntamente com toda a sua comunidade paroquial atual à Paróquia São José da Santíssima Trindade (Igreja Matriz). Está localizada na Rua São Sebastião, 355, no bairro Vila Baumann, na pequena cidade de Novo Horizonte.\n\nEm 14/12/2008, a capela teve a graça de ter seu status elevado e se tornou a Paróquia São Sebastião, sob a Diocese de Catanduva.\n\nDesde então tivemos a honra de diversos padres passarem pela nossa comunidade, e atualmente nossa comunidade conta com várias igrejas e muitas pastorais, atendendo a cidade e as áreas rurais.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30.0),

              // Botão Voltar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('ParoquiaScreen: Voltar button tapped');
                      paroquiaProvider.setCategoria('');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('ParoquiaScreen: Padroeiro button tapped');
                      paroquiaProvider.setCategoria('padroeiro');
                    },
                    icon: Icon(Icons.arrow_forward),
                    label: const Text('Padroeiro'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    // PADROEIRO
    else if (paroquiaProvider.categoria == 'padroeiro') {
      headerTitle = 'Nosso Padroeiro';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/img/padroeiro.png',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Text(
                  'São Sebastião',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(
                        Icons.calendar_today,
                        'Festa:',
                        '20 de janeiro',
                      ),
                      const SizedBox(height: 8.0),
                      buildInfoRow(
                        Icons.shield,
                        'Padroeiro:',
                        'Contra a peste, a fome e a guerra',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Nosso Padroeiro',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12.0),
              Text(
                'São Sebastião, nascido no século III em Narbonne, traz consigo a herança de Milão. Sua vida é marcada por uma generosidade intrínseca e uma ascensão impressionante de soldado a primeiro capitão da guarda imperial no Império Romano.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12.0),
              Text(
                'No entanto, sua verdadeira grandeza se manifesta durante a perseguição de Diocleciano, quando ele defende secretamente os cristãos, oferecendo conforto e testemunho silencioso de fé.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12.0),
              Text(
                'Diante do martírio, sua coragem inabalável e sua devoção indomável em meio à adversidade continuam a ressoar como um exemplo duradouro de sacrifício e devoção.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('ParoquiaScreen: Voltar button tapped');
                      paroquiaProvider.setCategoria('');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('ParoquiaScreen: Indo para Bíblia button tapped');
                      appProvider.setRoute('/biblia');
                      paroquiaProvider.clearAll();
                    },
                    icon: Icon(Icons.menu_book),
                    label: const Text('Bíblia'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    // ELSE
    else {
      headerTitle = 'Paróquia São Sebastião';
      body = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Escolha a opção desejada:',
                      style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    ...ParoquiaProvider.categoriasMap.entries.map((entry) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350.0,
                                child: ListTile(
                                  leading: Icon(entry.value['icon']),
                                  title: Text(entry.value['title']),
                                  subtitle: Text(entry.value['subtitle']),
                                  onTap: () {
                                    dp('ParoquiaScreen: ${entry.value} tapped');
                                    paroquiaProvider.setCategoria(entry.key);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            height: 1.0,
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(
                              context,
                            ).appBarTheme.backgroundColor,
                          ),
                          const SizedBox(height: 5.0),
                        ],
                      );
                    }),
                    const SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        dp('ParoquiaScreen: Voltar button tapped');
                        appProvider.setRoute('/home');
                      },
                      icon: Icon(Icons.arrow_back),
                      label: const Text('Voltar ao Início'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // RETURN
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: headerTitle),
      drawer: sidebar(context),
      body: body,
      bottomNavigationBar: footer(context),
    );
  }
}
