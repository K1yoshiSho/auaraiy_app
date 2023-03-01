import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const themeModeKey = 'auaraiye_theme';
SharedPreferences? _prefs;

abstract class AppTheme {
  static Future initialize() async => _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(themeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) =>
      mode == ThemeMode.system ? _prefs?.remove(themeModeKey) : _prefs?.setBool(themeModeKey, mode == ThemeMode.dark);

  static AppTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? DarkModeTheme() : LightModeTheme();
  }

  late Color primaryColor;
  late Color secondaryColor;
  late Color dangerColor;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBtnText;
  late Color lineColor;
  late Color iconColor;

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme {
  late Color primaryColor = const Color.fromARGB(255, 84, 84, 241);
  late Color secondaryColor = const Color(0xFF98A9FF);

  late Color dangerColor = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF57636C);

  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFFE0E3E7);
  late Color iconColor = Color(0xFFFFFFFF);
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  String get title1Family => 'Gilroy_kz';
  TextStyle get title1 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get title2Family => 'Gilroy_kz';
  TextStyle get title2 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
  String get title3Family => 'Gilroy_kz';
  TextStyle get title3 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get subtitle1Family => 'Gilroy_kz';
  TextStyle get subtitle1 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get subtitle2Family => 'Gilroy_kz';
  TextStyle get subtitle2 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get bodyText1Family => 'Gilroy_kz';
  TextStyle get bodyText1 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
  String get bodyText2Family => 'Gilroy_kz';
  TextStyle get bodyText2 => TextStyle(
        fontFamily: 'Gilroy_kz',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
}

class DarkModeTheme extends AppTheme {
  late Color primaryColor = Color.fromARGB(255, 84, 84, 241);
  late Color secondaryColor = const Color(0xFF98A9FF);
  late Color dangerColor = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFF1A1F24);
  late Color secondaryBackground = const Color(0xFF101213);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);
  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFF22282F);
  late Color iconColor = Color(0xFFEDEDED);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        height: lineHeight,
      );
}
