import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather/core/data/http_client.dart';
import 'package:open_weather/weather/data/repositories/remote_weather_repository.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late RemoteWeatherRepository weatherRepository;

  const apiKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

  setUp(() {
    httpClient = HttpClientMock();
    weatherRepository = RemoteWeatherRepository(
      httpClient: httpClient,
      apiKey: apiKey,
    );
  });

  const location = LocationEntity(latitude: -42, longitude: 42);
  const queryParameters = {
    'lat': '-42.0',
    'lon': '42.0',
    'appid': apiKey,
    'units': 'metric'
  };

  test('when an exception is thrown, should return left', () async {
    when(() => httpClient.request(queryParameters: queryParameters))
        .thenThrow(Exception('error'));
    final result = await weatherRepository.query(location: location);
    expect(result, const Left<void, WeatherReportEntity>(null));
  });

  test('on success should return a report', () async {
    when(() => httpClient.request(queryParameters: queryParameters))
        .thenAnswer((_) async => json);
    final result = await weatherRepository.query(location: location);
    expect(result, isA<Right<void, WeatherReportEntity>>());
  });
}

final json = {
  "lat": 33.44,
  "lon": -94.04,
  "current": {
    "temp": 292.55,
    "pressure": 1014,
    "humidity": 89,
    "wind_speed": 3.13,
    "wind_deg": 93,
    "weather": [
      {
        "id": 803,
        "main": "Clouds",
        "description": "broken clouds",
        "icon": "04d"
      }
    ]
  },
  "hourly": [
    {
      "dt": 1684926000,
      "temp": 292.01,
      "pressure": 1014,
      "humidity": 91,
      "wind_speed": 2.58,
      "wind_deg": 86,
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04n"
        }
      ],
    },
  ],
  "daily": [
    {
      "dt": 1684951200,
      "temp": {
        "min": 290.69,
        "max": 300.35,
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d",
        }
      ],
    },
  ],
};
