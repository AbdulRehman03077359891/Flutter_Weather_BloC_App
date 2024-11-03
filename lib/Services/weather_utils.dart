import 'package:flutter/material.dart';

Widget getWeatherIcon(int code) {
  if (code > 200 && code < 300) {
    return Image.asset("assets/14.png");
  } else if (code > 300 && code < 400) {
    return Image.asset("assets/13.png");
  } else if (code > 500 && code < 600) {
    return Image.asset("assets/15.png");
  } else if (code > 600 && code < 700) {
    return Image.asset("assets/16.png");
  } else if (code > 700 && code < 800) {
    return Image.asset("assets/2.png");
  } else if (code > 800 && code <= 804) {
    return Image.asset("assets/7.png");
  } else {
    return Image.asset("assets/5.png");
  }
}
