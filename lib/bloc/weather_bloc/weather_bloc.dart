import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data_provider/weather_data_provider.dart';
import 'package:weather/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    /// Fetch weather for the current location
    on<WeatherFetched>(_onWeatherFetched);
  }

  /// on WeatherFetched event method
  void _onWeatherFetched(
      WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final prefs = await SharedPreferences.getInstance();
      if (connectivityResult == ConnectivityResult.none) {
        print("Hello");
        emit(WeatherFailure(error: 'No internet connection showing old data'));
        String? jsonData = prefs.getString('weather_data');

        if (jsonData != null) {
          Map<String, dynamic> map = jsonDecode(jsonData);
          return emit(WeatherSuccess(WeatherModel.fromMap(map)));
        } else {
          return emit(WeatherFailure(error: 'There is no any saved data'));
        }
      } else {
        /// Get the current position
        final position = await _getCurrentPosition();

        /// Current location latitude and logitude for searching weather data
        final searchText = '${position.latitude},${position.longitude}';

        /// Get weather report from the API
        final weather =
            await WeatherDataProvider().getCurrentWeather(searchText);
        final data = WeatherModel.fromMap(weather);

        /// Save the fetched weather report to device for offline use

        String jsonData = jsonEncode(data.toMap());
        prefs.setString('weather_data', jsonData);

        /// Emit the weather data to use
        emit(WeatherSuccess(data));
      }
    } catch (e) {
      rethrow;
      // return emit(WeatherFailure(error: e.toString()));
    }
  }

  /// Gets current location of the user
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Check the Location is enabled or not
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    /// Check and request for Location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    /// Get current position
    final position = await Geolocator.getCurrentPosition();

    return position;
  }
}
