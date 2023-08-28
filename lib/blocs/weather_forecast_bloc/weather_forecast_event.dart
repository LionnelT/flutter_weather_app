part of 'weather_forecast_bloc.dart';

// Represents the base class for all weather forecast events
sealed class WeatherForecastEvent extends Equatable {
  const WeatherForecastEvent();

  @override
  List<Object> get props => [];
}

// Represents an event to fetch the weather forecast data
class FetchWeatherForecastEvent extends WeatherForecastEvent {
  final double lat;
  final double lon;

  const FetchWeatherForecastEvent({required this.lat, required this.lon});
  @override
  List<Object> get props => [lat, lon];
}