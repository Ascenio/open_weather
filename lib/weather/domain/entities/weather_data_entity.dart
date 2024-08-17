import 'weather.dart';

class WeatherDataEntity {
  const WeatherDataEntity({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.weather,
  });

  final double temperature;
  final int pressure;
  final int humidity;
  final Weather weather;
}
