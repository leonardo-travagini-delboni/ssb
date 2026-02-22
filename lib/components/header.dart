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
      PopupMenuButton<ThemeMode>(
        onSelected: (ThemeMode newMode) {
          dp('Theme mode changed to: $newMode');
          themeProvider.setThemeMode(newMode);
        },
        color: Theme.of(context).appBarTheme.backgroundColor,
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: ThemeMode.system,
            child: Row(
              children: [
                Icon(Icons.brightness_auto),
                SizedBox(width: 8),
                Text(
                  'Sistema',
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: ThemeMode.light,
            child: Row(
              children: [
                Icon(Icons.light_mode),
                SizedBox(width: 8),
                Text(
                  'Claro',
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: ThemeMode.dark,
            child: Row(
              children: [
                Icon(Icons.dark_mode),
                SizedBox(width: 8),
                Text(
                  'Escuro',
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        icon: Icon(Icons.brightness_4),
      ),
    ],
  );
}
