// ignore_for_file: invalid_return_type_for_catch_error

import 'package:auaraiy/features/home_page/state/bloc/weather_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:weather/weather.dart';

WeatherFactory openWeather = new WeatherFactory("70c84db4add85475621edb4291a1445d", language: Language.RUSSIAN);

class WeatherRepository {
  Future<void> getWeatherData(GetWeatherData event, Emitter<WeatherState> emit) async {
    try {
      emit(LoadingState());
      List<Weather> forecastList = await openWeather.fiveDayForecastByCityName(event.searchText).catchError((error) {
        return emit(FailureState(error.toString()));
      });

      Weather weatherData = await openWeather.currentWeatherByCityName(event.searchText).catchError((error) {
        return emit(FailureState(error.toString()));
      });
      emit(FetchedState(weatherData, forecastList));
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }
}
