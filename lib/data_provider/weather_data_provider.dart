import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherDataProvider {
  /// Fetch weather from the current location
  Future getCurrentWeather(String searchText) async {
    try {
      /// api.wetherapi.com API key
      const String apiKey = "82670b3bbc9c41cebab154047230809";

      /// Response from the API
      final res = await http.get(
        Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=$searchText',
        ),
      );

      final weatherData = res.body;
      final data = json.decode(weatherData);

      return data;
    } catch (e) {
      rethrow;
    }
  }

  /// Get search and auto complete data
  Future getSearchResult(String searchText) async {
    try {
      /// api.wetherapi.com API key
      const String apiKey = "82670b3bbc9c41cebab154047230809";

      /// Response from the API
      final res = await http.get(
        Uri.parse(
          'http://api.weatherapi.com/v1/search.json?key=$apiKey&days=7&q=$searchText',
        ),
      );

      final weatherData = res.body;
      final data = json.decode(weatherData);

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
