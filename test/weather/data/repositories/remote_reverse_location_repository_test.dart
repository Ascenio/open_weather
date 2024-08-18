import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather/core/data/http_client.dart';
import 'package:open_weather/weather/data/repositories/remote_reverse_location_repository.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/address_entity.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late RemoteReverseLocationRepository reverseLocationRepository;

  setUp(() {
    httpClient = HttpClientMock();
    reverseLocationRepository = RemoteReverseLocationRepository(
      httpClient: httpClient,
    );
  });

  const location = LocationEntity(latitude: -42, longitude: 42);
  const queryParameters = {
    'lat': '-42.0',
    'lon': '42.0',
    'format': 'json',
  };

  test('when an exception is thrown, should return left', () async {
    when(() => httpClient.request(queryParameters: queryParameters))
        .thenThrow(Exception('error'));
    final result = await reverseLocationRepository.query(location: location);
    expect(result, const Left<void, AddressEntity>(null));
  });

  test('on success should return an address', () async {
    when(() => httpClient.request(queryParameters: queryParameters))
        .thenAnswer((_) async => json);
    final result = await reverseLocationRepository.query(location: location);
    expect(result, isA<Right<void, AddressEntity>>());
  });
}

final json = {
  "address": {
    "city": "Natal",
    "state": "Rio Grande do Norte",
  },
};
