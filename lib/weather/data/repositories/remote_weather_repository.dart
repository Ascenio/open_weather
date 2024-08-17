import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:open_weather/weather/data/models/weather_report_model.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';

final class RemoteWeatherRepository implements WeatherRepository {
  const RemoteWeatherRepository({
    required this.baseUrl,
    required this.apiKey,
  });

  final String baseUrl;
  final String apiKey;

  @override
  Future<Either<void, WeatherReportEntity>> query({
    required LocationEntity location,
  }) async {
    try {
      return Right(await _request(
        latitude: location.latitude,
        longitude: location.longitude,
      ));
    } catch (error, stackTrace) {
      log(
        'Failed to fetch weather data',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(null);
    }
  }

  Future<WeatherReportEntity> _request({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'appid': apiKey,
        'units': 'metric',
      },
    );
    final response = await get(uri);
    final json = jsonDecode(response.body);
    return WeatherReportModel.fromJson(json);
  }
}
