part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

/// Fetch weather of the current location
final class WeatherFetched extends WeatherEvent {}
