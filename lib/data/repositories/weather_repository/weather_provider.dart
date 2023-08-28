import 'dart:convert';

import 'package:flutter_weather_app/res/app_constants.dart';
import 'package:flutter_weather_app/res/app_urls.dart';
import 'package:http/http.dart' as http;

class WeatherProvider {
  Future getCurrentWeatherCondition(double lat, double lon) async {
    // ignore: avoid_print
    print(
        '${AppUrls.baseUrl}/weather?lat=$lat&lon=$lon&appid=${AppConstants.appId}&units=${AppConstants.unit}');
    var response = await http.get(Uri.parse(
        '${AppUrls.baseUrl}/weather?lat=$lat&lon=$lon&appid=${AppConstants.appId}&units=${AppConstants.unit}'));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to get current weather information ${response.statusCode}');
    }
    // ignore: avoid_print
    print(jsonDecode(response.body));

    return response.body;
  }

  Future getWeatherForecast(double lat, double lon) async {
    // ignore: avoid_print
    print(
        '${AppUrls.baseUrl}/forecast?lat=$lat&lon=$lon&appid=${AppConstants.appId}&units=${AppConstants.unit}');

    var response = await http.get(Uri.parse(
        '${AppUrls.baseUrl}/forecast?lat=$lat&lon=$lon&appid=${AppConstants.appId}&units=${AppConstants.unit}'));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to get current weather information ${response.statusCode}');
    }
    // ignore: avoid_print
    print(jsonDecode(response.body));

    return response.body;
  }
}
