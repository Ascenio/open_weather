import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';

abstract interface class WeatherRepository {
  Future<WeatherReportEntity?> query();
}
