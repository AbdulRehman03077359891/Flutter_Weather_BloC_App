import 'package:flutter/material.dart';

class HumidityWindRow extends StatelessWidget {
  final double humidity;
  final double wind;

  const HumidityWindRow({
    super.key,
    required this.humidity,
    required this.wind,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HumidityWindItem(
          iconPath: "assets/9.png",
          label: "Wind Speed",
          value: "$wind km/h",
        ),
        HumidityWindItem(
          iconPath: "assets/18.png",
          label: "Humidity",
          value: "$humidity",
        ),
      ],
    );
  }
}

class HumidityWindItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  const HumidityWindItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, scale: 10),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
