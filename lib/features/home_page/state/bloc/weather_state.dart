part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class LoadingState extends WeatherState {}

class FailureState extends WeatherState {
  final String error;
  final DioError? errorDio;
  const FailureState(this.error, {this.errorDio});
}

class FetchedState extends WeatherState {
  final Weather weatherData;
  final List<Weather> forecastList;
  const FetchedState(this.weatherData, this.forecastList);
}
