import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences extends ChangeNotifier {
  static final AppSharedPreferences _instance = AppSharedPreferences._internal();

  factory AppSharedPreferences() {
    return _instance;
  }

  AppSharedPreferences._internal() {
    initializePersistedState();
  }

  Future<void> clearAll() async {
    _searchText = null;
    notifyListeners();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    print('Test prefs');
    _searchText = prefs.getString(_searchTextTag) ?? "Астана";
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String? _searchText;
  String? get searchText => _searchText;
  static String _searchTextTag = 'searchText';

  set searchText(String? _value) {
    _searchText = _value;
    prefs.setString(_searchTextTag, _value!);
  }
}
