import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key, required this.hourlyForecast});

  final List hourlyForecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyForecast.length,
        itemBuilder: (context, index) {
          /// Temperature of the indexed hour
          final hourTemp = hourlyForecast[index]['temp_c'];

          /// Time
          final time =
              hourlyForecast[index]['time'].toString().substring(11, 16);

          /// Weather condition
          final hourStatus = hourlyForecast[index]['condition']['text'];

          /// Weather icon image path
          final hourWeatherIcon =
              'assets/images/weather/${hourStatus.toString().replaceAll(' ', '').toLowerCase()}.png';

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Time
                HourlyCustomText(text: time),

                /// Weather icon image
                Image.asset(
                  hourWeatherIcon,
                  width: 50,
                ),

                /// Temperature
                HourlyCustomText(text: '$hourTemp\u2103'),

                /// Weather condition
                Text(
                  hourStatus,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HourlyCustomText extends StatelessWidget {
  const HourlyCustomText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
