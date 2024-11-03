import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherDetailRow extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const WeatherDetailRow({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WeatherDetailItem(
          iconPath: "assets/5.png",
          label: "Sunrise",
          time: DateFormat().add_jm().format(sunrise),
        ),
        WeatherDetailItem(
          iconPath: "assets/9.png",
          label: "Sunset",
          time: DateFormat().add_jm().format(sunset),
        ),
      ],
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final String time;

  const WeatherDetailItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
