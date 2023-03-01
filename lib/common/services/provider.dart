// Create a Provider class

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  // Getters
  ConnectivityResult get connectionStatus => _connectionStatus;

  // Setters
  set connectionStatus(ConnectivityResult value) {
    _connectionStatus = value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  void clearAll() {
    _connectionStatus = ConnectivityResult.none;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}
