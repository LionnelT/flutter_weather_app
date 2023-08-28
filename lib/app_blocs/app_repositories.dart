import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_provider.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_repository.dart';

// This class is a StatelessWidget that provides the WeatherRepository for the weather app.
class AppRepositories extends StatelessWidget {
  final Widget appBlocs;

  const AppRepositories({Key? key, required this.appBlocs}) : super(key: key);

// The build method returns a MultiRepositoryProvider that provides the WeatherRepository.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      // The WeatherRepository is created with the WeatherProvider injected.
      RepositoryProvider(
          create: (context) =>
              WeatherRepository(weatherProvider: WeatherProvider()))
    ], child: appBlocs);
  }
}
