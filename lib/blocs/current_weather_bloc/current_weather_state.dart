part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
  
  @override
  List<Object> get props => [];
}

final class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoadingState extends CurrentWeatherState {}

class CurrentWeatherLoadedState extends CurrentWeatherState {
  final CurrentWeatherModel current;

  const CurrentWeatherLoadedState({required this.current});

  @override
  List<Object> get props => [current];
}

class CurrentWeatherErrorState extends CurrentWeatherState {
  final String error;

  const CurrentWeatherErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
