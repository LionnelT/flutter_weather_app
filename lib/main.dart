import 'package:flutter/material.dart';
import 'package:flutter_weather_app/app_blocs/app_blocs.dart';
import 'package:flutter_weather_app/app_blocs/app_repositories.dart';
import 'package:flutter_weather_app/pages/home_page.dart';

// The main() function is the entry point for the app.
Future<void> main() async {
  // The config property is a configuration object that contains the app repositories and app blocs.
  var config = const AppRepositories(
    appBlocs: AppBlocs(
      app: MainApp(),
    ),
  );

  runApp(config);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
