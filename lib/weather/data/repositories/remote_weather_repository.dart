import 'dart:developer';

import 'package:open_weather/core/data/http_client.dart';
import 'package:open_weather/weather/data/models/weather_report_model.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';

final class RemoteWeatherRepository implements WeatherRepository {
  const RemoteWeatherRepository({
    required this.httpClient,
    required this.baseUrl,
    required this.apiKey,
  });

  final HttpClient httpClient;
  final String baseUrl;
  final String apiKey;

  @override
  Future<Either<void, WeatherReportEntity>> query({
    required LocationEntity location,
  }) async {
    try {
      final json = await httpClient.request(baseUrl, queryParameters: {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'appid': apiKey,
        'units': 'metric',
      });
      final report = WeatherReportModel.fromJson(json);
      return Right(report);
    } catch (error, stackTrace) {
      log(
        'Failed to fetch weather data',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(null);
    }
  }
}
