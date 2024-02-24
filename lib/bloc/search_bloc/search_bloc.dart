import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data_provider/weather_data_provider.dart';
import 'package:weather/models/weather_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    /// Searching for location
    on<SearchedLocation>(_onSearchedLocation);

    /// Gets the selected location weather data
    on<SearchLocationRequested>(_onSearchLocationRequested);
  }

  /// Searching for location method
  void _onSearchedLocation(
      SearchedLocation event, Emitter<SearchState> emit) async {
    try {
      final data =
          await WeatherDataProvider().getSearchResult(event.searchText);

      emit(SearchSuccess(searchData: data));
    } catch (e) {
      rethrow;
    }
  }

  /// Get selected location weather data method
  void _onSearchLocationRequested(
      SearchLocationRequested event, Emitter<SearchState> emit) async {
    try {
      final data =
          await WeatherDataProvider().getCurrentWeather(event.searchText);
      final weather = WeatherModel.fromMap(data);
      emit(SearchTextSuccess(weatherData: weather));
    } catch (e) {
      rethrow;
    }
  }
}
