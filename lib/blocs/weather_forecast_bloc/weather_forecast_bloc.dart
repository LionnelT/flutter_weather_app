import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/data/models/forecast.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_repository.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc extends Bloc<WeatherForecastEvent, WeatherForecastState> {

  final WeatherRepository weatherRepository;
  WeatherForecastBloc({required this.weatherRepository}) : super(WeatherForecastInitial()) {
    on<FetchWeatherForecastEvent>((event, emit) async {
               emit (WeatherForecastLoadingState());
        try {

        var data =
            await weatherRepository.getWeatherForecast(event.lat, event.lon);
        // ignore: avoid_print
        print("***Loaded");
        // ignore: avoid_print
        print(data);
        emit (WeatherForecastLoadedState(forecast: data));
      } catch (e) {
        emit (WeatherForecastErrorState(error: e.toString()));
      }
    });
  }
}
