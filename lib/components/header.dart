import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/theme.dart';

AppBar header(BuildContext context, {String title = ''}) {
  ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
  double screenHeight = MediaQuery.of(context).size.height;
  if (title.isEmpty) {
    title = Provider.of<AppProvider>(context).headerTitle;
  }
  return AppBar(
    toolbarHeight: screenHeight * 0.08,
    title: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        title,
        overflow: TextOverflow.visible,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.color_lens),
        onPressed: () async {
          dp('Header: Theme switch button tapped');
          await themeProvider.switchTheme();
        },
      ),
    ],
  );
}
