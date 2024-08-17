import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';

abstract interface class WeatherRepository {
  Future<Either<void, WeatherReportEntity>> query({
    required LocationEntity location,
  });
}
