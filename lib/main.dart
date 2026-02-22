import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/config/theme.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/biblia.dart';
import 'package:ssb/provider/paroquia.dart';
import 'package:ssb/provider/platform.dart';
import 'package:ssb/provider/theme.dart';
import 'package:ssb/router.dart';

// Global navigator key
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Main entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pdfrxFlutterInitialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => BibliaProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlatformProvider()),
        ChangeNotifierProvider(create: (_) => ParoquiaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Material App
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: showDebugBanner,
      title: appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: RouterScreen(),
    );
  }
}
