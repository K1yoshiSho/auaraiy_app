import 'package:auaraiy/features/home_page/recource/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:weather/weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _repository = WeatherRepository();
  WeatherBloc() : super(WeatherInitialState()) {
    on<GetWeatherData>(_repository.getWeatherData);
  }
}
