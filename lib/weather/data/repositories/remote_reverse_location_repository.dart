import 'dart:developer';

import 'package:open_weather/core/data/http_client.dart';
import 'package:open_weather/weather/data/models/address_model.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/address_entity.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/repositories/reverse_location_repository.dart';

class RemoteReverseLocationRepository implements ReverseLocationRepository {
  const RemoteReverseLocationRepository({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<Either<void, AddressEntity>> query({
    required LocationEntity location,
  }) async {
    try {
      final json = await httpClient.request(queryParameters: {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'format': 'json',
      });
      final report = AddressModel.fromJson(json);
      return Right(report);
    } catch (error, stackTrace) {
      log(
        'Failed to fetch address',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(null);
    }
  }
}
