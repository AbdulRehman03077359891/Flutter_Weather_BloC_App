import 'dart:async'; // Required for Timer
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_bloc/API/weather_apis.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  Timer? _timer; // Timer for auto-fetching every minute

  WeatherBloc() : super(WeatherInitial()) {
    // Start periodic fetching after the initial trigger
    _startAutoFetch();

    on<FetchWeather>((event, emit) async {
      if(event.isNotAuto){
      emit(WeatherLoading());}
      try {
        WeatherFactory weatherFactory =
            WeatherFactory(weatherApiKey, language: Language.ENGLISH);
        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.status == true ? event.position[0] : event.position.latitude,
            event.status == true ? event.position[1] : event.position.longitude);
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }

  // Start a timer to auto-fetch weather data every minute
  void _startAutoFetch() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      // Automatically trigger the FetchWeather event every minute
      if (state is WeatherSuccess) {
        bool isNotAuto = false;
       // Use the latest position and status from the state or pass fixed values
        final currentWeather = (state as WeatherSuccess).weather;
        List<double> position = [currentWeather.latitude!, currentWeather.longitude!];
        add(FetchWeather(position, true, isNotAuto)); // Adjust the parameters based on your needs
      }
    });
  }

  @override
  Future<void> close() {
    // Cancel the timer when the Bloc is closed to prevent memory leaks
    _timer?.cancel();
    return super.close();
  }
}
