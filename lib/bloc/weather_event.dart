part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final position;
  final bool status;
  final bool isNotAuto;

  const FetchWeather(this.position,this.status,this.isNotAuto);

  @override
  List<Object> get props => [position, status, isNotAuto];  
}