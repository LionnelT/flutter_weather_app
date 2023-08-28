part of 'current_weather_bloc.dart';

// Represents the base class for all current weather events
sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

// Represents an event to fetch the current weather data
class FetchCurrentWeatherEvent extends CurrentWeatherEvent {
  final double lat;
  final double lon;

  const FetchCurrentWeatherEvent({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}
