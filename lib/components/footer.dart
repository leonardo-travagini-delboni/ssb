import 'package:flutter/material.dart';

Widget footer(BuildContext context, {String title = ''}) {
  int curYear = DateTime.now().year;
  double screenHeight = MediaQuery.of(context).size.height;
  if (title.isEmpty) {
    title = '© 2024 - $curYear Paróquia São Sebastião. Novo Horizonte - SP';
  }
  return SafeArea(
    top: false,
    child: Container(
      height: screenHeight * 0.08,
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ),
    ),
  );
}
