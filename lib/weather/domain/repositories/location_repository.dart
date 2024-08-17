import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/failures/location_failure.dart';

abstract interface class LocationRepository {
  Future<Either<LocationFailure, LocationEntity>> query();
}
