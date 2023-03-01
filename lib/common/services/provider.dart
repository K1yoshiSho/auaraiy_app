// Create a Provider class

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier {
  String _searchText = 'Nur-Sultan';
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  // Getters
  String get searchText => _searchText;
  ConnectivityResult get connectionStatus => _connectionStatus;

  // Setters
  set searchText(String value) {
    _searchText = value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  set connectionStatus(ConnectivityResult value) {
    _connectionStatus = value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  void clear() {
    _searchText = 'Nur-Sultan';
    _connectionStatus = ConnectivityResult.none;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}
