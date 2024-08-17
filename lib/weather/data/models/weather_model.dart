import 'package:open_weather/weather/domain/entities/weather.dart';

final class WeatherModel extends Weather {
  const WeatherModel({required super.title, required super.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      title: json['main'],
      icon: json['icon'],
    );
  }
}
