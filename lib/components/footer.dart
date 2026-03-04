import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/provider/paroquia.dart';
import 'package:url_launcher/url_launcher.dart';

Widget footer(BuildContext context, {String title = ''}) {
  String? pixChave = ParoquiaProvider.pixMap["pix_chave"];
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  if (title.isEmpty) {
    title = 'Paróquia São Sebastião. Novo Horizonte - SP';
  }

  List<dynamic> footerAds = [
    // Footer 1 - PIX Paróquia São Sebastião (ação de copiar chave PIX)
    if (pixChave != null && pixChave.isNotEmpty && !kIsWeb)
      {
        'is_image': true,
        'content': 'assets/img/ads/footer1.png',
        'action': () {
          try {
            dp('Footer: PIX Paróquia tapped (footer1)');
            Clipboard.setData(ClipboardData(text: pixChave));
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
          } catch (e) {
            dp('Error copying PIX chave: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                content: Text(
                  'Erro ao copiar chave PIX. Tente novamente.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
      },
    // Footer 2 - Fundação Cáritas Catanduva (link para WhatsApp)
    if (enableCaritas && !kIsWeb)
      {
        'is_image': true,
        'content': 'assets/img/ads/footer2.png',
        'action': () async {
          try {
            dp('Footer: Fundação Cáritas Catanduva tapped (footer2)');
            if (await canLaunchUrl(Uri.parse(caritasWhatsapp))) {
              await launchUrl(
                Uri.parse(caritasWhatsapp),
                mode: LaunchMode.externalApplication,
              );
            }
          } catch (e) {
            dp('Error opening Cáritas link: $e');
          }
        },
      },
    // Footer 3 - Anuncie você também (link para WhatsApp)
    if (enableCreditos && !kIsWeb)
      {
        'is_image': true,
        'content': 'assets/img/ads/footer3.png',
        'action': () async {
          try {
            dp('Footer: Anuncie você também tapped (footer3)');
            if (await canLaunchUrl(Uri.parse(devWhatsapp))) {
              await launchUrl(
                Uri.parse(devWhatsapp),
                mode: LaunchMode.externalApplication,
              );
            }
          } catch (e) {
            dp('Error opening Dev link: $e');
          }
        },
      },
    // Footer 99 - Standard text footer (no ad)
    {'is_image': false, 'content': title, 'action': () {}},
  ];

  return SafeArea(
    top: false,
    child: Container(
      width: screenWidth,
      height: screenHeight * 0.08,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 300),
          autoPlayCurve: Curves.easeInOut,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1.0,
          height: screenHeight * 0.08,
        ),
        items: footerAds.map((ad) {
          return GestureDetector(
            onTap: ad['action'],
            child: ad['is_image']
                ? SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.08,
                    child: Image.asset(
                      ad['content'],
                      fit: BoxFit.contain,
                      width: screenWidth,
                      height: screenHeight * 0.08,
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        ad['content'],
                        style: TextStyle(
                          color: Theme.of(context).appBarTheme.foregroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          );
        }).toList(),
      ),
    ),
  );
}
