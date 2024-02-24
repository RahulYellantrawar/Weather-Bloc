part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

/// Search initial state
final class SearchInitial extends SearchState {}

/// Search results state
final class SearchSuccess extends SearchState {
  final List searchData;
  SearchSuccess({required this.searchData});
}

/// Search text weather result
final class SearchTextSuccess extends SearchState {
  final WeatherModel weatherData;
  SearchTextSuccess({required this.weatherData});
}
