part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastEvent extends Equatable {
  const WeatherForecastEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherForecastEvent extends WeatherForecastEvent {
  final double lat;
  final double lon;

  const FetchWeatherForecastEvent({required this.lat, required this.lon});
  @override
  List<Object> get props => [lat, lon];
}