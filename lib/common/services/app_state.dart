import 'package:auaraiy/common/services/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreference = SharedPreferenceHelper();

class SharedPreferenceHelper {
  late SharedPreferences _sharedPreference;

  Future<void> init() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _sharedPreference;

  Future<void> clearAll() async {
    await _sharedPreference.clear();
  }

  Future<void> setSearchText(String value) async {
    await _sharedPreference.setString(Preferences.searchText, value);
  }

  String? get getSearchText {
    return _sharedPreference.getString(Preferences.searchText);
  }
}
