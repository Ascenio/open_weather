import 'weather.dart';

class WeatherDataEntity {
  const WeatherDataEntity({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDegrees,
    required this.weather,
  });

  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final double windDegrees;
  final Weather weather;
}
