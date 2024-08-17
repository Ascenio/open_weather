import 'package:open_weather/weather/data/models/weather_model.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';

final class WeatherDataModel extends WeatherDataEntity {
  const WeatherDataModel({
    required super.temperature,
    required super.pressure,
    required super.humidity,
    required super.windSpeed,
    required super.windDegrees,
    required super.weather,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      temperature: (json['temp'] as num).toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDegrees: (json['wind_deg'] as num).toDouble(),
      weather: WeatherModel.fromJson(
        (json['weather'] as List).cast<Map<String, dynamic>>().first,
      ),
    );
  }
}
