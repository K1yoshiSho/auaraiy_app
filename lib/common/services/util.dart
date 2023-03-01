import 'dart:io';
import 'package:auaraiy/common/constants/app_colors.dart';
import 'package:auaraiy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:url_launcher/url_launcher.dart';
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

Future launchURL(String url) async {
  var uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    throw 'Не удалось открыть $uri. Причина: $e';
  }
}

Color? getIconColor(String tag, bool isForecast, BuildContext context) {
  if (tag == "13d" || tag == "01n" || tag == "13n" || tag == "50d" || tag == "50n") {
    return isForecast ? AppColors.darkColor(context) : Colors.white;
  } else
    return null;
}

String getIconLink(String tag) {
  return "http://openweathermap.org/img/wn/$tag@4x.png";
}

WeatherType getWeatherType(String tag) {
  switch (tag) {
    case "01d":
      return WeatherType.sunny;
    case "01n":
      return WeatherType.sunnyNight;
    case "02d":
      return WeatherType.cloudy;
    case "02n":
      return WeatherType.cloudyNight;
    case "03d":
      return WeatherType.overcast;
    case "03n":
      return WeatherType.cloudyNight;
    case "04d":
      return WeatherType.cloudy;
    case "04n":
      return WeatherType.cloudyNight;
    case "09d":
      return WeatherType.lightRainy;
    case "09n":
      return WeatherType.lightRainy;
    case "10d":
      return WeatherType.middleRainy;
    case "10n":
      return WeatherType.middleRainy;
    case "11d":
      return WeatherType.thunder;
    case "11n":
      return WeatherType.thunder;
    case "13d":
      return WeatherType.middleSnow;
    case "13n":
      return WeatherType.middleSnow;
    case "50d":
      return WeatherType.foggy;
    case "50n":
      return WeatherType.foggy;
    default:
      return WeatherType.sunny;
  }
}

String getAppname() => "Auaraiy";

String noValues() => "Нет значений";

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

bool get isAndroid => Platform.isAndroid;
bool get isiOS => Platform.isIOS;

const textValidatorEmailRegex =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

void setDarkModeSetting(BuildContext context, ThemeMode themeMode) => AuaraiyApp.of(context).setThemeMode(themeMode);
