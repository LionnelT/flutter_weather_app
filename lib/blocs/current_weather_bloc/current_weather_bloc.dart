
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/models/current.dart';
import 'package:flutter_weather_app/data/repositories/weather_repository/weather_repository.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository weatherRepository;
  CurrentWeatherBloc({required this.weatherRepository})
      : super(CurrentWeatherInitial()) {
    on<FetchCurrentWeatherEvent>((event, emit) async {
      emit(CurrentWeatherLoadingState());
      try {
        var data = await weatherRepository.getCurrentWeatherCondition(
            event.lat, event.lon);

        // ignore: avoid_print
        print("***Loaded");
        // ignore: avoid_print
        print(data);

        emit(CurrentWeatherLoadedState(current: data));
      } catch (e) {
        emit(CurrentWeatherErrorState(error: e.toString()));
      }
    });
  }
}
