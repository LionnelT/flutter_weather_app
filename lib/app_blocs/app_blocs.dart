import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_repository.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;
  const AppBlocs({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CurrentWeatherBloc(
          weatherRepository: RepositoryProvider.of<WeatherRepository>(context),
        ),
      ),
      BlocProvider(
        create: (context) => WeatherForecastBloc(
          weatherRepository: RepositoryProvider.of<WeatherRepository>(context),
        ),
      )
    ], child: app);
  }
}
