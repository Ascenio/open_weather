import 'package:open_weather/weather/data/models/weather_model.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';

final class WeatherDataModel extends WeatherDataEntity {
  const WeatherDataModel({
    required super.temperature,
    required super.pressure,
    required super.humidity,
    required super.weather,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      temperature: (json['temp'] as num).toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      weather: WeatherModel.fromJson(
        (json['weather'] as List).cast<Map<String, dynamic>>().first,
      ),
    );
  }
}
