class WeatherModel {
  String location;
  String dateAndTime;
  int temp;
  String description;
  int cloud;
  int windSpeed;
  int humidity;
  List hourly;
  List daily;

  WeatherModel({
    required this.location,
    required this.dateAndTime,
    required this.temp,
    required this.description,
    required this.cloud,
    required this.windSpeed,
    required this.humidity,
    required this.hourly,
    required this.daily,
  });

  /// Convert WeatherModel to a map
  Map<String, dynamic> toMap() {
    return {
      'location': {
        'name': location,
        'localtime': dateAndTime,
      },
      'current': {
        'temp_c': temp,
        'condition': {'text': description},
        'cloud': cloud,
        'wind_kph': windSpeed,
        'humidity': humidity,
      },
      'forecast': {'forecastday': daily},
    };
  }

  /// Factory method to create WeatherModel from a map
  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      location: map['location']['name'],
      dateAndTime: map['location']['localtime'].toString(),
      temp: map['current']['temp_c'].toInt() ?? 0,
      description: map['current']['condition']['text'] ?? '',
      cloud: map['current']['cloud'].toInt() ?? 0,
      windSpeed: map['current']['wind_kph'].toInt() ?? 0,
      humidity: map['current']['humidity'].toInt() ?? 0,
      daily: map['forecast']['forecastday'],
      hourly: map['forecast']['forecastday'][0]['hour'],
    );
  }
}
