import 'package:open_weather/weather/data/models/weather_model.dart';
import 'package:open_weather/weather/domain/entities/weather_daily_data_entity.dart';

final class WeatherDailyDataModel extends WeatherDailyDataEntity {
  const WeatherDailyDataModel({
    required super.date,
    required super.minimumTemperature,
    required super.maximumTemperature,
    required super.weather,
  });

  factory WeatherDailyDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDailyDataModel(
      date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      minimumTemperature: (json['temp']['min'] as num).toDouble(),
      maximumTemperature: (json['temp']['max'] as num).toDouble(),
      weather: WeatherModel.fromJson(
        (json['weather'] as List).cast<Map<String, dynamic>>().first,
      ),
    );
  }
}
