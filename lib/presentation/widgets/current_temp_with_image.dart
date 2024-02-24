import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather_model.dart';

class CurrentTempWithImage extends StatelessWidget {
  const CurrentTempWithImage({super.key, required this.weatherModel});

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    final status = weatherModel.description;
    final temp = weatherModel.temp;
    final DateTime date =
        DateTime.parse(weatherModel.dateAndTime.substring(0, 10));
    final weatherIcon =
        'assets/images/weather/${status.replaceAll(' ', '').toLowerCase()}.png';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Weather condition image
          Image.asset(
            weatherIcon,
            width: 150,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Current temperature
              Text(
                '$temp\u2103',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 65,
                ),
              ),

              /// Current weather status
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              /// Current date and week day name
              Text(
                DateFormat('MMMM dd, EEEE').format(date),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
