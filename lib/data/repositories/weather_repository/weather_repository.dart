import 'dart:convert';

import 'package:flutter_weather_app/data/models/current.dart';
import 'package:flutter_weather_app/data/models/forecast.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_provider.dart';

// This class is a WeatherRepository that provides a layer of abstraction between the data layer and the presentation layer.
class WeatherRepository {
  // The weatherProvider property is an instance of the WeatherProvider class.
  final WeatherProvider weatherProvider;

  WeatherRepository({required this.weatherProvider});

// The getCurrentWeatherCondition method fetches the current weather condition for the given latitude and longitude.
  Future<CurrentWeatherModel> getCurrentWeatherCondition(
      double lat, double lon) async {
    var data = await weatherProvider.getCurrentWeatherCondition(lat, lon);
    return CurrentWeatherModel.fromJson(jsonDecode(data));
  }

// The getWeatherForecast method fetches the weather forecast for the given latitude and longitude.
  Future getWeatherForecast(double lat, double lon) async {
    var forecastData = await weatherProvider.getWeatherForecast(lat, lon);
    return ForecastModel.fromJson(jsonDecode(forecastData));
  }
}
