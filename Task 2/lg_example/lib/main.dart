import 'package:flutter/material.dart';
import 'package:lg_example/screen/screen.dart';
import 'package:lg_example/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeChanger())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      themeMode: themeprovider.themeMode,
      darkTheme: ThemeData.dark(),
      theme: themeprovider.check(),

      // theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green[700]),
      home: Scaffold(
        appBar: AppBar(title: const Text('LG Basic'), elevation: 2),
        body: Screen(),
      ),
    );
  }
}
