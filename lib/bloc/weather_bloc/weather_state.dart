part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

/// Weather initial state
final class WeatherInitial extends WeatherState {}

/// Weather fetching success state
final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherData;
  WeatherSuccess(this.weatherData);
}

/// Weather fetching failure state
final class WeatherFailure extends WeatherState {
  final String error;
  WeatherFailure({required this.error});
}

/// Page change on the home screen for searched and current location weather
final class WeatherPageChange extends WeatherState {
  final int index;
  WeatherPageChange({required this.index});
}

/// Weather fetching in process state
final class WeatherLoading extends WeatherState {}
