import 'dart:convert';


import 'package:flutter_weather_app/data/models/current.dart';
import 'package:flutter_weather_app/data/models/forecast.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_provider.dart';

class WeatherRepository {
  final WeatherProvider weatherProvider;

  WeatherRepository({required this.weatherProvider});

  Future<CurrentWeatherModel> getCurrentWeatherCondition(double lat, double lon) async {
    var data = await weatherProvider.getCurrentWeatherCondition(lat, lon);
    return CurrentWeatherModel.fromJson(jsonDecode(data));
  }

  Future getWeatherForecast(double lat, double lon) async {
    var forecastData = await weatherProvider.getWeatherForecast(lat, lon);
    return ForecastModel.fromJson(jsonDecode(forecastData));
  }
}
