import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/models/forecast.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_repository.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final WeatherRepository weatherRepository;
  WeatherForecastBloc({required this.weatherRepository})
      : super(WeatherForecastInitial()) {
    on<FetchWeatherForecastEvent>((event, emit) async {
      // Emit a loading state to indicate that data is being fetched
      emit(WeatherForecastLoadingState());
      try {
        var data =
            await weatherRepository.getWeatherForecast(event.lat, event.lon);
        // Print loaded data for debugging purposes
        // ignore: avoid_print
        print("***Loaded");
        // ignore: avoid_print
        print(data);
        // Emit a loaded state with the fetched data
        emit(WeatherForecastLoadedState(forecast: data));
      } catch (e) {
        // Emit an error state if an exception occurs
        emit(WeatherForecastErrorState(error: e.toString()));
      }
    });
  }
}
