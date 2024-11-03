import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class TempMinMaxRow extends StatelessWidget {
  final Temperature tempMin;
  final Temperature tempMax;

  const TempMinMaxRow({
    super.key,
    required this.tempMin,
    required this.tempMax,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TempMinMaxItem(
          iconPath: "assets/1.png",
          label: "Temp Max",
          value: "${tempMax.celsius!.round()}°C",
        ),
        TempMinMaxItem(
          iconPath: "assets/3.png",
          label: "Temp Min",
          value: "${tempMin.celsius!.round()}°C",
        ),
      ],
    );
  }
}

class TempMinMaxItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  const TempMinMaxItem({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.value,
  }) : super(key: key);

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
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
