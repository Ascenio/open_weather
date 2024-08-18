import 'package:open_weather/weather/domain/entities/weather.dart';

class WeatherDailyDataEntity {
  const WeatherDailyDataEntity({
    required this.date,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.weather,
  });

  final DateTime date;
  final double minimumTemperature;
  final double maximumTemperature;
  final Weather weather;
}
