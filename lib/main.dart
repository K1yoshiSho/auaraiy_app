import 'package:auaraiy/common/services/app_state.dart';
import 'package:auaraiy/common/services/provider.dart';
import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/common/services/util.dart';
import 'package:auaraiy/features/home_page/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppTheme.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ChangeNotifierProvider(create: (context) => AppSharedPreferences()),
    ],
    child: MediaQuery(
      data: MediaQueryData(),
      child: AuaraiyApp(),
    ),
  ));
}

class AuaraiyApp extends StatefulWidget {
  @override
  State<AuaraiyApp> createState() => _AuaraiyAppState();
  static _AuaraiyAppState of(BuildContext context) => context.findAncestorStateOfType<_AuaraiyAppState>()!;
}

class _AuaraiyAppState extends State<AuaraiyApp> {
  Locale? _locale;
  ThemeMode _themeMode = AppTheme.themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: getAppname(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('ru'),
      ],
      theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: _themeMode,
      home: HomeScreen(),
    );
  }

  void setThemeMode(ThemeMode value) => setState(() {
        _themeMode = value;
        AppTheme.saveThemeMode(value);
      });
}
