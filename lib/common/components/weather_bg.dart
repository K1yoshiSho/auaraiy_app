import 'package:auaraiy/common/constants/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

class WeatherBackground extends StatelessWidget {
  final WeatherType weatherType;
  const WeatherBackground({
    Key? key,
    required this.weatherType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherBg(
      weatherType: weatherType,
      width: deviceSize.width,
      height: deviceSize.height,
    );
  }
}
