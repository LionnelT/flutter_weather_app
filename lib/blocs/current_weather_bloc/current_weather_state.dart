part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
  
  @override
  List<Object> get props => [];
}

// Represents the initial state when the CurrentWeatherBloc is first created

final class CurrentWeatherInitial extends CurrentWeatherState {}

// Represents the state when the CurrentWeatherBloc is loading data
class CurrentWeatherLoadingState extends CurrentWeatherState {}

// Represents the state when the CurrentWeatherBloc has successfully loaded the current weather data
class CurrentWeatherLoadedState extends CurrentWeatherState {
  final CurrentWeatherModel current;

  const CurrentWeatherLoadedState({required this.current});

  @override
  List<Object> get props => [current];
}

// Represents the state when an error occurs while loading or processing the current weather data

class CurrentWeatherErrorState extends CurrentWeatherState {
  final String error;

  const CurrentWeatherErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
