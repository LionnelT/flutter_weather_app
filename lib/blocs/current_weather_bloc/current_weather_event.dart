part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchCurrentWeatherEvent extends CurrentWeatherEvent {
  final double lat;
  final double lon;

  const FetchCurrentWeatherEvent({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}
