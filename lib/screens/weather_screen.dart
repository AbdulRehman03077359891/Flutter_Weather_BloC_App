
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_bloc/Services/weather_utils.dart';
import 'package:weather_bloc/Widgets/background_decoration.dart';
import 'package:weather_bloc/Widgets/tem_max_min_row.dart';
import 'package:weather_bloc/Widgets/weather_detail_row.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key?? const PageStorageKey('weather_screen'));

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const BackgroundDecorations(),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSuccess) {
                    return _buildWeatherContent(context, state.weather);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

 
  Widget _buildWeatherContent(BuildContext context, Weather weather) {
    print(weather.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📍 ${weather.areaName}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Text(
          "Good Morning",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Center(child: getWeatherIcon(weather.weatherConditionCode!)),
        Center(
          child: Text(
            "${weather.temperature!.celsius!.round()}°C",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 55,
            ),
          ),
        ),
        Center(
          child: Text(
            weather.weatherMain!.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
        Center(
          child: Text(
            DateFormat("EEEE dd ,").add_jm().format(weather.date!),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 30),
        WeatherDetailRow(
          sunrise: weather.sunrise!,
          sunset: weather.sunset!,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(color: Colors.grey),
        ),
        TempMinMaxRow(
          tempMin: weather.tempMin!,
          tempMax: weather.tempMax!,
        ),
      ],
    );
  }
}
