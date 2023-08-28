import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_repository.dart';

// This class is a StatelessWidget that provides the Blocs for the weather app.
class AppBlocs extends StatelessWidget {
  final Widget app;
  const AppBlocs({Key? key, required this.app}) : super(key: key);

// The build method returns a MultiBlocProvider that provides the CurrentWeatherBloc
  // and WeatherForecastBloc.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // The CurrentWeatherBloc is created with the WeatherRepository injected.
      BlocProvider(
        create: (context) => CurrentWeatherBloc(
          weatherRepository: RepositoryProvider.of<WeatherRepository>(context),
        ),
      ),
      // The WeatherForecastBloc is created with the WeatherRepository injected.
      BlocProvider(
        create: (context) => WeatherForecastBloc(
          weatherRepository: RepositoryProvider.of<WeatherRepository>(context),
        ),
      )
    ], child: app);
  }
}
