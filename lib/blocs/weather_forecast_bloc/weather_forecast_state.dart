part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastState extends Equatable {
  const WeatherForecastState();
  
  @override
  List<Object> get props => [];
}

// Represents the initial state when the WeatherForecastBloc is first created
final class WeatherForecastInitial extends WeatherForecastState {}

// Represents the state when the WeatherForecastBloc is loading data
class WeatherForecastLoadingState extends WeatherForecastState {}

// Represents the state when the WeatherForecastBloc has successfully loaded the current weather data
class WeatherForecastLoadedState extends WeatherForecastState {
  final ForecastModel forecast;

  const WeatherForecastLoadedState({required this.forecast});

  @override
  List<Object> get props => [forecast];
}

// Represents the state when an error occurs while loading or processing the current weather data
class WeatherForecastErrorState extends WeatherForecastState {
  final String error;

  const WeatherForecastErrorState({required this.error});

  @override
  List<Object> get props => [error];
}