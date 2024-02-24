import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';

class CurrentWeatherInfo extends StatelessWidget {
  const CurrentWeatherInfo({super.key, required this.weatherModel});

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Wind speed
          CustomImageWithText(
              parameterName: 'windspeed',
              parameterValue: '${weatherModel.windSpeed} km/h'),

          /// Humidity
          CustomImageWithText(
              parameterName: 'humidity',
              parameterValue: '${weatherModel.humidity}%'),

          /// Cloud
          CustomImageWithText(
              parameterName: 'cloud', parameterValue: '${weatherModel.cloud}%'),
        ],
      ),
    );
  }
}

class CustomImageWithText extends StatelessWidget {
  const CustomImageWithText({
    super.key,
    required this.parameterValue,
    required this.parameterName,
  });

  final String parameterValue;
  final String parameterName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Parameter image
        Image.asset(
          'assets/images/weather/$parameterName.png',
          width: 65,
        ),
        const SizedBox(height: 10),

        /// Parameter value
        Text(
          parameterValue,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
