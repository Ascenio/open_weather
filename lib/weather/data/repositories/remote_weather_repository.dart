import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:open_weather/weather/data/models/weather_report_model.dart';
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
  Future<WeatherReportEntity?> query() async {
    try {
      return await _request();
    } catch (error, stackTrace) {
      log(
        'Failed to fetch weather data',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<WeatherReportEntity> _request() async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'lat': (-42).toString(),
        'lon': (-42).toString(),
        'appid': apiKey,
        'units': 'metric',
      },
    );
    final response = await get(uri);
    final json = jsonDecode(response.body);
    return WeatherReportModel.fromJson(json);
  }
}
