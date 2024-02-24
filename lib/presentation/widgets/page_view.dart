import 'package:flutter/material.dart';

import '../../models/weather_model.dart';
import 'current_temp_with_image.dart';
import 'current_weather_info.dart';
import 'daily_forecast.dart';
import 'hourly_forecast.dart';
import 'top_bar.dart';

class PageItem extends StatelessWidget {
  const PageItem({
    super.key,
    required this.data,
    required this.pageIndex,
  });

  final WeatherModel data;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Top bar
        TopBar(
          location: data.location,
          index: pageIndex,
        ),
        const SizedBox(height: 25),

        /// Current temperature with image, status and date
        CurrentTempWithImage(weatherModel: data),
        const SizedBox(height: 40),

        /// Current Weather details consisting of windSpeed, humidity, cloud
        CurrentWeatherInfo(weatherModel: data),
        const SizedBox(height: 25),

        /// Hourly forecast
        HourlyForecast(hourlyForecast: data.hourly),
        const SizedBox(height: 30),

        /// Daily forecast
        DailyForecast(dailyForecast: data.daily),
      ],
    );
  }
}
