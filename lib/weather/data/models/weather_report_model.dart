import 'package:open_weather/weather/data/models/weather_daily_data_model.dart';
import 'package:open_weather/weather/data/models/weather_data_model.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';

final class WeatherReportModel extends WeatherReportEntity {
  const WeatherReportModel({
    required super.current,
    required super.hourly,
    required super.daily,
  });

  factory WeatherReportModel.fromJson(Map<String, dynamic> json) {
    return WeatherReportModel(
      current: WeatherDataModel.fromJson(json['current']),
      hourly: (json['hourly'] as List)
          .cast<Map<String, dynamic>>()
          .map(WeatherDataModel.fromJson)
          .toList(),
      daily: (json['daily'] as List)
          .cast<Map<String, dynamic>>()
          .map(WeatherDailyDataModel.fromJson)
          .toList(),
    );
  }
}
