import 'dart:async';
import 'package:auaraiy/common/components/loading_indicator.dart';
import 'package:auaraiy/common/constants/app_colors.dart';
import 'package:auaraiy/common/components/no_connection.dart';
import 'package:auaraiy/common/components/not_found.dart';
import 'package:auaraiy/features/home_page/components/search_component.dart';
import 'package:auaraiy/common/services/app_model.dart';
import 'package:auaraiy/common/constants/device_size.dart';
import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/common/components/icon_button.dart';
import 'package:auaraiy/common/services/util.dart';
import 'package:auaraiy/features/home_page/components/current_city.dart';
import 'package:auaraiy/features/home_page/components/forecast.dart';
import 'package:auaraiy/features/home_page/components/main_information.dart';
import 'package:auaraiy/features/home_page/components/overlay_component.dart';
import 'package:auaraiy/common/components/weather_bg.dart';
import 'package:auaraiy/features/home_page/model/home_screen_model.dart';
import 'package:auaraiy/features/home_page/state/bloc/weather_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Model
  late HomeScreenModel _homeModel;

  late ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _homeModel = createModel(context, () => HomeScreenModel());
    _homeModel.homeRepository.checkBiometric(_homeModel.biometricValue);
    _homeModel.weatherBloc.add(GetWeatherData(_homeModel.weatherProvider.searchText));
    super.initState();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      print(result);
    } on PlatformException catch (e) {
      debugPrint('Не удалось проверить состояние подключения: $e');
      return;
    }
    if (!mounted) return Future.value(null);
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _homeModel.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeModel.scaffoldKey,
      backgroundColor: AppColors.primaryBackground(context),
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_homeModel.unfocusNode),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (_connectionStatus == ConnectivityResult.wifi || _connectionStatus == ConnectivityResult.mobile)
                  ? BlocConsumer<WeatherBloc, WeatherState>(
                      bloc: _homeModel.weatherBloc,
                      listener: (context, state) {
                        if (state is FetcheedState) {
                          setState(() {
                            _homeModel.weatherData = state.weatherData;
                            _homeModel.forecastList = state.forecastList;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is FetcheedState) {
                          return Container(
                            width: double.infinity,
                            height: deviceSize.height * 0.895,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).primaryBackground,
                            ),
                            child: Stack(
                              children: [
                                WeatherBackground(
                                  weatherType: getWeatherType(_homeModel.weatherData!.weatherIcon!),
                                ),
                                OverlayComponent(
                                  opacityValue: 50,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: MainInformation(
                                        tempValue:
                                            "${_homeModel.weatherData?.temperature?.celsius?.toStringAsFixed(0).capitalize()}°",
                                        description:
                                            _homeModel.weatherData?.weatherDescription?.capitalize() ?? noValues(),
                                        iconCode: _homeModel.weatherData!.weatherIcon!,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
                                      child: MoreInformation(
                                        weekValue: DateFormat('EEEE, d MMMM', 'ru_RU')
                                            .format(_homeModel.weatherData!.date!)
                                            .capitalize(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: CurrentCity(
                                        cityName: _homeModel.weatherData!.areaName!.capitalize(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: ForecastList(
                                        forecastList: _homeModel.forecastList,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else if (state is LoadingState) {
                          return SizedBox(
                            width: double.infinity,
                            height: deviceSize.height * 0.89,
                            child: LoadingIndicator(),
                          );
                        } else if (state is FailureState) {
                          return NotFoundComponent(homeModel: _homeModel);
                        } else {
                          return Container();
                        }
                      },
                    )
                  : NoConnectionComponent(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor(context),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: SizedBox(width: 50),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
          child: CustomIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 50,
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.iconColor(context),
              size: 30,
            ),
            onPressed: () async {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SearchComponent(
                      onSubmit: (String? value) {
                        if (value != null && value.isNotEmpty) {
                          _homeModel.weatherProvider.searchText = value;
                          _homeModel.weatherBloc.add(GetWeatherData(value));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  );
                },
              ).then((value) => setState(() {}));
            },
          ),
        ),
      ],
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/app_launcher_icon.png',
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          AutoSizeText(
            getAppname(),
            style: AppTheme.of(context).title2.override(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
        ],
      ),
      elevation: 0,
    );
  }
}
