import 'package:open_weather/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';

class WeatherReportEntity {
  const WeatherReportEntity({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  final WeatherDataEntity current;
  final List<WeatherDataEntity> hourly;
  final List<WeatherDailyDataEntity> daily;
}
