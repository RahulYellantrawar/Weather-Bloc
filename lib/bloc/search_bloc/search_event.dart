part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

/// Searching text event
final class SearchedLocation extends SearchEvent {
  final String searchText;
  SearchedLocation({required this.searchText});
}

/// Selected text weather event
final class SearchLocationRequested extends SearchEvent {
  final String searchText;
  SearchLocationRequested({required this.searchText});
}
