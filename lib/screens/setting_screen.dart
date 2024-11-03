
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/Widgets/background_decoration.dart';
import 'package:weather_bloc/Widgets/choose_city.dart';
import 'package:weather_bloc/Widgets/e1_button.dart';
import 'package:weather_bloc/bloc/Location/location_bloc.dart';
import 'package:weather_bloc/bloc/Location/location_event.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onNavigateToWeather;

  const SettingsScreen({super.key, required this.onNavigateToWeather});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _cityController = TextEditingController();
  String? _selectedCity;
  double? _latitude;
  double? _longitude;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(), // Create WeatherBloc once
      child: Stack(
        children: [
          const BackgroundDecorations(),
          _buildMainContent(context),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCityChooser(context),
        const SizedBox(height: 20),
        _buildCoordinatesDisplay(),
        const SizedBox(height: 20),
        _buildGetCurrentLocationButton(context),
      ],
    );
  }

  Widget _buildCityChooser(BuildContext context) {
    return CityChoose(
      controller: _cityController,
      selectedCity: _selectedCity,
      onChange: (city) {
        if (city != null) {
          final coordinates = CityChoose.cityCoordinates[city]!; // Access cityCoordinates
          setState(() {
            _selectedCity = city;
            _latitude = coordinates[0];  // Update latitude
            _longitude = coordinates[1];  // Update longitude
          });

          // Dispatch event using the existing WeatherBloc instance
          context.read<WeatherBloc>().add(FetchWeather(coordinates, true, true));
          widget.onNavigateToWeather();  // Call the navigation callback
        }
      },
      onCoordinatesChanged: (lat, lon) {
        setState(() {
          _latitude = lat;
          _longitude = lon;
        });
      },
      width: MediaQuery.of(context).size.width,
      fillColor: Colors.white24,
      labelColor: Colors.white,
      focusBorderColor: Colors.white,
      errorBorderColor: Colors.red,
      dropTextColor: Colors.white,
      dropColor: Colors.white12,
    );
  }

  Widget _buildCoordinatesDisplay() {
    if (_latitude != null && _longitude != null) {
      return Text(
        "Latitude: $_latitude, Longitude: $_longitude",
        style: const TextStyle(color: Colors.white),
      );
    }
    return const SizedBox(); // Return an empty widget if no coordinates
  }

  Widget _buildGetCurrentLocationButton(BuildContext context) {
    return E1Button(
      backColor: Colors.orange,
      text: "Get Current Location",
      textColor: Colors.white,
      onPressed: () {
        // Dispatch event to get current location
        context.read<LocationBloc>().add(GetLocation());
      },
    );
  }
}
