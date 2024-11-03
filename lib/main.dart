import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/Location/location_bloc.dart'; // Import LocationBloc
import 'package:weather_bloc/bloc/Location/location_event.dart';
import 'package:weather_bloc/bloc/Location/location_state.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';
import 'package:weather_bloc/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc()..add(GetLocation()), // Trigger location fetching
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LocationLoaded) {
                // Once the location is loaded, fetch the weather
                context.read<WeatherBloc>().add(FetchWeather(state.position, false, true));
                return const HomeScreen();
              } else if (state is LocationError) {
                return Center(child: Text('Error: ${state.message}. Please try again.'));
              } else {
                return const Center(child: Text("Provide the Permition"));
              }
            },
          ),
        ),
      ),
    );
  }
}
