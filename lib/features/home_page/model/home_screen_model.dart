// ignore_for_file: unused_field, cancel_subscriptions

import 'dart:async';

import 'package:auaraiy/common/services/app_model.dart';
import 'package:auaraiy/common/services/provider.dart';
import 'package:auaraiy/features/home_page/recource/home_repository.dart';
import 'package:auaraiy/features/home_page/state/bloc/weather_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

class HomeScreenModel extends AppModel {
  // Main fields
  late final HomeRepository homeRepository;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final FocusNode unfocusNode;
  late final WeatherProvider weatherProvider;

  // Weather fields
  late Weather? weatherData;
  late List<Weather> forecastList;

  // Internet connection fields
  late ConnectivityResult connectionStatus;
  late final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  // Other fields
  late final bool biometricValue;
  late final bool hasConnection;

  void initState(BuildContext context) {
    biometricValue = false;
    connectionStatus = ConnectivityResult.none;
    connectivity = Connectivity();
    homeRepository = HomeRepository();
    scaffoldKey = GlobalKey<ScaffoldState>();
    unfocusNode = FocusNode();
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
  }

  void dispose() {
    biometricValue = false;

    connectivitySubscription.cancel();
    weatherProvider.clearAll();
    weatherProvider.dispose();
  }
}
