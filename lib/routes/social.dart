import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/components/footer.dart';
import 'package:ssb/components/header.dart';
import 'package:ssb/components/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível abrir o link')),
        );
      }
    }
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required String url,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          dp('SocialScreen: $label button tapped');
          _launchUrl(url);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    dp('SocialScreen started');
    String title = "Redes Sociais";

    Widget body = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Informações de Contato
                    Text(
                      'Fale Conosco',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Informações para contato e localização',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15.0),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone, size: 20, color: Colors.blue),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(
                                    '(17) 99747-9104 / (17) 3543-1654',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              children: [
                                Icon(Icons.email, size: 20, color: Colors.blue),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(
                                    'contato@saosebastiaoparoquia.com.br',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(
                                    'Rua São Sebastião, 335\nVila Baumann\nNovo Horizonte - SP\nCEP: 14967-264',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(
                                    'Padre Eugênio Pessato',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Redes Sociais',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Acompanhe nossas redes sociais',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15.0),
                    // Redes Sociais
                    _buildSocialButton(
                      icon: Icons.language,
                      label: 'Site Oficial',
                      color: Colors.blue,
                      url: 'https://saosebastiaoparoquia.com.br/',
                    ),
                    const SizedBox(height: 12.0),
                    _buildSocialButton(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      color: Color(0xFF1877F2),
                      url: 'https://www.facebook.com/saosebastiao.matriz',
                    ),
                    const SizedBox(height: 12.0),
                    _buildSocialButton(
                      icon: Icons.camera_alt,
                      label: 'Instagram',
                      color: Color(0xFFE4405F),
                      url: 'https://www.instagram.com/sao.sebastiao.paroquia/',
                    ),
                    const SizedBox(height: 12.0),
                    _buildSocialButton(
                      icon: Icons.play_circle_filled,
                      label: 'YouTube',
                      color: Color(0xFFFF0000),
                      url:
                          'https://www.youtube.com/channel/UCCdnVASNbY3O1Femu7BS-TQ',
                    ),
                    const SizedBox(height: 12.0),
                    _buildSocialButton(
                      icon: Icons.chat,
                      label: 'WhatsApp',
                      color: Color(0xFF25D366),
                      url: 'https://api.whatsapp.com/send/?phone=5517997479104',
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
            // Botão Voltar
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  dp('SocialScreen: Voltar button tapped');
                  appProvider.setRoute('/home');
                },
                icon: Icon(Icons.arrow_back),
                label: const Text('Voltar ao Início'),
              ),
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
