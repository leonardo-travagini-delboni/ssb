import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:ssb/config/func.dart';
import 'package:ssb/config/params.dart';
import 'package:ssb/config/theme.dart';
import 'package:ssb/provider/app.dart';
import 'package:ssb/provider/biblia.dart';
import 'package:ssb/provider/game.dart';
import 'package:ssb/provider/paroquia.dart';
import 'package:ssb/provider/theme.dart';
import 'package:ssb/router.dart';

// Global navigator key
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Main entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pdfrxFlutterInitialize();
  if (!kIsWeb) {
    dp('Non-web platform detected, setting preferred orientations');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } else {
    dp('Web platform detected, skipping orientation lock');
  }
  dp('Starting app with version: $appVersion (Release $releaseVersion)');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => BibliaProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ParoquiaProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
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
    dp('Building MyApp widget');
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
