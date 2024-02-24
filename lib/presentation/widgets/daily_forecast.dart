import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    super.key,
    required this.dailyForecast,
  });

  final List dailyForecast;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      itemCount: dailyForecast.length,
      itemBuilder: (context, index) {
        /// Retrieving date from the JSON
        DateTime date = DateTime.parse(dailyForecast[index]['date']);

        /// Formatted date from retrieved date in the form "22/02"
        String formattedDate = DateFormat('dd/MM').format(date);

        /// Formatted day from retrieved date in the form "Wednesday"
        String formattedDay = DateFormat('EEEE').format(date);

        /// Maximum temperature on the day
        final maxTemp = dailyForecast[index]['day']['maxtemp_c'].toInt();

        /// Minimum temperature on the day
        final minTemp = dailyForecast[index]['day']['mintemp_c'].toInt();

        /// Getting weather image name from the JSON
        String weatherName = dailyForecast[index]['day']['condition']['text'];

        /// Asset image path
        String dailyWeatherIcon =
            'assets/images/weather/${weatherName.replaceAll(' ', '').toLowerCase()}.png';

        return Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Date
              CustomTextWithWidth(width: 70, formattedDate: formattedDate),

              /// Day
              CustomTextWithWidth(width: 70, formattedDate: formattedDay),

              /// Weather condition image
              SizedBox(
                width: 70,
                child: Image.asset(
                  dailyWeatherIcon,
                  height: 25,
                ),
              ),

              /// Maximum temperature
              CustomTextWithWidth(width: 40, formattedDate: '$maxTemp\u2103'),

              /// Minimum temperature
              CustomTextWithWidth(width: 40, formattedDate: '$minTemp\u2103'),
            ],
          ),
        );
      },
    );
  }
}

class CustomTextWithWidth extends StatelessWidget {
  const CustomTextWithWidth({
    super.key,
    required this.formattedDate,
    required this.width,
  });

  final String formattedDate;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        formattedDate,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
