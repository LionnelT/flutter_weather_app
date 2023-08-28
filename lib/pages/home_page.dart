import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:flutter_weather_app/data/models/forecast.dart';
import 'package:flutter_weather_app/helpers/date_converter.dart';
import 'package:flutter_weather_app/res/app_colors.dart';
import 'package:flutter_weather_app/widgets/destinations.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _callBlocs();
  }

  _callBlocs() async {
    // This method fetches the current weather and forecast.

    // The LocationPermission.checkPermission() method checks if the user has granted permission to access their location.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // The Geolocator.getCurrentPosition() method gets the current position of the device.
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // The following method adds an event to the CurrentWeatherBloc.
    // The event tells the bloc to fetch the current weather for the given latitude and longitude.
    BlocProvider.of<CurrentWeatherBloc>(context).add(
      FetchCurrentWeatherEvent(lat: position.latitude, lon: position.longitude),
    );

    // The following method adds an event to the WeatherForecastBloc.
    // The event tells the bloc to fetch the weather forecast for the given latitude and longitude.
    BlocProvider.of<WeatherForecastBloc>(context).add(
      FetchWeatherForecastEvent(
          lat: position.latitude, lon: position.longitude),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
        bottomNavigationBar: NavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          destinations: destinations.map<NavigationDestination>((d) {
            return NavigationDestination(
              icon: Icon(d.icon),
              label: d.label,
            );
          }).toList(),
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: ListView(
          children: [
            BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
              listener: (context, state) {
                // ignore: avoid_print
                print(state);
                if (state is CurrentWeatherErrorState) {
                  Center(
                    child: Text(state.error),
                  );
                }
              },
              builder: (context, state) {
                if (state is CurrentWeatherLoadingState) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          SimpleCircularProgressBar(
                            progressColors: [
                              appColorRainy,
                              appColorSunny,
                              appColorCloudy
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Loading Please Wait...'),
                          )
                        ],
                      ),
                    ),
                  );
                }
                if (state is CurrentWeatherLoadedState) {
                  var weatherState =
                      state.current.weather!.map((e) => e.main).toString();

                  return Stack(
                    children: [
                      weatherState.toString().toLowerCase().contains('clear')
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                'assets/images/forest_sunny.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          : weatherState
                                  .toString()
                                  .toLowerCase()
                                  .contains('sunny')
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    'assets/images/forest_sunny.png',
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : weatherState
                                      .toString()
                                      .toLowerCase()
                                      .contains('rain')
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        'assets/images/forest_rainy.png',
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : weatherState
                                          .toString()
                                          .toLowerCase()
                                          .contains('clouds')
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.asset(
                                            'assets/images/forest_cloudy.png',
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : weatherState
                                              .toString()
                                              .toLowerCase()
                                              .contains('mist')
                                          ? SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.asset(
                                                'assets/images/forest_rainy.png',
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.asset(
                                                'assets/images/forest_sunny.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text(
                                '${state.current.main?.temp}\u{00B0}',
                                style: const TextStyle(
                                    color: appColorWhite, fontSize: 30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: Text(
                                weatherState.toString(),
                                style: const TextStyle(
                                    color: appColorWhite, fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        SimpleCircularProgressBar(
                          progressColors: [
                            appColorRainy,
                            appColorSunny,
                            appColorCloudy
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Loading Please Wait...'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CurrentWeatherLoadedState) {
                  var weatherState =
                      state.current.weather!.map((e) => e.main).first;
                  return Container(
                    height: 60,
                    color:
                        weatherState.toString().toLowerCase().contains('clear')
                            ? appColorSunny
                            : weatherState
                                    .toString()
                                    .toLowerCase()
                                    .contains('sunny')
                                ? appColorSunny
                                : weatherState
                                        .toString()
                                        .toLowerCase()
                                        .contains('rain')
                                    ? appColorRainy
                                    : weatherState
                                            .toString()
                                            .toLowerCase()
                                            .contains('clouds')
                                        ? appColorCloudy
                                        : weatherState
                                                .toString()
                                                .toLowerCase()
                                                .contains('mist')
                                            ? appColorRainy
                                            : appColorSunny,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${state.current.main!.tempMin}\u{00B0}',
                              style: const TextStyle(
                                  color: appColorWhite, fontSize: 20),
                            ),
                            const Text(
                              'min',
                              style:
                                  TextStyle(color: appColorWhite, fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${state.current.main!.temp}\u{00B0}',
                              style: const TextStyle(
                                  color: appColorWhite, fontSize: 20),
                            ),
                            const Text(
                              'Current',
                              style:
                                  TextStyle(color: appColorWhite, fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${state.current.main!.temp}\u{00B0}',
                              style: const TextStyle(
                                  color: appColorWhite, fontSize: 20),
                            ),
                            const Text(
                              'max',
                              style:
                                  TextStyle(color: appColorWhite, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            BlocConsumer<WeatherForecastBloc, WeatherForecastState>(
              listener: (context, state) {
                // ignore: avoid_print
                print(state);
              },
              builder: (context, state) {
                if (state is WeatherForecastLoadedState) {
                  return _buildForecast(state.forecast);
                }
                return Container();
              },
            )
          ],
        ));
  }
}

// This method builds the weather forecast UI
Widget _buildForecast(ForecastModel forecast) {
  return SizedBox(
    height: 400,
    child: ListView.builder(
      itemCount: forecast.list.length,
      itemBuilder: ((context, index) {
        var forecasts = forecast.list[index].weather;
        var weatherState = forecasts.map((element) => element.main);
        return Container(
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  DateConverter.getDayOfTheWeek(forecast.list[index].dtTxt),
                  style: const TextStyle(fontSize: 20, color: appColorWhite),
                ),
                weatherState.toString().toLowerCase().contains("clear")
                    ? const ImageIcon(
                        AssetImage("assets/Icons/clear.png"),
                        color: appColorWhite,
                        size: 100,
                      )
                    : weatherState.toString().toLowerCase().contains("rain")
                        ? const ImageIcon(
                            AssetImage("assets/Icons/rain.png"),
                            color: appColorWhite,
                            size: 60,
                          )
                        : weatherState
                                .toString()
                                .toLowerCase()
                                .contains("clouds")
                            ? const ImageIcon(
                                AssetImage("assets/Icons/partlysunny.png"),
                                color: appColorWhite,
                                size: 60,
                              )
                            : const ImageIcon(
                                AssetImage("assets/Icons/partlysunny.png"),
                                color: appColorWhite,
                                size: 60,
                              ),
                Text(
                  '${forecast.list[index].main.temp}\u{00B0}',
                  style: const TextStyle(fontSize: 20, color: appColorWhite),
                ),
              ],
            ));
      }),
    ),
  );
}
