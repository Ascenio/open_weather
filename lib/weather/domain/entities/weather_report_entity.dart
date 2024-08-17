import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';

class WeatherReportEntity {
  const WeatherReportEntity({
    required this.current,
    required this.hourly,
  });

  final WeatherDataEntity current;
  final List<WeatherDataEntity> hourly;
}
