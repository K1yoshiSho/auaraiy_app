import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends ChangeNotifier {
  static final SharedPref _instance = SharedPref._internal();

  factory SharedPref() {
    return _instance;
  }

  SharedPref._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  // String _searchedValue = 'Астана';
  // String get searchedValue => _searchedValue;
  // set searchedValue(String _value) {
  //   _searchedValue = _value;
  // }
}
